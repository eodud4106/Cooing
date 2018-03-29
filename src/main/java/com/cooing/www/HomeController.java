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

import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	RelationDAO relationDAO;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
	/**
	 * 메인페이지로 이동.
	 */
	@RequestMapping(value = "/albumList", method = RequestMethod.GET)
	public String mainPage(Model model,HttpSession session) {
		Member personal = (Member)session.getAttribute("Member");
		logger.info(personal.getMember_id());
		ArrayList<String> arr_friend = relationDAO.selectFriend(personal.getMember_id());
		model.addAttribute("friend", arr_friend);
		logger.info(arr_friend.toString());
		return "albumList";
	}
	
	/**
	 * 앨범뷰...?? 뭐지???
	 */
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumPage(Model model) {
		
		return "albumView";
	}
	
}
