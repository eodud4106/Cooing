package com.cooing.www.dy.controller;

import java.io.File;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value = "albumEdit")
public class AlbumEditController {
	private static String strFilePath = "/FileSave/upload/";
	
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
	
}
