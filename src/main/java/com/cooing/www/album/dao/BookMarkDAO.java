package com.cooing.www.album.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.album.vo.BookMark;

@Repository
public class BookMarkDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean bookmark_create(BookMark bookmark){
		BookMarkMapper mapper = sqlSession.getMapper(BookMarkMapper.class);
		if(mapper.bookmark_create(bookmark) > 0){
			return true;
		}		
		return false; 
	}
	
	public boolean bookmark_delete(BookMark bookmark){
		BookMarkMapper mapper = sqlSession.getMapper(BookMarkMapper.class);
		if(mapper.bookmark_delete(bookmark) > 0){
			return true;
		}		
		return false; 
	}
	
	public boolean bookmark_check(BookMark bookmark){
		BookMarkMapper mapper = sqlSession.getMapper(BookMarkMapper.class);
		if(mapper.bookmark_check(bookmark) != null){
			return true;
		}		
		return false; 
	}

}
