package com.kh.teampl.util;

import com.kh.teampl.user.LoginUserDto;
import com.kh.teampl.user.UserVo;

public class UserUtil {
	public static LoginUserDto createLoginUserDto(UserVo userVo) {
		
		LoginUserDto loginUserDto = new LoginUserDto();
		
		loginUserDto.setId(userVo.getId());
		loginUserDto.setEmail(userVo.getEmail());
		loginUserDto.setIsauth(userVo.getIsauth());
		loginUserDto.setRecentlog(userVo.getRecentlog());
		loginUserDto.setPoint(userVo.getPoint());
		loginUserDto.setRegdate(userVo.getRegdate());
		
		return loginUserDto;
	}
}
