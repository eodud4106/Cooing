package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import com.cooing.www.jinsu.object.Category;
import com.cooing.www.jinsu.object.Member;

public interface MemberMapper {
	public int insertMember(Member member);
	public ArrayList<String> searchallId(String all);
	public Member selectMember(String id);
	public ArrayList<Member> searchId(Map<String,String> map);
	public ArrayList<Member> searchUser(Map<String,String> map);
	public ArrayList<Member> selectfriend(String myid);
	public int updateTimeMember(String id);
	public int insertCategory(Category category);
}
