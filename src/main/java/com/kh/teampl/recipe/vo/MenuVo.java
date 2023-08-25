package com.kh.teampl.recipe.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MenuVo {
	private int mno;
	private String mname;
	private String mdesc;	
	private String mfilename;
}
