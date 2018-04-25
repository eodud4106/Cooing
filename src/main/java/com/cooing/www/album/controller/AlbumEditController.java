package com.cooing.www.album.controller;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
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

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.album.vo.PageHtmlVO;
import com.cooing.www.common.dao.SearchDAO;
import com.cooing.www.member.vo.Member;
import com.google.gson.Gson;

@Controller
public class AlbumEditController {
	
	@Autowired
	AlbumDAO albumDAO;
	@Autowired
	SearchDAO searchDAO;

	//private final String strFilePath = "/FileSave/upload/";						// windows
	private static String strFilePath = "/Users/insect/hindoong_upload/";			// mac
	//private final String strThumbnailPath = "/FileSave/thumbnail/";				// windows
	private static String strThumbnailPath = "/Users/insect/hindoong_upload/";	// mac
	//private final String strTemp_PicturePath = "/FileSave/temp_picture/"; 			//사진 자를 때 필요한 경로
	private static String strTemp_PicturePath = "/Users/insect/hindoong_upload/";	// mac
	
	private static final Logger logger = LoggerFactory.getLogger(AlbumEditController.class);
	
	
	//앨범생성
	@ResponseBody
	@RequestMapping(value = "/create_album", method = RequestMethod.POST)
	public String personal_albumCreate(Model model, HttpSession session, Integer isPersonal, String party_name){
		
		String returnMessage = null;
		
		String album_writer = "";
		int openrange = 0;
		
		if(isPersonal == 1) {
			// 개인 앨범
			album_writer = ((Member) session.getAttribute("Member")).getMember_id();
			openrange = 1;
		} else {
			// 파티 앨범
			album_writer = party_name;
			openrange = 3;
		}
		
		if (album_writer == null) returnMessage = "user null";
		
		// 앨범 이름 - 임시 앨범, 공개 범위 - 나만or그룹, 카테고리 - 기타로 설정
		AlbumWriteVO albumwrite = new AlbumWriteVO(album_writer, "Enter album name", openrange, 20, isPersonal);

		//앨범 만들기
		int created_album_num = -1;
		try {
			created_album_num = albumDAO.personal_createAlbum(albumwrite);
		} catch (Exception e) {
			// 오류 발생이면 앨범 제작 실패임
			returnMessage = "fail";
		}
		
		returnMessage = created_album_num + "";
			
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
			return "redirect:./";
		}
		
		try {
			//TODO 앨범 넘버로 앨범 정보 가져와 모델에 담기
			AlbumWriteVO album = albumDAO.searchAlbumNum(int_album_num);
			if(album == null) return "redirect:./";
			//TODO 앨범 넘버로 페이지 배열로 받아와 모델에 담기
			ArrayList<PageHtmlVO> arr_page = albumDAO.select_pages_by_album_num(int_album_num);
			
			model.addAttribute("album", album);
			model.addAttribute("arr_page", arr_page);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			
		return "album/edit_album";
	}
	

	//앨범생성,편집(임시)
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String albumEdit(){
			
		return "albumEdit";
	}

	//앨범 정보 업데이트
	@ResponseBody
	@RequestMapping(value = "/update_albuminfo", method = RequestMethod.POST)
	public String AlbumFirstCreate(HttpSession session, int album_num, String album_name, String album_contents,
			int album_openrange, int album_category, String hashtag){
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(album_num, album_name, album_openrange, album_contents, album_category);
		
		boolean update_check = false;
		update_check = albumDAO.personal_update_page1_Album(albumwrite);
		
		
		//해쉬태그
//		String[] tags = hashtag.split(",");
//		for(int i = 0; i < tags.length; i++){
//			searchDAO.insertHashTag(new HashTag(0 , ialbumnum , tags[i]));
//		}
				
		return update_check? "success":"fail";
	}
	
