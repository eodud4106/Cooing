package com.cooing.www.dy.vo;

public class PageHtmlVO {
	private int page_id;
	private int page_albumnum;
	private int page_num;
	private String page_html;
	
	public PageHtmlVO() {
	}
	
	

	public PageHtmlVO(int page_albumnum, int page_num, String page_html) {
		super();
		this.page_albumnum = page_albumnum;
		this.page_num = page_num;
		this.page_html = page_html;
	}



	public PageHtmlVO(int page_id, int page_albumnum, int page_num, String page_html) {
		this.page_id = page_id;
		this.page_albumnum = page_albumnum;
		this.page_num = page_num;
		this.page_html = page_html;
	}

	public int getPage_id() {
		return page_id;
	}

	public void setPage_id(int page_id) {
		this.page_id = page_id;
	}

	public int getPage_albumnum() {
		return page_albumnum;
	}

	public void setPage_albumnum(int page_albumnum) {
		this.page_albumnum = page_albumnum;
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
		return "AlbumHtmlVO [page_id=" + page_id + ", page_albumnum=" + page_albumnum + ", page_num=" + page_num
				+ ", page_html=" + page_html + "]";
	}
	
}
