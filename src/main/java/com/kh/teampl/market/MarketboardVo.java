package com.kh.teampl.market;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarketboardVo {
	
	private int mbno;
	private String mbtitle;
	private String mbcontents;
	private String mbwriter;
	private int readcount;
	private Timestamp regdate;
	private Timestamp solddate;
	private String mbcategories;
//	private String filename;
	
	
	// 첨부파일
	private String[] filename;
}
