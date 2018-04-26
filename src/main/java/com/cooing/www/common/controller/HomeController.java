package com.cooing.www.common.controller;

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

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.dao.AlbumLikesDAO;
import com.cooing.www.album.vo.AlbumLikesVO;
import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.album.vo.PageHtmlVO;
import com.cooing.www.common.dao.SearchDAO;
import com.cooing.www.common.vo.PageLimit;
import com.cooing.www.member.dao.MemberDAO;
import com.cooing.www.member.dao.RelationDAO;
import com.cooing.www.member.vo.Member;
import com.cooing.www.member.vo.Party;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	AlbumDAO albumDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	AlbumLikesDAO albumlikesDAO;
	@Autowired
	SearchDAO searchDAO;
	
	private Gson gson = new Gson();
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);
			int totalpage = albumDAO.TotalAlbumCount(personal.getMember_id());
			model.addAttribute("totalpage", (totalpage/10));
		}
		
		return "home";
	}
	
	@RequestMapping(value = "/search_other", method = RequestMethod.GET)
	public String search_other_home(Model model, HttpSession session , String search) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			ArrayList<String> arr_friend = relationDAO.selectFriend(personal.getMember_id());
			model.addAttribute("friend", arr_friend);
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);
			int totalpage = albumDAO.total_album_count(search,"3");
			model.addAttribute("totalpage", (totalpage/10));			
			//다른 곳에서 홈으로 검색을 통해 home으로 간다는 것을 알려준다.
			model.addAttribute("search_other", 0);
			//검색어
			model.addAttribute("search" , search);			
		}		
		return "home";
	}
	
	@RequestMapping(value = "/category_other", method = RequestMethod.GET)
	public String category_other_home(Model model, HttpSession session , int categorynum) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			ArrayList<String> arr_friend = relationDAO.selectFriend(personal.getMember_id());
			model.addAttribute("friend", arr_friend);
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);
			int totalpage = albumDAO.CategoryAlbumCount(categorynum);
			model.addAttribute("totalpage", (totalpage/10));			
			//다른 곳에서 홈으로 검색을 통해 home으로 간다는 것을 알려준다.
			model.addAttribute("search_other", 1);
			//검색어
			model.addAttribute("categorynum" , categorynum);			
		}		
		return "home";
	}
	
	
	// 개인 앨범 조회
	@ResponseBody
	@RequestMapping(value = "/getTotalAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getMyAlbumList(int pagenum , HttpSession session) {
		logger.info(pagenum + "_page_list ljs");
		Member member = (Member)session.getAttribute("Member");
		int totalnum = albumDAO.TotalAlbumCount(member.getMember_id());
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.TotalAlbumList(pl.getStartBoard() , pl.getCountPage() , member.getMember_id());
	}
	
	// 좋아요 목록 조회
	@ResponseBody
	@RequestMapping(value = "/getLikeAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getLikeAlbumList(int pagenum , HttpSession session) {
		logger.info(pagenum + "_like_page_list ljs");
		Member member = (Member)session.getAttribute("Member");
		int totalnum = albumDAO.TotalAlbumCount(member.getMember_id());
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		ArrayList<AlbumWriteVO> vo = albumDAO.LikeAlbumList(pl.getStartBoard() , pl.getCountPage() , member.getMember_id());
		logger.info(vo.toString());
		return vo;
	}	


	/**
	 * 앨범뷰... 앨범과 페이지 리스트를 갖고 albumView로 이동....
	 */
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumPage(int album_num, Model model) {
		
		try {
			AlbumWriteVO album = albumDAO.searchAlbumNum(album_num);
			if(album == null) return "redirect:/";
			ArrayList<PageHtmlVO> arr_page = albumDAO.select_pages_by_album_num(album_num);
			
			model.addAttribute("album", album);
			model.addAttribute("arr_page", arr_page);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "album/albumView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumRead", method = RequestMethod.POST)
	public ArrayList<PageHtmlVO> getMyAlbumRead(String num) {
		return  albumDAO.select_pages_by_album_num(Integer.parseInt(num));
	}

	//좋아요 체크
	@ResponseBody
	@RequestMapping(value = "/check_likes", method = RequestMethod.GET)
	public String albumTestPage(@RequestParam int likeit_albumnum,
			HttpSession session) {
		
		String likeit_memberid = ((Member) session.getAttribute("Member")).getMember_id();
	
		AlbumLikesVO vo = new AlbumLikesVO(likeit_albumnum, likeit_memberid);
		
		String check_likeMember = null;
		check_likeMember = albumlikesDAO.check_Likes(vo);
		System.out.println(check_likeMember);
		
		return check_likeMember;
	}
	
	//마이페이지
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(HttpSession session , Model model){
		Member member = (Member)session.getAttribute("Member");
		int totalpage = albumDAO.MyAlbumCount(member.getMember_id());
		model.addAttribute("totalpage", (totalpage/10));		
		return "myPage";
	}
	
	// 책 목록 조회
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getMyAlbumList(HttpSession session , int pagenum) {
		logger.info("myalbumlist_homecontroller_ljs");
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		int totalnum = albumDAO.MyAlbumCount(album_writer);
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.MyAlbumList(album_writer , pl.getStartBoard() , pl.getCountPage());
	}
	
	@ResponseBody
	@RequestMapping(value = "/getIDAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getIDAlbumList(HttpSession session , String albumwriter , int pagenum) {
		logger.info(albumwriter+"_IDalbumlist_homecontroller_ljs");
		int totalnum = albumDAO.IDAlbumCount(albumwriter);
		PageLimit pl = new PageLimit(10,5,pagenum,totalnum);
		return albumDAO.IDAlbumList(albumwriter , pl.getStartBoard() , pl.getCountPage());
	}
	
	//랭킹페이지
	@RequestMapping(value = "/LankingPage", method = RequestMethod.GET)
	public String LankingPage(){
		return "LankingPage";
	}
}