	//앨범 페이지별 저장
	@ResponseBody
	@RequestMapping(value = "/save_page", method = RequestMethod.POST)
	public String save_page(String album_num, String arr_page, String mode, HttpSession session){
		
		int int_album_num = -1;
		
		try {
			int_album_num = Integer.parseInt(album_num);
			if (int_album_num == -1) new Exception();
		} catch (Exception e) {
			return "fail";
		}
		
		
		if(mode.equals("all")) {
			// 앨범 전체 저장이므로 album_num으로 기존 페이지 모두 제거
			albumDAO.delete_pages_by_album_num(Integer.parseInt(album_num));
		}

		JSONArray jo_arr_page = new JSONArray(arr_page);
		Gson gson= new Gson();
		
		for (int i = 0; i < jo_arr_page.length(); i++) {
			JSONObject jo_page = jo_arr_page.getJSONObject(i);
			
			PageHtmlVO page = gson.fromJson(jo_page.toString(), PageHtmlVO.class);
			page.setAlbum_num(int_album_num);
			albumDAO.personal_insertAlbumOfPage(page);
		}
		
		return "saved";
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
		File fpath = new File(strThumbnailPath);
	    if(!fpath.isDirectory()){
			fpath.mkdirs();			
		}	
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
		
		AlbumWriteVO albumwrite = new AlbumWriteVO(album_num, album_name, album_openrange, album_contents, album_category);
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
		
		String fullpath = strThumbnailPath + filePath;
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
				//오류 뜨는 게 보기 싫어 잠깐 끔...
				//e.printStackTrace();
			}
		}
		return null;
	}
	
	//사진 자를 때 자르는 창에 맞게 사진 재조정
	@RequestMapping(value = "crop_picture", method = RequestMethod.GET)
	public String crop_picture(Model model, String url_picture) {
				
		String imgFormat; // 새 이미지 포맷. jpg, gif 등
		int newWidth = 500; // 변경 할 넓이
		int newHeight = 500;// 변경 할 높이
			 
		Image image;
		int imageWidth;
		int imageHeight;
		double ratio;
		int w = 0;
		int h = 0;
		int i = 0;
		String picture_name; //사진 이름만 추출
		//이미지 이름만 추출
		while(true) {
			if(url_picture.charAt(i) == '='){
				picture_name = url_picture.substring(i+1, url_picture.length());
				break;
			}
			i++;
		}
		i=0;
		//사진 파일 확장자 추출
		while(true) {
			if(picture_name.charAt(i) == '.'){
				imgFormat = picture_name.substring(i+1, picture_name.length());
				break;
			}
			i++;
		}		
		try{
		    // 원본 이미지 가져오기
			image = ImageIO.read(new File(strFilePath + picture_name));
		    // 원본 이미지 사이즈 가져오기
		    imageWidth = image.getWidth(null);
		    imageHeight = image.getHeight(null);
		    
		    //이미지 파일이 가로가 기냐 세로가 기냐 비교 코드
		    if(imageWidth > imageHeight){
		        ratio = (double)newWidth/(double)imageWidth;
		        w = (int)(imageWidth * ratio);
		        h = (int)(imageHeight * ratio);
		    }
		    else if(imageWidth < imageHeight){
		        ratio = (double)newHeight/(double)imageHeight;
		        w = (int)(imageWidth * ratio);
		        h = (int)(imageHeight * ratio);
		    } else{ //가로세로 같을때
		                w = imageWidth;
		                h = imageHeight;
		            }
		    // 이미지 리사이즈
		    // Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
		    // Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
		    // Image.SCALE_REPLICATE : ReplicateScaleFilter 클래스로 구체화 된 이미지 크기 조절 알고리즘
		    // Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
		    // Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용
			    Image resizeImage = image.getScaledInstance(w, h, Image.SCALE_SMOOTH);
 
	            // 새 이미지  저장하기
            BufferedImage newImage = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
            Graphics g = newImage.getGraphics();
            g.drawImage(resizeImage, 0, 0, null);
            g.dispose();
    	    
            File fpath = new File(strTemp_PicturePath);
    	    if(!fpath.isDirectory()){
    			fpath.mkdirs();			
    	    } 
    	    ImageIO.write(newImage, imgFormat, new File(strTemp_PicturePath+picture_name));
	        } catch (Exception e){
	            e.printStackTrace();
	        }
		//자를 사진 저장한 모델
		String new_url_picture = "img_picture?filePath="+picture_name;
		model.addAttribute("new_url_picture", new_url_picture);
		model.addAttribute("picture_width", w);
		model.addAttribute("picture_height", h);
		
		return "album/crop_picture";
	}
				
	//url 경로 불러오는 코드
	@RequestMapping(value = "img_picture", method = RequestMethod.GET)
	public String img(HttpServletResponse response , String filePath ) {
	
		String fullpath = strTemp_PicturePath + "/" + filePath;
		if(!fullpath.isEmpty()){
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
				
	//자른 사진 저장 코드
	@ResponseBody
	@RequestMapping(value = "/croped_picture_save", method = RequestMethod.POST)
	public String croped_picture_save(HttpServletRequest request) throws Exception{

		String binaryData = request.getParameter("imgUrl");
		File fpath = new File(strFilePath);
	    if(!fpath.isDirectory()){
			fpath.mkdirs();			
		}	
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
            stream = new FileOutputStream(strFilePath+newFileName+".png");
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

		
	
}
