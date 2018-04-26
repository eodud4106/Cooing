package com.cooing.www.album.dao;

import com.cooing.www.album.vo.BookMark;

public interface AlbumBookMarkMapper {
	// 책갈피
	public int bookmark_create(BookMark bookmark);
	
	public int bookmark_delete(BookMark bookmark);
	
	public BookMark bookmark_check(BookMark bookmark);
}
