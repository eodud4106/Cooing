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
		Member personally = get_session(session);
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
	@RequestMapping(value="/friend_check" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String friend_check(String id){
		logger.info("friend_check__jinsu");
		Member friend= memberDAO.selectMember(id);
		if(friend != null){
			return "success";
		}
		return "친구 확인을 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	
	@ResponseBody
	@RequestMapping(value="/friend_plus" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String friend_plus(String friendid , HttpSession session){
		logger.info("friend_plus__jinsu");
		Member personally = get_session(session);
		Member friend= memberDAO.selectMember(friendid);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friend.getMember_id());				
		if(relationDAO.insertFriend(map) == true){
			return "success";
		}
		return "친구 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	@ResponseBody
	@RequestMapping(value="/friend_delete" , method = RequestMethod.POST ,produces = "application/text; charset=utf8")
	public String friend_delete(String friendid , HttpSession session){
		logger.info("friend_delete__jinsu");
		Member personally = get_session(session);
		Member friend= memberDAO.selectMember(friendid);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friend.getMember_id());				
		if(relationDAO.deleteFriend(map) == true){
			return "success";
		}
		return "친구 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
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
		Member personally = get_session(session);
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
	@RequestMapping(value="/party_member_create" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String party_member_create(int partynum , String groupmember , HttpSession session){
		logger.info("party_member_create__jinsu");
		String[] arr_str_member = groupmember.split("<br>");
		Member smember = get_session(session);
		if(arr_str_member.length > 7){
			return "그룹은 8명을 초과할 수 없습니다.";			
		}
		for(String s : arr_str_member){
			if(s.equals(smember.getMember_id()))
				return "자신의 ID는 그룹에 추가할 수 없습니다.";
		}
		for(String s : arr_str_member){			
			if(!s.isEmpty() && s.length() != 0){
				if(!relationDAO.insertPartyMember(new PartyMember(0 , partynum , s)) == true)
					return "멤버 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
			}
		}		
		return "success";		
	}
	
	@RequestMapping(value="/groupview_get" , method = RequestMethod.GET)
	public String groupview_get(HttpSession session , Model model){
		logger.info("groupview_get__jinsu");
		Member personally = get_session(session);
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
	
	@RequestMapping(value="/groupupdate_get" , method = RequestMethod.GET)
	public String groupudate_get(String group_name , HttpSession session , Model model){
		logger.info("groupudate_get__jinsu");
		Party party = relationDAO.searchParty(group_name);
		Member smember = get_session(session);
		if(party != null && smember != null){
			ArrayList<PartyMember> arr_party_member = relationDAO.searchPartyMember(party.getParty_num());
			if(smember.getMember_id().equals(party.getParty_leader())){
				model.addAttribute("partyinfo", party);
				model.addAttribute("memberlist", arr_party_member);
				return strpath+"/groupupdate";
			}
		}
		return "redirect:/";		
	}	
	
	@ResponseBody
	@RequestMapping(value="/delete_member" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String delete_member(int partynum , String memberid){
		logger.info("delete_member__jinsu");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("g_member_partynum", partynum);
		map.put("g_member_memberid", memberid);
		if(relationDAO.deletePartyMember(map) > 0){
			return "success";
		}
		return "멤버 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	@ResponseBody
	@RequestMapping(value="/delete_party" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String delete_party(int partynum){
		logger.info("delete_party__jinsu");
		if(relationDAO.deleteMemberParty(partynum) > 0){
			if(relationDAO.deleteLeaderParty(partynum) > 0){
				return "success";
			}
		}
		return "그룹 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	
	@ResponseBody
	@RequestMapping(value="/member_list_post" , method = RequestMethod.POST)
	public ArrayList<PartyMember> member_list_post(int partynum){
		logger.info("member_list_post__jinsu");
		return relationDAO.searchPartyMember(partynum);
	}
	
	@ResponseBody
	@RequestMapping(value="/party_member_input" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String party_member_input(int partynum , String groupmember ,HttpSession session){
		logger.info("party_member_input__jinsu");
		ArrayList<PartyMember> member = relationDAO.searchPartyMember(partynum);
		Member smember = get_session(session);
		if(member.size() > 7){
			return "그룹은 8명을 초과할 수 없습니다.";
		}
		for(PartyMember party : member){
			if(party.getG_member_memberid().equals(groupmember))
				return "이미 추가 되어 있는 아이디 입니다.";
		}
		if(smember.getMember_id().equals(groupmember)){
			return "자신의 ID는 추가할 수 없습니다.";
		}
		if(!relationDAO.insertPartyMember(new PartyMember(0 , partynum , groupmember)))
			return "멤버 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";		
		return "success";		
	}
	
	
	private Member get_session(HttpSession session){
		return (Member)session.getAttribute("Member");
	}
}
