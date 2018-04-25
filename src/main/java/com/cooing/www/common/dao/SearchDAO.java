package com.cooing.www.common.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.album.vo.CategoryPop;
import com.cooing.www.album.vo.HashTag;
import com.cooing.www.common.vo.Search;

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
	
	public boolean insertSearch(Search search){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		if(mapper.insertSearch(search) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<Map<String , Object>> selectDaySearch(String date){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		return mapper.selectDaySearch(date);
	}
	
	public boolean insertCategoryPop(CategoryPop categorypop){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		if(mapper.insertCategoryPop(categorypop) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<Map<String , Object>> selectDayLike(String date){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		ArrayList<Map<String , Object>> map = mapper.selectDayLike(date);
		for(Map<String , Object> m : map){
			System.out.println(m.toString());
		}
		return map;
	}
	
	public ArrayList<Map<String , Object>> selectDayCategory(String date){
		SearchMapper mapper = sqlSession.getMapper(SearchMapper.class);
		return mapper.selectDayCategory(date);
	}	
}
