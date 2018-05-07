package com.cooing.www.member.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.album.vo.Category;
import com.cooing.www.member.vo.Member;

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
	
	public ArrayList<String> searchallId(String all){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.searchallId(all);
	}
	
	public ArrayList<Member> searchId(Map<String,String> map){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.searchId(map);
	}
	
	public ArrayList<Member> selectfriend(String myid){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectfriend(myid);
	}
	
	public ArrayList<Member> searchUser(Map<String,String> map){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.searchUser(map);
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