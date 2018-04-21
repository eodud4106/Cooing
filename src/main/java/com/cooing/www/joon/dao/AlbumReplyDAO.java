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
	public ArrayList<AlbumReplyVO> selectReply() {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		return albumreplymapper.selectReply();
	}

}
