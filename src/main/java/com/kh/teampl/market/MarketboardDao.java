package com.kh.teampl.market;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.market.dialog.DialogSearchDto;
import com.kh.teampl.market.dialog.MarketboardDialogVo;


@Repository
public class MarketboardDao {
	private final String NAMESPACE = "com.kh.teampl.marketMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	// 리스트 출력
	public List<MarketboardVo> listAll() throws Exception {
		List<MarketboardVo> list = sqlSession.selectList(NAMESPACE + "listAll");
		return list;
	}
	
	// 게시판 글 읽기(특정글 1개 조회) 
	public MarketboardVo reading(int mbno) throws Exception {
		MarketboardVo marketboardVo = sqlSession.selectOne(NAMESPACE + "reading", mbno);
		return marketboardVo;
	}
	
	// 글쓰기 
	public void insert(MarketboardVo marketboardVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insert", marketboardVo);
	}
	
	// 수정
	public void update(MarketboardVo marketboardVo) throws Exception {
//		Map<String, Object> map = new HashMap<>();
//		map.put("marketboardVo", marketboardVo);
//		map.put("id", id);
		System.out.println("update:" + marketboardVo);
		sqlSession.update(NAMESPACE + "update", marketboardVo);
	}

	// 삭제
	public void delete(int mbno) throws Exception {
		sqlSession.delete(NAMESPACE + "delete", mbno);
	}
	
	// 첨부 파일 추가
	public void insertAttach(String fullname, int mbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("fullname", fullname);
		map.put("mbno", mbno);
		sqlSession.insert(NAMESPACE + "insertAttach", map);
	}
	
	// 첨부 파일 목록
	public List<String> getAttachList(int mbno) throws Exception {
		List<String> attachList = sqlSession.selectList(NAMESPACE + "getAttachList", mbno);
		return attachList;
	}
	
	// 첨부 파일 삭제
	public void deleteAttach(String filename) {
		sqlSession.delete(NAMESPACE + "deleteAttach", filename);
	}
	
	public void updateReplycnt(int mbno, int amount) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("amount", amount);
		map.put("mbno", mbno);
		sqlSession.update(NAMESPACE + "updateReplycnt", map);
	}
	
	
	// 시퀀스 얻기 (아마 mbno 값 올리기)
	public int getNextSeq() throws Exception {
		int mbno = sqlSession.selectOne(NAMESPACE + "getNextSeq");
		//System.out.println("MarketboardDao, getNextSeq, mbno: " + mbno);
		return mbno;
	}
	
	
	// 조회수 증가
	public void readcount(MarketboardVo marketboardVo) throws Exception {
		sqlSession.update(NAMESPACE + "readcount", marketboardVo);
	}

	
	// 최다 조회수 글 목록
	public List<MarketboardVo> recountList() throws Exception {
		List<MarketboardVo> recountList = sqlSession.selectList(NAMESPACE + "readcountList");
		return recountList;
	}
	
	public List<MarketboardVo>searchList(String keyword, String categories) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("mbcategories", categories);
		map.put("keyword", keyword);
		List<MarketboardVo>searchList = sqlSession.selectList(NAMESPACE + "searchList", map);
		return searchList;
	}
	
	public void soldOut(int mbno)throws Exception{
		sqlSession.update(NAMESPACE + "soldOut", mbno);
	}
	
	public int getNextSeqDialog() throws Exception {
		int mbno = sqlSession.selectOne(NAMESPACE + "getNextSeqDialog");
		//System.out.println("MarketboardDao, getNextSeq, mbno: " + mbno);
		return mbno;
	}
	
	public void insertDialog(MarketboardDialogVo marketboardDialogVo)throws Exception{
		sqlSession.insert(NAMESPACE + "insertDialog", marketboardDialogVo);
	}
	
	public List<MarketboardDialogVo> getDialogList(DialogSearchDto dialogSearchDto)throws Exception{
		Map<String, Object>map = new HashMap<>();
		map.put("attendant", dialogSearchDto.getAttendant());
		map.put("mbno", dialogSearchDto.getMbno());
		
		List<MarketboardDialogVo>list = sqlSession.selectList(NAMESPACE + "getDialogList", map);
		return list;
	}
	
	public List<String> getAttendantList(int mbno)throws Exception{
		List<String>list = sqlSession.selectList(NAMESPACE + "getAttendantList" ,mbno);
		return list;
	}
	
	public int countAllItems()throws Exception{
		int count = sqlSession.selectOne(NAMESPACE + "countAllItems");
		return count;
	}
	
	public List<MarketboardVo>searchListAll(String keyword) throws Exception{
		List<MarketboardVo>searchListAll = sqlSession.selectList(NAMESPACE + "searchListAll", keyword);
		return searchListAll;
	}
}
