package com.cooing.www.album.vo;

public class LikesVO {
	private int likeit_num;
	private int likeit_albumnum;
	private String likeit_memberid;	
	private String likeit_date;
	private int totalLike;
	private int isLike;
	
	public LikesVO() {}
	
	public LikesVO(int likeit_albumnum, String likeit_memberid) {
		super();
		this.likeit_albumnum = likeit_albumnum;
		this.likeit_memberid = likeit_memberid;
	}

	public LikesVO(int likeit_num, int likeit_albumnum, String likeit_memberid, String likeit_date, int totalLike,
			int isLike) {
		super();
		this.likeit_num = likeit_num;
		this.likeit_albumnum = likeit_albumnum;
		this.likeit_memberid = likeit_memberid;
		this.likeit_date = likeit_date;
		this.totalLike = totalLike;
		this.isLike = isLike;
	}

	@Override
	public String toString() {
		return "LikesVO [likeit_num=" + likeit_num + ", likeit_albumnum=" + likeit_albumnum + ", likeit_memberid="
				+ likeit_memberid + ", likeit_date=" + likeit_date + ", totalLike=" + totalLike + ", isLike=" + isLike
				+ "]";
	}

	public int getLikeit_num() {
		return likeit_num;
	}

	public void setLikeit_num(int likeit_num) {
		this.likeit_num = likeit_num;
	}

	public int getLikeit_albumnum() {
		return likeit_albumnum;
	}

	public void setLikeit_albumnum(int likeit_albumnum) {
		this.likeit_albumnum = likeit_albumnum;
	}

	public String getLikeit_memberid() {
		return likeit_memberid;
	}

	public void setLikeit_memberid(String likeit_memberid) {
		this.likeit_memberid = likeit_memberid;
	}

	public String getLikeit_date() {
		return likeit_date;
	}

	public void setLikeit_date(String likeit_date) {
		this.likeit_date = likeit_date;
	}

	public int getTotalLike() {
		return totalLike;
	}

	public void setTotalLike(int totalLike) {
		this.totalLike = totalLike;
	}

	public int getIsLike() {
		return isLike;
	}

	public void setIsLike(int isLike) {
		this.isLike = isLike;
	}

	
}
