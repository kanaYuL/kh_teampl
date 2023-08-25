package com.kh.teampl.market;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MarketAttachVo {
	private String fullname;
	private int mbno;
	private Timestamp regdate;
}
