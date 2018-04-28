package com.cooing.www.album.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.album.vo.PageVO;

@Repository
public class AlbumDAO{
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 *	앨범 생성 후 album_num 리턴
	 */
	public int personal_createAlbum(AlbumVO albumwrite){
		
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
	public AlbumVO searchAlbumNum(int album_num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchAlbumNum(album_num);		
	}
	
	/**
	 *	앨범 넘버로 페이지 리스트 검색
	 */
	public ArrayList<PageVO> select_pages_by_album_num(int album_num) {
		
		ArrayList<PageVO> arr_page = null; 
		
		try {
			arr_page = sqlSession.getMapper(AlbumMapper.class).select_pages_by_album_num(album_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return arr_page;
	}
	
	/**
	 *  앨범 넘버로 페이지 전체 삭제
	 */
	public int delete_pages_by_album_num(int album_num) {
		
		int result = 0;
		
		try {
			result = sqlSession.getMapper(AlbumMapper.class).delete_pages_by_album_num(album_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return result;
	}
	
	public boolean personal_insertAlbumOfPage(PageVO page){
		
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
	//1번 검색 2번 좋아요리스트 3번 토탈 앨범 4번 내 앨범 5번 ID로 앨범찾기
	public ArrayList<AlbumVO> total_album_list(String search , String check , int startpl , int endpl ){
		System.out.println("total_album_list : " + search+"_search , " + check + "_check");
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		RowBounds rb = new RowBounds(startpl , endpl);
		Map<String,String> map = new HashMap<String,String>();
		map.put("check", check);
		map.put("search_writer", search);
		return mapper.total_album_list(rb , map);
	}
	public int total_album_count(String search , String check){
		System.out.println("total_album_count : " + search+"_search , " + check + "_check");
		Map<String,String> map = new HashMap<String,String>();
		map.put("check", check);
		map.put("search_writer", search);
		return sqlSession.getMapper(AlbumMapper.class).total_album_count(map);
	}
	
	public boolean personal_update_page1_Album(AlbumVO albumwrite){
		
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		if(mapper.personal_update_page1_Album(albumwrite) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public PageVO searchPage1(int num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.searchPage1(num);		
	}
	
	public ArrayList<AlbumVO> searchCategory(int icategorynum , int startpl , int endpl){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		RowBounds rb = new RowBounds(startpl , endpl);
		return mapper.searchCategory(rb , icategorynum);		
	}	
	
	public int updateThumbnail(Map<String,String> map){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.updateThumbnail(map);	
	}
	
	public int deleteAlbum(int album_num){
		AlbumMapper mapper = sqlSession.getMapper(AlbumMapper.class);
		return mapper.deleteAlbum(album_num);	
	}
	
	public int CategoryAlbumCount(int categorynum){
		return sqlSession.getMapper(AlbumMapper.class).CategoryAlbumCount(categorynum);
	}
	
	public ArrayList<AlbumVO> select_album(RowBounds rb, AlbumVO album) {
		return sqlSession.getMapper(AlbumMapper.class).select_album(rb, album);
	}
}
