package com.kh.teampl.user;

import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.util.Sha256;

@Repository
public class UserDao {
	private static final String NAMESPACE = "com.kh.teampl.userMapper.";
	
	@Autowired
	SqlSession sqlsession;
	
	public boolean isDupId(String id) {
		int count = (int)sqlsession.selectOne(NAMESPACE + "isDupId", id);
		
		if (count == 1) {
			return true;
		}
		
		return false;
	}
	
	public void createUser(JoinDto joinDto) {
		sqlsession.insert(NAMESPACE + "createUser", joinDto);
	}
	
	public boolean loginCheck(LoginDto loginDto) {
		int count = sqlsession.selectOne(NAMESPACE + "loginCheck", loginDto);
		
		if (count == 1) {
			return true;
		}
		
		return false;
	}
	
	public void updateloginDate(UserVo userVo) {
		sqlsession.update(NAMESPACE + "updateloginDate", userVo);		
	}
	
	public Optional<UserVo> getUser(LoginDto loginDto) {
		
		UserVo userVo = sqlsession.selectOne(NAMESPACE + "getUser", loginDto);
		Optional<UserVo> maybeUserVo = Optional.ofNullable(userVo);
		
		return maybeUserVo;
	}
	
	public String getIDFromEmail(String email) {
		return sqlsession.selectOne(NAMESPACE + "getIDFromEmail", email);
	}
	
	public UserVo getUserFromIDEmail(Map<String, String> map) {
		
		UserVo userVo = sqlsession.selectOne(NAMESPACE + "getUserFromIDEmail", map);
		
		return userVo;
	}
	
	public void setNewPwd(Map<String, String> map) {
		
		sqlsession.update(NAMESPACE + "setNewPwd", map);
	}
	
	
	
}
