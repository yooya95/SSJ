package com.oracle.S202350102.service.thService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;


@Slf4j
// 로그인한 사용자에 대해서 postHandle()을 통해 HttpSession에 보관하는 처리.
public class ThLoginInterceptor implements HandlerInterceptor {
	
	private static final String LOGIN = "login";
    private static final Logger logger = LoggerFactory.getLogger(ThLoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("ThLoginInterceptor preHandle Start...");
		
		// 클라이언트 요청에 대한 세션을 가져오거나 세션이 없을경우 새로 생성
		HttpSession session = request.getSession();
        
        if(session.getAttribute(LOGIN) != null) {
        
            // 기존 HttpSession에 남아있는 정보가 있는 경우 이를 삭제
            logger.info("clear login data before");
            session.removeAttribute(LOGIN);
        }
        
        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("ThLoginInterceptor postHandle Start...");
		HttpSession session = request.getSession();
		System.out.println("modelAndView --> " + modelAndView);
        ModelMap 	modelMap = modelAndView.getModelMap();
        Object 		user1 = modelMap.get("user1");
        System.out.println("ThLoginInterceptor postHandle modelMap.get(\"user1\") --> " + modelMap.get("user1"));
        
        if(user1 != null) {
            // 로그인 성공시 Session에 저장후, 초기 화면 이동
            logger.info("new login success");
            session.setAttribute(LOGIN, user1);
            
            // 이전 destination 불러오기
            Object dest = session.getAttribute("dest");
            
            // dest값이 null이 아니면 이전주소로, null이면 메인페이지로 이동
            response.sendRedirect(dest != null ? (String)dest : "/");
        }
	}
	
}
