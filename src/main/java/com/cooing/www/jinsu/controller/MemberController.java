package com.cooing.www.jinsu.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cooing.www.jinsu.object.Member;


@Controller
@RequestMapping("/jinsu")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class); 
	private static final String strpath = "jinsu";
	
	@RequestMapping(value="/member_get" , method = RequestMethod.GET)
	public String member_get(){
		
		return strpath + "/member";
	}
	@RequestMapping(value="/member_post" , method = RequestMethod.POST)
	public String member_post(Member member , @RequestParam(value="list[]") List<String> list
			, MultipartFile upload){
		/*if(upload != null && !upload.isEmpty()){
			//logger.info(upload.toString());
		}*/
		
		logger.info(list.toString());
		logger.info(member.toString());
		
		return strpath + "/member";
	}
}
