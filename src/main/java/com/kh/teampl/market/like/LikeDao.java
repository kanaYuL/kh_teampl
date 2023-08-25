package com.kh.teampl.market.like;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class LikeDao {

	private static final String NAMESPACE= "com.kh.teampl.LikeMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public void plusLike(String id, int mbno) {
		Map<String, Object>map = new HashMap<>();
		map.put("id", id);
		map.put("mbno", mbno);
		sqlSession.insert(NAMESPACE + "plus", map);
	}
	
	public void cancelLike(String id, int mbno) {
		Map<String, Object>map = new HashMap<>();
		map.put("id", id);
		map.put("mbno", mbno);
		sqlSession.insert(NAMESPACE + "cancel", map);
	}
	
	public String setLike(String id, int mbno) {
		Map<String, Object>map = new HashMap<>();
		map.put("id", id);
		map.put("mbno", mbno);
		LikeVo vo = sqlSession.selectOne(NAMESPACE + "set", map);
		
		if(vo != null) {
			return "yes";
		}
		
		return "no";
	}
	public int setLikeCount(int mbno) {		
		int count = sqlSession.selectOne(NAMESPACE + "setCount", mbno);
		return count;
	}
	
	
}
