package com.kh.teampl.market.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
public class LikeService {

	
	@Autowired
	private LikeDao likeDao;
	
	@Transactional
	public void plusLike(String id, int mbno) {
		likeDao.plusLike(id, mbno);
	}
	@Transactional
	public void cancelLike(String id, int mbno) {
		likeDao.cancelLike(id, mbno);
	}
	
	@Transactional
	public String setLike(String id, int mbno) {
		String str = likeDao.setLike(id, mbno);
		if(str.equals("yes"))
			return str;
		return "no";
	}
	@Transactional
	public int setLikeCount(int mbno) {
		int count = likeDao.setLikeCount(mbno);
		return count;
	}
}
