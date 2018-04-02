package com.cooing.www.jinsu.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.jinsu.object.Category;
import com.cooing.www.jinsu.object.Member;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertMember(Member member){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.insertMember(member) > 0)
			return true;
		else 
			return false;
	}
	
	public Member selectMember(String id){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMember(id);
	}
	
	public ArrayList<String> searchId(String text){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.searchId(text);
	}
	
	public boolean updateTimeMember(String id){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.updateTimeMember(id) > 0)
			return true;
		else 
			return false;
	}
	
	public boolean insertCategory(Category category){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.insertCategory(category) > 0)
			return true;
		else 
			return false;
	}
}
