package com.cooing.www.album.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.album.vo.ReplyVO;

public interface ReplyMapper {
	// 댓글 작성
	public void replyWrite(ReplyVO vo);
	// 댓글 삭제
	public void replyDelete(ReplyVO vo);
	// 댓글 목록
	public ArrayList<ReplyVO> listReply(int num, RowBounds rb);
	// 댓글 하나 가져옴
	public ReplyVO getReply(int reply_num);
	// 댓글 수
	public int getReplyTotal(int num);
	
}
