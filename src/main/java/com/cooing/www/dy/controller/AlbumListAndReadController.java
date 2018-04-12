package com.cooing.www.dy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "albumEdit")
public class AlbumListAndReadController {
	private static String strFilePath = "/FileSave/upload/";
	
	@Autowired
	AlbumDAO albumDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumListAndReadController.class);
		
		//앨범 생성
		@RequestMapping(value = "/MyAlbumList", method = RequestMethod.POST)
		public String MyAlbumListOutPut(Model model, HttpSession session){
			
			//아이디 불러오기
			String album_writer = null;
			album_writer = ((Member) session.getAttribute("Member")).getMember_id();
			
			
			
			
			return "albumEdit";
		}
	
}
