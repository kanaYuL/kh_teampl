package com.kh.teampl.user;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserVo {
	private String id;
	private String pwd;
	private String email;
	private String isauth;
	private Timestamp regdate;
	private Timestamp recentlog;
	private int point; 
}
