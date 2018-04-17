package com.cooing.www;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.socket.TextMessage;

import com.cooing.www.dy.dao.AlbumListAndReadDAO;
import com.cooing.www.dy.vo.AlbumListVO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;
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
	AlbumListAndReadDAO albumListAndReadDAO;
	private Gson gson = new Gson();
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			ArrayList<String> arr_friend = relationDAO.selectFriend(personal.getMember_id());
			model.addAttribute("friend", arr_friend);
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);
		}
		
		String album_writer = null;
		album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		ArrayList<AlbumListVO> myAlbumList = null;
		myAlbumList = albumListAndReadDAO.MyAlbumList(album_writer);
		model.addAttribute("myAlbumListSize", myAlbumList.size());
		
		HashMap<String, AlbumListVO> myAlbumMap = new HashMap<>();
		HashMap<String, String> myAlbumPageMap = new HashMap<>();
		
//		for(AlbumListVO albumListVO: myAlbumList) {
//			String tmp = albumListVO.getPage_html();
//			String str = "#"+albumListVO.getAlbum_num();
//			
//			//앨범 넘버와 페이지만 가져가는 부분
//			tmp.replaceAll("\\t", "");
//			tmp.replaceAll(" ", "");
//			albumListVO.setPage_html(tmp.replaceAll("\\n", ""));
//			myAlbumPageMap.put(str, albumListVO.getPage_html());
//			
//			//앨범 넘버와 제목,내용, 작성자를 가져가는 부분
//			albumListVO.setPage_html(null);
//			myAlbumMap.put(str, albumListVO);
//			
//		}
		
		for (AlbumListVO albumListVO : myAlbumList) {
			albumListVO.setPage_html(albumListVO.getPage_html().replaceAll("\\n", "\\\\n"));
		}
		
		model.addAttribute("arr_page", myAlbumList);
		
//		model.addAttribute("albumlist", myAlbumMap);
//		model.addAttribute("pagelist", myAlbumPageMap);
		
		return "home";
	}
}
