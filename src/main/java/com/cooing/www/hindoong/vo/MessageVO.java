package com.cooing.www.hindoong.vo;

public class MessageVO {
	
	private int message_num;
	private int is1to1;			// 1 = 1to1, 0 = 그룹
	private String message_from;
	private String message_to;
	private String message_message;
	private String message_read;
	private String message_date;
	
	public MessageVO () {}

	public MessageVO(int message_num, int is1to1, String message_from, String message_to, String message_message,
			String message_read, String message_date) {
		super();
		this.message_num = message_num;
		this.is1to1 = is1to1;
		this.message_from = message_from;
		this.message_to = message_to;
		this.message_message = message_message;
		this.message_read = message_read;
		this.message_date = message_date;
	}

	public int getMessage_num() {
		return message_num;
	}

	public void setMessage_num(int message_num) {
		this.message_num = message_num;
	}

	public int getIs1to1() {
		return is1to1;
	}

	public void setIs1to1(int is1to1) {
		this.is1to1 = is1to1;
	}

	public String getMessage_from() {
		return message_from;
	}

	public void setMessage_from(String message_from) {
		this.message_from = message_from;
	}

	public String getMessage_to() {
		return message_to;
	}

	public void setMessage_to(String message_to) {
		this.message_to = message_to;
	}

	public String getMessage_message() {
		return message_message;
	}

	public void setMessage_message(String message_message) {
		this.message_message = message_message;
	}

	public String getMessage_read() {
		return message_read;
	}

	public void setMessage_read(String message_read) {
		this.message_read = message_read;
	}

	public String getMessage_date() {
		return message_date;
	}

	public void setMessage_date(String message_date) {
		this.message_date = message_date;
	}

	@Override
	public String toString() {
		return "MessageVO [message_num=" + message_num + ", is1to1=" + is1to1 + ", message_from=" + message_from
				+ ", message_to=" + message_to + ", message_message=" + message_message + ", message_read="
				+ message_read + ", message_date=" + message_date + "]";
	}

}
