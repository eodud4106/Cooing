package com.cooing.www.jinsu.controller;


import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.dy.dao.AlbumDAO;
import com.cooing.www.dy.vo.AlbumWriteVO;
import com.cooing.www.dy.vo.PageHtmlVO;
import com.cooing.www.jinsu.dao.SearchDAO;
import com.cooing.www.jinsu.object.HashTag;


@Controller
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class); 
	
	@Autowired
	SearchDAO searchDAO;
	
	@Autowired
	AlbumDAO albumDAO;
	
	@ResponseBody
	@RequestMapping(value="/searchWord" , method = RequestMethod.POST)
	public ArrayList<AlbumWriteVO> searchWord(String searchtext){
		logger.info("search_word__jinsu");
		//검색어가 해쉬 태그 , 앨범 이름, 설명 , 앨범 만든 사람
		
		ArrayList<AlbumWriteVO> arrayalbum = albumDAO.searchAlbum(searchtext);		
		ArrayList<HashTag> arraytag = searchDAO.selectHashTag(searchtext);
		for(int i = 0; i < arraytag.size();i++){
			arrayalbum.add(albumDAO.searchAlbumNum(arraytag.get(i).getTag_albumnum()));
		}
		ArrayList<Albumlist> arraypicture = new ArrayList<Albumlist>();
		for(int i = 0; i < arrayalbum.size();i++){
			PageHtmlVO page=albumDAO.searchPage1(arrayalbum.get(i).getAlbum_num()); 
			arraypicture.add(new Albumlist(arrayalbum.get(i) , page.getPage_html()));
		}
			
		return arrayalbum;		
	}
	
	protected class Albumlist{
		private AlbumWriteVO albumobj;
		private String picturehtml;
		
		public Albumlist(AlbumWriteVO albumobj , String picturehtml){
			this.albumobj = albumobj;
			this.picturehtml = picturehtml;
		}

		public AlbumWriteVO getAlbumobj() {
			return albumobj;
		}

		public void setAlbumobj(AlbumWriteVO albumobj) {
			this.albumobj = albumobj;
		}

		public String getPicturehtml() {
			return picturehtml;
		}

		public void setPicturehtml(String picturehtml) {
			this.picturehtml = picturehtml;
		}

		@Override
		public String toString() {
			return "Albumlist [albumobj=" + albumobj + ", picturehtml=" + picturehtml + "]";
		}		
	}
}