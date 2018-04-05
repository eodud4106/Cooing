package com.cooing.www.hindoong.vo;

public class G_messageVO {
	
	private int g_message_num;
	private String g_message_from;
	private String g_message_to;
	private String g_message_message;
	private String g_message_read;
	private String g_message_date;
	
	public G_messageVO() {}

	public G_messageVO(int g_message_num, String g_message_from, String g_message_to, String g_message_message,
			String g_message_read, String g_message_date) {
		super();
		this.g_message_num = g_message_num;
		this.g_message_from = g_message_from;
		this.g_message_to = g_message_to;
		this.g_message_message = g_message_message;
		this.g_message_read = g_message_read;
		this.g_message_date = g_message_date;
	}

	public int getG_message_num() {
		return g_message_num;
	}

	public void setG_message_num(int g_message_num) {
		this.g_message_num = g_message_num;
	}

	public String getG_message_from() {
		return g_message_from;
	}

	public void setG_message_from(String g_message_from) {
		this.g_message_from = g_message_from;
	}

	public String getG_message_to() {
		return g_message_to;
	}

	public void setG_message_to(String g_message_to) {
		this.g_message_to = g_message_to;
	}

	public String getG_message_message() {
		return g_message_message;
	}

	public void setG_message_message(String g_message_message) {
		this.g_message_message = g_message_message;
	}

	public String getG_message_read() {
		return g_message_read;
	}

	public void setG_message_read(String g_message_read) {
		this.g_message_read = g_message_read;
	}

	public String getG_message_date() {
		return g_message_date;
	}

	public void setG_message_date(String g_message_date) {
		this.g_message_date = g_message_date;
	}

	@Override
	public String toString() {
		return "G_messageVO [g_message_num=" + g_message_num + ", g_message_from=" + g_message_from + ", g_message_to="
				+ g_message_to + ", g_message_message=" + g_message_message + ", g_message_read=" + g_message_read
				+ ", g_message_date=" + g_message_date + "]";
	}
	
	

}
