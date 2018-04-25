package com.cooing.www.common.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.cooing.www.album.vo.AlbumWriteVO;
import com.cooing.www.album.vo.CategoryPop;
import com.cooing.www.album.vo.HashTag;
import com.cooing.www.common.vo.Search;

public interface SearchMapper {
	public int insertHashTag(HashTag tag);
	public ArrayList<HashTag> selectHashTag(String search);
	
	public int insertSearch(Search search);
	public ArrayList<Map<String , Object>> selectDaySearch(String date);
	
	public int insertCategoryPop(CategoryPop categorypop);
	public ArrayList<Map<String , Object>> selectDayCategory(String date);
	
	public ArrayList<Map<String , Object>> selectDayLike(String date);
}
