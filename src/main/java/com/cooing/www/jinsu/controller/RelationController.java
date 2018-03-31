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
import com.cooing.www.jinsu.object.Party;
import com.cooing.www.jinsu.object.PartyMember;

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
		logger.info("friend_get__jinsu");
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
		logger.info("friend_check__jinsu");
		Member friend= memberDAO.selectMember(id);
		if(friend != null){
			return "success";
		}
		return "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="/friend_plus" , method = RequestMethod.POST)
	public String friend_plus(String friendid , HttpSession session){
		logger.info("friend_plus__jinsu");
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
		logger.info("friend_delete__jinsu");
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
	
	@RequestMapping(value="/groupcreate_get" , method = RequestMethod.GET)
	public String group_get(){
		logger.info("group_get__jinsu");
		return strpath + "/groupcreate";
	}
	@ResponseBody
	@RequestMapping(value="/party_create" , method = RequestMethod.POST)
	public int party_create(HttpSession session , String groupname){
		logger.info("party_create__jinsu");
		Member personally = (Member)session.getAttribute("Member");
		if(personally == null){
			return -1;
		}
		int inum = -1;
		if(relationDAO.insertParty(new Party(0,groupname , personally.getMember_id()))){
			inum = relationDAO.searchPartyNumber(groupname);			
		}
		return inum;
	}
	
	@ResponseBody
	@RequestMapping(value="/party_member_create" , method = RequestMethod.POST)
	public String party_member_create(int partynum , String groupmember){
		logger.info("party_member_create__jinsu");
		String[] arr_str_member = groupmember.split("<br>");
		for(String s : arr_str_member){			
			if(!s.isEmpty() && s.length() != 0){
				if(!relationDAO.insertPartyMember(new PartyMember(0 , partynum , s)) == true)
					return "fail";
			}
		}		
		return "success";		
	}
	
	@RequestMapping(value="/groupview_get" , method = RequestMethod.GET)
	public String groupview_get(HttpSession session , Model model){
		logger.info("groupview_get__jinsu");
		Member personally = (Member)session.getAttribute("Member");
		if(personally == null){
			return "redirect:/";
		}
		ArrayList<String> groupleaderlist = new ArrayList<String>();
		ArrayList<String> arraystrval = relationDAO.searchLeaderPartyName(personally.getMember_id());
		for(String s : arraystrval){
			groupleaderlist.add(s);
		}
		arraystrval.clear();
		ArrayList<String> groupmemberlist = new ArrayList<String>();
		ArrayList<Integer> arrayintval = relationDAO.searchMemberPartyName(personally.getMember_id());
		for(Integer i : arrayintval){
			arraystrval.add(relationDAO.searchPartyName(i));
		}
		for(String s : arraystrval){
			groupmemberlist.add(s);
		}
		
		model.addAttribute("leaderlist", groupleaderlist);
		model.addAttribute("memberlist", groupmemberlist);
		
		return strpath + "/groupview";
	}
}
