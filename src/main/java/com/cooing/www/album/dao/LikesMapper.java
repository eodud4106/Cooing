package com.cooing.www.album.dao;

import java.util.ArrayList;

import com.cooing.www.album.vo.LikesVO;

public interface LikesMapper {
	// 좋아요
	public void addLikes(LikesVO vo);
	// 좋아요 취소
	public void deleteLikes(LikesVO vo);
	// 앨범 하나 가져옴
	public ArrayList<LikesVO> getAlbum(int likeit_albumnum);
	// 좋아요 확인
	public String check_Likes(LikesVO vo);
	// 좋아요 목록
	public ArrayList<LikesVO> listLikes(int likeit_albumnum);
	//좋아요 갯수
	public int countLikes(int likeit_albumnum);
}
