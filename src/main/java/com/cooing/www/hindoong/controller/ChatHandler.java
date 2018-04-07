package com.cooing.www.hindoong.controller;

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

import com.cooing.www.hindoong.dao.G_messageDAO;
import com.cooing.www.hindoong.dao.P_messageDAO;
import com.cooing.www.hindoong.vo.MessageVO;
import com.cooing.www.jinsu.dao.RelationDAO;
import com.cooing.www.jinsu.object.PartyMember;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Repository
public class ChatHandler extends TextWebSocketHandler implements InitializingBean {

	@Autowired
	P_messageDAO pmDAO;
	@Autowired
	G_messageDAO gmDAO;
	@Autowired
	RelationDAO rDAO;

	private final Logger logger = LogManager.getLogger(getClass());

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	
	private HashMap<String, String> hashmap_id = new HashMap<>();
	
	private Gson gson = new Gson();
	
	public ChatHandler() {
		super();
		this.logger.info("create SocketHandler instance!");
	}

	//웹소켓 연결이 닫혔을 때 호출
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);

		sessionSet.remove(session);
		System.out.println(session.getId() + " 삭제 됨!!\n" + sessionSet.toString());
		
		this.logger.info("remove session!");
	}

	//웹소켓 연결 후 사용이 준비될 때 호출됨
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		
		sessionSet.add(session);
		System.out.println(session.getId() + " 추가 됨!!\n" + sessionSet.toString());
		
		this.logger.info("add session!");
	}
	
	//사용자가 보낸 메시지 처리
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		
		HashMap<String, String> map_message = new HashMap<String, String>();
		MessageVO msg = new MessageVO();
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			//사용자가 보낸 메세지는 message.getPayload에 담겨 있다.
			map_message = mapper.readValue(message.getPayload().toString(), 
					new TypeReference<HashMap<String, String>>(){});
			
			// 메세지의 타입
			String type = map_message.get("type");
			
			if(type.equals("login")) {
				hashmap_id.put(map_message.get("id"), session.getId());
				System.out.println("세션아이디&로그인아이디 매칭 정보 -> " + hashmap_id);
				
			} else if (type.equals("message")) {
				
				// 1to1메시지인지, 그룹메시지인지 판별
				boolean is1to1 = Boolean.parseBoolean(map_message.get("is1to1"));
				
				//날짜 정보 저장
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String message_date = sdf.format(new Date());
				
				msg.setMessage_from(map_message.get("from"));
				msg.setMessage_to(map_message.get("to"));
				msg.setMessage_message(map_message.get("message"));
				msg.setMessage_date(message_date);
				
				sendMessage(msg, is1to1);
				
				//db에 넣는 작업에서 딜레이가 발생하기 때문에 우선 메시지를 뿌리고 나서 db에 넣는다.
				if (is1to1) {
					//1to1메시지
					pmDAO.insertMessage(msg);
				} else {
					//그룹메시지
					gmDAO.insertMessage(msg);
				}
				
			} else if (type.equals("read")) {
				//TODO 개인 읽음, 그룹 읽음 구현 필요함
				
				// 1to1메시지인지, 그룹메시지인지 판별
				boolean is1to1 = Boolean.parseBoolean(map_message.get("is1to1"));
				if (is1to1) {
					//1to1메시지
					pmDAO.updateMessage(map_message);
				} else {
					//그룹메시지
					gmDAO.updateMessage(map_message);
				}
				
				readMessage(map_message);
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

	//웹소켓 핸들러가 부분메세지???를 처리할 때 호출
	@Override
	public boolean supportsPartialMessages() {
		this.logger.info("call method!");

		return super.supportsPartialMessages();
	}

	// 대화 푸시
	public void sendMessage(MessageVO message, boolean is1to1) {
		
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					// 1:1 채팅 & 그룹채팅 여부에 따른 처리
					if (is1to1) {
						// 1:1 채팅
						if (hashmap_id.get(message.getMessage_from()).equals(session.getId()) ||
								hashmap_id.get(message.getMessage_to()).equals(session.getId())) {
							session.sendMessage(new TextMessage(gson.toJson(message)));
						}
					} else {
						// 그룹 채팅
						
						// 1. message_to(수신 대상 그룹)으로 그룹 멤버를 조회
						ArrayList<PartyMember> arr_partymember = 
								rDAO.searchPartyMember(Integer.parseInt(message.getMessage_to()));
						// 2. 조회한 그룹 멤버들의 id 중 현재 세션에 연결된 경우 메시지 발신
						for (PartyMember partyMember : arr_partymember) {
							String memberid = partyMember.getG_member_memberid();
							if (hashmap_id.get(memberid).equals(session.getId())) {
								session.sendMessage(new TextMessage(gson.toJson(message)));
							}
						}
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//읽음 처리
	public void readMessage(HashMap<String, String> map) {
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					if (hashmap_id.get(map.get("from")) != null && hashmap_id.get(map.get("from")).equals(session.getId())) {
						session.sendMessage(new TextMessage(gson.toJson(map)));
					} 
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
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
