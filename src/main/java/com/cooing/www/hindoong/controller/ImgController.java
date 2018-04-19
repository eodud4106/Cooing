package com.cooing.www.hindoong.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.hindoong.dao.ImgDAO;
import com.cooing.www.hindoong.vo.ImgVO;

@Controller
@RequestMapping(value = "img")
public class ImgController {

	private static final Logger logger = LoggerFactory.getLogger(ImgController.class);
	
	@Inject
	private ImgDAO DAO;
	
	// 이미지 저장
	@ResponseBody
	@RequestMapping(value = "/saveImg", method = RequestMethod.POST)
	public ImgVO getChat(Model model, HttpSession session, String original_name) {
		
		ImgVO img = new ImgVO();
		
		return img;
		
	}
}
