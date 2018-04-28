package com.cooing.www.album.vo;

public class ReplyVO {
	private int reply_num;
	private int reply_albumnum;
	private String reply_memberid;
	private String reply_contents;
	private String reply_date;
	private int currentPage; //페이징 처리에 필요한 현재 페이지
	
	public ReplyVO() {
	}
	
	

	public ReplyVO(int reply_num, int reply_albumnum, String reply_memberid, String reply_contents,
			String reply_date) {
		super();
		this.reply_num = reply_num;
		this.reply_albumnum = reply_albumnum;
		this.reply_memberid = reply_memberid;
		this.reply_contents = reply_contents;
		this.reply_date = reply_date;
	}
	
	public ReplyVO(int reply_num, int reply_albumnum, String reply_memberid, String reply_contents,
			String reply_date, int currentPage) {
		this.reply_num = reply_num;
		this.reply_albumnum = reply_albumnum;
		this.reply_memberid = reply_memberid;
		this.reply_contents = reply_contents;
		this.reply_date = reply_date;
		this.currentPage = currentPage;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public int getReply_albumnum() {
		return reply_albumnum;
	}

	public void setReply_albumnum(int reply_albumnum) {
		this.reply_albumnum = reply_albumnum;
	}

	public String getReply_memberid() {
		return reply_memberid;
	}

	public void setReply_memberid(String reply_memberid) {
		this.reply_memberid = reply_memberid;
	}

	public String getReply_contents() {
		return reply_contents;
	}

	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}

	public String getReply_date() {
		return reply_date;
	}

	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}



	@Override
	public String toString() {
		return "AlbumReplyVO [reply_num=" + reply_num + ", reply_albumnum=" + reply_albumnum + ", reply_memberid="
				+ reply_memberid + ", reply_contents=" + reply_contents + ", reply_date=" + reply_date + "]";
	}
	
	
}
