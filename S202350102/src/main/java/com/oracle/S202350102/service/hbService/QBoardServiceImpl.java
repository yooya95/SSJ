package com.oracle.S202350102.service.hbService;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.hbDao.QBoardDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QBoardServiceImpl implements QBoardService {
	private final QBoardDao qbd;

	@Override
	public List<Board> qBoardList(Board board) {
		List<Board> qBoardList = qbd.qBoardList(board);
		
		int brd_md = 0;
		for (int i = 0; i < qBoardList.size(); i++) {
			brd_md = qBoardList.get(i).getBrd_md();
			switch (brd_md) {
			case 100: qBoardList.get(i).setCategory("회원관련"); break;
			case 101: qBoardList.get(i).setCategory("버그"); break;
			case 102: qBoardList.get(i).setCategory("챌린지"); break;
			case 103: qBoardList.get(i).setCategory("쉐어링"); break;
			case 104: qBoardList.get(i).setCategory("팔로워"); break;
			case 105: qBoardList.get(i).setCategory("기타건의"); break;
			}
		}
		
		return qBoardList;
	}

	@Override
	public Board qBoardSelect(int brd_num) {
		Board board = qbd.qBoardSelect(brd_num);
		
		int brd_md = board.getBrd_md();
		switch (brd_md) {
		case 100: board.setCategory("회원관련"); break;
		case 101: board.setCategory("버그"); break;
		case 102: board.setCategory("챌린지"); break;
		case 103: board.setCategory("쉐어링"); break;
		case 104: board.setCategory("팔로워"); break;
		case 105: board.setCategory("기타건의"); break;
		}
		
		return board;
	}

	@Override
	public int qBoardInsert(Board board) {
		int result = qbd.qBoardInsert(board);
		return result;
	}

	@Override
	public int qBoardDelete(int brd_num) {
		int result = qbd.qBoardDelete(brd_num);
		return result;
	}

	@Override
	public void readCnt(int brd_num) {
		qbd.readCnt(brd_num);
	}

	@Override
	public int qBoardUpdate(Board board) {
		int result = qbd.qBoardUpdate(board);
		return result;
	}

	@Override
	public int totalQBoard(User1 user1) {
		int total = qbd.totalQBoard(user1);
		return total;
	}

	@Override
	public List<Board> qboardListSearch(Board board) {
		List<Board> qboardListSearch = qbd.qboardListSearch(board);
		
		int brd_md = 0;
		for (int i = 0; i < qboardListSearch.size(); i++) {
			brd_md = qboardListSearch.get(i).getBrd_md();
			switch (brd_md) {
			case 100: qboardListSearch.get(i).setCategory("회원관련"); break;
			case 101: qboardListSearch.get(i).setCategory("버그"); break;
			case 102: qboardListSearch.get(i).setCategory("챌린지"); break;
			case 103: qboardListSearch.get(i).setCategory("쉐어링"); break;
			case 104: qboardListSearch.get(i).setCategory("팔로워"); break;
			case 105: qboardListSearch.get(i).setCategory("기타건의"); break;
			}
		}
		
		return qboardListSearch;
	}

	@Override
	public List<Board> qBoardCommentList(int brd_group){
		return qbd.qBoardCommentList(brd_group);
	}
	
	@Override
	public int qBoardCommentWrite(Board board) {
		int result = 0;
		result = qbd.qBoardCommentWrite(board);
		return result;
	}

	@Override
	public int qBoardCommentUpdate(Board board) {
		return qbd.qBoardCommentUpdate(board);
	}

	@Override
	public int qBoardCommentDelete(int brd_num) {
		return qbd.qBoardCommentDelete(brd_num);
	}
	
	@Override
	public int qBoardSearchListCount(Board board) {
		return qbd.qBoardSearchListCount(board);
	}
}
