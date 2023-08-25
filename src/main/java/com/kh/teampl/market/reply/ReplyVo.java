package com.kh.teampl.market.reply;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVo {
	private int mbrno;
	private int mbno;
	private String mbrwriter;
	private String mbrcontents;
	private Timestamp regdate;
	private Timestamp updatedate;
}