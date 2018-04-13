package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import com.cooing.www.jinsu.object.HashTag;
import com.cooing.www.jinsu.object.Party;
import com.cooing.www.jinsu.object.PartyMember;

public interface SearchMapper {
	public int insertHashTag(HashTag tag);
	public ArrayList<HashTag> selectHashTag(String search);
}
