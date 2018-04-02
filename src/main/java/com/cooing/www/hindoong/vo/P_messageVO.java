package com.cooing.www.hindoong.vo;

public class P_messageVO {
	
	private int p_message_num;
	private String p_message_from;
	private String p_message_to;
	private String p_message_message;
	private int p_message_read;
	private String p_message_date;
	
	public P_messageVO() {}

	public P_messageVO(int p_message_num, String p_message_from, String p_message_to, String p_message_message,
			int p_message_read, String p_message_date) {
		super();
		this.p_message_num = p_message_num;
		this.p_message_from = p_message_from;
		this.p_message_to = p_message_to;
		this.p_message_message = p_message_message;
		this.p_message_read = p_message_read;
		this.p_message_date = p_message_date;
	}

	public int getP_message_num() {
		return p_message_num;
	}

	public void setP_message_num(int p_message_num) {
		this.p_message_num = p_message_num;
	}

	public String getP_message_from() {
		return p_message_from;
	}

	public void setP_message_from(String p_message_from) {
		this.p_message_from = p_message_from;
	}

	public String getP_message_to() {
		return p_message_to;
	}

	public void setP_message_to(String p_message_to) {
		this.p_message_to = p_message_to;
	}

	public String getP_message_message() {
		return p_message_message;
	}

	public void setP_message_message(String p_message_message) {
		this.p_message_message = p_message_message;
	}

	public int getP_message_read() {
		return p_message_read;
	}

	public void setP_message_read(int p_message_read) {
		this.p_message_read = p_message_read;
	}

	public String getP_message_date() {
		return p_message_date;
	}

	public void setP_message_date(String p_message_date) {
		this.p_message_date = p_message_date;
	}

	@Override
	public String toString() {
		return "P_messageVO [p_message_num=" + p_message_num + ", p_message_from=" + p_message_from + ", p_message_to="
				+ p_message_to + ", p_message_message=" + p_message_message + ", p_message_read=" + p_message_read
				+ ", p_message_date=" + p_message_date + "]";
	}
	
	

}
