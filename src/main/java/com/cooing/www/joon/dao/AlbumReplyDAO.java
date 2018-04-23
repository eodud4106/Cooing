package com.cooing.www.joon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.joon.vo.AlbumReplyVO;

@Repository
public class AlbumReplyDAO {
	@Autowired
	SqlSession sqlSession;
	// 댓글 작성
	public void replyWrite(AlbumReplyVO vo) {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		albumreplymapper.replyWrite(vo);
	}
	// 댓글 삭제
	public void replyDelete(AlbumReplyVO vo) {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		albumreplymapper.replyDelete(vo);	
	}
	// 댓글 목록
	public ArrayList<AlbumReplyVO> listReply(int num, int start, int countPerPage) {
		RowBounds rb = new RowBounds(start, countPerPage);
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		return albumreplymapper.listReply(num, rb);
	}
	// 댓글 하나 가져옴
	public AlbumReplyVO getReply(int reply_num) {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		return albumreplymapper.getReply(reply_num);
	}
	// 댓글 수
	public int getReplyTotal(int num) {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		return albumreplymapper.getReplyTotal(num);
	}
}
