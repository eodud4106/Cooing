package com.cooing.www.dy.dao;

import java.util.ArrayList;

import com.cooing.www.dy.vo.AlbumListVO;

public interface AlbumListAndReadMapper {
	
	public int albumListCount(String album_writer);
	
	public ArrayList<AlbumListVO> MyAlbumList(String album_writer);
	
	
	
	
}
