package com.cooing.www.joon.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.joon.dao.AlbumLikesDAO;
import com.cooing.www.joon.vo.AlbumLikesVO;

@Controller
public class AlbumLikesController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumLikesController.class);
	@Autowired
	AlbumLikesDAO albumlikesDAO;
	// 좋아요
	@ResponseBody
	@RequestMapping(value = "/likes", method = RequestMethod.POST)
	public String addLikes(Model model, @RequestParam int likeit_albumnum) {
		
		String str = null;
		
		logger.debug("좋아요 기능: " + likeit_albumnum);

		String id = "test";
		 
		AlbumLikesVO vo = new AlbumLikesVO();
		vo.setLikeit_memberid(id);
		vo.setLikeit_albumnum(likeit_albumnum);
		 
		albumlikesDAO.addLikes(vo);
		
		str= "success";
		
		return str;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteLikes", method = RequestMethod.POST)
	public String deleteLikes(Model model, @RequestParam int likeit_albumnum) {
		
		String str = null;
		
		logger.debug("좋아요 취소 기능: " + likeit_albumnum);

		String id = "test";
		 
		AlbumLikesVO vo = new AlbumLikesVO();
		vo.setLikeit_memberid(id);
		vo.setLikeit_albumnum(likeit_albumnum);
		 
		albumlikesDAO.deleteLikes(vo);
			
		str= "success";

		return str;
	}
	
	
}
