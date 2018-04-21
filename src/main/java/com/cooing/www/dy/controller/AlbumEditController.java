package com.cooing.www.dy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
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
	private static String strFilePath = "/FileSave/upload/";
	private static String strFilePath_mac = "/Users/insect/hindoong_upload/";
	private static String strThumbnailPath = "/FileSave/thumbnail/";
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumEditController.class);
	
	
	//앨범생성
	@ResponseBody
	@RequestMapping(value = "/create_personal_album", method = RequestMethod.POST)
	public String personal_albumCreate(Model model, HttpSession session){
		
		String returnMessage = null;
		
		String album_writer = ((Member) session.getAttribute("Member")).getMember_id();
		if (album_writer == null) returnMessage = "user null";
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(-1, album_writer, "임시 앨범", 1);

		//앨범 만들기
		int created_album_num = albumDAO.personal_createAlbum(albumwrite);
		
		// created_album_num이 -1이면 앨범 제작 실패임
		if(created_album_num == -1) {
			returnMessage = "fail";
		} else {
			returnMessage = created_album_num + "";
		}
			
		return returnMessage;
	}
	
	// 앨범 수정 창으로 이동
	@RequestMapping(value = "/edit_album", method = RequestMethod.GET)
	public String edit_album(String album_num, Model model, HttpSession session){
		
		int int_album_num = -1;
		
		// 숫자가 아니거나 -1 그대로인 경우 홈으로 리턴
		try {
			int_album_num = Integer.parseInt(album_num);
			if(int_album_num == -1) {
				new Exception();
			}
		} catch (Exception e) {
			return "redirect:../";
		}
		
		try {
			//TODO 앨범 넘버로 앨범 정보 가져와 모델에 담기
			AlbumWriteVO album = albumDAO.searchAlbumNum(int_album_num);
			if(album == null) return "redirect:../";
			//TODO 앨범 넘버로 페이지 배열로 받아와 모델에 담기
			ArrayList<PageHtmlVO> arr_page = albumDAO.select_pages_by_album_num(int_album_num);
			
			model.addAttribute("album", album);
			model.addAttribute("arr_page", arr_page);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			
		return "Album/edit_album";
	}
	

	//앨범생성,편집(임시)
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String albumEdit(){
			
		return "albumEdit";
	}

	//앨범 정보 업데이트
	@RequestMapping(value = "/update_albuminfo", method = RequestMethod.POST)
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
	
	//앨범 페이지별 저장
	@ResponseBody
	@RequestMapping(value = "/save_page", method = RequestMethod.POST)
	public String save_page(String album_num, String page_html, String page_num, HttpSession session){
			
		PageHtmlVO page = new PageHtmlVO(Integer.parseInt(album_num), Integer.parseInt(page_num), page_html);
		
		//앨범 만들고 바로 앨범 넘버 받아서 page태그랑 연결해 주는 코드
		if(albumDAO.personal_insertAlbumOfPage(page))
			return "success";
			
		return "fail";
	}	
	
	@ResponseBody
	@RequestMapping(value = "/deleteAlbum", method = RequestMethod.POST)
	public String deleteAlbum(int albumnum){
		logger.info("deleteAlbum_LJS");
		if(albumDAO.deleteAlbum(albumnum) > 0)
			return "success";
		
		return "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/page1ImageSave", method = RequestMethod.POST)
	public String page1ImageSave(HttpServletRequest request) throws Exception{
		logger.info("page1 Image Save _ ljs");
		String binaryData = request.getParameter("imgSrc");
        FileOutputStream stream = null;
        String newFileName = "" + new Date().getTime();
        try{
            logger.info("binary file   "  + binaryData);
            if(binaryData == null || binaryData=="") {
                throw new Exception();    
            }
            newFileName = newFileName + new Date().getTime();
            binaryData = binaryData.replaceAll("data:image/png;base64,", "");            
            byte[] decode = Base64.decodeBase64(binaryData);
            stream = new FileOutputStream(strThumbnailPath+newFileName+".png");
            stream.write(decode);
            stream.close();
            logger.info("파일 작성 완료");
            
        }catch(Exception e){
        	logger.info("파일이 정상적으로 넘어오지 않았습니다.");
            return "fail";
        }finally{
            stream.close();
        }
        return newFileName + ".png";		
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
	
	@ResponseBody
	@RequestMapping(value = "/thumbnailSave", method = RequestMethod.POST)
	public String thumbnailSave(MultipartHttpServletRequest multi){

		String newFileName = ""; 	        
	    File fpath = new File(strThumbnailPath);
	    if(!fpath.isDirectory()){
			fpath.mkdirs();			
		}	        
	    String ext="";
	    Map<String, MultipartFile> fileMap = multi.getFileMap();
	    
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
	        	serverFile = new File(strThumbnailPath + newFileName + ext);
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
	
		@ResponseBody
		@RequestMapping(value = "/thumbnailPathSave", method = RequestMethod.POST)
		public String thumbnailSave(String thumbnail , String albumnum){
			Map<String , String> map = new HashMap<String,String>();
			map.put("album_thumbnail", thumbnail);
			map.put("album_num", albumnum);
			logger.info(map.toString());
			if(albumDAO.updateThumbnail(map) > 0)
				return "success";
			else 
				return "fail";
		}
		
		@RequestMapping(value = "img", method = RequestMethod.GET)
		public String img(HttpServletResponse response , HttpSession session , String filePath) {
			logger.info("img__jinsu");
			
			String fullpath = strFilePath + filePath;
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
		
		@ResponseBody
		@RequestMapping(value = "/modifiy_AlbumInfomation", method = RequestMethod.POST)
		public String modifiy_AlbumInfomation(int album_num, String album_name, String album_contents,
				int album_category, int album_openrange){
			
			AlbumWriteVO albumwrite = new AlbumWriteVO(album_num, album_name, album_contents, album_category, album_openrange);
			boolean check_infomationUpdate = false;
			check_infomationUpdate = albumDAO.personal_update_page1_Album(albumwrite);
			
			if(check_infomationUpdate == true) {
				return "success";
			}else{
				return "fail";
			}
			
			
		}
		
		@RequestMapping(value = "thumbnail", method = RequestMethod.GET)
		public String thumbnail(HttpServletResponse response , String filePath) {
			logger.info("thumbnail__jinsu");
			
			String fullpath = strThumbnailPath + "/" + filePath;
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
