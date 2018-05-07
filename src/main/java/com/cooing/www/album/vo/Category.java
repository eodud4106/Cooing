package com.cooing.www.album.vo;

public class Category {
	private int category_num;
	private String category_memberid;
	private int category_kind;
	
	public Category(){}
	public Category(int category_num , String category_memberid , int category_kind){
		this.category_num = category_num;
		this.category_memberid = category_memberid;
		this.category_kind = category_kind;
	}
	public int getCategory_num() {
		return category_num;
	}
	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}
	public String getCategory_memberid() {
		return category_memberid;
	}
	public void setCategory_memberid(String category_memberid) {
		this.category_memberid = category_memberid;
	}
	public int getCategory_kind() {
		return category_kind;
	}
	public void setCategory_kind(int category_kind) {
		this.category_kind = category_kind;
	}
	@Override
	public String toString() {
		return "Category [category_num=" + category_num + ", category_memberid=" + category_memberid
				+ ", category_kind=" + category_kind + "]";
	}
}
