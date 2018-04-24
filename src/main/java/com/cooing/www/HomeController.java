package com.cooing.www;

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

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.jinsu.dao.MemberDAO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.dao.SearchDAO;
import com.cooing.www.jinsu.object.Member;
import com.cooing.www.jinsu.object.PageLimit;
import com.cooing.www.jinsu.object.Party;
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
	SearchDAO searchDAO;
	@Autowired
	MemberDAO memberDAO;
	
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
			int totalpage = searchDAO.searchAllAlbumCount(search);
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
		return albumDAO.LikeAlbumList(pl.getStartBoard() , pl.getCountPage() , member.getMember_id());
	}	
}
