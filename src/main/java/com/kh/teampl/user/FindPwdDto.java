package com.kh.teampl.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FindPwdDto {
	private String id;
	private String pwd;
	private String email;
}
