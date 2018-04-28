package com.cooing.www.album.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.album.vo.LikesVO;

@Repository
public class LikesDAO {
	@Autowired
	SqlSession sqlSession;
	// 좋아요
	public void addLikes(LikesVO vo) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		albumlikesmapper.addLikes(vo);
	}
	// 좋아요 취소
	public void deleteLikes(LikesVO vo) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		albumlikesmapper.deleteLikes(vo);
	}
	// 앨범 읽기
	public ArrayList<LikesVO> getAlbum(int likeit_albumnum) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		return albumlikesmapper.getAlbum(likeit_albumnum);
	}
	// 좋아요 확인
	public String check_Likes(LikesVO vo) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		return albumlikesmapper.check_Likes(vo);
	}
	// 좋아요 목록
	public ArrayList<LikesVO> listLikes(int likeit_albumnum) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		return albumlikesmapper.listLikes(likeit_albumnum);
	}
	//좋아요 갯수
	public int countLikes(int likeit_albumnum) {
		LikesMapper albumlikesmapper = sqlSession.getMapper(LikesMapper.class);
		return albumlikesmapper.countLikes(likeit_albumnum);
	}
}
