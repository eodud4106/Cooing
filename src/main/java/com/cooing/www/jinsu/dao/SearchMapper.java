package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import com.cooing.www.jinsu.object.CategoryPop;
import com.cooing.www.jinsu.object.HashTag;
import com.cooing.www.jinsu.object.Search;

public interface SearchMapper {
	public int insertHashTag(HashTag tag);
	public ArrayList<HashTag> selectHashTag(String search);
	
	public int insertSearch(Search search);
	public ArrayList<Map<String , Object>> selectDaySearch(String date);
	
	public int insertCategoryPop(CategoryPop categorypop);
	public ArrayList<Map<String , Object>> selectDayCategory(String date);
}
