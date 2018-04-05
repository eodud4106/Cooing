package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.G_messageVO;

@Repository
public class G_messageDAO implements G_messageMapper {
	
	@Inject
	SqlSession session;

	@Override
	public int insertG_message(G_messageVO p_message) {
		
		int result = 0;
		
		try {
			result = session.getMapper(G_messageMapper.class).insertG_message(p_message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int updateG_message(HashMap<String, String> map) {

		try {
			session.getMapper(G_messageMapper.class).updateG_message(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public ArrayList<G_messageVO> selectG_message(HashMap<String, String> map) {
		
		ArrayList<G_messageVO> pmlist = new ArrayList<G_messageVO>();
		
		try {
			pmlist = session.getMapper(G_messageMapper.class).selectG_message(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pmlist;
	}

}
