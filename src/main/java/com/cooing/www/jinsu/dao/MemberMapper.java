package com.cooing.www.jinsu.dao;

import java.util.ArrayList;

import com.cooing.www.jinsu.object.Category;
import com.cooing.www.jinsu.object.Member;

public interface MemberMapper {
	public int insertMember(Member member);
	public Member selectMember(String id);
	public ArrayList<String> searchId(String text);
	public int updateTimeMember(String id);
	public int insertCategory(Category category);
}
