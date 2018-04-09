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
                 return "앨범이미지 저장을 실패 했습니다. 잠시 후 다시 시도해 주십시오.";
             }
        }
        
        return "success";

	}
	
	//사진 좌표값
	@ResponseBody
	@RequestMapping(value = "/coordinate", method = RequestMethod.POST)
	public String coordinate(String[] array){
		
		Coordinate_Picture cp = null;
		ArrayList<Coordinate_Picture> list = new ArrayList<>();
		
		String page = null;
		String div_num = null;
		String top = null;
		String left = null;
		String width = null;
		String height = null;
		
		for(int i=0; i<array.length; i++) {
			String str = array[i];
			int next = 0;
			int j = 0;
			
			boolean flag = true;
			while(flag) {
				
				if(str.charAt(j)=='d') {
					page = null;
					page = str.substring(1, j);
					next = j;
				} else if(str.charAt(j)=='t'){
					div_num = null;
					div_num = str.substring(next+1, j);
					next = j;
				} else if(str.charAt(j)=='l'){
					top = null;
					top = str.substring(next+1, j);
					next = j;
				} else if(str.charAt(j)=='w'){
					left = null;
					left = str.substring(next+1, j);
					next = j;
				} else if(str.charAt(j)=='h'){
					width = null;
					width = str.substring(next+1, j);
					next = j;
					height = null;
					height = str.substring(next+1, str.length());
					flag = false;
				}
				
				j++;
				
			}
			cp = new Coordinate_Picture(Integer.parseInt(page), Integer.parseInt(div_num) ,Integer.parseInt(top), Integer.parseInt(left), Integer.parseInt(width), Integer.parseInt(height));
			list.add(cp);
		}
		
		albumDAO.insertAlbum(list); //앨범 sql 저장
			
		return "success";
	}
	
}
