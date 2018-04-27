package com.cooing.www.common.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.album.vo.CategoryPop;
import com.cooing.www.album.vo.HashTag;
import com.cooing.www.common.vo.Search;

public interface SearchMapper {
	public int insertSearch(Search search);
	public ArrayList<Map<String , Object>> selectDaySearch(String date);
	
	public int insertCategoryPop(CategoryPop categorypop);
	public ArrayList<Map<String , Object>> selectDayCategory(String date);
	
	public ArrayList<Map<String , Object>> selectDayLike(String date);
	
	public ArrayList<String> search_id_check(String search);
}
