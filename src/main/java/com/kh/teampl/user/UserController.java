package com.kh.teampl.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.util.Sha256;
import com.kh.teampl.util.UserUtil;

@Controller
@RequestMapping("/user")

public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		System.out.println("[User Controller] login");
		return "/user/login";
	}
	
	// 로그인 폼
	@RequestMapping(value ="/loginRun", method = RequestMethod.POST) 
	public String loginRun(LoginDto loginDto, Model model, HttpSession session) {
		
		String url = "redirect:/user/login";
		
		// pwd SHA-256 (단방향)  
		loginDto.setPwd(Sha256.encrypt(loginDto.getPwd()));
		UserVo userVo = userService.login(loginDto).orElse(null);

		if (userVo != null) {
			
			// 1. 로그인 성공 시, Session에 로그인 회원 정보 Binding
			// 2. 로그인 처리 이후 메인 화면으로 이동
			String targetLocation = (String) session.getAttribute("targetLocation");
			
			if (targetLocation != null) {
				url = "redirect:" + targetLocation;
			} else {
				url = "redirect:/";
			}
			
			session.removeAttribute("targetLocation");
			session.setAttribute("userInfo", UserUtil.createLoginUserDto(userVo));
		}
			
		return url;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("userInfo");
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		
		return "/user/join";
	}
	
	@ResponseBody
	@RequestMapping(value = "/isDupId", method = RequestMethod.POST)
	public String isDupId(@RequestBody Map<String, Object> map) {
		
		String id = (String)map.get("id");
		boolean dupResult = userService.isDupId(id);
		
		if(dupResult) {
			return "TRUE";
		}
		
		return "FALSE";
	}
	
	@RequestMapping(value = "/joinRun", method = RequestMethod.POST)
	public String joinRun(JoinDto joinDto, RedirectAttributes rttr) {
		
		// 평문 비밀번호 암호화 -> SHA256, 64bit.
		joinDto.setPwd(Sha256.encrypt(joinDto.getPwd()));
		System.out.println("[User Controller] joinDto : " + joinDto);
		
		// 회원가입 처리 -> tbl_user 에 insert
		userService.createUser(joinDto);
		
		rttr.addFlashAttribute("result", true);
		
		return "redirect:/user/login";
	}
	
	@RequestMapping(value = "findID", method = RequestMethod.GET)
	public String findID(String email) {
		
		return "/user/findID";
	}
	
	@ResponseBody
	@RequestMapping(value = "findIDRun", method = RequestMethod.POST)
	public String findIDRun(@RequestBody Map<String, Object> map) {
		String email = (String)map.get("email");
		
		return userService.getIDFromEmail(email);
	}
	
	@RequestMapping(value = "findPwd", method = RequestMethod.GET)
	public String findPwd() {
				
		return "/user/findPwd";
	}
	
	@RequestMapping(value = "findPwdRun", method = RequestMethod.POST)
	public String findPwdRun(String id, String email, 
			                 Model model, RedirectAttributes rttr) {
		
		String url = "";
		
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("email", email);
		
		UserVo userVo = userService.getUserFromIDEmail(map);
		
		// 아이디, 이메일 동일
		if (userVo != null) {
			url = "/user/setNewPwd";
			model.addAttribute("id", id);
		
		// 아이디, 이메일 다름 
		} else {
			url = "redirect:/user/findPwd";
			rttr.addFlashAttribute("findPwdFail", false);
		}
		
		return url;
	}
	
	@RequestMapping(value = "setNewPwd", method = RequestMethod.GET) 
	public String setNewPwd() {
		
		return "/user/setNewPwd";
	}
	
	@RequestMapping(value = "setNewPwdRun", method = RequestMethod.POST) 
	public String setNewPwdRun(String id, String pwd) {
		
		// userService.findPwd(map);
		System.out.println("[UserController setNewPwdRun] id : " + id);
		System.out.println("[UserController setNewPwdRun] pwd : " + pwd);
		
		Map<String, String> map = new HashMap<>();
		
		map.put("id", id);
		map.put("pwd", Sha256.encrypt(pwd));
		userService.setNewPwd(map);
		
		return "redirect:/user/login";
	}
}
