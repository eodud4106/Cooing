package com.cooing.www.album.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.chat.dao.MessageDAO;
import com.cooing.www.chat.vo.MessageVO;
import com.cooing.www.common.vo.PageLimit;
import com.cooing.www.member.vo.Member;

@Controller
@RequestMapping(value = "album")
public class AlbumController {

	private static final Logger logger = LoggerFactory.getLogger(AlbumController.class);
	
	@Inject
	private AlbumDAO albumDAO;
	
	//파티 앨범 리스트 조회
	@ResponseBody
	@RequestMapping(value = "/getPartyAlbumList", method= RequestMethod.POST)
	public ArrayList<AlbumWriteVO> getPartyAlbumList(String party_name, int pagenum, HttpSession session) {
		logger.info(party_name + "_page_list ljs");
		
		// 파티는 파티 이름이 유니크. 그래서 파티 이름으로 총 파티 앨범 개수를 구한다.
		int totalnum = albumDAO.TotalAlbumCount(party_name);
		
		PageLimit pl = new PageLimit(10, 5, pagenum, totalnum);
		//pl.getStartBoard(), pl.getCountPage();
		RowBounds rb = new RowBounds(pl.getStartBoard(), pl.getCountPage());
		
		AlbumWriteVO album = new AlbumWriteVO();
		album.setAlbum_writer(party_name);
		album.setIsPersonal(0);
		
		ArrayList<AlbumWriteVO> arr_album = null;
		
		try {
			arr_album = albumDAO.select_album(rb, album);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return arr_album;
	}
	
}
