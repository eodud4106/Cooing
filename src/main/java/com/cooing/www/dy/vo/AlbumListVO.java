package com.cooing.www.dy.vo;

public class AlbumListVO {
	
	private int album_num;
	private String album_name;
	private String album_contents;
	private String page_html;
	private int page_num;
	
	public AlbumListVO() {
		super();
	}

	public AlbumListVO(int album_num, String album_name, String album_contents, String page_html, int page_num) {
		super();
		this.album_num = album_num;
		this.album_name = album_name;
		this.album_contents = album_contents;
		this.page_html = page_html;
		this.page_num = page_num;
	}

	public int getAlbum_num() {
		return album_num;
	}

	public void setAlbum_num(int album_num) {
		this.album_num = album_num;
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

	public String getPage_html() {
		return page_html;
	}

	public void setPage_html(String page_html) {
		this.page_html = page_html;
	}

	public int getPage_num() {
		return page_num;
	}

	public void setPage_num(int page_num) {
		this.page_num = page_num;
	}

	@Override
	public String toString() {
		return "AlbumListVO [album_num=" + album_num + ", album_name=" + album_name + ", album_contents="
				+ album_contents + ", page_html=" + page_html + ", page_num=" + page_num + "]";
	}

}
