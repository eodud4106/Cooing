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
	
	//파티 앨범 리스트 카운트
	@ResponseBody
	@RequestMapping(value = "/getPartyAlbumCount", method= RequestMethod.POST)
	public int getPartyAlbumCount(String party_name, HttpSession session) {
		logger.info(party_name + "_page_count ljs");
		AlbumVO album = new AlbumVO();
		album.setAlbum_writer(party_name);
		album.setIsPersonal("0");
		// 파티는 파티 이름이 유니크. 그래서 파티 이름으로 총 파티 앨범 개수를 구한다.
		return albumDAO.select_album_count(album);
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
	
	// 책 카테고리 조회
	@ResponseBody
	@RequestMapping(value = "/getMyCategoryAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getMyCategoryAlbumList(HttpSession session , String categorynum ,  int pagenum) {
		logger.info("mycategoryalbumlist_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		int totalnum = albumDAO.searchCategoryCount("4", album_writer, categorynum);
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.searchCategory("4", album_writer, categorynum, pl.getStartBoard() , pl.getCountPage());
	}
	//책 카테고리 카운트 
	@ResponseBody
	@RequestMapping(value = "/getMyCategoryAlbumCount", method= RequestMethod.POST)
	public int getMyCategoryAlbumCount(HttpSession session , String categorynum) {
		logger.info("mycategoryalbumcount_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		return albumDAO.searchCategoryCount("4", album_writer, categorynum) / 10;
		
		
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
	
	// 책 카테고리 조회
	@ResponseBody
	@RequestMapping(value = "/getIDCategoryAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getIDCategoryAlbumList(HttpSession session , String albumwriter , String categorynum ,  int pagenum) {
		logger.info("IDcategoryalbumlist_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		int totalnum = albumDAO.friendCategoryCount(album_writer, "4", albumwriter, categorynum);
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.friendCategory(album_writer, "4", albumwriter, categorynum ,pl.getStartBoard() , pl.getCountPage());
	}
	//책 카테고리 카운트 
	@ResponseBody
	@RequestMapping(value = "/getIDCategoryAlbumCount", method= RequestMethod.POST)
	public int getIDCategoryAlbumCount(HttpSession session , String categorynum , String albumwriter) {
		logger.info("IDcategoryalbumcount_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		return albumDAO.friendCategoryCount(album_writer, "4", albumwriter, categorynum) / 10;
		
		
	}
	
	//앨범 리스트 리턴
	@ResponseBody
	@RequestMapping(value = "/get_album_list", method= RequestMethod.POST)
	public ArrayList<AlbumVO> get_album_list(String type, String keyword, String order, String openrange, 
			String writer_type, int page , String friendId , String userId , HttpSession session) {
		
		String user = ((Member)session.getAttribute("Member")).getMember_id();
		
		int album_per_page = 10;
		
		RowBounds rb = new RowBounds(page *10, album_per_page);
		
		HashMap<String, String> map = new HashMap<>();
		
		//홈 페이지에서 검색어 없이 로딩하는 것 외의 경우는 아직 기능 테스트가 안 되었으니 사용하지 마세요....
		
		/*
		 * type
		 *  - category: 카테고리 리스트
		 *  - writer: 검색 리스트
		 * 
		 * keyword: 모든 keyword 검색결과를 가지고 갈 때 사용   , category에서는 category번호
		 * 
		 * writer_type
		 *  - total: 가리지 않고 저자 검색 - 전체페이지
		 * 	- personal: 개인 앨범만 - 내페이지
		 * 	- party: 파티 앨범만 - 그룹페이지
		 *  - friend: 친구 앨범만  - 친구 페이지
		 * 
		 * order
		 *  - like: 좋아요 순
		 *  - date: 최신 순
		 * 
		 * userId
		 * 	- 내 아이디를 넣어서 가져가기 위해서 사용  & party에서는 party이름이 들어가야 겠지??
		 * 
		 * friendId
		 *  - 친구 페이지 갈때 친구 아이디를 넣어서 검색 하기 위해 사용 
		 */
		map.put("type", type);
		map.put("keyword", keyword);
		map.put("writer_type", writer_type);
		map.put("order", order);
		map.put("openrange", openrange);
		if(writer_type.equals("party"))
			map.put("userId", userId);
		else
			map.put("userId", user);
		map.put("friendId", friendId);
		
		return albumDAO.get_album_list(map, rb);
	}
	
	
}
