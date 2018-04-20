package com.cooing.www.dy.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;

@Repository
public class AlbumDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean personal_createAlbum(AlbumWriteVO albumwrite){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		if(mapper.personal_createAlbum(albumwrite) > 0) {
			return true;
		} else {
			return false;
		}	
	}
	
	public int personal_selectAlbum_Num(String album_identifier){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.personal_selectAlbum_Num(album_identifier);
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
		if( mapper.personal_update_page1_Album(albumwrite) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public String MyAlbumListOutPut(String html){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.MyAlbumListOutPut(html);
		
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
	
	public int updateThumbnail(Map<String,String> map){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.updateThumbnail(map);	
	}
	
	public int deleteAlbum(int album_num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.deleteAlbum(album_num);	
	}
	
	public ArrayList<AlbumWriteVO> TotalAlbumList(){		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);		
		return mapper.TotalAlbumList();			
	}
	
	public ArrayList<AlbumWriteVO> MyAlbumList(String album_writer){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.MyAlbumList(album_writer);
	}
	
	public ArrayList<String> MyAlbumRead(int pagenum){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.MyAlbumRead(pagenum);		
	}
}
