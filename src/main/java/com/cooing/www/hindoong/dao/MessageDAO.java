package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.MessageVO;

@Repository
public class MessageDAO implements MessageMapper {
	
	@Inject
	SqlSession session;

	// 메세지 저장 후 메세지 번호 리턴
	@Override
	public int insertMessage(MessageVO message) {
		
		int result = 0;
		
		try {
			result = session.getMapper(MessageMapper.class).insertMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return message.getMessage_num();
	}

	@Override
	public int updateMessage(HashMap<String, String> map) {

		int result = 0;
		
		try {
			result = session.getMapper(MessageMapper.class).updateMessage(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public ArrayList<MessageVO> selectMessage(HashMap<String, String> map) {
		
		ArrayList<MessageVO> mlist = new ArrayList<MessageVO>();
		
		try {
			mlist = session.getMapper(MessageMapper.class).selectMessage(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mlist;
	}

}
