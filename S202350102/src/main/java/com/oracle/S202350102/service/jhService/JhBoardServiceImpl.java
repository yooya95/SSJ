package com.oracle.S202350102.service.jhService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.jhDao.JhBoardDao;
import com.oracle.S202350102.dao.jhDao.JhChallengeDao;
import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JhBoardServiceImpl implements JhBoardService {
	
	private final JhBoardDao jhBrdDao;
	
	//후기 내용
	@Override
	public Board reviewContent(int brd_num) {
		System.out.println("JhBoardServiceImpl reviewContent Start...");
		Board reviewContent = jhBrdDao.reviewContent(brd_num);
		
		return reviewContent;
	}
	
	//리뷰 총개수
	@Override
	public int reviewTotal(int chg_id) {
		System.out.println("JhBoardServiceImpl reviewTotal Start...");
		int reviewTotal = jhBrdDao.reviewTotal(chg_id);
		
		return reviewTotal;
	}
	
	//후기 리스트
	@Override
	public List<Board> chgReviewList(Board board) {
		System.out.println("JhBoardServiceImpl chgReviewList Start...");
		
		List<Board> chgReviewList = jhBrdDao.chgReviewList(board);
		
		return chgReviewList;
	}
	
	//조회수 업
	@Override
	public void viewCntUp(int brd_num) {
		System.out.println("JhBoardServiceImpl viewCntUp Start...");
		jhBrdDao.viewCntUp(brd_num);
	}


	//댓글 리스트
	@Override
	public List<Board> reviewReplyList(Board board) {
		System.out.println("JhBoardServiceImpl reviewReplyList Start...");
		
		List<Board> reviewReplyList = jhBrdDao.reviewReplyList(board);
		
		return reviewReplyList;
	}
	
	//댓글 입력
	@Override
	public void replyInsert(Board board) {
		System.out.println("JhBoardServiceImpl replyInsert Start...");
		jhBrdDao.replyInsert(board);
		
	}

	//댓글 수정
	@Override
	public int replyUpdate(Board board) {
		System.out.println("JhBoardServiceImpl replyUpdate Start...");
		int result = jhBrdDao.replyUpdate(board);
		return result;
	}

	//댓글 삭제
	@Override
	public int replyDelete(int brd_num) {
		System.out.println("JhBoardServiceImpl replyDelete Start...");
		int result = jhBrdDao.replyDelete(brd_num);
		
		return result;
	}
	
	//후기 작성
	@Override
	public int reviewPost(Board board) {
		System.out.println("JhBoardServiceImpl reviewPost Start...");
		
		int result = jhBrdDao.reviewPost(board);
		
		return result;
	}

	//후기 수정
	@Override
	public int reviewUpdate(Board board) {
		System.out.println("JhBoardServiceImpl reviewUpdate Start...");
		int result = jhBrdDao.reviewUpdate(board);
		return result;
	}
	
	//후기 삭제
	@Override
	public int reviewDelete(int brd_num) {
		System.out.println("JhBoardServiceImpl reviewDelete Start...");
		
		int reviewDel = jhBrdDao.reviewDelete(brd_num);
		return reviewDel;
	}

	
}
