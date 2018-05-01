package com.cooing.www.socket.push.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.member.vo.Member;
import com.cooing.www.socket.push.dao.PushDAO;
import com.cooing.www.socket.push.vo.PushVO;

@Controller
@RequestMapping(value = "push")
public class PushController {

	private static final Logger logger = LoggerFactory.getLogger(PushController.class);
	
	@Inject
	private PushDAO pDAO;
	
	// push 불러오기
	@ResponseBody
	@RequestMapping(value = "/get_unread_push", method = RequestMethod.POST)
	public ArrayList<PushVO> getChat(HttpSession session) {
		
		logger.debug("push 불러오기");
		
		String id = ((Member) session.getAttribute("Member")).getMember_id();
		HashMap<String, String> map_search = new HashMap<>();
		
		ArrayList<PushVO> arr_push = new ArrayList<>();
		map_search.put("userId", id);
		map_search.put("search", "unread");
		
		arr_push = pDAO.selectPush(map_search);
		
		return arr_push;
		
	}
	
	// push에 응답
	@ResponseBody
	@RequestMapping(value = "/send_answer", method = RequestMethod.POST)
	public String send_answer(String push_id, String agree, HttpSession session) {
		
		logger.debug("push 대답");
		
		int i_push_id = -1;
		int i_agree = -1;
		
		try {
			i_push_id = Integer.parseInt(push_id);
			i_agree = Integer.parseInt(agree);
		} catch (Exception e) {
			e.printStackTrace();
			return "not num";
		}
		
		PushVO push = new PushVO(i_push_id, i_agree);
		
		int result = pDAO.updatePush(push);
				
		return result == 1? "success":"fail";
		
	}
}
