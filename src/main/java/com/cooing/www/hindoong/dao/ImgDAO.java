package com.cooing.www.hindoong.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.ImgVO;

@Repository
public class ImgDAO implements ImgMapper {
	
	@Autowired
	SqlSession session;

	@Override
	public int insertImg(ImgVO img) {
			
		int result = 0;
		
		try {
			result = session.getMapper(ImgMapper.class).insertImg(img);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public ImgVO selectImg(int img_id) {
		
		ImgVO img = null;
		
		try {
			img = session.getMapper(ImgMapper.class).selectImg(img_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return img;
	}
	
	
	
}
