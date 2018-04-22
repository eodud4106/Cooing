package com.cooing.www.hindoong.vo;

public class MessageVO {
	
	private int message_id;
	private int is1to1;			// 1 = 1to1, 0 = 그룹
	private String sender;
	private String addressee;
	private String message;
	private String unread;
	private String send_date;
	private String type;		// handler 처리 편의 변수
	private String ids;			// 읽음 처리 편의 변수
	
	public MessageVO () {}

	public MessageVO(int message_id, int is1to1, String sender, String addressee, String message, String unread,
			String send_date, String type, String ids) {
		super();
		this.message_id = message_id;
		this.is1to1 = is1to1;
		this.sender = sender;
		this.addressee = addressee;
		this.message = message;
		this.unread = unread;
		this.send_date = send_date;
		this.type = type;
		this.ids = ids;
	}

	public int getMessage_id() {
		return message_id;
	}

	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}

	public int getIs1to1() {
		return is1to1;
	}

	public void setIs1to1(int is1to1) {
		this.is1to1 = is1to1;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getUnread() {
		return unread;
	}

	public void setUnread(String unread) {
		this.unread = unread;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	@Override
	public String toString() {
		return "MessageVO [message_id=" + message_id + ", is1to1=" + is1to1 + ", sender=" + sender + ", addressee="
				+ addressee + ", message=" + message + ", unread=" + unread + ", send_date=" + send_date + ", type="
				+ type + ", ids=" + ids + "]";
	}

	
	

}
