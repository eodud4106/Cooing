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

import com.cooing.www.hindoong.dao.G_messageDAO;
import com.cooing.www.hindoong.dao.P_messageDAO;
import com.cooing.www.hindoong.vo.MessageVO;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "chat")
public class ChatController {

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	private P_messageDAO pmDAO;
	@Inject
	private G_messageDAO gmDAO;
	
	// 대화목록 불러오기
	@ResponseBody
	@RequestMapping(value = "/getChat", method = RequestMethod.POST)
	public ArrayList<MessageVO> getChat(Model model, String counterpart, boolean is1to1, HttpSession session) {

		String id = ((Member) session.getAttribute("Member")).getMember_id();
		HashMap<String, String> map_search = new HashMap<>();
		
		ArrayList<MessageVO> arr_message = new ArrayList<>();
		if (is1to1) {
			//1to1 대화
			map_search.put("id1", id);
			map_search.put("id2", counterpart);
			arr_message = pmDAO.selectMessage(map_search);
		} else {
			//그룹 대화
			map_search.put("group", counterpart);
			arr_message = gmDAO.selectMessage(map_search);
		}
		
		return arr_message;
		
	}
}
