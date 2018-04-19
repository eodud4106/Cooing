package com.cooing.www.joon.dao;

import com.cooing.www.joon.vo.AlbumReplyVO;

public interface AlbumReplyMapper {
	// 댓글 작성
	public void replyWrite(AlbumReplyVO vo);
}
