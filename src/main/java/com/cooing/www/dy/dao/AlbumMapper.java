package com.cooing.www.dy.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;

public interface AlbumMapper {
	
	public int personal_createAlbum(AlbumWriteVO albumwrite);
	
	public int personal_insertAlbumOfPage(PageHtmlVO page);
	
	public int personal_selectAlbum_Num(String album_identifier);
	
	public int personal_update_page1_Album(AlbumWriteVO albumwrite);
	
	
	public String MyAlbumListOutPut(String html);
	
	public ArrayList<AlbumWriteVO> searchAlbum(String searchtext);
	
	public ArrayList<AlbumWriteVO> searchCategory(RowBounds rb , int icategorynum);
	
	public AlbumWriteVO searchAlbumNum(int num);
	
	public PageHtmlVO searchPage1(int num);
	
	public int updateThumbnail(Map<String,String> map);
	
	public int deleteAlbum(int album_num);
	
	public ArrayList<AlbumWriteVO> TotalAlbumList(RowBounds rb , String album_writer);
	
	public ArrayList<AlbumWriteVO> IDAlbumList(RowBounds rb , String album_writer);
	
	public ArrayList<PageHtmlVO> select_pages_by_album_num(int album_num);
	
	public int TotalAlbumCount();
	
	public int SearchAlbumCount(String search);
	
	public int CategoryAlbumCount(int categorynum);
	
	public int IDAlbumCount(String album_writer);
	
	public int delete_pages_by_album_num(int album_num);
}
