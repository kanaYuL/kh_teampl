package com.kh.teampl.market.reply;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class ReplyService {
	
	@Autowired
	private ReplyDao replyDao;
	
	
	// 목록
	public List<ReplyVo> list(int mbno) {
		List<ReplyVo> list = replyDao.list(mbno);
		return list;
	}
	
	// 추가
	public void insert(ReplyVo replyVo) {
		replyDao.insert(replyVo);
	}
	
	// 수정
	public void update(ReplyVo replyVo) {
		replyDao.update(replyVo);
		
	}
	
	// 삭제
	@Transactional
	public void delete(int mbrno, int mbno) {
		replyDao.delete(mbrno);
	}
	
	// 수정 시간 얻기
	public Timestamp getUpdatedate(int mbrno) {
		Timestamp updatedate = replyDao.getUpdatedate(mbrno);
		return updatedate;
	}
	
	
}