package com.cooing.www.jinsu.dao;

import java.util.ArrayList;

import com.cooing.www.jinsu.object.HashTag;
import com.cooing.www.jinsu.object.Search;

public interface SearchMapper {
	public int insertHashTag(HashTag tag);
	public ArrayList<HashTag> selectHashTag(String search);
	
	public int insertSearch(Search search);
	public ArrayList<Search> selectDaySearch(String date);
}
