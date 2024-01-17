package com.oracle.S202350102.service.thService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class ThAdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("ThAdminInterceptor Prehandle Start.....");
		System.out.println("[Controller Method 호출 전]");
		System.out.println("[" + request.getMethod() + "]");
		System.out.println("[" + request.getRequestURL() + "]");
		System.out.println("[" + request.getRequestURI() + "]");
		//request에서 세션정보 추출
		HttpSession session = request.getSession();
		
		//로그인 여부 확인 -> 로그인 전이면 로그인 페이지로 이동
		int userNum = 0;
		System.out.println("session.getAttribute(\"status_md\") --> " + session.getAttribute("status_md"));
		System.out.println("session.getAttribute(\"user_num\")) --> " + session.getAttribute("user_num"));
		
		// 세션에 담긴 회원 번호가 없다 --> 홈
		if(session.getAttribute("user_num") == null) {
			System.out.println("세션에 담긴 회원 정보 없음");
			response.sendRedirect("/errorLogin");
			return false;
			
		// 세션에 담긴 회원번호가 있다
		} else {
			
			// 세션에 담긴 유저 상태가 관리자(102)다 --> 정상적으로 controller 탄다.		
			if(session.getAttribute("status_md").equals(102)) {
				System.out.println("유저상태 --> 관리자");
				return true;

			// 세션에 담긴 유저 상태가 관리자(102)가 아니다 --> 홈
			} else {
				System.out.println("유저상태 --> 관리자 아님");
				userNum = (int) session.getAttribute("user_num");
				System.out.println("ThAdminInterceptor Prehandle userNum -> " + userNum);
				response.sendRedirect("/errorAuth");
				return false;
			}
		}

		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("ThAdminInterceptor Interceptor PostHandle Start.....");
	//	HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	

	
}
