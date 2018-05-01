package com.cooing.www.socket.push.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.cooing.www.socket.push.vo.PushVO;

public interface PushMapper {

	public int insertPush(PushVO push);
	
	//해당 메세지의 읽음 숫자를 하나 줄인다.
	public int updatePush(PushVO push);
	
	// 맵에 검색 조건을 담아 push 검색...
	public ArrayList<PushVO> selectPush(HashMap<String, String> map);
	
}
