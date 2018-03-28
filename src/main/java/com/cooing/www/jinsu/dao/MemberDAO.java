package com.cooing.www.jinsu.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.jinsu.object.Member;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertMember(Member member){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.insertMember(member) > 0)
			return true;
		else 
			return false;
	}
	
	public Member selectMember(String id){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMember(id);
	}
	
	/*public ArrayList<Web5Board> selectBoard(String search ,int startp , int endp){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);							
		RowBounds rb = new RowBounds(startp , endp);
		return mapper.selectBoard(rb , search);
	}
	
	public Web5Board selectoneBoard(int num){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectoneBoard(num);
	}
	
	public boolean hitsupBoard(int num){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.hitsupBoard(num) > 0)
			return true;
		else 
			return false;
	}
	
	public boolean deleteoneBoard(int num){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.deleteoneBoard(num) > 0)
			return true;
		else 
			return false;
	}
	
	public int countBoard(String search){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.countBoard(search.toUpperCase());		
	}
	
	public boolean updateoneBoard(Web5Board board){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(mapper.updateoneBoard(board) > 0)
			return true;
		else 
			return false;
	}*/
}
