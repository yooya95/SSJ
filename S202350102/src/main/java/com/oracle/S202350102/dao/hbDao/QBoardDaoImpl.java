package com.oracle.S202350102.dao.hbDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class QBoardDaoImpl implements QBoardDao {
	private final SqlSession session;
	
	
	@Override
	public List<Board> qBoardList(Board board) {
		List<Board> qBoardList = null;
		try {
			qBoardList = session.selectList("qBoardList",board);
			System.out.println("qbd dao qBoardList.size->"+qBoardList.size());
		} catch (Exception e) {
			System.out.println("qbd dao exception->"+e.getMessage());
		}
		return qBoardList;
	}


	@Override
	public Board qBoardSelect(int brd_num) {
		Board board = null;
		try {
			board = session.selectOne("qBoardSelect",brd_num);
		} catch (Exception e) {
			System.out.println("qbd dao sel exception->"+e.getMessage());
		}
		return board;
	}


	@Override
	public int qBoardInsert(Board board) {
		int result = 0;
		try {
			System.out.println("board->"+board);
			result = session.insert("qBoardInsert",board);
		} catch (Exception e) {
			System.out.println("qbd dao ins exception->"+e.getMessage());
		}
		return result;
	}


	@Override
	public int qBoardDelete(int brd_num) {
		int result = 0;
		try {
			result = session.delete("qBoardDelete",brd_num);
		} catch (Exception e) {
			System.out.println("qbd dao del exception->"+e.getMessage());
		}
		return result;
	}


	@Override
	public void readCnt(int brd_num) {
		try {
			session.update("qReadCount",brd_num);
		} catch (Exception e) {
			System.out.println("qbd dao readcnt exception->"+e.getMessage());
		}
	}


	@Override
	public int qBoardUpdate(Board board) {
		int result = 0;
		try {
			System.out.println("dao qboardupdate board->"+board);
			result = session.update("qBoardUpdate",board);
			System.out.println("dao qboardUpdate result->"+result);
		} catch (Exception e) {
			System.out.println("qbd dao qBoardUpdate exception->"+e.getMessage());
		}
		
		return result;
	}


	@Override
	public int totalQBoard(User1 user1) {
		int total = 0;
		try {
			total = session.selectOne("totalQBoard", user1);
		} catch (Exception e) {
			System.out.println("totalQBoard dao sql exception->"+e.getMessage());
		}
		return total;
	}


	@Override
	public List<Board> qboardListSearch(Board board) {
		System.out.println("qboardListSearch dao start..");
		List<Board> qboardListSearch = null;
		try {
			System.out.println("board->"+board);
			qboardListSearch = session.selectList("qboardListSearch",board);
			System.out.println("qboardListSearch size->"+qboardListSearch.size());
		} catch (Exception e) {
			System.out.println("qboardListSearch dao sql exception->"+e.getMessage());
		}
		return qboardListSearch;
	}
	
	@Override
	public List<Board> qBoardCommentList(int brd_group){
		List<Board> qBoardCommentList = null;
		try {
			qBoardCommentList = session.selectList("qBoardCommentList",brd_group);
		} catch (Exception e) {
			System.out.println("qBoardCommentList dao sql exception->"+e.getMessage());
		}
		return qBoardCommentList;
	}
	
	@Override
	public int qBoardCommentWrite(Board board) {
		int result = 0;
		try {
			result = session.insert("qBoardCommentWrite",board);
		} catch (Exception e) {
			System.out.println("qBoardCommentWrite dao sql exception->"+e.getMessage());
		}
		return result;
	}


	@Override
	public int qBoardCommentUpdate(Board board) {
		int result = 0;
		try {
			result = session.update("qBoardCommentUpdate",board);
		} catch (Exception e) {
			System.out.println("qBoardCommentUpdate dao sql exception->"+e.getMessage());
		}
		return result;
	}


	@Override
	public int qBoardCommentDelete(int brd_num) {
		int result = 0;
		try {
			result = session.delete("qBoardCommentDelete",brd_num);
		} catch (Exception e) {
			System.out.println("qBoardCommentDelete dao sql exception->"+e.getMessage());
		}
		return result;
	}
	
	@Override
	public int qBoardSearchListCount(Board board) {
		int total = 0;
		try {
			total = session.selectOne("qBoardSearchListCount", board);
		} catch (Exception e) {
			System.out.println("qBoardSearchListCount dao sql exception->"+e.getMessage());
		}
		return total;
	}

}
