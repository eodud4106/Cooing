package com.cooing.www.member.vo;

public class PartyMember {
	private int	partymember_num;
	private int party_num;
	private String member_id;
	private String party_name;
	
	public PartyMember(){}

	public PartyMember(int partymember_num, int party_num, String member_id) {
		super();
		this.partymember_num = partymember_num;
		this.party_num = party_num;
		this.member_id = member_id;
	}

	public PartyMember(int partymember_num, int party_num, String member_id, String party_name) {
		super();
		this.partymember_num = partymember_num;
		this.party_num = party_num;
		this.member_id = member_id;
		this.party_name = party_name;
	}

	public int getPartymember_num() {
		return partymember_num;
	}

	public void setPartymember_num(int partymember_num) {
		this.partymember_num = partymember_num;
	}

	public int getParty_num() {
		return party_num;
	}

	public void setParty_num(int party_num) {
		this.party_num = party_num;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getParty_name() {
		return party_name;
	}

	public void setParty_name(String party_name) {
		this.party_name = party_name;
	}

	@Override
	public String toString() {
		return "PartyMember [partymember_num=" + partymember_num + ", party_num=" + party_num + ", member_id="
				+ member_id + ", party_name=" + party_name + "]";
	}
	
	
	
	
}
