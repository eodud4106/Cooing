package com.cooing.www.album.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.album.vo.PageVO;

public interface AlbumMapper {
	
	public int personal_createAlbum(AlbumVO albumwrite);
	
	public int personal_insertAlbumOfPage(PageVO page);
	
	public int personal_update_page1_Album(AlbumVO albumwrite);
	
	public ArrayList<AlbumVO> total_album_list(RowBounds rb , Map<String,String> map);
	
	public int total_album_count(Map<String,String> map);
	
	public ArrayList<AlbumVO> searchCategory(RowBounds rb ,Map<String,String> map);
	
	public int searchCategoryCount(Map<String,String> map);
	
	public AlbumVO searchAlbumNum(int num);
	
	public PageVO searchPage1(int num);
	
	public int updateThumbnail(Map<String,String> map);
	
	public int deleteAlbum(int album_num);
	
	public ArrayList<PageVO> select_pages_by_album_num(int album_num);
	
	public ArrayList<PageVO> select_pages_by_album(AlbumVO album);
	
	public int delete_pages_by_album_num(int album_num);
	// 검색 조건으로 앨범 리스트를 검색
	public ArrayList<AlbumVO> select_album(RowBounds rb, AlbumVO album);
	// 검색 조건으로 앨범 리스트의 개수를 검색
	public int select_album_count(AlbumVO album);
	
	// 검색 조건 포함 앨범 리스트 조회
	public ArrayList<AlbumVO> get_album_list(RowBounds rb, HashMap<String, String> map);
	
	// 앨범 작성자 프로필사진
	public String select_album_writer(String member_id);
}
