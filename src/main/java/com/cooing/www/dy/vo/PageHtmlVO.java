package com.cooing.www.dy.vo;

public class PageHtmlVO {
	private int page_id;
	private int album_num;
	private int page_num;
	private String page_html;
	
	public PageHtmlVO() {}
	
	public PageHtmlVO(int album_num, int page_num, String page_html) {
		super();
		this.album_num = album_num;
		this.page_num = page_num;
		this.page_html = page_html;
	}

	public PageHtmlVO(int page_id, int album_num, int page_num, String page_html) {
		super();
		this.page_id = page_id;
		this.album_num = album_num;
		this.page_num = page_num;
		this.page_html = page_html;
	}

	public int getPage_id() {
		return page_id;
	}

	public void setPage_id(int page_id) {
		this.page_id = page_id;
	}

	public int getAlbum_num() {
		return album_num;
	}

	public void setAlbum_num(int album_num) {
		this.album_num = album_num;
	}

	public int getPage_num() {
		return page_num;
	}

	public void setPage_num(int page_num) {
		this.page_num = page_num;
	}

	public String getPage_html() {
		return page_html;
	}

	public void setPage_html(String page_html) {
		this.page_html = page_html;
	}

	@Override
	public String toString() {
		return "PageHtmlVO [page_id=" + page_id + ", album_num=" + album_num + ", page_num=" + page_num + ", page_html="
				+ page_html + "]";
	}
	
	
}
