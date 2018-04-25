package com.cooing.www.album.vo;

public class BookMark {
	
	private int bookmark_num;
	private int bookmark_albumnum;
	private String bookmark_memberid;
	private int bookmark_page;
	
	public BookMark(){}
	public BookMark(int bookmark_num , int bookmark_albumnum , String bookmark_memberid , int bookmark_page){
		this.bookmark_num = bookmark_num;
		this.bookmark_albumnum = bookmark_albumnum;
		this.bookmark_memberid = bookmark_memberid;
		this.bookmark_page = bookmark_page;
	}
	public int getBookmark_num() {
		return bookmark_num;
	}
	public void setBookmark_num(int bookmark_num) {
		this.bookmark_num = bookmark_num;
	}
	public int getBookmark_albumnum() {
		return bookmark_albumnum;
	}
	public void setBookmark_albumnum(int bookmark_albumnum) {
		this.bookmark_albumnum = bookmark_albumnum;
	}
	public String getBookmark_memberid() {
		return bookmark_memberid;
	}
	public void setBookmark_memberid(String bookmark_memberid) {
		this.bookmark_memberid = bookmark_memberid;
	}
	public int getBookmark_page() {
		return bookmark_page;
	}
	public void setBookmark_page(int bookmark_page) {
		this.bookmark_page = bookmark_page;
	}
	@Override
	public String toString() {
		return "BookMark [bookmark_num=" + bookmark_num + ", bookmark_albumnum=" + bookmark_albumnum
				+ ", bookmark_memberid=" + bookmark_memberid + ", bookmark_page=" + bookmark_page + "]";
	}
}
