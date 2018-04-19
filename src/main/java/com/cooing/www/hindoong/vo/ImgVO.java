package com.cooing.www.hindoong.vo;

public class ImgVO {

	private int img_id;
	private String original_name;
	private String saved_name;
	
	public ImgVO() {}

	public ImgVO(int img_id, String original_name, String saved_name) {
		super();
		this.img_id = img_id;
		this.original_name = original_name;
		this.saved_name = saved_name;
	}

	public int getImg_id() {
		return img_id;
	}

	public void setImg_id(int img_id) {
		this.img_id = img_id;
	}

	public String getOriginal_name() {
		return original_name;
	}

	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}

	public String getSaved_name() {
		return saved_name;
	}

	public void setSaved_name(String saved_name) {
		this.saved_name = saved_name;
	}

	@Override
	public String toString() {
		return "ImgVO [img_id=" + img_id + ", original_name=" + original_name + ", saved_name=" + saved_name + "]";
	};
	
}
