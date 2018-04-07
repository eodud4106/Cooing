package com.cooing.www.jinsu.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cooing.www.jinsu.object.Party;
import com.cooing.www.jinsu.object.PartyMember;

@Repository
public class RelationDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertFriend(Map<String , String> map){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.insertFriend(map) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<String> selectFriend(String id){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);							
		return mapper.selectFriend(id);
	}
	
	public boolean deleteFriend(Map<String , String> map){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.deleteFriend(map) > 0)
			return true;
		else 
			return false;
	}
	
	public boolean insertParty(Party group){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.insertParty(group) > 0)
			return true;
		else 
			return false;
	}
	
	public int  searchPartyNumber(String id){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchPartyNumber(id);
	}
	
	public ArrayList<String> searchLeaderPartyName(String id){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchLeaderPartyName(id);
	}	
	
	public boolean insertPartyMember(PartyMember pm){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		if(mapper.insertPartyMember(pm) > 0)
			return true;
		else 
			return false;
	}
	
	public ArrayList<Party> searchPartyByMemberid(String id){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchPartyByMemberid(id);
	}
	
	public String searchPartyName(int inum){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchPartyName(inum);
	}
	
	public Party searchParty(String groupname){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchParty(groupname);
	}
	
	public ArrayList<PartyMember> searchPartyMember(int groupnum){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.searchPartyMember(groupnum);
	}
	
	public int deletePartyMember(Map<String,Object> map){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.deletePartyMember(map);
	}
	
	public int deleteMemberParty(int groupnum){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.deleteMemberParty(groupnum);
	}
	public int deleteLeaderParty(int groupnum){
		RelationMapper mapper = sqlSession.getMapper(RelationMapper.class);
		return mapper.deleteLeaderParty(groupnum);
	}
}
