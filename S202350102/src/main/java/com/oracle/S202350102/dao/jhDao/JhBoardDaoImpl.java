package com.oracle.S202350102.dao.jhDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JhBoardDaoImpl implements JhBoardDao {

	private final SqlSession session;
	
	//후기 내용
	@Override
	public Board reviewContent(int brd_num) {
		System.out.println("JhBoardDaoImpl reviewContent Start...");
		Board reviewContent = null;
		
		try {
			reviewContent = session.selectOne("jhReviewContent" ,brd_num);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewContent e.getMessage() -> " + e.getMessage());
		}
		System.out.println("JhBoardDaoImpl chgReviewList  reviewContent -> " + reviewContent);
		
		return reviewContent;
	}
	
	
	//후기 총개수 
	@Override
	public int reviewTotal(int chg_id) {
		System.out.println("JhBoardDaoImpl reviewTotal Start...");
		int reviewTotal = 0;
		
		try {
			reviewTotal = session.selectOne("jhReviewTotal", chg_id);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewTotal e.getMessage() -> " + e.getMessage());
		}
		System.out.println("JhBoardDaoImpl chgReviewList  reviewTotal -> " + reviewTotal);
		
		
		return reviewTotal;
	}
	
	
	
	//후기 리스트
	@Override
	public List<Board> chgReviewList(Board board) {
		System.out.println("JhBoardDaoImpl chgReviewList Start...");
		List<Board> chgReviewList = null;
		
		try {
			
			chgReviewList = session.selectList("jhChgReviewList", board);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl chgReviewList e.getMessage() -> "+ e.getMessage());
		}
		
		System.out.println("JhBoardDaoImpl chgReviewList  chgReviewList.size() -> " + chgReviewList.size());

		return chgReviewList;
	}
	
	//조회수 업
	@Override
	public void viewCntUp(int brd_num) {
		System.out.println("JhBoardDaoImpl viewCntUp Start...");
		
		int result = 0;
		
		try {
			result = session.update("jhViewCntUp", brd_num);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl viewCntUp e.getMessage() -> " + e.getMessage());
		}
		
		System.out.println("JhBoardDaoImpl viewCntUp result -> "+ result);
		
	}
	
	//댓글 리스트
	@Override
	public List<Board> reviewReplyList(Board board) {
		System.out.println("JhBoardDaoImpl reviewReplyList Start...");
		
		List<Board> reviewReplyList = null;
		
		try {
			reviewReplyList = session.selectList("jhReviewReplyList", board);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewReplyList e.getMessage() -> " + e.getMessage());
		}
		
		System.out.println("JhBoardDaoImpl reviewReplyList  reviewReplyList.size() -> " + reviewReplyList.size());
		
		return reviewReplyList;
	}

	//댓글 입력
	@Override
	public void replyInsert(Board board) {
		System.out.println("JhBoardDaoImpl replyInsert Start...");
		session.selectOne("jhReplyInsertPro", board);
		System.out.println("JhBoardDaoImpl replyInsert board.getResultCount() -> "+board.getResultCount());
	}
	
	//댓글 수정
	@Override
	public int replyUpdate(Board board) {
		System.out.println("JhBoardDaoImpl replyUpdate Start...");
		int result = 0;
		try {
			result = session.update("jhReplyUpdate", board);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl replyUpdate e.getMessage() -> " + e.getMessage());
		}
		return result;
	}

	//댓글 삭제
	@Override
	public int replyDelete(int brd_num) {
		System.out.println("JhBoardDaoImpl replyDelete Start...");
		System.out.println("JhBoardDaoImpl replyDelete brd_num -> "+ brd_num);
		
		int result = 0;
		
		try {
			result = session.delete("jhReplyDelete", brd_num);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl replyDelete e.getMessage() -> " + e.getMessage());
		}
		System.out.println("JhBoardDaoImpl replyDelete result -> "+ result);
		
		return result;
	}
	
	//후기 작성
	@Override
	public int reviewPost(Board board) {
		System.out.println("JhBoardDaoImpl reviewPost Start...");
		
		int result = 0;
		
		try {
			result = session.insert("jhReviewPost", board);
			
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewPost e.getMessage() -> " + e.getMessage());
			
		}
		
		return result;
	}
	
	
	//후기 수정
	@Override
	public int reviewUpdate(Board board) {
		System.out.println("JhBoardDaoImpl reviewUpdate Start...");
		int result = 0;
		try {
			result = session.update("jhReviewUpdate", board);
			
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewUpdate e.getMessage() -> " + e.getMessage());
			
		}
		return result;
	}
	
	//후기 삭제
	@Override
	public int reviewDelete(int brd_num) {
		System.out.println("JhBoardDaoImpl reviewDelete Start...");
		
		int reviewDel = 0; 
		try {
			reviewDel = session.delete("jhReviewDelete", brd_num);
		} catch (Exception e) {
			System.out.println("JhBoardDaoImpl reviewDelete e.getMessage() -> " + e.getMessage());
		}
		return reviewDel;
	}
	
	
	
}
