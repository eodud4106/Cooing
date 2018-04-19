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
	private final String strFilePath = "/FileSave/upload/";
	private final String strFilePath_mac = "/Users/insect/hindoong_upload/";
	private static String album_identifier = null;
	
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
			int album_openrange, int album_category, String hashtag){
		
		
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(album_num, album_name, album_contents, album_category, album_openrange);
		
		boolean update_check = false;
		update_check = albumDAO.personal_update_page1_Album(albumwrite);
		
		
		//해쉬태그
//		String[] tags = hashtag.split(",");
//		for(int i = 0; i < tags.length; i++){
//			searchDAO.insertHashTag(new HashTag(0 , ialbumnum , tags[i]));
//		}
				
		return "redirect:/";
	}
	
	//앨범 페이지별 저장하면서 앨범 생성
	@ResponseBody
	@RequestMapping(value = "/personal_pageSave", method = RequestMethod.POST)
	public String personal_createpageSave(String html , int pagenum, HttpSession session, Locale locale){
		
		int page_num = 0;
		page_num = pagenum;
		
		String page_html = null;
		page_html = html;
		
		if(page_num == 1) {

			String album_writer = null;
			album_writer = ((Member) session.getAttribute("Member")).getMember_id();
					
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formatting = dateFormat.format(date);
			album_identifier = formatting.concat(album_writer);
			
			AlbumWriteVO albumwrite = new AlbumWriteVO(0, album_writer, 1 , album_identifier);
			
			boolean create_confirmed = false;
			//앨범 만들기
			create_confirmed = albumDAO.personal_createAlbum(albumwrite);
			
			if(create_confirmed == true) {
				
				//앨범 만들고 바로 앨범 넘버 받아서 page태그랑 연결해 주는 코드
				int album_num = 0; 
				album_num = albumDAO.personal_selectAlbum_Num(album_identifier);
				PageHtmlVO page = new PageHtmlVO(album_num, page_num, page_html);
				albumDAO.personal_insertAlbumOfPage(page);
				return String.valueOf(album_num);
				
				
			} else {
				System.err.println("첫 페이지 저장 실패");
			}
		
		} else{
			//앨범 만들고 바로 앨범 넘버 받아서 page태그랑 연결해 주는 코드
			int album_num = 0; 
			album_num = albumDAO.personal_selectAlbum_Num(album_identifier);
			PageHtmlVO page = new PageHtmlVO(album_num, page_num, page_html);
			albumDAO.personal_insertAlbumOfPage(page);
			return String.valueOf(album_num);
		}
		

			
		return "fail";
	}	
		
	// 사진 저장
	@ResponseBody
	@RequestMapping(value = "/albumImageSave", method = RequestMethod.POST)
	public String pageSave(MultipartHttpServletRequest multi){

		String newFileName = ""; 	        
	    File fpath = new File(strFilePath_mac);
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
	        	serverFile = new File(strFilePath_mac + newFileName + ext);
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
        
	    System.out.println(newFileName + ext);
        return newFileName + ext;

	}
		
	// 이미지 src 로 이미지 제공
	@RequestMapping(value = "img", method = RequestMethod.GET)
	public String img(HttpServletResponse response , HttpSession session , String filePath) {
		logger.info("img__jinsu");
		
		String fullpath = strFilePath_mac + filePath;
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
