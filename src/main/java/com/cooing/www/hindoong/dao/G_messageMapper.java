package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.cooing.www.hindoong.vo.MessageVO;

public interface G_messageMapper {

	public int insertMessage(MessageVO p_message);
	
	//해당 메세지의 읽음 컬럼을 수정..
	public int updateMessage(HashMap<String, String> map);
	
	public ArrayList<MessageVO> selectMessage(HashMap<String, String> map);
	
}
