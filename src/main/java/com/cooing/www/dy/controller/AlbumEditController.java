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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.jinsu.dao.SearchDAO;
import com.cooing.www.jinsu.object.HashTag;
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "albumEdit")
public class AlbumEditController {
	
	@Autowired
	AlbumDAO albumDAO;
	@Autowired
	SearchDAO searchDAO;
	
	//private static String id = null; 
	//private static String strFilePath = "/FileSave/upload/"+id+"/";
	private static String strFilePath = "/FileSave/upload/";
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumEditController.class);
	
	
	//앨범생성
	@RequestMapping(value = "/personal_albumCreate", method = RequestMethod.GET)
	public String personal_albumCreate(){
			
		return "Album/personal_albumCreate";
	}
	
	
	
	//앨범생성,편집(임시)
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String albumEdit(){
			
		return "albumEdit";
	}

	//앨범 생성
	@RequestMapping(value = "/personal_AlbumTotalCreate", method = RequestMethod.POST)
	public String AlbumFirstCreate(HttpSession session, int album_num, String album_name, String album_contents,
			int album_party, int album_version, int album_category, String hashtag){
		
		
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(album_num, album_name, album_contents, album_category);
		
		boolean update_check = false;
		update_check = albumDAO.personal_update_page1_Album(albumwrite);
		
		
		
		
		
		//해쉬태그
//		String[] tags = hashtag.split(",");
//		for(int i = 0; i < tags.length; i++){
//			searchDAO.insertHashTag(new HashTag(0 , ialbumnum , tags[i]));
//		}
				
		return "albumEdit";
	}
	
	//앨범 페이지별 저장하면서 앨범 생성
	@ResponseBody
	@RequestMapping(value = "/personal_pageSave", method = RequestMethod.POST)
	public String personal_createpageSave(String html , String pagenum, HttpSession session, Locale locale){
				
		int page_num = 0;
		page_num = Integer.parseInt(pagenum);
		
		String page_html = null;
		page_html = html;
		
		String album_writer = null;
		album_writer = ((Member) session.getAttribute("Member")).getMember_id();
				
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formatting = dateFormat.format(date);
		String album_identifier = formatting.concat(album_writer);
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(0, album_writer, 1 , album_identifier);
		
		
		boolean create_confirmed = false;
		//앨범 만들기
		create_confirmed = albumDAO.personal_createAlbum(albumwrite);
		
		//앨범 만들고 바로 앨범 넘버 받아서 page태그랑 연결해 주는 코드
		if(create_confirmed == true) {
			
			int album_num = 0; 
			album_num = albumDAO.personal_selectAlbum_Num(album_identifier);
			PageHtmlVO page = new PageHtmlVO(album_num, page_num, page_html);
			albumDAO.personal_insertAlbumOfPage(page);
			
			return String.valueOf(album_num);
			
		}
			
		return "fail";
	}	
		
	// 앨범 임시 저장
	@ResponseBody
	@RequestMapping(value = "/albumImageSave", method = RequestMethod.POST)
	public String pageSave(MultipartHttpServletRequest multi){
		
		System.out.println("들어오니 albumimage");
		
		String newFileName = ""; 	        
	    File fpath = new File(strFilePath);
	    if(!fpath.isDirectory()){
			fpath.mkdirs();			
		}	        
	    String ext="";
	    Map<String, MultipartFile> fileMap = multi.getFileMap();
	    logger.info(fileMap.toString());
	    
	    for(MultipartFile multipartfile:fileMap.values()){
	    	int lastIndex = multipartfile.getOriginalFilename().lastIndexOf('.');
	    	if(lastIndex == -1)
	    		ext = "";		
	    	else{
	    		ext = "." + multipartfile.getOriginalFilename().substring(lastIndex + 1);
	    		newFileName = multipartfile.getOriginalFilename().substring(0,lastIndex);
	    	}
	    	newFileName += new Date().getTime();
	    	String[] strarray = {"%" , "," , "\\\\",  "\\" , "." , "?",  "&",  "*", "^"  ,"$" ,"#" , "@" , "!" ,"-" , "="  ,"/" , "Ű" };
	    	for(String s : strarray){
	    		if(newFileName.indexOf(s) != -1){
	    			newFileName = newFileName.replaceAll(s, "");
	    		}	    			
	    	}
	        File serverFile = null;
	        while(true){
	        	serverFile = new File(strFilePath + newFileName + ext);
	    		if ( !serverFile.isFile()) break;
	    			newFileName = newFileName + new Date().getTime();
	    		}		
	             try {
	            	 multipartfile.transferTo(serverFile);
	             } catch (Exception e) {
	                 e.printStackTrace();
	                 return "fail";
	             }
	        }	        
	        return newFileName + ext;
		}
		
		@RequestMapping(value = "img", method = RequestMethod.GET)
		public String img(HttpServletResponse response , HttpSession session , String filePath) {
			logger.info("img__jinsu");
			System.out.println("들어오니 img");
			
			String fullpath = strFilePath + "/" + filePath;
			if( filePath.length() != 0){
				FileInputStream filein = null;
				ServletOutputStream fileout = null;
				try {
					filein = new FileInputStream(fullpath);
					fileout = response.getOutputStream();
					FileCopyUtils.copy(filein, fileout);			
					filein.close();
					fileout.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return null;
		}
	
}
