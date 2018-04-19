package com.cooing.www.joon.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.joon.dao.AlbumReplyDAO;
import com.cooing.www.joon.vo.AlbumReplyVO;

@Controller
public class AlbumReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumLikesController.class);
	@Autowired
	AlbumReplyDAO albumreplyDAO;
	// 댓글 창 이동
	@RequestMapping(value = "/albumReply", method = RequestMethod.GET)
	public String albumReply(Model model) {
		
		return "./albumReply";
	}
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/writeReply", method = RequestMethod.POST)
	public String writeReply(Model model, @RequestParam int reply_albumnum, 
			@RequestParam String reply_contents) {
		
		String str = null;
		
		logger.debug("댓글 작성: " + reply_albumnum);

		String id = "test";
		 
		AlbumReplyVO vo = new AlbumReplyVO();
		vo.setReply_memberid(id);
		vo.setReply_albumnum(reply_albumnum);
		vo.setReply_contents(reply_contents);
		 
		albumreplyDAO.replyWrite(vo);
		
		str= "success";
		
		return str;
	}
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public String deleteReply(Model model, @RequestParam int reply_albumnum) {
		
		String str = null;
		
		logger.debug("댓글 삭제: " + reply_albumnum);

		String id = "test";
		 
		AlbumReplyVO vo = new AlbumReplyVO();
		vo.setReply_memberid(id);
		vo.setReply_albumnum(reply_albumnum);
		 
		albumreplyDAO.replyDelete(vo);
		
		str= "success";
		
		return str;
	}
}
