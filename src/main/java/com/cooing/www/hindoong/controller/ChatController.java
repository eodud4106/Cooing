package com.cooing.www.hindoong.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cooing.www.hindoong.dao.P_messageDAO;

@Controller
@RequestMapping(value = "chat")
public class ChatController {

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	private P_messageDAO pmDAO;
	
	// chat 홈으로 이동
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Locale locale, Model model, String friend_id) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		
		
		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("friend_id", friend_id);
		
		
		return "hindoong/home";
	}
	
}
