package com.kh.teampl.recipe;

import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString

public class PagingDto {
	
	/* Page */
	private int page = 1; // 현재 페이지 ( default value : 1 )
	private int totalArticle; // 게시판 내 모든 게시글의 수 
	private final int PAGE_BLOCK_COUNT = 5; // 화면 당 보이는 페이지 갯수
	private int totalPage;
	private int startPage;
	private int endPage;
	
	/* Article Per Page */
	private int articlePerPage = 9; // 페이지 당 게시글 갯수. ( 3 row x 3 col ) 
	private int startRow; // 페이지 당 게시글의 시작 번호 (rownum as rnum)
	private int endRow;  // 페이지 당 게시글의 끝 번호 (rownum as rnum)
	
	/* Search Type */
	private String categories;
	
	private String temp = "H";
	private String latte = "N";
	private String cream = "N";
	private String alcohol = "N";
	private String syrub = "N";
	private String fruit = "N";
	
	private String searchType = "t";
	private String keyword = "";
	
	public void calc() {
		pageCalc();
		rowCalc();
	}
	
	// 한 페이지 내 startRow, endRow 계산 ( rnum ) 
	private void rowCalc() {
		// from page, articlePerPage
		
		// page 1 -> startRow 1 ~ endRow articlePerPage(9)
		// page 2 -> startRow 10 ~ endRow articlePerpage(18)
		
		startRow = ((page - 1) * articlePerPage) + 1;
		endRow = (page * articlePerPage);
		
		if(endRow > totalArticle) {
			endRow = totalArticle;
		}
		
	}
	
	// 전체 게시글의 숫자에 대한 totalPage 로부터, 한 화면 내 startPage, endPage 구함
	private void pageCalc() {
		
		// 1. totalPage 
		totalPage = (int)Math.ceil(totalArticle / (double)articlePerPage);
		
		// 2. startPage, endPage from curPage ( field 'page')
		int pageRange = page - 1; // 0 ~ page - 1
		startPage = (( pageRange / PAGE_BLOCK_COUNT ) * PAGE_BLOCK_COUNT ) + 1 ;
		
		endPage = ((( pageRange / PAGE_BLOCK_COUNT ) + 1) * PAGE_BLOCK_COUNT );
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
	
//	private int page = 1 ;    // 현재 페이지 (default value : 1)
//	private int startRow;     // 시작 행번호 (rnum between A)
//	private int endRow;       // 끝 행번호 (                and B)
//	private int startPage;    // 1 2 3 , ... 10 : 1
//	private int endPage;      // 1 2 3 , ... 10 : 10 
//	private int perPage = 10; // 한 페이지 당 게시글 수 ( N 줄씩 보기 ) default value : 10 
//	private int totalCount;   // 전체 데이터( 게시글 ) 갯수
//	private int totalPage;    // 전체 페이지 갯수
//	
//	private final int PAGE_BLOCK_COUNT = 10; // 화면 당 보이는 페이지 갯수
//	
//	private String searchType;
//	private String keyword;
//	
//	public PagingDto(int page, int perPage, int count, 
//			String searchType, String keyword) {
//		this.page = page;
//		this.perPage = perPage;
//		this.totalCount = count;
//		this.searchType = searchType;
//		this.keyword = keyword;
//		calc();
//	}
//	
//	public void calc() {
//		this.endRow = this.page * this.perPage;
//		this.startRow = this.endRow - (this.perPage - 1);
//		
//		// count     totalPage
//		// 500       50
//		// 501       51
//		
//		// totalPage 
////		totalPage = totalCount / perPage;
////		if((totalCount % perPage) > 0) {
////			totalPage += 1;
////		}
//		
//		totalPage = (int)Math.ceil(this.totalCount / (double)perPage);
//		
//		// startPage, endPage
//		
////		this.endPage = (int)(Math.ceil(page / (double)PAGE_BLOCK_COUNT)) * PAGE_BLOCK_COUNT;
////      this.startPage = (endPage - PAGE_BLOCK_COUNT) + 1;
//		
//		int pageRange = page - 1; // 0 ~ page - 1
//		startPage = (( pageRange / PAGE_BLOCK_COUNT ) * PAGE_BLOCK_COUNT ) + 1 ;
//		
//		endPage = ((( pageRange / PAGE_BLOCK_COUNT ) + 1) * PAGE_BLOCK_COUNT );
//		
//		if(endPage > totalPage) {
//			endPage = totalPage;
//		}
//
//	} // calc()	
}
