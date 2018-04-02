package com.cooing.www.jinsu.object;

public class Member {
	
	private String member_id;
	private String member_pw;
	private int member_manager;
	private String	member_picture;
	private String member_recentlogin;
	
	public Member(){}
	public Member(String id , String pw , int manager , String picture , String recentlogin){
		member_id = id;
		member_pw = pw;
		member_manager = manager;
		member_picture = picture;
		member_recentlogin = recentlogin;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public int getMember_manager() {
		return member_manager;
	}
	public void setMember_manager(int member_manager) {
		this.member_manager = member_manager;
	}
	public String getMember_picture() {
		return member_picture;
	}
	public void setMember_picture(String member_picture) {
		this.member_picture = member_picture;
	}
	public String getMember_recentlogin() {
		return member_recentlogin;
	}
	public void setMember_recentlogin(String member_recentlogin) {
		this.member_recentlogin = member_recentlogin;
	}
	@Override
	public String toString() {
		return "Member [member_id=" + member_id + ", member_pw=" + member_pw + ", member_manager=" + member_manager
				+ ", member_picture=" + member_picture + ", member_recentlogin=" + member_recentlogin + "]";
	}
}
