package com.cooing.www.dy.dao;

import java.util.ArrayList;

import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;

public interface AlbumMapper {
	
	public int personal_createAlbum(AlbumWriteVO albumwrite);
	
	public int personal_insertAlbumOfPage(PageHtmlVO page);
	
	public int personal_selectAlbum_Num(String album_identifier);
	
	public int personal_update_page1_Album(AlbumWriteVO albumwrite);
	
	
	public String MyAlbumListOutPut(String html);
	
	public ArrayList<AlbumWriteVO> searchAlbum(String searchtext);
	
	public ArrayList<AlbumWriteVO> searchCategory(int icategorynum);
	
	public AlbumWriteVO searchAlbumNum(int num);
	
	public PageHtmlVO searchPage1(int num);
}
