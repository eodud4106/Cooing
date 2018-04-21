package com.cooing.www.dy.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;

@Repository
public class AlbumDAO {
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 개인 앨범 생성 후 album_num 리턴
	 */
	public int personal_createAlbum(AlbumWriteVO albumwrite){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		try {
			mapper.personal_createAlbum(albumwrite);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return albumwrite.getAlbum_num();
	}
	
	/**
	 * 앨범 넘버로 앨범 검색
	 */
	public AlbumWriteVO searchAlbumNum(int album_num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchAlbumNum(album_num);		
	}
	
	/**
	 *	앨범 넘버로 페이지 리스트 검색
	 */
	public ArrayList<PageHtmlVO> select_pages_by_album_num(int album_num) {
		
		ArrayList<PageHtmlVO> arr_page = null; 
		
		try {
			arr_page = sqlSession.getMapper(AlbumMapper.class).select_pages_by_album_num(album_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return arr_page;
	}
	
	public int personal_selectAlbum_Num(String album_identifier){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.personal_selectAlbum_Num(album_identifier);
	}
	
	public boolean personal_insertAlbumOfPage(PageHtmlVO page){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		int cnt = 0;
		try {
			cnt = mapper.personal_insertAlbumOfPage(page);
		} catch (Exception e) {
			
		}
		
		
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
	
	public ArrayList<AlbumWriteVO> TotalAlbumList(int stratpl , int endpl){		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		RowBounds rb = new RowBounds(stratpl , endpl);
		return mapper.TotalAlbumList(rb);			
	}
	
	public ArrayList<AlbumWriteVO> MyAlbumList(String album_writer , int stratpl , int endpl){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		RowBounds rb = new RowBounds(stratpl , endpl);
		return mapper.MyAlbumList(rb,album_writer);
	}
	
	public int TotalAlbumCount(){
		return sqlSession.getMapper(AlbumMapper.class).TotalAlbumCount();
	}
	
	public int IDAlbumCount(String album_writer){
		return sqlSession.getMapper(AlbumMapper.class).IDAlbumCount(album_writer);
	}
}
