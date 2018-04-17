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

import com.cooing.www.dy.dao.AlbumListAndReadDAO;
import com.cooing.www.dy.vo.AlbumListVO;
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
	AlbumListAndReadDAO albumListAndReadDAO;


	/**
	 * 앨범뷰...?? 뭐지???
	 */
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumPage(int album_num, Model model) {
		
		model.addAttribute("album_num", album_num);
		
		
		return "Album/albumView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumRead", method = RequestMethod.POST)
	public ArrayList<String> getMyAlbumRead(String num) {
		
		int album_num = 0;
		album_num = Integer.parseInt(num);
		
		ArrayList<String> myAlbumReadList = null;
		myAlbumReadList = albumListAndReadDAO.MyAlbumRead(album_num);
		
		System.out.println(myAlbumReadList.toString());
		
		
		return myAlbumReadList;
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
	public ArrayList<AlbumListVO> getMyAlbumList(HttpSession session) {
		
		ArrayList<AlbumListVO> albumList = new ArrayList<>();
		String album_writer = null;
		album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		albumList = albumListAndReadDAO.MyAlbumList(album_writer);
		System.out.println(albumList.toString());
		for (AlbumListVO albumListVO : albumList) {
			albumListVO.setPage_html(albumListVO.getPage_html().replaceAll("\\n", ""));
		}
		
		System.out.println("test");
		System.out.println(albumList.toString());
		
		return albumList;
	}
	
	//그룹페이지
	/*@RequestMapping(value = "/groupPage", method = RequestMethod.GET)
	public String groupPage(){
			
		return "groupPage";
	}*/
	
}
