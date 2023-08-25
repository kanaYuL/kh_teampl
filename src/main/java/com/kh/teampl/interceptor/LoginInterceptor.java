package com.kh.teampl.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.teampl.user.LoginUserDto;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		LoginUserDto userDto = (LoginUserDto)session.getAttribute("userInfo");
		
		// 로그인 되어 있지 않다면
		if (userDto == null) {
			String uri = request.getRequestURI();    // 가려고 했던 혹은 간 uri를 얻는다
			System.out.println("uri:" + uri);
			String queryString = request.getQueryString();   // url 뒤의 파라미터를 얻는다
			System.out.println("queryString: " + queryString);
			String targetLocation = uri + "?" + queryString;
			System.out.println("targetLocation: " + targetLocation);
			session.setAttribute("targetLocation", targetLocation);
			
			// 로그인 페이지로 이동
			response.sendRedirect("/user/login");
			return false;     // 실제 요청 처리를 하지 않음
		}
		
		return true; // 요청 처리를 함
	}
	
	
	
	
}
