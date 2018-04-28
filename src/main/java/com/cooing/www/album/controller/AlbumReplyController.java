package com.cooing.www.album.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.ReplyDAO;
import com.cooing.www.album.vo.ReplyVO;
import com.cooing.www.member.vo.Member;
import com.cooing.www.util.PageNavigator;

@Controller
public class AlbumReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumLikesController.class);
	@Autowired
	ReplyDAO albumreplyDAO;
	
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
		 
		ReplyVO vo = new ReplyVO();
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
		ReplyVO vo = albumreplyDAO.getReply(reply_num);
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
	public ArrayList<ReplyVO> listReply(Model model, String reply_albumnum, String rep_page) {
		
		int num = 0;
		num = Integer.parseInt(reply_albumnum);
		
		int i_rep_page = 0;
		if(i_rep_page == 0) {
			i_rep_page = 1;
		}
		
		try {
			i_rep_page = Integer.parseInt(rep_page);
		} catch (Exception e) {
			i_rep_page = 1;
		}
		
		
		// 댓글 페이징
		int repTotal = albumreplyDAO.getReplyTotal(num);
		PageNavigator RepNavi = new PageNavigator(3, 3, i_rep_page, repTotal);
		ArrayList<ReplyVO> replyList = albumreplyDAO.listReply(num, RepNavi.getStartRecord(), RepNavi.getCountPerPage());
		PageNavigator navi = new PageNavigator(3, 3, i_rep_page, repTotal);

		if(replyList.isEmpty() == false) {
			System.out.println("뒷단 현재페이지 : "+ navi.getCurrentPage());
			replyList.get(0).setCurrentPage(navi.getCurrentPage());
		}
		
		
		return replyList;
	}
	
	// 댓글 페이징
	@ResponseBody
	@RequestMapping(value = "/pageReply", method = RequestMethod.GET)
	public PageNavigator pageReply(String reply_albumnum, String rep_page) {
		
		int i_rep_page = 0;
		if(i_rep_page == 0) {
			i_rep_page = 1;
		}
		
		try {
			i_rep_page = Integer.parseInt(rep_page);
		} catch (Exception e) {
			i_rep_page = 1;
		}
		
		int num = 0;
		num = Integer.parseInt(reply_albumnum);
		// 댓글 페이징
		int repTotal = albumreplyDAO.getReplyTotal(num);
		//가져 갈 요소들
		PageNavigator navi = new PageNavigator(3, 3, i_rep_page, repTotal);
		
		return navi;
	}
	
	//댓글 갯수 
	@ResponseBody
	@RequestMapping(value = "/countReply", method = RequestMethod.POST)
	public int countReply(int reply_albumnum) {
		return albumreplyDAO.getReplyTotal(reply_albumnum);
	}
}
