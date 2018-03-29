package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RelationDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertFriend(Map<String , String> map){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.insertFriend(map) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<String> selectFriend(String id){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);							
		return mapper.selectFriend(id);
	}
	
	public boolean deleteFriend(Map<String , String> map){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.deleteFriend(map) > 0)
			return true;
		else 
			return false;
	}
}
