package com.oracle.S202350102.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


import lombok.Data;

@Data
public class Challenge {
	private int 	chg_id;			// 챌린지등록번호
	private int 	user_num;		// 회원번호
	private int 	chg_lg;			// 분류번호
	private int 	chg_md;			// 종류(중분류)
	private String 	title;			// 챌린지명
	private int 	chg_capacity;	// 참여정원
	private String 	chg_conts;		// 챌린지소개
	private int 	state_lg;		// 진행상태(대분류)
	private int 	state_md;		// 진행상태(중분류)
	private String 	upload;			// 인증방법
	private String 	sample_img;		// 인증예시사진
	private int 	freq;			// 인증빈도
	private int 	chg_public;		// 공개여부
	private int 	priv_pswd;		// 비밀번호
	private String 	thumb;			// 썸네일
	private int 	return_lg;		// 반려사유(대분류)
	private int 	return_md;		// 반려사유(중분류)
	@DateTimeFormat(pattern = "yy-MM-dd")
	private Date 	reg_date;		// 챌린지 신청일
	@DateTimeFormat(pattern = "yy-MM-dd")
	private Date 	create_date;	// 챌린지 개설일
	@DateTimeFormat(pattern = "yy-MM-dd")
//	private Date 	start_date;		// 챌린지시작일
	private Date 	return_date;	// 챌린지 반려일
	@DateTimeFormat(pattern = "yy-MM-dd")
	private Date 	end_date;		// 챌린지 마감일
	
	
	//조회용
	private String ctn; 			//챌린지 카테고리명
	private String userName; 		//챌린지 개설자 이름
	private String nick; 			//챌린지 개설자 닉네임
	private String stateCtn; 		//챌린지 진행상태
	private String userId; 			//챌린지 개설자 id
	private String returnReason; 	//챌린지 반려사유
	private int delStatus;			//파일 업로드 -> 파일 삭제 여부 확인용
	
	
	
	// 페이징 조회용    //검색타입		//검색 내용
	private String search;   	private String keyword;
	private String pageNum;
	private int start; 		 	private int end;
	
	// 챌린지 리스트 카테고리 조회용
	private String sortOpt;
	private String chlgerCnt; 		// 챌린지 참여자 수 
	private int	   my_user_num;  	// user별 챌린지 리스트 찜하기 확인용
	private int    pickyn;			// 찜하기 여부 판단용
	private int    pick_cnt;		// 챌린지 찜수
	
	
}
