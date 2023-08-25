package com.kh.teampl.market;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.market.dialog.DialogSearchDto;
import com.kh.teampl.market.dialog.MarketboardDialogVo;

@Service
public class MarketboardService {
	
	@Autowired
	private MarketboardDao marketboardDao;
	
	// 리스트 출력
	public List<MarketboardVo> listAll() throws Exception {
		List<MarketboardVo> list =  marketboardDao.listAll();
		return list;
	}
	
	// 게시판 글 읽기(특정글 1개 조회) 
	public MarketboardVo reading(int mbno) throws Exception {
		MarketboardVo marketboardVo = marketboardDao.reading(mbno);
		return marketboardVo;
	}
	
	// 글쓰기
	@Transactional
	public void insert(MarketboardVo marketboardVo) throws Exception {
		int mbno = marketboardDao.getNextSeq();
		marketboardVo.setMbno(mbno);
		marketboardDao.insert(marketboardVo);
		
		if (marketboardVo.getFilename() != null) {
			for (String fullname : marketboardVo.getFilename()) {
				marketboardDao.insertAttach(fullname, mbno);    
			}
		}
	}
		
	// 수정
	@Transactional
	public void update(MarketboardVo marketboardVo) throws Exception {
		
		// 1. tbl_marketboard 수정
		marketboardDao.update(marketboardVo);
		
		// 2. new fullnames insert to tbl_market_attach
		if (marketboardVo.getFilename() != null) {
			for (String fullname : marketboardVo.getFilename()) {
				marketboardDao.insertAttach(fullname, marketboardVo.getMbno());
			}
		}
	}
	
	// 삭제
	@Transactional
	public void delete(int mbno, List<String> filenames) throws Exception {
		for (String fullname : filenames) {
			marketboardDao.deleteAttach(fullname);
		}
		marketboardDao.delete(mbno);
	}
	

	public List<String> getAttachList(int bno) throws Exception {
		List<String> attachList = marketboardDao.getAttachList(bno);
		return attachList;
	}
	
	
	public void deleteAttach(String filename) {
		marketboardDao.deleteAttach(filename);
	}
	
	
	// 조회수 증가
	public void readcount(MarketboardVo marketboardVo) throws Exception {
		marketboardDao.readcount(marketboardVo);
	}
	
	
	// 최다 조회수 글 목록
		public List<MarketboardVo> readcountList() throws Exception {
			List<MarketboardVo> recountList = marketboardDao.recountList();
			return recountList;
		}
		
		
	public List<MarketboardVo> searchList(String keyword, String categories) throws Exception{
        List<MarketboardVo>list = marketboardDao.searchList(keyword, categories);
		return list;
    }
	
	public void soldOut(int mbno) throws Exception{
		marketboardDao.soldOut(mbno);
	}
	
	@Transactional
	public void insertDialog(MarketboardDialogVo marketboardDialogVo)throws Exception{
		int mbdno = marketboardDao.getNextSeqDialog();
		marketboardDialogVo.setMbdno(mbdno);
		marketboardDao.insertDialog(marketboardDialogVo);
	}
	
	public List<MarketboardDialogVo> getDialogList(DialogSearchDto dialogSearchDto) throws Exception{
		List<MarketboardDialogVo>list = marketboardDao.getDialogList(dialogSearchDto);
		return list;
	}
	public List<String> getAttendantList(int mbno)throws Exception{
		List<String>list = marketboardDao.getAttendantList(mbno);
		return list;
	}
	public int getTotalItems() throws Exception{
        return marketboardDao.countAllItems(); // 데이터베이스에서 전체 아이템 수를 가져옴
    }
	
	public List<MarketboardVo> searchListAll(String keyword) throws Exception{
		List<MarketboardVo>searchListAll = marketboardDao.searchListAll(keyword);
		return searchListAll;
	}
}
