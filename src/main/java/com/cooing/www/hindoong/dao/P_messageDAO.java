package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.P_messageVO;

@Repository
public class P_messageDAO implements P_messageMapper {
	
	@Inject
	SqlSession session;

	@Override
	public int insertP_message(P_messageVO p_message) {
		
		int result = 0;
		
		try {
			result = session.getMapper(P_messageMapper.class).insertP_message(p_message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int updateP_message(int p_message_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<P_messageVO> selectP_message(HashMap<String, String> map) {
		
		ArrayList<P_messageVO> pmlist = new ArrayList<P_messageVO>();
		
		try {
			pmlist = session.getMapper(P_messageMapper.class).selectP_message(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pmlist;
	}

}
