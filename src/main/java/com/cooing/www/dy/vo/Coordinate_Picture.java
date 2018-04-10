package com.cooing.www.dy.vo;

public class Coordinate_Picture {
	private int page;
	private int div_num;
	private int picture_top;
	private int picture_left;
	private int picture_width;
	private int picture_height;
	
	public Coordinate_Picture() {
		super();
	}
	
	public Coordinate_Picture(int page, int div_num, int picture_top, int picture_left, int picture_width,
			int picture_height) {
		super();
		this.page = page;
		this.div_num = div_num;
		this.picture_top = picture_top;
		this.picture_left = picture_left;
		this.picture_width = picture_width;
		this.picture_height = picture_height;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}
	
	public int getDiv_num() {
		return div_num;
	}

	public void setDiv_num(int div_num) {
		this.div_num = div_num;
	}
	
	public int getPicture_top() {
		return picture_top;
	}

	public void setPicture_top(int picture_top) {
		this.picture_top = picture_top;
	}

	public int getPicture_left() {
		return picture_left;
	}

	public void setPicture_left(int picture_left) {
		this.picture_left = picture_left;
	}

	public int getPicture_width() {
		return picture_width;
	}

	public void setPicture_width(int picture_width) {
		this.picture_width = picture_width;
	}

	public int getPicture_height() {
		return picture_height;
	}

	public void setPicture_height(int picture_height) {
		this.picture_height = picture_height;
	}



	@Override
	public String toString() {
		return "Coordinate_Picture [page=" + page + ", div_num=" + div_num + ", picture_top=" + picture_top
				+ ", picture_left=" + picture_left + ", picture_width=" + picture_width + ", picture_height="
				+ picture_height + "]";
	}


}
