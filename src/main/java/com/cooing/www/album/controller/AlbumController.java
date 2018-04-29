package com.cooing.www.album.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.common.vo.PageLimit;
import com.cooing.www.member.vo.Member;


@Controller
@RequestMapping(value = "album")
public class AlbumController {

	private static final Logger logger = LoggerFactory.getLogger(AlbumController.class);
	
	@Inject
	private AlbumDAO albumDAO;
	
	//파티 앨범 리스트 조회
	@ResponseBody
	@RequestMapping(value = "/getPartyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getPartyAlbumList(String party_name, int pagenum, HttpSession session) {
		logger.info(party_name + "_page_list ljs");
		
		AlbumVO album = new AlbumVO();
		album.setAlbum_writer(party_name);
		album.setIsPersonal("0");
		// 파티는 파티 이름이 유니크. 그래서 파티 이름으로 총 파티 앨범 개수를 구한다.
		int totalnum = albumDAO.select_album_count(album);
		
		PageLimit pl = new PageLimit(10, 5, pagenum, totalnum);
		RowBounds rb = new RowBounds(pl.getStartBoard(), pl.getCountPage());
		ArrayList<AlbumVO> arr_album = null;
		
		try {
			arr_album = albumDAO.select_album(rb, album);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return arr_album;
	}
	
	// 책 목록 조회
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getMyAlbumList(HttpSession session , String search ,  int pagenum) {
		logger.info("myalbumlist_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		int totalnum = albumDAO.total_album_count("",album_writer,"4");
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.total_album_list(search,album_writer , "4" , pl.getStartBoard() , pl.getCountPage());
	}
	//책 목록 카운트 
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumCount", method= RequestMethod.POST)
	public int getMyAlbumCount(HttpSession session , String search) {
		logger.info("myalbumlist_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		return albumDAO.total_album_count(search , album_writer ,"4") / 10;
	}
	
	//친구 목록 조회
	@ResponseBody
	@RequestMapping(value = "/getIDAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getIDAlbumList(HttpSession session , String search , String albumwriter , int pagenum) {
		logger.info(albumwriter+"_IDalbumlist_homecontroller_ljs");
		Member member = (Member)session.getAttribute("Member");
		int totalnum = albumDAO.friend_album_count("",albumwriter, member.getMember_id() , "5");
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.friend_album_list(search,albumwriter , member.getMember_id() , "5" , pl.getStartBoard() , pl.getCountPage());
	}
	
	//친구 총 목록 숫자
	@ResponseBody
	@RequestMapping(value = "/getIDAlbumCount", method= RequestMethod.POST)
	public int getIDAlbumCount(HttpSession session , String search , String albumwriter) {
		logger.info(albumwriter+"_IDalbumcount_homecontroller_ljs");
		Member member = (Member)session.getAttribute("Member");
		return albumDAO.friend_album_count(search,albumwriter, member.getMember_id() , "5") / 10;
	}
	
	//앨범 리스트 리턴
	@ResponseBody
	@RequestMapping(value = "/get_album_list", method= RequestMethod.POST)
	public ArrayList<AlbumVO> get_album_list(String type, String keyword, String order, String openrange, 
			String writer_type, int page, HttpSession session) {
		System.out.println("type: " + type + " / keyword: " + keyword + " / order: " + order + " / page: " + page);
		
		String userId = ((Member)session.getAttribute("Member")).getMember_id();
		
		int album_per_page = 10;
		
		RowBounds rb = new RowBounds(page *10, album_per_page);
		
		HashMap<String, String> map = new HashMap<>();
		
		/*
		 * type
		 *  - total: 전체 검색
		 *  - writer: 저자로 검색
		 *  - like: 내가 좋아요 한 사람만 검색 -> id keyword에 자신의 아이디 넣어야 함
		 * 
		 * keyword: writer 검색 시 검색할 writer, like일 경우 자신의 id
		 * 
		 * writer_type(tyep == writer 일 때만, keyword에는 그룹명이 들어가야겠지...)
		 *  - total: 가리지 않고 저자 검색
		 * 	- personal: 개인 앨범만
		 * 	- party: 파티 앨범만
		 * 
		 * order
		 *  - like: 좋아요 순
		 *  - date: 최신 순
		 * 
		 * openrange
		 * 	- private: 나만(type: writer, keyword: 내 아이디, writer_type: personal)
		 *  - friend: 친구만(type: writer, keyword: 친구 아이디, writer_type: personal)
		 * 	- party: 파티만(type: writer, keyword: 파티명, writer_type: party)
		 * 	- total: 전체(type: total, keyword: "", writer_type: total)
		 * 
		 * userId
		 * 	- openrange에서 시 현재 접속한 유저가 열람 권한이 있는지 판별하기 위해 넣어 보냄
		 */
		map.put("type", type);
		map.put("keyword", keyword);
		map.put("writer_type", writer_type);
		map.put("order", order);
		map.put("opendrange", openrange);
		map.put("userId", userId);
		
		return albumDAO.get_album_list(map, rb);
	}
	
	
}
