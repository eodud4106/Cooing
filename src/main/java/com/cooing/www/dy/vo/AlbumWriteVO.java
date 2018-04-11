package com.cooing.www.dy.vo;

public class AlbumWriteVO {	
	private String album_writer;	
	private String album_name;	
	private int album_party;	
	private int album_delete;	
	private String album_deleteid;	
	private String album_contents;	
	private String album_editor;	
	private int album_version;
	private int album_category;
	
	public AlbumWriteVO() {
		super();
	}	

	public AlbumWriteVO(String album_writer, String album_name, int album_party, int album_delete, String album_contents,
			int album_version, int album_category) {
		super();
		this.album_writer = album_writer;
		this.album_name = album_name;
		this.album_party = album_party;
		this.album_delete = album_delete;
		this.album_contents = album_contents;
		this.album_version = album_version;
		this.album_category = album_category;
	}


	public AlbumWriteVO(String album_writer, String album_name, int album_party, int album_delete, String album_deleteid,
			String album_contents, String album_editor, int album_version, int album_category) {
		super();
		this.album_writer = album_writer;
		this.album_name = album_name;
		this.album_party = album_party;
		this.album_delete = album_delete;
		this.album_deleteid = album_deleteid;
		this.album_contents = album_contents;
		this.album_editor = album_editor;
		this.album_version = album_version;
		this.album_category = album_category;
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

	public int getAlbum_party() {
		return album_party;
	}

	public void setAlbum_party(int album_party) {
		this.album_party = album_party;
	}

	public int getAlbum_delete() {
		return album_delete;
	}

	public void setAlbum_delete(int album_delete) {
		this.album_delete = album_delete;
	}

	public String getAlbum_deleteid() {
		return album_deleteid;
	}

	public void setAlbum_deleteid(String album_deleteid) {
		this.album_deleteid = album_deleteid;
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

	public int getAlbum_version() {
		return album_version;
	}

	public void setAlbum_version(int album_version) {
		this.album_version = album_version;
	}
	
	

	public int getAlbum_category() {
		return album_category;
	}


	public void setAlbum_category(int album_category) {
		this.album_category = album_category;
	}


	@Override
	public String toString() {
		return "AlbumWrite [album_writer=" + album_writer + ", album_name=" + album_name + ", album_party="
				+ album_party + ", album_delete=" + album_delete + ", album_deleteid=" + album_deleteid
				+ ", album_contents=" + album_contents + ", album_editor=" + album_editor + ", album_version="
				+ album_version + ", album_category=" + album_category + "]";
	}
	
}
