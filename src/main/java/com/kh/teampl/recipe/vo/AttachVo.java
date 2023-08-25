package com.kh.teampl.recipe.vo;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class AttachVo {
	private Integer mno;
	private String filename;
	private Timestamp regdate;
}
