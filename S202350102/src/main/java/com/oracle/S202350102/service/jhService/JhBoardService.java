package com.oracle.S202350102.service.jhService;

import java.util.List;

import com.oracle.S202350102.dto.Board;

public interface JhBoardService {
	//후기 내용
	Board 				reviewContent(int brd_num);
	
	//리뷰 총개수
	int 				reviewTotal(int chg_id);
	
	//후기 리스트
	List<Board> 		chgReviewList(Board board);
	
	//조회수 업
	void 				viewCntUp(int brd_num);
	
	//댓글 리스트	
	List<Board>			reviewReplyList(Board board);
	
	//댓글 입력
	void 				replyInsert(Board board);
	
	//댓글 수정
	int 				replyUpdate(Board board);
	
	//댓글 삭제
	int 				replyDelete(int brd_num);
	
	//후기 작성
	int 				reviewPost(Board board);
	
	//후기 수정
	int 				reviewUpdate(Board board);
	
	//후기 삭제
	int 				reviewDelete(int brd_num);
	
	
	
}
