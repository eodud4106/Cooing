package com.cooing.www.jinsu.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cooing.www.jinsu.dao.MemberDAO;
import com.cooing.www.jinsu.object.FileLimit;
import com.cooing.www.jinsu.object.Member;


@Controller
@RequestMapping("/jinsu")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class); 
	private static final String strpath = "jinsu";
	private static String strFilePath = "/FileSave";
	
	@Autowired
	MemberDAO memberDAO;
	
	@RequestMapping(value="/member_get" , method = RequestMethod.GET)
	public String member_get(){		
		return strpath + "/member";
	}
	@RequestMapping(value="/member_post" , method = RequestMethod.POST)
	public String member_post(Member member , @RequestParam("hobby") String[] hobby
			,MultipartFile upload){
		
		if(upload != null && !upload.isEmpty()){
			String savefile = FileLimit.FileSave(upload, strFilePath);
			member.setMember_picture(savefile);
		}
		//밑에 코드는 나중에 sql에서 default 값 설정 하면 지울 에정
		member.setMember_manager(0);
		memberDAO.insertMember(member);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/member_check" , method = RequestMethod.POST)
	public String member_check(Member member){
		char[] cban ={ '/' , '&' , '<' , '>' , '|'};
		//검사
		if(member.getMember_id() != null){
			if(member.getMember_pw() != null){
				for(int i = 0; i < member.getMember_pw().length(); i++){
					for(int j = 0; j < cban.length; j++){
						if(member.getMember_pw().charAt(i) == cban[j]){
							return "fail";
						}
					}
				}
				if(member.getMember_pw().length() < 6 || 12 < member.getMember_pw().length()){
					return "fail";
				}
			}
			return "success";
		}
		else{
			return "fail";
		}		
	}
	
	@RequestMapping(value="/login_get" , method = RequestMethod.GET)
	public String login_get(){		
		return strpath + "/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/login_post" , method = RequestMethod.POST)
	public String login_post(Member member,HttpSession session){
		logger.info(member.toString()+"__1");
		Member member_check= memberDAO.selectMember(member.getMember_id());
		logger.info(member.toString()+"__2");
		if(member_check != null){
			logger.info(member_check.toString()+"__3");
			if(member_check.getMember_pw().equals(member.getMember_pw())){
				logger.info(member_check.toString()+"__4");
				session.setAttribute("Login", true);
				session.setAttribute("Member", member_check);
				return "success";
			}
			else{
				return "fail";
			}
		}
		else{
			return "fail";
		}				
	}
}
