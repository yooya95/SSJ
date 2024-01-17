package com.oracle.S202350102.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "Report")
@Getter
@Setter
@ToString
// @Data 대신 나눠서도 써봄
public class Report {

	@Id
	private int  report_id;  // 신고번호
	private int  user_num;   // 회원번호
	private int  brd_num;	 // 게시물등록번호
	
	@Column(nullable = false, columnDefinition = "date default sysdate")
	private Date report_date;// 신고일
	
	private int  report_lg;	 // 신고상세사유(대분류)
	private int  report_md;	 // 신고상세사유(중분류)
	private int  ctg_lg;	 // 신고 카테고리(대분류)
	private int  ctg_md;	 // 신고 카테고리(중분류)
	private int  cnt;		 // 신고 횟수
	private Date mod_date;	 // 처리일
	private int  state_lg;	 // 신고처리상태(대분류)
	private int  state_md;	 // 신고처리상태(중분류)
	

}
