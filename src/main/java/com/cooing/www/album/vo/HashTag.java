package com.cooing.www.album.vo;

public class HashTag {
	private int tag_num;
	private int tag_albumnum;
	private String tag_content;
	
	public HashTag(){}
	public HashTag(int tag_num , int tag_albumnum , String tag_content){
		this.tag_num = tag_num;
		this.tag_albumnum = tag_albumnum;
		this.tag_content = tag_content;		
	}
	public int getTag_num() {
		return tag_num;
	}
	public void setTag_num(int tag_num) {
		this.tag_num = tag_num;
	}
	public int getTag_albumnum() {
		return tag_albumnum;
	}
	public void setTag_albumnum(int tag_albumnum) {
		this.tag_albumnum = tag_albumnum;
	}
	public String getTag_content() {
		return tag_content;
	}
	public void setTag_content(String tag_content) {
		this.tag_content = tag_content;
	}
	@Override
	public String toString() {
		return "HashTag [tag_num=" + tag_num + ", tag_albumnum=" + tag_albumnum + ", tag_content=" + tag_content + "]";
	}
}
