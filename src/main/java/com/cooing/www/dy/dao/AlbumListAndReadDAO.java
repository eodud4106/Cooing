package com.cooing.www.dy.dao;

import java.util.ArrayList;  

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.AlbumListVO;

@Repository
public class AlbumListAndReadDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList<AlbumListVO> MyAlbumList(String album_writer){
		
		AlbumListAndReadMapper mapper = sqlSession.getMapper(AlbumListAndReadMapper.class);
		ArrayList<AlbumListVO> myalbumlist = null;
		myalbumlist = mapper.MyAlbumList(album_writer);
		
		return myalbumlist;
			
	}
	
}
