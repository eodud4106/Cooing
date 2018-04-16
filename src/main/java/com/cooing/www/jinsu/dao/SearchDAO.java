package com.cooing.www.jinsu.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.jinsu.object.HashTag;

@Repository
public class SearchDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertHashTag(HashTag tag){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		if(mapper.insertHashTag(tag) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<HashTag> selectHashTag(String search){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		return mapper.selectHashTag(search);
	}
	
}