package com.cooing.www.hindoong.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cooing.www.hindoong.vo.MessageVO;

@Repository
public class MessageDAO {
	
	@Inject
	SqlSession session;

	// 메세지 저장 후 메세지id, 안 읽음 개수 업데이트해서 반환
	public MessageVO insertMessage(MessageVO message) {
		
		try {
			session.getMapper(MessageMapper.class).insertMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return message;
	}

	// 메세지를 읽은 사람을 확인하고... 처리...
	public MessageVO updateMessage(MessageVO message) {
		
		System.out.println("읽음 요청 -> " + message);
		
		try {
			session.getMapper(MessageMapper.class).updateMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("읽음 처리 -> " + message);
		
		return message;
	}

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
