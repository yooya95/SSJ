package com.oracle.S202350102.service.jhService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
	
    
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("LoginInterceptor Interceptor Prehandle Start.....");
		System.out.println("[Controller Method 호출 전]");
		System.out.println("[" + request.getMethod() + "]");
		System.out.println("[" + request.getRequestURL() + "]");
		System.out.println("[" + request.getRequestURI() + "]");
		//request에서 세션정보 추출
		HttpSession session = request.getSession();
		
		//로그인 여부 확인 -> 로그인 전이면 로그인 페이지로 이동
		int userNum = 0;
		if(session.getAttribute("user_num") == null) {
			response.sendRedirect("/errorLogin");
			return false;
			
		} else {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		}
		//로그인 되어있으면 정상적 요청으로 컨트롤러로 이동
		return true;
	}
	
	
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("LoginInterceptor Interceptor PostHandle Start.....");

//		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	


}
