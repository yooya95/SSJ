package com.oracle.S202350102.dto;

import java.time.LocalDate;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Report {
	private int  report_id;  // 신고번호
	private int  user_num;   // 회원번호
	private int  brd_num;	 // 게시물등록번호
	private Date report_date;// 신고일
	private int  report_lg;	 // 신고상세사유(대분류)
	private int  report_md;	 // 신고상세사유(중분류)
	private int  ctg_lg;	 // 신고 카테고리(대분류)
	private int  ctg_md;	 // 신고 카테고리(중분류)
	private int  cnt;		 // 신고 횟수
	private Date mod_date;	 // 처리일
	private int  state_lg;	 // 신고처리상태(대분류)
	private int  state_md;	 // 신고처리상태(중분류)
	
	// 과거 신고 여부 조회
	private int burningRecord;
	
	// 페이징 조회용 & 검색
	private int start;
	private int end;
	private String keyword;
	private String searchType;
	private String startDate;
	private String endDate;
	
   // 리스트 조회용
   private String reported_name;
   private String reported_id;
   private String reported_nick;
   private String reporter_name;
   private String reporter_id;
   private String reporter_nick;
   private String ctn;
   private String title;
   private String user_img;
   
   // 모달창 용 -> 시간이 될 때 map 방식도
   private String	img;
   private Date		reg_date;
   private String	conts;

}
