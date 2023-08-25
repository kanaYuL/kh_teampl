package com.kh.teampl.user;

import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.util.Sha256;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	@Resource(name = "mailSender")
	private JavaMailSenderImpl mailSender; 
	
	public boolean isDupId(String id) {
		return userDao.isDupId(id);
	}
	
	public void createUser(JoinDto joinDto) {
		userDao.createUser(joinDto);
	}
	
	// ifPresent( null 아닐 때 처리되는 메서드 ) 
	// orElseGet( null 일때 처리되는 메서드 )
	@Transactional
	public Optional<UserVo> login(LoginDto loginDto) {
		Optional<UserVo> maybeUserVo = userDao.getUser(loginDto);
		maybeUserVo.ifPresent(userVo -> {userDao.updateloginDate(userVo); });
	
		return maybeUserVo;
	}
	
	public boolean loginCheck(LoginDto loginDto) {
		return userDao.loginCheck(loginDto);
	}
	
	@Transactional
	public void findPwd(Map<String, String> map) {
		// 1. ID와 EMAIL 검증 이후 메일로 새 비밀번호 만들어서 보내줌.
		UserVo userVo = userDao.getUserFromIDEmail(map);
		if (userVo != null) {
					
		// 메일 제목, 내용
		String subject = "[ NPE ] 임시 비밀번호 안내";

		// 임시 비밀번호 설정 ( 8자리 )
		String pwd = RandomStringUtils.randomAlphanumeric(8);
		String content = "임시 비밀번호는 " + pwd + "입니다.";
		System.out.println("[UserService findPwd, content] " + content);
		// 보내는 사람
		String from = "cigr4456@gmail.com";
					
		// 받는 사람 - 사용자가 입력한 이메일
		String to = map.get("email"); 

		try {
			// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

			// 메일 내용을 채워줌
			mailHelper.setFrom(from);	// 보내는 사람 셋팅
			mailHelper.setTo(to);		// 받는 사람 셋팅
			mailHelper.setSubject(subject);	// 제목 셋팅
			mailHelper.setText(content);	// 내용 셋팅

			// 메일 전송
			mailSender.send(mail);
			
			// 실제 DB에 반영
			map.put("pwd", Sha256.encrypt(pwd));
			map.remove("email");
			
			userDao.setNewPwd(map);
			
			} catch(Exception e) {
				e.printStackTrace();
		  	}
		}					
	}
	
	public String getIDFromEmail(String email) {
		return userDao.getIDFromEmail(email);
	}
	
	public UserVo getUserFromIDEmail(Map<String, String> map) {
		
		return userDao.getUserFromIDEmail(map); 
	}
	
	public void setNewPwd(Map<String, String> map) {
		userDao.setNewPwd(map);
	}
	
}
