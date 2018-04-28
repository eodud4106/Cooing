package com.cooing.www.album.controller;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.common.vo.PageLimit;


@Controller
@RequestMapping(value = "album")
public class AlbumController {

	private static final Logger logger = LoggerFactory.getLogger(AlbumController.class);
	
	@Inject
	private AlbumDAO albumDAO;
	
	//파티 앨범 리스트 조회
	@ResponseBody
	@RequestMapping(value = "/getPartyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumVO> getPartyAlbumList(String party_name, int pagenum, HttpSession session) {
		logger.info(party_name + "_page_list ljs");
		
		// 파티는 파티 이름이 유니크. 그래서 파티 이름으로 총 파티 앨범 개수를 구한다.
		int totalnum = albumDAO.total_album_count(party_name,"3");
		
		PageLimit pl = new PageLimit(10, 5, pagenum, totalnum);
		//pl.getStartBoard(), pl.getCountPage();
		RowBounds rb = new RowBounds(pl.getStartBoard(), pl.getCountPage());
		
		AlbumVO album = new AlbumVO();
		album.setAlbum_writer(party_name);
		album.setIsPersonal("0");
		
		ArrayList<AlbumVO> arr_album = null;
		
		try {
			arr_album = albumDAO.select_album(rb, album);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return arr_album;
	}
	
}
