package com.cooing.www.album.dao;

import java.util.ArrayList;

import com.cooing.www.album.vo.BookMark;

public interface BookMarkMapper {
	// 책갈피
	public int bookmark_create(BookMark bookmark);
	
	public int bookmark_delete(BookMark bookmark);
	
	public BookMark bookmark_check(BookMark bookmark);
	
	public ArrayList<BookMark> bookmark_list(String bookmark_memberid);
}
