package com.cooing.www.dy.dao;

import java.util.ArrayList; 

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.Coordinate_Picture;
import com.cooing.www.jinsu.dao.MemberMapper;

@Repository
public class AlbumDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean createAlbum(AlbumWriteVO albumwrite){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.createAlbum(albumwrite);
		
		if(cnt > 0) {
			return true;
		} else {
			return false;
		}
		
		
	}
	
	public boolean insertAlbum_Picture(PageHtmlVO page){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.insertAlbum_Picture(page);
		
		if(cnt > 0) {
			return true;
		} else {
			return false;
		}
		
		
	}
}
