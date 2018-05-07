package com.cooing.www.member.dao;

import java.util.ArrayList;
import java.util.Map;

import com.cooing.www.member.vo.Party;
import com.cooing.www.member.vo.PartyMember;

public interface RelationMapper {
	public int insertFriend(Map<String , String> map);
	public ArrayList<String> selectFriend(String id);
	public int deleteFriend(Map<String , String> map);
	
	public int insertParty(Party group);
	public int searchPartyNumber(String id);
	public ArrayList<String> searchLeaderPartyName(String id);
	public int insertPartyMember(PartyMember pm);
	public ArrayList<Party> searchPartyByMemberid(String id);
	public String searchPartyName(int inum);
	public Party searchParty(String groupname);
	public ArrayList<PartyMember> searchPartyMember(int groupnum);
	public int deletePartyMember(Map<String,Object> map);
	public int deleteMemberParty(int groupnum);
	public int deleteLeaderParty(int groupnum);
	public ArrayList<PartyMember> searchPartyMember_by_party_name(String party_name);
	public int insertPartyMember_by_party_name(PartyMember pm);
}
