package com.cooing.www.jinsu.object;

import java.io.File;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileLimit {
	
	public static String FileSave(MultipartFile file , String path){
		
		if(file == null || file.isEmpty() || file.getSize() == 0)
			return null;
		
		//파일을 생성해보고 그 경로에 파일이 있으면 넘어가고 없으면 생성
		File fpath = new File(path);
		if(!fpath.isDirectory()){
			//파일  생성
			fpath.mkdirs();			
		}
			
		String saveFilename = "" + new Date().getTime();
		String oriFilename = "";
		String ext;
		int lastIndex = file.getOriginalFilename().lastIndexOf('.');
		if(lastIndex == -1)
			ext = "";		
		else{
			ext = "." + file.getOriginalFilename().substring(lastIndex + 1);
			oriFilename = file.getOriginalFilename().substring(0,lastIndex);
		}
		saveFilename += oriFilename;
		File serverFile = null;
		while(true){
			serverFile = new File(path + "/" + saveFilename + ext);
			if ( !serverFile.isFile()) break;
			saveFilename = saveFilename + new Date().getTime();
		}		
		
		try{
			file.transferTo(serverFile);
		}catch(Exception e){
			saveFilename = null;
			e.printStackTrace();
		}
		
		return saveFilename + ext;	
	}
	
	public static boolean imageFileCheck(String oripath){
		String ext;
		int lastIndex = oripath.lastIndexOf('.');
		if(lastIndex == -1){
			ext = "";
			return false;
		}			
		else
			ext = oripath.substring(lastIndex + 1);
		
		if(ext.equals("jpg") || ext.equals("png") || ext.equals("gif"))
			return true;
		
		return false;
	}
	
	public static boolean deleteFile(String fullpath){
		File delFile = new File(fullpath);
		if(delFile.isFile()){
			delFile.delete();
			return true;
		}
		return false;
	}

}
