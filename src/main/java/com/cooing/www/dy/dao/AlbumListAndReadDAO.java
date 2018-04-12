package com.cooing.www.dy.dao;

import java.util.ArrayList;  

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.jinsu.dao.MemberMapper;

@Repository
public class AlbumListAndReadDAO {
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
	
	public int first_selectAlbum_Num(String isWrite){
			
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = 0;
		cnt = mapper.first_selectAlbum_Num(isWrite);
		
		return cnt;
	}
		
		
	
	public boolean insertAlbumOfPage(PageHtmlVO page){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.insertAlbumOfPage(page);
		
		if(cnt > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public String MyAlbumListOutPut(String html){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		String list_html = mapper.MyAlbumListOutPut(html);
		
		return list_html;
		
	}
	
}
