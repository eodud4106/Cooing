package com.cooing.www.joon.dao;

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

}
