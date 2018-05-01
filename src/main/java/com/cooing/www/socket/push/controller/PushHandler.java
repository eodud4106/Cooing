package com.cooing.www.socket.push.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
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
import com.cooing.www.socket.push.dao.PushDAO;
import com.cooing.www.socket.push.vo.PushVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Repository
public class PushHandler extends TextWebSocketHandler implements InitializingBean {

	@Autowired
	PushDAO pDAO;
	@Autowired
	RelationDAO rDAO;

	private final Logger logger = LogManager.getLogger(getClass());

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	
	private HashMap<String, String> hashmap_id = new HashMap<>();
	
	private Gson gson = new Gson();
	
	public PushHandler() {
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
		PushVO push = null;
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			//사용자가 보낸 메세지는 message.getPayload에 담겨 있다.
			push = mapper.readValue(message.getPayload().toString(), 
					new TypeReference<PushVO>(){});
			// 메세지의 타입
			/*
			 * 0 - 웹소켓 초기 설정
			 * 1 - 친구 요청
			 * 2 - 파티 초대
			 * 3 - 수신인의 대답
			 */
			int type = push.getType();
			
			// 타입 별 처리
			if(type == 0) {
				// 1. [홈페이지 접속]
				// 실제 id와 웹소켓 세션 id를 key, value로 저장 
				// (메시지 푸시 받을 id -> 웹소켓 세션 id -> 발송) 구조이기 때문.
				hashmap_id.put(push.getSender(), session.getId());
				
			} else if (type == 1 || type == 2) {
				// 2. [친구 요청  or 파티초대]
				
				PushVO db_push = pDAO.insertPush(push);
				sendMessage(db_push);
				
			} else if (type == 3 || type == 4) {
				// 3. [push에 대한 대답..]
				int result = pDAO.updatePush(push);
				
				if (result == 1) {
					PushVO db_push = pDAO.selectPushOne(push.getPush_id());
					
					// 친구 요청
					if (db_push.getType() == 1) {
						db_push.setType(3);
						
						// 승낙한 경우만 가입처리
						if (push.getAgree() == 1) {
							Map<String,String> map = new HashMap<String,String>();
							map.put("person", db_push.getSender());
							map.put("friend", db_push.getAddressee());
							rDAO.insertFriend(map);
						}
						
					}
					
					// 파티 초대
					else if(db_push.getType() == 2) {
						db_push.setType(4);
						
						// 승낙한 경우만 가입처리
						if (push.getAgree() == 1) {
							PartyMember pm = new PartyMember(db_push.getAddressee(), db_push.getSender());
							rDAO.insertPartyMember_by_party_name(pm);
							
						}
						
					}
					
					sendMessage(db_push);
				} else {
					System.out.println("push 업데이트 실패!!!!");
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

	// 푸시
	public void sendMessage(PushVO push) {
		
		// push의 타입이 초대, 요청일 경우는 수신자한테!
		if(push.getType() <= 2) {
		
			try {
		
				for (WebSocketSession session : this.sessionSet) {
					if (session.isOpen()) {
						// 수신인이 웹소켓 세션에 있을 경우 메시지 푸시
						if (hashmap_id.containsKey(push.getAddressee())
								&& hashmap_id.get(push.getAddressee()).equals(session.getId())) {
							session.sendMessage(new TextMessage(gson.toJson(push)));
						}

					}
				}
		
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// push의 타입이 응답일 경우는 발신자한테!
		else if (push.getType() > 2) {
			
			if(push.getType() == 4) {
				// 파티 초대에 대한 대답일 경우는 파티 리더한테 보낸다!
				push.setSender(rDAO.searchParty(push.getSender()).getParty_leader());
			}
			
			try {
				for (WebSocketSession session : this.sessionSet) {
					if (session.isOpen()) {
						// 수신인이 웹소켓 세션에 있을 경우 메시지 푸시
						if (hashmap_id.containsKey(push.getSender())
								&& hashmap_id.get(push.getSender()).equals(session.getId())) {
							session.sendMessage(new TextMessage(gson.toJson(push)));
						}
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	}
	
	@Override
	public void afterPropertiesSet() throws Exception {

	}

}
