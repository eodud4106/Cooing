package com.cooing.www.miji;

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
import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	AlbumDAO albumDAO;


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
		
		return "Album/albumView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumRead", method = RequestMethod.POST)
	public ArrayList<PageHtmlVO> getMyAlbumRead(String num) {
		return  albumDAO.select_pages_by_album_num(Integer.parseInt(num));
	}
	
	@RequestMapping(value = "/albumTestView", method = RequestMethod.GET)
	public String albumTestPage() {
		
		return "albumTestView";
	}
	
	//친구페이지
	@RequestMapping(value = "/friendPage", method = RequestMethod.GET)
	public String friendPage(){
			
		return "friendPage";
	}
	
	//마이페이지
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(){
		return "myPage";
	}
	
	// 책 목록 조회
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getMyAlbumList(HttpSession session) {
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		return albumDAO.MyAlbumList(album_writer);
	}
	
	//랭킹페이지
	@RequestMapping(value = "/LankingPage", method = RequestMethod.GET)
	public String LankingPage(){
		return "LankingPage";
	}
	
}
