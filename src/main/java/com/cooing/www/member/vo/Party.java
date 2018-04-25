package com.cooing.www.member.vo;

public class Party {
	private int party_num;
	private String party_name;
	private String party_leader;
	
	public Party(){}
	public Party(int party_num , String party_name , String party_leader){
		this.party_num = party_num;
		this.party_name = party_name;
		this.party_leader = party_leader;		
	}
	public int getParty_num() {
		return party_num;
	}
	public void setParty_num(int party_num) {
		this.party_num = party_num;
	}
	public String getParty_name() {
		return party_name;
	}
	public void setParty_name(String party_name) {
		this.party_name = party_name;
	}
	public String getParty_leader() {
		return party_leader;
	}
	public void setParty_leader(String party_leader) {
		this.party_leader = party_leader;
	}
	@Override
	public String toString() {
		return "Party [party_num=" + party_num + ", party_name=" + party_name + ", party_leader=" + party_leader + "]";
	}
	
}
