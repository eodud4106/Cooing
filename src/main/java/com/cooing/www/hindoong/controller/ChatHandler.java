package com.cooing.www.hindoong.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
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

import com.cooing.www.hindoong.dao.ChatDAO;
import com.cooing.www.hindoong.dao.P_messageDAO;
import com.cooing.www.hindoong.vo.P_messageVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Repository
public class ChatHandler extends TextWebSocketHandler implements InitializingBean {

	@Autowired
	P_messageDAO pmDAO;

	private final Logger logger = LogManager.getLogger(getClass());

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();

	// @Override
	// public void afterConnectionClosed(WebSocketSession session, CloseStatus
	// status) throws Exception {
	// //웹 소켓 연결이 종료되고 나서 서버단에서 실행해야할 일들을 정의해주는 메소드
	// super.afterConnectionClosed(session, status);
	// sessionSet.remove(session);
	// System.out.println("remove session!");
	// }
	//
	// @Override
	// public void afterConnectionEstablished(WebSocketSession session) throws
	// Exception {
	// //연결이 성사 되고 나서 해야할 일들.
	// super.afterConnectionEstablished(session);
	//
	// sessionSet.add(session);
	// System.out.println("add session!");
	// }
	//
	// @Override
	// protected void handleTextMessage(WebSocketSession session, TextMessage
	// message) throws Exception {
	// //웹소켓 서버단으로 메세지가 도착했을때 해주어야할 일들을 정의하는 메소드
	// ChatDAO dao = ((SqlSession) session).getMapper(ChatDAO.class);
	// this.logger.info(message.getPayload());
	// //session.sendMessage(new
	// TextMessage(dao.count_receive_note(message.getPayload())));
	// //현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.
	//
	// }
	public ChatHandler() {
		super();
		this.logger.info("create SocketHandler instance!");
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
		
		P_messageVO pm = new P_messageVO();
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			//사용자가 보낸 메세지는 message.getPayload에 담겨 있다.
			map = mapper.readValue(message.getPayload().toString(), 
					new TypeReference<HashMap<String, String>>(){});
			pm.setP_message_from(map.get("from").toString());
			pm.setP_message_to(map.get("to").toString());
			pm.setP_message_message(map.get("message").toString());
			
			int result = pmDAO.insertP_message(pm);
			
			this.logger.info("result = " + result);

			sendMessage(session.getId() +" : "+ pm.getP_message_message());
			
//	        for(WebSocketSession sess : sessionSet){
//
//	            sess.sendMessage(new TextMessage(session.getId() +" : "+ message.getPayload()));
//
//	        }
		
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

	public void sendMessage(String message) {
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					session.sendMessage(new TextMessage(message));
					System.out.println(message);
				} catch (Exception ignored) {
					this.logger.error("fail to send message!", ignored);
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
