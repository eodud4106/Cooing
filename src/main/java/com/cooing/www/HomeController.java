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

import com.cooing.www.dy.dao.AlbumListAndReadDAO;
import com.cooing.www.dy.vo.AlbumListVO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;
import com.cooing.www.jinsu.object.Party;

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
		
		System.out.println(myAlbumList.size());
		
		if(myAlbumList.isEmpty() != true){
			for(int i=0; i<myAlbumList.size(); i++){
				System.out.println(myAlbumList.get(i).toString());
			}
		}
		
		return "home";
	}
}
