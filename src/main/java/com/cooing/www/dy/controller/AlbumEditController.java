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
import com.cooing.www.jinsu.object.Member;

@Controller
@RequestMapping(value = "albumEdit")
public class AlbumEditController {
	private static String strFilePath = "/FileSave/upload/";
	
	@Autowired
	AlbumDAO albumDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumEditController.class);
	
	//앨범생성,편집
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String albumEdit(){
			
		return "albumEdit";
	}
	
	// 앨범 임시 저장
		@ResponseBody
		@RequestMapping(value = "/albumImageSave", method = RequestMethod.POST)
		public String pageSave(MultipartHttpServletRequest multi){
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
		
		//앨범 페이지별 저장
		@ResponseBody
		@RequestMapping(value = "/pageSave", method = RequestMethod.POST)
		public String createpageSave(String html , String pagenum, HttpSession session){
					
			String isWrite = null;
			isWrite = (String) session.getAttribute("writing");
					
			//처음 페이지 만들 때
			if(isWrite != null) {
				int album_num = 0;
				album_num = albumDAO.first_selectAlbum_Num(isWrite);
				session.removeAttribute("writing");
				session.setAttribute("create_page_albumnum", album_num);
							
				int page_num = 0;
				page_num = Integer.parseInt(pagenum);
				String page_html = null;
							
				page_html = html;
				PageHtmlVO page = new PageHtmlVO(album_num, page_num, page_html);
				boolean insertAlbumOfPage = albumDAO.insertAlbumOfPage(page);
			} 
					
			else {
				int album_num = 0;
				album_num = (int) session.getAttribute("create_page_albumnum");
							
				int page_num = 0;
				page_num = Integer.parseInt(pagenum);
				String page_html = null;
							
				page_html = html;
				PageHtmlVO page = new PageHtmlVO(album_num, page_num, page_html);
				boolean insertAlbumOfPage = albumDAO.insertAlbumOfPage(page);
			}
					
					
			return "success";
		}
		
		//앨범생성
		@RequestMapping(value = "/AlbumNameCreate", method = RequestMethod.GET)
		public String AlbumNameCreate(){
				
			return "Album/AlbumNameCreate";
		}
		
		//앨범 생성
		@RequestMapping(value = "/AlbumFirstCreate", method = RequestMethod.POST)
		public String AlbumFirstCreate(HttpSession session, String album_name, String album_contents,
				int album_party, int album_version, int album_category, Locale locale){
					
			//아이디 불러오기
			String album_writer = null;
			album_writer = ((Member) session.getAttribute("Member")).getMember_id();
					
			//난수 추가
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formatting = dateFormat.format(date);
			String album_identifier = formatting.concat(album_writer);
					
			session.setAttribute("writing", album_identifier);
					
			//앨범 생성
			AlbumWriteVO albumwrite = new AlbumWriteVO(0 , album_writer, 1 , album_identifier);
			boolean create_confirmed = false;
			create_confirmed = albumDAO.createAlbum(albumwrite);
					
					
			return "albumEdit";
		}
		
		@RequestMapping(value = "img", method = RequestMethod.GET)
		public String img(HttpServletResponse response , HttpSession session , String filePath) {
			logger.info("img__jinsu");
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
