package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.cooing.www.hindoong.vo.P_messageVO;

public interface P_messageMapper {

	public int insertP_message(P_messageVO p_message);
	
	//p_message_num을 받아 해당 메세지의 읽음 숫자를 하나 줄인다.
	public int updateP_message(int p_message_num);
	
	public ArrayList<P_messageVO> selectP_message(HashMap<String, String> map);
	
}
