package com.cooing.www.album.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.album.vo.AlbumListInfomation;
import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.album.vo.PageHtmlVO;

public interface AlbumMapper {
	
	public int personal_createAlbum(AlbumWriteVO albumwrite);
	
	public int personal_insertAlbumOfPage(PageHtmlVO page);
	
	public int personal_update_page1_Album(AlbumWriteVO albumwrite);
	
	public ArrayList<AlbumWriteVO> total_album_list(RowBounds rb , Map<String,String> map);
	
	public int total_album_count(Map<String,String> map);
	
	public ArrayList<AlbumWriteVO> searchCategory(RowBounds rb , int icategorynum);
	
	public AlbumWriteVO searchAlbumNum(int num);
	
	public PageHtmlVO searchPage1(int num);
	
	public int updateThumbnail(Map<String,String> map);
	
	public int deleteAlbum(int album_num);
	
	public ArrayList<PageHtmlVO> select_pages_by_album_num(int album_num);
	
	public int CategoryAlbumCount(int categorynum);
	
	public int delete_pages_by_album_num(int album_num);
	// 검색 조건으로 앨범 리스트를 검색
	public ArrayList<AlbumWriteVO> select_album(RowBounds rb, AlbumWriteVO album);
	
	public ArrayList<AlbumListInfomation> getMyAlbumInfomation(String album_writer);
}
