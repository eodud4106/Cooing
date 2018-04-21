package com.cooing.www.joon.dao;

import com.cooing.www.joon.vo.AlbumLikesVO;

public interface AlbumLikesMapper {
	// 좋아요
	public void addLikes(AlbumLikesVO vo);
	// 좋아요 취소
	public void deleteLikes(AlbumLikesVO vo);

}
