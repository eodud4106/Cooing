package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.MessageVO;

@Repository
public class G_messageDAO implements G_messageMapper {
	
	@Inject
	SqlSession session;

	@Override
	public int insertMessage(MessageVO message) {
		
		int result = 0;
		
		try {
			result = session.getMapper(G_messageMapper.class).insertMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int updateMessage(HashMap<String, String> map) {

		try {
			session.getMapper(G_messageMapper.class).updateMessage(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public ArrayList<MessageVO> selectMessage(HashMap<String, String> map) {
		
		ArrayList<MessageVO> pmlist = new ArrayList<MessageVO>();
		
		try {
			pmlist = session.getMapper(G_messageMapper.class).selectMessage(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pmlist;
	}

}
