package com.cooing.www.dy.dao;

import java.util.ArrayList;  

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.jinsu.dao.MemberMapper;

@Repository
public class AlbumDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean personal_createAlbum(AlbumWriteVO albumwrite){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.personal_createAlbum(albumwrite);
		
		if(cnt > 0) {
			return true;
		} else {
			return false;
		}	
	}
	
	public int personal_selectAlbum_Num(String album_identifier){
			
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = 0;
		cnt = mapper.personal_selectAlbum_Num(album_identifier);
		
		return cnt;
	}
	
	public boolean personal_insertAlbumOfPage(PageHtmlVO page){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.personal_insertAlbumOfPage(page);
		
		if(cnt > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean personal_update_page1_Album(AlbumWriteVO albumwrite){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = mapper.personal_update_page1_Album(albumwrite);
		
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
	
	public ArrayList<AlbumWriteVO> searchAlbum(String searchtext){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchAlbum(searchtext);
	}
	
	public AlbumWriteVO searchAlbumNum(int num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchAlbumNum(num);		
	}
	
	public PageHtmlVO searchPage1(int num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchPage1(num);		
	}
	
	public ArrayList<AlbumWriteVO> searchCategory(int icategorynum){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchCategory(icategorynum);		
	}	
}
