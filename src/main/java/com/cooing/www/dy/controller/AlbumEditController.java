package com.cooing.www.dy.controller;

import org.slf4j.Logger; 
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.io.File;
import java.util.Iterator;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "albumEdit")
public class AlbumEditController {
	
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
		
		String root = multi.getSession().getServletContext().getRealPath("/");
        String path = root+"resources/upload/";
         
        String newFileName = ""; // 업로드 되는 파일명
         
        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
 
        while(files.hasNext()){
        	System.out.println("와일문 들어왔나?");
        	
            String uploadFile = files.next();
                         
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            System.out.println("실제 파일 이름 : " +fileName);
            newFileName = System.currentTimeMillis()+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);
             
            try {
                mFile.transferTo(new File(path+newFileName));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
         
        System.out.println("들어왔나?");
        
        
        return null;

	}
	
}
