package com.cooing.www.dy.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value = "albumEdit")
public class AlbumEditController {

	private static final Logger logger = LoggerFactory.getLogger(AlbumEditController.class);
	
	//앨범생성,편집
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String albumEdit(){
			
		return "albumEdit";
	}
	
	// 앨범 임시 저장
	@ResponseBody
	@RequestMapping(value = "/albumPageSave", method = RequestMethod.GET)
	public String pageSave(String id) {
		
		logger.info(id);
		
		String a = "zz";
		
		return a;
	}
	
}
