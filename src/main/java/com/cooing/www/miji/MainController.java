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


	/**
	 * 앨범뷰...?? 뭐지???
	 */
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumPage(Model model) {
		
		return "albumView";
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
	
	//그룹페이지
	/*@RequestMapping(value = "/groupPage", method = RequestMethod.GET)
	public String groupPage(){
			
		return "groupPage";
	}*/
	
}
