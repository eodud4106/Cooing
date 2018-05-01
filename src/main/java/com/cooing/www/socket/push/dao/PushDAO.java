package com.cooing.www.socket.push.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.socket.push.vo.PushVO;

@Repository
public class PushDAO {
	
	@Inject
	SqlSession session;

	public int insertPush(PushVO push) {
		try {
			session.getMapper(PushMapper.class).insertPush(push);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return push.getPush_id();
	};
	
	public int updatePush(PushVO push) {
		try {
			session.getMapper(PushMapper.class).updatePush(push);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return push.getPush_id();
	};
	
	// 맵에 검색 조건을 담아 push 검색...
	public ArrayList<PushVO> selectPush(HashMap<String, String> map) {
		ArrayList<PushVO> result = null;
		try {
			result = session.getMapper(PushMapper.class).selectPush(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
