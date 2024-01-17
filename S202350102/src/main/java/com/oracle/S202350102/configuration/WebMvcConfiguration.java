package com.oracle.S202350102.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.oracle.S202350102.service.jhService.LoginInterceptor;
import com.oracle.S202350102.service.thService.ThAdminInterceptor;
import com.oracle.S202350102.service.thService.ThAuthInterceptor;
import com.oracle.S202350102.service.thService.ThLoginInterceptor;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new ThAuthInterceptor()).addPathPatterns("/chgApplicationForm")		// 지혜 - 챌린지 개설 신청하기										   
													   .addPathPatterns("/thkakaoPayForm")			// 태현 - 구독안내 페이지
													   .addPathPatterns("/mypage")					// 진기 - 마이페이지
													   .addPathPatterns("/sharingUserDetail")		// 진기 - 게시글 작성하기
													   .addPathPatterns("/myLikeSharing")			// 연아 - 찜한 쉐어링
													   .addPathPatterns("/qBoardList")				// 한빛 - 문의 게시판
													   .addPathPatterns("/listUserAdmin")			// 태현 - 관리자 유저 리스트 ( 이건 왜 될까?) 
													   ;
		
		registry.addInterceptor(new ThAdminInterceptor()).addPathPatterns("/detailUserByAdmin")			// 태현 - 관리자 유저 상세
														 .addPathPatterns("/updateUserFormAdmin")		// 태현 - 관리자 유저 업데이트
														 .addPathPatterns("/updateUserAdmin")			// 태현 - 관리자 유저 업데이트 처리
														 .addPathPatterns("/delUserByAdmin")			// 태현 - 관리자 유저 삭제
														 .addPathPatterns("/listUserAdmin")				// 태현 - 관리자 유저 리스트
														 .addPathPatterns("/sharAdminList")				// 진기 - 관리자 쉐어링 관리
														 .addPathPatterns("/communityAdminList")		// 연아 - 관리자 커뮤니티 관리
														 .addPathPatterns("/reportListAdmin")			// 보경 - 관리자 인증게시판 관리
														 .addPathPatterns("/chgAdminList")				// 지혜 - 관리자 챌린지 리스트 관리
														 .addPathPatterns("/replyInsert")				// 해당부분은 바로 원래페이지로 돌아가면 에러나서 일단 홈으로 보내놓음
														 .addPathPatterns("/reviewPost")				// 해당부분은 바로 원래페이지로 돌아가면 에러나서 일단 홈으로 보내놓음
														 .addPathPatterns("/writeCertBrd")				// 해당부분은 바로 원래페이지로 돌아가면 에러나서 일단 홈으로 보내놓음
														 .addPathPatterns("/commentInsert")				// 해당부분은 바로 원래페이지로 돌아가면 에러나서 일단 홈으로 보내놓음
														 ;
		// 로그인 성공시 이전페이지 돌아가기
		registry.addInterceptor(new ThLoginInterceptor()).addPathPatterns("/loginSuc");
		
	}
}
