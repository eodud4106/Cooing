package com.cooing.www.dy.dao;

import java.util.ArrayList;

import com.cooing.www.dy.vo.AlbumListVO;
import com.cooing.www.dy.vo.AlbumWriteVO;

public interface AlbumListAndReadMapper {
	
	public int albumListCount(String album_writer);
	
	public ArrayList<AlbumWriteVO> TotalAlbumList();
	
	public ArrayList<AlbumListVO> MyAlbumList(String album_writer);
	
	public ArrayList<String> MyAlbumRead(int album_num);
	
	
	
	
}
