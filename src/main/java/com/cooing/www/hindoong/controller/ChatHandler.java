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

import com.cooing.www.hindoong.dao.P_messageDAO;
import com.cooing.www.hindoong.vo.P_messageVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Repository
public class ChatHandler extends TextWebSocketHandler implements InitializingBean {

	@Autowired
	P_messageDAO pmDAO;

	private final Logger logger = LogManager.getLogger(getClass());

	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	
	private HashMap<String, String> hashmap_id = new HashMap<>();
	
	private Gson gson = new Gson();

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
		HashMap<String, String> map = new HashMap<String, String>();
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			//사용자가 보낸 메세지는 message.getPayload에 담겨 있다.
			map = mapper.readValue(message.getPayload().toString(), 
					new TypeReference<HashMap<String, String>>(){});
			
			if(map.get("type").equals("loginId")) {
				hashmap_id.put(map.get("id"), session.getId());
				
//				//TODO 나와 상대와의 대화목록을 불러와서 클라이언트에게 보내줘야 함.
//				HashMap<String, String> search = new HashMap<>();
//				search.put("id1", map.get("id"));
//				search.put("id2", map.get("to"));
//				ArrayList<P_messageVO> messageList = pmDAO.selectP_message(search);
//				for (int i = 0; i < messageList.size(); i++) {
//					sendMessage(messageList.get(i), session.getId());
//				}
				
			} else if (map.get("type").equals("message")) {
				pm.setP_message_from(map.get("from"));
				pm.setP_message_to(map.get("to"));
				pm.setP_message_message(map.get("message"));

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				String str = sdf.format(new Date());
				
				pm.setP_message_date(str);
				
				this.logger.info(pm);
				
				sendMessage(pm);
				//db에 넣는 작업에서 딜레이가 발생하기 때문에... 우선 메시지를 뿌리고 나서 db에 넣는다...
				pmDAO.insertP_message(pm);
			} else if (map.get("type").equals("read")) {
				//TODO 읽음 처리 구현해야 함.. 
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
	public void sendMessage(P_messageVO pm) {
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					if (hashmap_id.get(pm.getP_message_from()).equals(session.getId()) ||
							hashmap_id.get(pm.getP_message_to()).equals(session.getId())) {
						session.sendMessage(new TextMessage(gson.toJson(pm)));
						this.logger.error(pm);
					} 
				} catch (Exception e) {
					e.printStackTrace();
					//this.logger.error("fail to send message!");
				}
			}
		}
	}
	
	//대화방 입장 시 이전 채팅 내역 보내기
	public void sendMessage(P_messageVO pm, String id) {
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					if (id.equals(session.getId())) {
						session.sendMessage(new TextMessage(gson.toJson(pm)));
						break;
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
