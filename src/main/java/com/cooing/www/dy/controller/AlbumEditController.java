package com.cooing.www.dy.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.dy.vo.Coordinate_Picture;

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
		@RequestMapping(value = "/albumPageSave", method = RequestMethod.POST)
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
		
		//사진 좌표값
		@ResponseBody
		@RequestMapping(value = "/coordinate", method = RequestMethod.POST)
		public String coordinate(String array){
			
			Coordinate_Picture cp = null;
			
			String page = null;
			String div_num = null;
			String top = null;
			String left = null;
			String width = null;
			String height = null;
		
			int next = 0;
			int j = 0;
			logger.info(array);
			/*boolean flag = true;
			while(flag) {
				if(array.charAt(j)=='p') {
					page = null;
					page = array.substring(1, j);
					next = j;
				} else if(array.charAt(j)=='t'){
					div_num = null;
					div_num = array.substring(next+1, j);
					next = j;
				} else if(array.charAt(j)=='l'){
					top = null;
					top = array.substring(next+1, j);
					next = j;
				} else if(array.charAt(j)=='w'){
					left = null;
					left = array.substring(next+1, j);
					next = j;
				} else if(array.charAt(j)=='h'){
					width = null;
					width = array.substring(next+1, j);
					next = j;
					height = null;
					height = array.substring(next+1, array.length());
					flag = false;
				}
				j++;				
				cp = new Coordinate_Picture(Integer.parseInt(page), Integer.parseInt(div_num) ,Integer.parseInt(top), Integer.parseInt(left), Integer.parseInt(width), Integer.parseInt(height));
			}			
			albumDAO.insertAlbum(cp); //앨범 sql 저장
*/				
			return "success";
		}
	
}
