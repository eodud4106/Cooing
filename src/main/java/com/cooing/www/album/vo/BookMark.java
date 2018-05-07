package com.cooing.www.album.vo;

public class BookMark {
	
	private int bookmark_num;
	private int bookmark_albumnum;
	private String bookmark_memberid;
	private int bookmark_page;
	//
	private String album_writer;	
	private String album_name;		
	private String album_contents;	
	private int album_category;
	private String album_thumbnail;
	
	public BookMark(){}
	public BookMark(int bookmark_num , int bookmark_albumnum , String bookmark_memberid , int bookmark_page){
		this.bookmark_num = bookmark_num;
		this.bookmark_albumnum = bookmark_albumnum;
		this.bookmark_memberid = bookmark_memberid;
		this.bookmark_page = bookmark_page;
	}
	public BookMark(int bookmark_num, int bookmark_albumnum, String bookmark_memberid, int bookmark_page,
			String album_writer, String album_name, String album_contents, int album_category) {
		super();
		this.bookmark_num = bookmark_num;
		this.bookmark_albumnum = bookmark_albumnum;
		this.bookmark_memberid = bookmark_memberid;
		this.bookmark_page = bookmark_page;
		this.album_writer = album_writer;
		this.album_name = album_name;
		this.album_contents = album_contents;
		this.album_category = album_category;
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
	
	public String getAlbum_writer() {
		return album_writer;
	}
	public void setAlbum_writer(String album_writer) {
		this.album_writer = album_writer;
	}
	public String getAlbum_name() {
		return album_name;
	}
	public void setAlbum_name(String album_name) {
		this.album_name = album_name;
	}
	public String getAlbum_contents() {
		return album_contents;
	}
	public void setAlbum_contents(String album_contents) {
		this.album_contents = album_contents;
	}
	public int getAlbum_category() {
		return album_category;
	}
	public void setAlbum_category(int album_category) {
		this.album_category = album_category;
	}
	
	public String getAlbum_thumbnail() {
		return album_thumbnail;
	}
	public void setAlbum_thumbnail(String album_thumbnail) {
		this.album_thumbnail = album_thumbnail;
	}
	@Override
	public String toString() {
		return "BookMark [bookmark_num=" + bookmark_num + ", bookmark_albumnum=" + bookmark_albumnum
				+ ", bookmark_memberid=" + bookmark_memberid + ", bookmark_page=" + bookmark_page + ", album_writer="
				+ album_writer + ", album_name=" + album_name + ", album_contents=" + album_contents
				+ ", album_category=" + album_category + ", album_thumbnail=" + album_thumbnail + "]";
	}
	
	
}
