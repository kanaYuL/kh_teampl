package com.kh.teampl.market.dialog;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MarketboardDialogVo {
	private int mbdno;
	private String attendant;
	private String drole;
	private String mbdcontents;
	private Timestamp regdate;
	private int mbno;
}
