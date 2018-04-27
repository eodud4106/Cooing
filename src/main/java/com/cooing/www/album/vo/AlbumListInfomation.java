package com.cooing.www.album.vo;

public class AlbumListInfomation {
	
	private int album_num;
	private String album_writer;
	private String album_name;
	private String album_contents;
	private int category;
	private int likeit_count;
	
	public AlbumListInfomation() {
		super();
	}
	public AlbumListInfomation(int album_num, String album_writer, String album_name, String album_contents,
			int category, int likeit_count) {
		super();
		this.album_num = album_num;
		this.album_writer = album_writer;
		this.album_name = album_name;
		this.album_contents = album_contents;
		this.category = category;
		this.likeit_count = likeit_count;
	}
	public int getAlbum_num() {
		return album_num;
	}
	public void setAlbum_num(int album_num) {
		this.album_num = album_num;
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
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getLikeit_count() {
		return likeit_count;
	}
	public void setLikeit_count(int likeit_count) {
		this.likeit_count = likeit_count;
	}
	@Override
	public String toString() {
		return "AlbumListInfomation [album_num=" + album_num + ", album_writer=" + album_writer + ", album_name="
				+ album_name + ", album_contents=" + album_contents + ", category=" + category + ", likeit_count="
				+ likeit_count + "]";
	}
	
	
	
	

}
