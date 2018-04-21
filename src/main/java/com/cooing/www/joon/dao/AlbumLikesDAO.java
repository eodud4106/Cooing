package com.cooing.www.joon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.joon.vo.AlbumLikesVO;

@Repository
public class AlbumLikesDAO {
	@Autowired
	SqlSession sqlSession;

	public void addLikes(AlbumLikesVO vo) {
		AlbumLikesMapper albumlikesmapper = sqlSession.getMapper(AlbumLikesMapper.class);
		albumlikesmapper.addLikes(vo);
	}

	public void deleteLikes(AlbumLikesVO vo) {
		AlbumLikesMapper albumlikesmapper = sqlSession.getMapper(AlbumLikesMapper.class);
		albumlikesmapper.deleteLikes(vo);
	}
	// 앨범 읽기
	public AlbumLikesVO getAlbum(int likeit_albumnum) {
		AlbumLikesMapper albumlikesmapper = sqlSession.getMapper(AlbumLikesMapper.class);
		return albumlikesmapper.getAlbum(likeit_albumnum);
	}
	// 좋아요 목록
	public ArrayList<AlbumLikesVO> listLikes(int likeit_albumnum) {
		AlbumLikesMapper albumlikesmapper = sqlSession.getMapper(AlbumLikesMapper.class);
		return albumlikesmapper.listLikes(likeit_albumnum);
	}

	public String confirm_Likes(AlbumLikesVO vo) {
		AlbumLikesMapper albumlikesmapper = sqlSession.getMapper(AlbumLikesMapper.class);
		return albumlikesmapper.confirm_Likes(vo);
	}


}
