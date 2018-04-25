package com.cooing.www.member.vo;

public class PartyMember {
	private int g_member_num;
	private int g_member_partynum;
	private String g_member_memberid;
	
	public PartyMember(){}
	public PartyMember(int num , int partynum , String memberid){
		this.g_member_num = num;
		this.g_member_partynum = partynum;
		this.g_member_memberid = memberid;
	}
	public int getG_member_num() {
		return g_member_num;
	}
	public void setG_member_num(int g_member_num) {
		this.g_member_num = g_member_num;
	}
	public int getG_member_partynum() {
		return g_member_partynum;
	}
	public void setG_member_partynum(int g_member_partynum) {
		this.g_member_partynum = g_member_partynum;
	}
	public String getG_member_memberid() {
		return g_member_memberid;
	}
	public void setG_member_memberid(String g_member_memberid) {
		this.g_member_memberid = g_member_memberid;
	}
	@Override
	public String toString() {
		return "PartyMember [g_member_num=" + g_member_num + ", g_member_partynum=" + g_member_partynum
				+ ", g_member_memberid=" + g_member_memberid + "]";
	}	
}
