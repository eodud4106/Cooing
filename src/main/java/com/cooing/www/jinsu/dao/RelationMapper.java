package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import com.cooing.www.jinsu.object.Party;
import com.cooing.www.jinsu.object.PartyMember;

public interface RelationMapper {
	public int insertFriend(Map<String , String> map);
	public ArrayList<String> selectFriend(String id);
	public int deleteFriend(Map<String , String> map);
	
	public int insertParty(Party group);
	public int searchPartyNumber(String id);
	public ArrayList<String> searchLeaderPartyName(String id);
	public int insertPartyMember(PartyMember pm);
	public ArrayList<Integer> searchMemberPartyName(String id);
	public String searchPartyName(int inum);
}
