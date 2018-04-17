package com.cooing.www.dy.dao;

import java.util.ArrayList;

import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;

public interface AlbumMapper {
	
	public int createAlbum(AlbumWriteVO albumwrite);
	
	public int insertAlbumOfPage(PageHtmlVO page);
	
	public int first_selectAlbum_Num(String isWrite);
	
	public String MyAlbumListOutPut(String html);
	
	public ArrayList<AlbumWriteVO> searchAlbum(String searchtext);
	
	public ArrayList<AlbumWriteVO> searchCategory(int icategorynum);
	
	public AlbumWriteVO searchAlbumNum(int num);
	
	public PageHtmlVO searchPage1(int num);
}
