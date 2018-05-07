package com.cooing.www.socket.push.vo;

public class PushVO {
	
	private int push_id;
	private String sender;
	private String addressee;
	private int type;
	private String msg;
	private String push_date;
	private int agree;
	private String agree_date;
	
	public PushVO() {
		super();
	}
	
	

	public PushVO(int push_id, int agree) {
		super();
		this.push_id = push_id;
		this.agree = agree;
	}



	public PushVO(int push_id, String sender, String addressee, int type, String msg, String push_date, int agree,
			String agree_date) {
		super();
		this.push_id = push_id;
		this.sender = sender;
		this.addressee = addressee;
		this.type = type;
		this.msg = msg;
		this.push_date = push_date;
		this.agree = agree;
		this.agree_date = agree_date;
	}

	public int getPush_id() {
		return push_id;
	}

	public void setPush_id(int push_id) {
		this.push_id = push_id;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getAddressee() {
		return addressee;
	}

	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPush_date() {
		return push_date;
	}

	public void setPush_date(String push_date) {
		this.push_date = push_date;
	}

	public int getAgree() {
		return agree;
	}

	public void setAgree(int agree) {
		this.agree = agree;
	}

	public String getAgree_date() {
		return agree_date;
	}

	public void setAgree_date(String agree_date) {
		this.agree_date = agree_date;
	}

	@Override
	public String toString() {
		return "PushVO [push_id=" + push_id + ", sender=" + sender + ", addressee=" + addressee + ", type=" + type
				+ ", msg=" + msg + ", push_date=" + push_date + ", agree=" + agree + ", agree_date=" + agree_date + "]";
	}
	
	
}
