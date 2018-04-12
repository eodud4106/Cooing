package com.cooing.www.dy.dao;

import java.util.ArrayList;  

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlbumListAndReadDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public String MyAlbumList(String album_writer){
		
		AlbumListAndReadMapper mapper = sqlSession.getMapper(AlbumListAndReadMapper.class);
		String str = null;
		
		return str;
			
	}
	
}
