package com.cooing.www.hindoong.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.bytecode.annotation.MemberValueVisitor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.hindoong.dao.P_messageDAO;
import com.cooing.www.hindoong.vo.P_messageVO;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "chat")
public class ChatController {

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	private P_messageDAO pmDAO;
	
	// chat 홈으로 이동
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Locale locale, Model model, String friend_id, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		String id = ((Member) session.getAttribute("Member")).getMember_id();
		HashMap<String, String> map_search = new HashMap<>();
		map_search.put("id1", id);
		map_search.put("id2", friend_id);
		ArrayList<P_messageVO> arr_pm = pmDAO.selectP_message(map_search);
		
		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("friend_id", friend_id);
		model.addAttribute("arr_pm", arr_pm);
		
		return "hindoong/home";
	}
	
	// 대화목록 불러오기
	@ResponseBody
	@RequestMapping(value = "/getChat", method = RequestMethod.POST)
	public ArrayList<P_messageVO> getChat(Model model, String friend_id, HttpSession session) {

		String id = ((Member) session.getAttribute("Member")).getMember_id();
		HashMap<String, String> map_search = new HashMap<>();
		map_search.put("id1", id);
		map_search.put("id2", friend_id);
		ArrayList<P_messageVO> arr_pm = pmDAO.selectP_message(map_search);
		
		return arr_pm;
	}
	
}
