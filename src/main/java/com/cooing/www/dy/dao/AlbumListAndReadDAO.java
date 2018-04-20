package com.cooing.www.dy.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.AlbumListVO;
import com.cooing.www.dy.vo.AlbumWriteVO;

@Repository
public class AlbumListAndReadDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList<AlbumWriteVO> TotalAlbumList(){		
		AlbumListAndReadMapper mapper = sqlSession.getMapper(AlbumListAndReadMapper.class);		
		return mapper.TotalAlbumList();			
	}
	
	public ArrayList<AlbumListVO> MyAlbumList(String album_writer){
		
		AlbumListAndReadMapper mapper = sqlSession.getMapper(AlbumListAndReadMapper.class);
		ArrayList<AlbumListVO> myalbumlist = null;
		myalbumlist = mapper.MyAlbumList(album_writer);
		
		return myalbumlist;
			
	}
	
	public ArrayList<String> MyAlbumRead(int album_num){
		
		AlbumListAndReadMapper mapper = sqlSession.getMapper(AlbumListAndReadMapper.class);
		ArrayList<String> myAlbumReadList = null;
		myAlbumReadList = mapper.MyAlbumRead(album_num);
		
		return myAlbumReadList;
			
	}
	
	
	
}
