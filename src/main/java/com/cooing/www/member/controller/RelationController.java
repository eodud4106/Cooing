package com.cooing.www.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.member.dao.MemberDAO;
import com.cooing.www.member.dao.RelationDAO;
import com.cooing.www.member.vo.Member;
import com.cooing.www.member.vo.Party;
import com.cooing.www.member.vo.PartyMember;

@Controller
public class RelationController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	AlbumDAO albumDAO;
	
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
		logger.info(friendid +"_friend_plus__jinsu");
		Member personally = get_session(session);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friendid);				
		if(relationDAO.insertFriend(map) == true){
			return "success";
		}
		return "친구 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	@ResponseBody
	@RequestMapping(value="/friend_delete" , method = RequestMethod.POST ,produces = "application/text; charset=utf8")
	public String friend_delete(String friendid , HttpSession session){
		logger.info(friendid + "_friend_delete__jinsu");
		Member personally = get_session(session);
		Map<String,String> map = new HashMap<String,String>();
		map.put("person", personally.getMember_id());
		map.put("friend", friendid);				
		if(relationDAO.deleteFriend(map) == true){
			return "success";
		}
		return "친구 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	
	@RequestMapping(value="/groupcreate_get" , method = RequestMethod.GET)
	public String group_get(){
		logger.info("group_get__jinsu");
		return "/groupcreate";
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
		PartyMember pm = new PartyMember(personally.getMember_id(), groupname);
		relationDAO.insertPartyMember_by_party_name(pm);
		return inum;
	}
	
	@ResponseBody
	@RequestMapping(value="/party_member_create" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String party_member_create(int partynum , String groupmember , HttpSession session){
		logger.info("party_member_create__jinsu");
		String[] arr_str_member = groupmember.split(" ");		
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
		if(!relationDAO.insertPartyMember(new PartyMember(0 , partynum , smember.getMember_id())) == true)
			return "멤버 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
		return "success";		
	}
	
	@ResponseBody
	@RequestMapping(value="/delete_member" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String delete_member(int partynum , String memberid){
		logger.info("delete_member__jinsu");
		logger.info(partynum+"_party , " + memberid + "_id");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("party_num", partynum);
		map.put("member_id", memberid);
		if(relationDAO.deletePartyMember(map) > 0){
			return "success";
		}
		return "멤버 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
	}
	@ResponseBody
	@RequestMapping(value="/delete_party" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String delete_party(int partynum){
		logger.info("delete_party__jinsu");
		relationDAO.deleteMemberParty(partynum);
		if(relationDAO.deleteLeaderParty(partynum) > 0){
			return "success";
		}else{
			return "그룹 삭제를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
		}
				
	}
	
	@ResponseBody
	@RequestMapping(value="/member_list_post" , method = RequestMethod.POST)
	public ArrayList<Member> member_list_post(int partynum){
		logger.info("member_list_post__jinsu");
		ArrayList<PartyMember> arr_party_member = relationDAO.searchPartyMember(partynum);
		ArrayList<Member> arr_member = new ArrayList<Member>();
		for(PartyMember party : arr_party_member){
			arr_member.add(memberDAO.selectMember(party.getMember_id()));
		}
		return arr_member;
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
			if(party.getMember_id().equals(groupmember))
				return "이미 추가 되어 있는 아이디 입니다.";
		}
		if(smember.getMember_id().equals(groupmember)){
			return "자신의 ID는 추가할 수 없습니다.";
		}
//		if(!relationDAO.insertPartyMember(new PartyMember(0 , partynum , groupmember)))
//			return "멤버 추가를 실패 했습니다. 잠시 후 다시 시도해 주십시오.";		
		return "success";		
	}
	
	@ResponseBody
	@RequestMapping(value="/party_search_name" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String party_search_name(String groupname){
		Party party = relationDAO.searchParty(groupname);
		if(party == null){
			return "success";
		}else{
			return "fail";
		}		
	}
	
	

	
	private Member get_session(HttpSession session){
		return (Member)session.getAttribute("Member");
	}
}
