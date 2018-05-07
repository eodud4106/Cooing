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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.LikesDAO;
import com.cooing.www.album.vo.LikesVO;
import com.cooing.www.member.vo.Member;

@Controller
public class AlbumLikesController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumLikesController.class);
	@Autowired
	LikesDAO albumlikesDAO;
	// 좋아요
	@ResponseBody
	@RequestMapping(value = "/likes", method = RequestMethod.POST)
	public String addLikes(Model model, int likeit_albumnum, HttpSession session) {
		
		String str = null;
		
		logger.debug("좋아요 기능: " + likeit_albumnum);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();
		 
		LikesVO vo = new LikesVO();
		
		vo.setLikeit_memberid(memberid);
		vo.setLikeit_albumnum(likeit_albumnum);
		 
		albumlikesDAO.addLikes(vo);
		
		str = "success";
		
		return str;
	}
	// 좋아요 취소
	@ResponseBody
	@RequestMapping(value = "/deleteLikes", method = RequestMethod.POST)
	public String deleteLikes(Model model, int likeit_albumnum, HttpSession session) {
		
		String str = null;
		
		logger.debug("좋아요 취소: " + likeit_albumnum);

		String memberid = ((Member) session.getAttribute("Member")).getMember_id();
		 
		ArrayList<LikesVO> vo = albumlikesDAO.getAlbum(likeit_albumnum);
		// id 비교해서 좋아요 취소
		for (int i = 0; i < vo.size(); i++) {
			if(vo.get(i).getLikeit_memberid().equals(memberid)){
				albumlikesDAO.deleteLikes(vo.get(i));
				str = "success";
			}
		}
		return str;
	}
	// 좋아요 목록
	@ResponseBody
	@RequestMapping(value = "/listLikes", method = RequestMethod.GET)
	public ArrayList<LikesVO> listLikes(Model model, 
			@RequestParam int likeit_albumnum) {
		
		ArrayList<LikesVO> likesList = albumlikesDAO.listLikes(likeit_albumnum);
		
		return likesList;
	}
	//좋아요 갯수 
	@ResponseBody
	@RequestMapping(value = "/count_like", method = RequestMethod.POST)
	public int count_like(Model model, int likeit_albumnum) {
		logger.info("count_like_ljs__album_num:" + likeit_albumnum);
		return albumlikesDAO.countLikes(likeit_albumnum);
	}
	
	/*
	 * 좋아요
	 * 앨범 번호와 유저의 아이디를 가지고
	 * 1. 기존에 좋아요 한 이력이 있는지 확인
	 * 2. 없을 경우 좋아요 추가 후 새로 조회한 좋아요 개수 반환
	 * 3. 있을 경우 좋아요 취소 후 새로 조회한 좋아요 개수 반환
	 */
	@ResponseBody
	@RequestMapping(value = "/addLike", method = RequestMethod.POST)
	public LikesVO addLike(Model model, int album_num, HttpSession session) {
		
		String user_id = ((Member) session.getAttribute("Member")).getMember_id();
		LikesVO like = new LikesVO(album_num, user_id);
		albumlikesDAO.addLike(like);
		
		return albumlikesDAO.selelct_like(like);
	}
	
}
