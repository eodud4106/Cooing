package com.cooing.www.common.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.album.vo.CategoryPop;
import com.cooing.www.album.vo.HashTag;
import com.cooing.www.common.vo.Search;

public interface SearchMapper {
	public int insertSearch(Search search);
	public int insertCategoryPop(CategoryPop categorypop);
	
	public ArrayList<Map<String , Object>> selectDayCategory(RowBounds rb , String date);
	public ArrayList<Map<String , Object>> selectDaySearch(RowBounds rb , String date);
	public ArrayList<Map<String , Object>> selectDayLike(RowBounds rb , String date);
	
	public ArrayList<String> search_id_check(String search);
}
