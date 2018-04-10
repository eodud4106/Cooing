package com.cooing.www.dy.dao;

import java.util.ArrayList; 

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.dy.vo.Coordinate_Picture;

@Repository
public class AlbumDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertAlbum(ArrayList<Coordinate_Picture> list){
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).toString());
		}
		
		if(list.size() < 0)
			return true;
		else 
			return false;
	}
}
