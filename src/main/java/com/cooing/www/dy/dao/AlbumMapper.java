package com.cooing.www.dy.dao;

import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.dy.vo.AlbumWriteVO;

public interface AlbumMapper {
	public int createAlbum(AlbumWriteVO albumwrite);
	
	public int insertAlbum_Picture(PageHtmlVO page);
}
