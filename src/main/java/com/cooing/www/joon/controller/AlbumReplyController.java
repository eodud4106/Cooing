package com.cooing.www.joon.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.jinsu.object.Member;
import com.cooing.www.joon.dao.AlbumReplyDAO;
import com.cooing.www.joon.util.PageNavigator;
import com.cooing.www.joon.vo.AlbumReplyVO;

@Controller
public class AlbumReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumLikesController.class);
	@Autowired
	AlbumReplyDAO albumreplyDAO;
	
	// 한 페이지 당 글 개수
	private static final int COUNT_PER_PAGE = 3;
	// 페이지 그룹 개수
	private static final int PAGE_PER_GROUP = 5;
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/writeReply", method = RequestMethod.POST)
	public String writeReply(Model model,int reply_albumnum, String reply_contents, HttpSession session) {
		
		String str = null;
		
		logger.debug("댓글 작성: " + reply_albumnum);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();
		 
		AlbumReplyVO vo = new AlbumReplyVO();
		vo.setReply_memberid(memberid);
		vo.setReply_albumnum(reply_albumnum);
		vo.setReply_contents(reply_contents);
		 
		albumreplyDAO.replyWrite(vo);
		
		str = "success";
		
		return str;
	}
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public String deleteReply(Model model, int reply_num, HttpSession session) {
		
		String str = null;
		
		logger.debug("댓글 삭제: " + reply_num);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();

		// 넘어온 댓글 번호로 댓글 꺼내옴
		AlbumReplyVO vo = albumreplyDAO.getReply(reply_num);
		// id 비교
		if(vo.getReply_memberid().equals(memberid)){
			albumreplyDAO.replyDelete(vo);
			str = "success";
		}
		else{
		}

		return str;
	}
	
	// 댓글 목록
	@ResponseBody
	@RequestMapping(value = "/listReply", method = RequestMethod.GET)
	public ArrayList<AlbumReplyVO> listReply(Model model, String reply_albumnum, @RequestParam(value="rep_page", defaultValue="1") int page) {
		
		int num = 0;
		
		num = Integer.parseInt(reply_albumnum);
		
		// 댓글 페이징
		int repTotal = albumreplyDAO.getReplyTotal(num);
		PageNavigator RepNavi = new PageNavigator(COUNT_PER_PAGE, PAGE_PER_GROUP, page, repTotal);
		
		ArrayList<AlbumReplyVO> replyList = albumreplyDAO.listReply(num, RepNavi.getStartRecord(), RepNavi.getCountPerPage());
		
		model.addAttribute("RepNavi", RepNavi);
		
		return replyList;
	}
}
