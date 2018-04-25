package com.cooing.www.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cooing.www.member.vo.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(HandlerInterceptorAdapter.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)	
			throws Exception {		
		logger.debug("logininterceptor_exe");
		//세션의 로그인 정보 읽음
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("Member");
		if(member == null){
			response.sendRedirect(request.getContextPath() + "/login_get");
			return false;
		}
				
		//없으면 로그인 페이지로 리다이렉트
		// TODO Auto-generated method stub
		return super.preHandle(request, response, handler);
	}

}
