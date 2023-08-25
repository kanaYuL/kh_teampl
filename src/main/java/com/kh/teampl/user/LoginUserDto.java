package com.kh.teampl.user;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class LoginUserDto {
	private String id;
	private String email;
	private String isauth;
	private Timestamp recentlog;
	private Timestamp regdate;
	private int point;
	
}
