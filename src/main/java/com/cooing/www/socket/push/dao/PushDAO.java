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

	public PushVO insertPush(PushVO push) {
		try {
			session.getMapper(PushMapper.class).insertPush(push);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return push;
	};
	
	public int updatePush(PushVO push) {
		int result = 0;
		try {
			result = session.getMapper(PushMapper.class).updatePush(push);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	};
	
	// 맵에 검색 조건을 담아 push list 검색...
	public PushVO selectPushOne(int push_id) {
		PushVO result = null;
		try {
			result = session.getMapper(PushMapper.class).selectPushOne(push_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 맵에 검색 조건을 담아 push list 검색...
	public ArrayList<PushVO> selectPushList(HashMap<String, String> map) {
		ArrayList<PushVO> result = null;
		try {
			result = session.getMapper(PushMapper.class).selectPushList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
