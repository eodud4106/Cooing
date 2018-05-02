package com.cooing.www.socket.edit;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cooing.www.member.dao.RelationDAO;
import com.cooing.www.member.vo.PartyMember;
import com.cooing.www.socket.chat.dao.MessageDAO;
import com.cooing.www.socket.chat.vo.MessageVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Repository
public class EditHandler extends TextWebSocketHandler implements InitializingBean {

	private final Logger logger = LogManager.getLogger(getClass());

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	
	// 키=파티명, 값=편집 유저명
	private HashMap<String, String> edit_user = new HashMap<>();
	
	
	//private HashMap<String, String> edit_user = new HashMap<>();
	
	private Gson gson = new Gson();
	
	public EditHandler() {
		super();
	}

	//웹소켓 연결이 닫혔을 때 호출
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);

		sessionSet.remove(session);
		
		this.logger.info("remove session!");
	}

	//웹소켓 연결 후 사용이 준비될 때 호출됨
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		
		sessionSet.add(session);
		
		this.logger.info("add session!");
	}
	
	//사용자가 보낸 메시지 처리
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		
		// 메세지....
		HashMap<String, String> msg = null;
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			//사용자가 보낸 메세지는 message.getPayload에 담겨 있다.
			msg = mapper.readValue(message.getPayload().toString(), 
					new TypeReference<HashMap<String, String>>(){});
			
			// 메세지의 타입
			String type = msg.get("type");
			// 메세지의 타입
			String party_name = msg.get("party_name");
			// 메세지의 타입
			String member_id = msg.get("member_id");
			
			msg.put("session_id", session.getId());
			
			// 타입 별 처리
			if(type.equals("open")) {
				// 1. [edit 시작...]
				
				// 누가 편집중인지 확인
				if(edit_user.containsKey(party_name)) {
					// 누가 편집 중임..
					
					//TODO 편집 중임을 유저에게 알리기
					msg.put("editable", "false");
					sendMessage(msg);
				} else {
					// 편집 중이 아님
					edit_user.put(party_name, member_id);
					//TODO 편집 중이 아님을 유저에게 알리기
					msg.put("editable", "true");
					sendMessage(msg);
				}
				
				
				
			} else if (type.equals("close")) {
				// 2. [edit 종료...]

				if(edit_user.containsKey(party_name)) {
					
					edit_user.remove(party_name);
				}
				
			} 
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	//에러 처리하는 핸들러
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		this.logger.error("web socket error!", exception);
	}

	//웹소켓 핸들러가 부분메세지를 처리할 때 호출
	@Override
	public boolean supportsPartialMessages() {
		this.logger.info("call method!");

		return super.supportsPartialMessages();
	}

	// 대화 푸시
	public void sendMessage(HashMap<String, String> msg) {
		
		
	
	}


	@Override
	public void afterPropertiesSet() throws Exception {

//		Thread thread = new Thread() {
//
//			int i = 0;
//
//			@Override
//			public void run() {
//				while (true) {
//
//					try {
//						sendMessage("send message index " + i++);
//						Thread.sleep(1000);
//					} catch (InterruptedException e) {
//						e.printStackTrace();
//						break;
//					}
//				}
//			}
//
//		};
//
//		thread.start();
	}

}
