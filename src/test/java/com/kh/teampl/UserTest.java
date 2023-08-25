package com.kh.teampl;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.RandomStringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class UserTest {
	
	@Resource(name = "mailSender")
	private JavaMailSenderImpl mailSender; 
	
	@Test
	public void testMail() {
		
		// 메일 제목, 내용
		String subject = "제목입니당";
		String content = "내용입니당~";
		
		// 보내는 사람
		String from = "cigr4456@gmail.com";
		
		// 받는 사람
		String[] to = new String[2];
		to[0] = "cigr4455@daum.net";
		to[1] = "cigr45@naver.com";
		
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
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test 
	public void testCreatePwd() {
		String pwd = RandomStringUtils.randomAlphanumeric(10);
		System.out.println(pwd);
	}

}
