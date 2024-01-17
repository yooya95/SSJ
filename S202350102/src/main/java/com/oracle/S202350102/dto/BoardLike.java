package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class BoardLike {
	private int brd_num;  // 게시물등록번호
//	private int like_num; // 좋아요번호 / 사용 안함
	private int user_num; // 회원번호
}
