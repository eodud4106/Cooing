package com.cooing.www.joon.controller;

import java.util.ArrayList;

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
	public String addLikes(Model model, @RequestParam int likeit_albumnum, HttpSession session) {
		
		String str = null;
		
		logger.debug("좋아요 기능: " + likeit_albumnum);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();
		 
		AlbumLikesVO vo = new AlbumLikesVO();
		
		vo.setLikeit_memberid(memberid);
		vo.setLikeit_albumnum(likeit_albumnum);
		 
		albumlikesDAO.addLikes(vo);
		
		str = "success";
		
		return str;
	}
	// 좋아요 취소
	@ResponseBody
	@RequestMapping(value = "/deleteLikes", method = RequestMethod.POST)
	public String deleteLikes(Model model, @RequestParam int likeit_albumnum, HttpSession session) {
		
		String str = null;
		
		logger.debug("좋아요 취소: " + likeit_albumnum);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();
		 
		AlbumLikesVO vo = albumlikesDAO.getAlbum(likeit_albumnum);
		// id 비교함
		if(vo.getLikeit_memberid().equals(memberid)){
			albumlikesDAO.deleteLikes(vo);
			str = "success";
		}
		else{
		}

		return str;
	}
	// 좋아요 목록
	@ResponseBody
	@RequestMapping(value = "/listLikes", method = RequestMethod.GET)
	public ArrayList<AlbumLikesVO> listLikes(Model model, 
			@RequestParam int likeit_albumnum) {
		
		ArrayList<AlbumLikesVO> likesList = albumlikesDAO.listLikes(likeit_albumnum);
		
		return likesList;
	}
	
}
