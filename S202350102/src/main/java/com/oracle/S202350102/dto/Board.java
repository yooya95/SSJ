package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private int 	brd_num; 		// 게시물등록번호
	private int 	chg_id; 		// 첼린지등록번호 
	private int 	user_num;		// 회원번호
	private int 	brd_lg;			// 분류번호(대분류)
	private int 	brd_md;			// 분류번호(중분류)
	private String 	title;			// 게시글 제목
	private String 	conts;			// 게시글내용
	private String 	img;			// 게시글 첨부파일
	private int 	view_cnt;		// 게시글 조회 수
	private Date 	reg_date;		// 게시글 작성일자
	private int		price;			// 쉐어링 금액
	private String 	bank_info;		// 쉐어링 은행,계좌번호
	private String 	bank_duedate;	// 쉐어링 입금기한
	private String 	addr;			// 쉐어링 주소
	private int 	applicants;		// 쉐어링 모집인원
	private int 	participants;	// 쉐어링 참여인원
	private String 	user_tel;		// 쉐어링 연락처정보
	private String 	memo;			// 쉐어링 전달할메모
	private int 	brd_group;		// 게시글그룹
	private int 	brd_step;		// 댓글순서
	private int 	loc_brd_num;	// 지도목록코드번호
	private int 	loc_num;		// 지역코드번호
	private String	zipCode;		// 우편번호
	
	// 페이징 조회용    //검색타입						 //검색 내용
	private String search;   	private String keyword;
	private String pageNum;
	private int start; 		 	private int end;
	private int idx;
	private String searchType;
	private String category;
	private String sortBy;	// 정렬 조회
	
	
	//파일 업로드 -> 파일 삭제 여부 확인용
	private int delStatus;
	// 게시판 유저 정보 조회용
	private String icon;
	private int user_level;
	private int user_exp;
	private int percentage;
	private int status_md;
	
	//join
	private String nick;			// 유저 닉네임
	private String user_name;
	private String user_id;
	private String user_img;		// 유저 프로필사진
	private String chg_title;		// 내가쓴 인증/후기에서 챌린지 제목 가져오기 
	
	//후기 게시판 조회용 
//	private int rn; //글번호 rownum 삭제 예정
	private int replyCount; //댓글수
	
	//Challenge_Review_Insert_Proc 리턴 값 저장
	private int resultCount;
	
	
	private int likeyn;		// 좋아요 유무 판단용
	private int b_user_num;	// 로그인한 나의 user_num
	private int like_cnt;	// 좋아요 갯수
	
	
	private int followyn;	// 팔로우 유무 판단용
	private int chgryn;		// 챌린지 참여 여부 판단용
	// 태워요 
	private int report_cnt;	
	private int myBurning;	
	
}