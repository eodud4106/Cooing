package com.cooing.www.jinsu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.jinsu.dao.MemberDAO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping("/jinsu")
public class RelationController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class); 
	private static final String strpath = "jinsu";
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	MemberDAO memberDAO;
	
	@RequestMapping(value="/friend_get" , method = RequestMethod.GET)
	public String friend_get(String id , Model model , HttpSession session){
		Member personally = (Member)session.getAttribute("Member");
		Member friend= memberDAO.selectMember(id);
		model.addAttribute("friend", friend);
		ArrayList<String> arrfriend = relationDAO.selectFriend(personally.getMember_id());
		for(String s:arrfriend){
			if(s.equals(friend.getMember_id())){
				model.addAttribute("check" , true);
				logger.info("check_sita");
				break;
			}
		}
		return strpath + "/friend";
	}
	
	@ResponseBody
	@RequestMapping(value="/friend_check" , method = RequestMethod.POST)
	public String friend_check(String id){
		Member friend= memberDAO.selectMember(id);
		if(friend != null){
			return "success";
		}
		return "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="/friend_plus" , method = RequestMethod.POST)
	public String friend_plus(String friendid , HttpSession session){
		Member personally = (Member)session.getAttribute("Member");
		Member friend= memberDAO.selectMember(friendid);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friend.getMember_id());				
		if(relationDAO.insertFriend(map) == true){
			return "success";
		}
		return "fail";
	}
	@ResponseBody
	@RequestMapping(value="/friend_delete" , method = RequestMethod.POST)
	public String friend_delete(String friendid , HttpSession session){
		Member personally = (Member)session.getAttribute("Member");
		Member friend= memberDAO.selectMember(friendid);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friend.getMember_id());				
		if(relationDAO.deleteFriend(map) == true){
			return "success";
		}
		return "fail";
	}
}
