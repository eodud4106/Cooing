package com.cooing.www.dy.vo;

public class AlbumWriteVO {	
	private int album_num;
	private String album_writer;	
	private String album_name;	
	private int album_openrange;		
	private String album_contents;	
	private String album_editor;	
	private int album_category;
	private String album_identifier;
	private String album_thumbnail;
	
	public AlbumWriteVO() {
		super();
	}	
	
	public AlbumWriteVO(int album_num , String album_writer, int album_openrange , String album_identifier){
		this.album_num = album_num;
		this.album_writer = album_writer;
		this.album_openrange = album_openrange;
		this.album_identifier = album_identifier;
	}
	
	public AlbumWriteVO(int album_num , String album_writer , String album_name , int album_openrange , String album_contents , String album_editor , int album_category , String album_identifier , String album_thumbnail){
		this(album_num , album_writer , album_openrange , album_identifier);
		this.album_name = album_name;
		this.album_contents = album_contents;
		this.album_editor = album_editor;
		this.album_category = album_category;		
		this.album_thumbnail = album_thumbnail;
	}	

	public AlbumWriteVO(int album_num, String album_name, String album_contents,
			int album_category, int album_openrange) {
		super();
		this.album_num = album_num;
		this.album_name = album_name;
		this.album_contents = album_contents;
		this.album_category = album_category;
		this.album_openrange = album_openrange;
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

	public int getAlbum_openrange() {
		return album_openrange;
	}

	public void setAlbum_openrange(int album_openrange) {
		this.album_openrange = album_openrange;
	}

	public String getAlbum_contents() {
		return album_contents;
	}

	public void setAlbum_contents(String album_contents) {
		this.album_contents = album_contents;
	}

	public String getAlbum_editor() {
		return album_editor;
	}

	public void setAlbum_editor(String album_editor) {
		this.album_editor = album_editor;
	}

	public int getAlbum_category() {
		return album_category;
	}

	public void setAlbum_category(int album_category) {
		this.album_category = album_category;
	}

	public String getAlbum_identifier() {
		return album_identifier;
	}

	public void setAlbum_identifier(String album_identifier) {
		this.album_identifier = album_identifier;
	}

	public String getAlbum_thumbnail() {
		return album_thumbnail;
	}

	public void setAlbum_thumbnail(String album_thumbnail) {
		this.album_thumbnail = album_thumbnail;
	}

	@Override
	public String toString() {
		return "AlbumWriteVO [album_num=" + album_num + ", album_writer=" + album_writer + ", album_name=" + album_name
				+ ", album_openrange=" + album_openrange + ", album_contents=" + album_contents + ", album_editor="
				+ album_editor + ", album_category=" + album_category + ", album_identifier=" + album_identifier
				+ ", album_thumbnail=" + album_thumbnail + "]";
	}
}
