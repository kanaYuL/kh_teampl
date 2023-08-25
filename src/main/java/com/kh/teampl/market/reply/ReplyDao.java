package com.kh.teampl.market.reply;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDao {
	private final String NAMESPACE = "com.kh.teampl.ReplyMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	
	// 댓글 목록
	public List<ReplyVo> list(int mbno) {
		List<ReplyVo> list = sqlSession.selectList(NAMESPACE + "list", mbno);
		return list;
	}
	
	// 댓글 추가
	public void insert(ReplyVo replyVo) {
		sqlSession.insert(NAMESPACE + "insert", replyVo);
	}
	
	
	// 댓글 수정
	public void update(ReplyVo replyVo) {
		sqlSession.update(NAMESPACE + "update", replyVo);
	}
	
	
	// 댓글 삭제 
	public void delete(int mbrno) {
		sqlSession.delete(NAMESPACE + "delete", mbrno);
	}
	
	// 수정날짜 얻기
	public Timestamp getUpdatedate(int mbrno) {
		Timestamp updatedate = sqlSession.selectOne(NAMESPACE + "getUpdatedate", mbrno);
		return updatedate;
	}
	
	
}