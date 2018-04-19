package com.cooing.www.hindoong.dao;

import com.cooing.www.hindoong.vo.ImgVO;

public interface ImgMapper {

	public int insertImg(ImgVO img);
	
	public ImgVO selectImg(int img_id);
	
}
