package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

public interface RelationMapper {
	public int insertFriend(Map<String , String> map);
	public ArrayList<String> selectFriend(String id);
	public int deleteFriend(Map<String , String> map);
	
}
