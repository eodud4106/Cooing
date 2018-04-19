package com.cooing.www.joon.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.joon.vo.AlbumReplyVO;

@Repository
public class AlbumReplyDAO {
	@Autowired
	SqlSession sqlSession;

	public void replyWrite(AlbumReplyVO vo) {
		AlbumReplyMapper albumreplymapper = sqlSession.getMapper(AlbumReplyMapper.class);
		albumreplymapper.replyWrite(vo);
	}
}
