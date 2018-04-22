package com.cooing.www.hindoong.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.hindoong.dao.MessageDAO;
import com.cooing.www.hindoong.vo.MessageVO;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "chat")
public class ChatController {

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	private MessageDAO mDAO;
	
	// 대화목록 불러오기
	@ResponseBody
	@RequestMapping(value = "/getChat", method = RequestMethod.POST)
	public ArrayList<MessageVO> getChat(Model model, String counterpart, String is1to1, HttpSession session) {
		
		logger.debug("chatController -> 대화목록 불러오기");
		
		String id = ((Member) session.getAttribute("Member")).getMember_id();
		HashMap<String, String> map_search = new HashMap<>();
		
		ArrayList<MessageVO> arr_message = new ArrayList<>();
		map_search.put("id", id);
		map_search.put("counterpart", counterpart);
		map_search.put("is1to1", is1to1);
		
		arr_message = mDAO.selectMessage(map_search);
		
		return arr_message;
		
	}
}
