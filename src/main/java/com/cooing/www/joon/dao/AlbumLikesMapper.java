package com.cooing.www.joon.dao;

import java.util.ArrayList;

import com.cooing.www.joon.vo.AlbumLikesVO;

public interface AlbumLikesMapper {
	// 좋아요
	public void addLikes(AlbumLikesVO vo);
	// 좋아요 취소
	public void deleteLikes(AlbumLikesVO vo);
	// 앨범 하나 가져옴
	public ArrayList<AlbumLikesVO> getAlbum(int likeit_albumnum);
	// 좋아요 확인
	public String check_Likes(AlbumLikesVO vo);
	// 좋아요 목록
	public ArrayList<AlbumLikesVO> listLikes(int likeit_albumnum);

	

}
