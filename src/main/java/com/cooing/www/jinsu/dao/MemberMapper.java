package com.cooing.www.jinsu.dao;

import com.cooing.www.jinsu.object.Category;
import com.cooing.www.jinsu.object.Member;

public interface MemberMapper {
	public int insertMember(Member member);
	public Member selectMember(String id);
	/*public ArrayList<Web5Board> selectBoard(RowBounds rb , String search);
	public Web5Board selectoneBoard(int num);
	public int hitsupBoard(int num);
	public int deleteoneBoard(int num);
	public int countBoard(String search);
	public int updateoneBoard(Web5Board board);*/
	public int insertCategory(Category category);
}
