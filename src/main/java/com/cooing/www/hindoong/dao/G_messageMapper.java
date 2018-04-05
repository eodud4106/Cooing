package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.cooing.www.hindoong.vo.G_messageVO;

public interface G_messageMapper {

	public int insertG_message(G_messageVO p_message);
	
	//해당 메세지의 읽음 컬럼을 수정..
	public int updateG_message(HashMap<String, String> map);
	
	public ArrayList<G_messageVO> selectG_message(HashMap<String, String> map);
	
}
