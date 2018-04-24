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

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.jinsu.dao.MemberDAO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.Member;
import com.cooing.www.jinsu.object.Party;
import com.cooing.www.jinsu.object.PartyMember;

@Controller
public class RelationController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	AlbumDAO albumDAO;
	
	//친구페이지
	@RequestMapping(value="/friend_get" , method = RequestMethod.GET)
	public String friend_get(String id , Model model , HttpSession session){
		logger.info("friend_get__jinsu");
		Member personally = get_session(session);
		Member friend= memberDAO.selectMember(id);
		model.addAttribute("friend_id", friend);
		ArrayList<String> arrfriend = relationDAO.selectFriend(personally.getMember_id());
		for(String s:arrfriend){
			if(s.equals(friend.getMember_id())){
				model.addAttribute("check" , true);
				break;
			}
		}
		int totalpage = albumDAO.IDAlbumCount(id);
		model.addAttribute("totalpage", (totalpage/10));
		return "friendPage";
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
		
		// 파티 멤버의 id만 담는 배열
		ArrayList<String> groupmemberlist = new ArrayList<String>();
		
		// 아이디가 속한 파티를 불러온다
		ArrayList<Party> array_party = relationDAO.searchPartyByMemberid(personally.getMember_id());
		
		// 방금 불러온 파티의 party_num으로 파티 멤버를 불러와 멤버의 id만 배열에 담는다
		for (Party party : array_party) {
			ArrayList<PartyMember> array_memeber = relationDAO.searchPartyMember(party.getParty_num());
			for (PartyMember partyMember : array_memeber) {
				groupmemberlist.add(partyMember.getG_member_memberid());
			}
		}
		
		model.addAttribute("leaderlist", groupleaderlist);
		model.addAttribute("memberlist", groupmemberlist);
		
		return "/groupview";
	}
	
	@RequestMapping(value="/groupPage" , method = RequestMethod.GET)
	public String groupPage_get(String group_name , Model model){
		logger.info("groupPage__jinsu");
		Party party = relationDAO.searchParty(group_name);
		if(party != null){
			ArrayList<PartyMember> arr_party_member = relationDAO.searchPartyMember(party.getParty_num());
			ArrayList<Member> arr_member = new ArrayList<Member>();
			for(PartyMember pm: arr_party_member){
				arr_member.add(memberDAO.selectMember(pm.getG_member_memberid()));
			}
			model.addAttribute("partyleader" , memberDAO.selectMember(party.getParty_leader()));
			model.addAttribute("partyinfo", party);
			model.addAttribute("memberlist", arr_party_member);
			model.addAttribute("memberinfo", arr_member);
			return "/groupPage";
		}
		return "redirect:/";		
	}
	
	@ResponseBody
	@RequestMapping(value="/delete_member" , method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String delete_member(int partynum , String memberid){
		logger.info("delete_member__jinsu");
		logger.info(partynum+"_party , " + memberid + "_id");
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
			arr_member.add(memberDAO.selectMember(party.getG_member_memberid()));
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
