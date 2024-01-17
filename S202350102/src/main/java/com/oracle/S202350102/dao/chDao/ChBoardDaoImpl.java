package com.oracle.S202350102.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.BoardReChk;
import com.oracle.S202350102.service.hbService.Paging;

import lombok.Data;

@Repository
@Data
public class ChBoardDaoImpl implements ChBoardDao {
	
	private final SqlSession session;
	
	
	@Override
	public int noticeCount(int brd_md) {
		int noticeCount = 0;
		
		try {
			noticeCount = session.selectOne("noticeCount", brd_md);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeCount e.getMessage->" + e.getMessage());
		}
		return noticeCount;
	}
	
	
	
	@Override
	public List<Board> noticeList(Board board) {
		System.out.println("chBoardDaoImpl noticeList Start...");
		List<Board> noticeList =null;
		try {
			noticeList = session.selectList("noticeList",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeList e.getMessage->" + e.getMessage());
		}
		
		System.out.println("chBoardDaoImpl noticeList.size()->"+noticeList.size());
		return noticeList;
	}

	@Override
	public int noticeWrite(Board board) {
		System.out.println("chBoardDaoImpl noticeWrite Start...");
		int result = 0;
		
		try {
			result = session.insert("noticeWrite", board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeWrite e.getMessage->" + e.getMessage());
		}
		
		
		return result;
	}

	@Override
	public Board noticeConts(int brd_num) {
		System.out.println("chBoardDaoImpl noticeConts Start...");
		Board noticeCont = null;
		
		try {
			noticeCont = session.selectOne("noticeCont",brd_num);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeConts e.getMessage->" + e.getMessage());
		}
		
		return noticeCont;
	}

	@Override
	public int noticeUpdate(Board board) {
		System.out.println("chBoardDaoImpl noticeUpdate Start...");
		System.out.println("board->"+board );
		int result = 0;
		
		try {
			result= session.update("noticeUpdate", board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeUpdate e.getMessage->" + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int deleteNotice(int brd_num) {
		System.out.println("chBoardDaoImpl deleteNotice Start...");
		
		int result = 0;
		
		try {
			result = session.delete("deleteNotice", brd_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl deleteNotice e.getMessage->" + e.getMessage());
			result = 0;
		}
		return result;
	}

	@Override
	public void noticeViewUp(int brd_num) {
		System.out.println("chBoardDaoImpl noticeViewUp Start...");

		try {
			session.update("noticeViewUp", brd_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl noticeViewUp e.getMessage->" + e.getMessage());
		}
		
	}

	@Override
	public List<Board> popBoardList() {
		System.out.println("chBoardDaoImpl popBoardList Start...");
		List<Board> popBoardList = null;
		
		try {
			popBoardList = session.selectList("popBoardList");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl popBoardList e.getMessage->" + e.getMessage());
		}
		
		System.out.println("chBoardDaoImpl popBoardList Start...");
		return popBoardList;
	}



	@Override
	public List<Board> popShareList(int user_num) {
		System.out.println("chBoardDaoImpl popShareList Start...");
		List<Board> popShareList = null;
		
		try {
			popShareList = session.selectList("popShareList",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl popBoardList e.getMessage->" + e.getMessage());
		}
		
		System.out.println("chBoardDaoImpl popShareList->" + popShareList.size());
		
		return popShareList;
	}



	@Override
	public List<BoardReChk> alarmchk(int user_num) {
		
		List<BoardReChk> result = null;
		
		try {
			result = session.selectList("alarmchk",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl alarmchk e.getMessage->" + e.getMessage());
		}
		
		return result;
	}



	@Override
	public List<Board> myReview(int user_num) {
		List<Board> myReviewList = null;
		
		try {
			myReviewList = session.selectList("myReviewList",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl myReviewList e.getMessage->" + e.getMessage());
		}
		
		return myReviewList;
	}



	@Override
	public List<Board> myCertiList(int user_num) {
		List<Board> myCertiList = null;
		
		try {
			myCertiList = session.selectList("myCertiList",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl myCertiList e.getMessage->" + e.getMessage());
		}
		return myCertiList;
	}



	@Override
	public List<Board> myCommuList(Board board) {
		List<Board> myCommuList = null;
		
		try {
			myCommuList = session.selectList("myCommuList",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl myCommuList e.getMessage->" + e.getMessage());
		}
		return myCommuList;
	}



	@Override
	public List<Board> myShareList(int user_num) {
		List<Board> myShareList = null;
		
		try {
			myShareList = session.selectList("myShareList",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl myShareList e.getMessage->" + e.getMessage());
		}
		return myShareList;
	}



	@Override
	public int readAlarm(BoardReChk brc) {
		System.out.println("chBoardDaoImpl readAlarm Start...");
		int result = 0;
		try {
			result = session.update("readAlarm", brc);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl readAlarm e.getMessage->" + e.getMessage());
		}
		return result;
	}



	@Override
	public int moveToNewCmt(BoardReChk brc) {
		System.out.println("chBoardDaoImpl moveToNewCmt Start...");
		int result = 0;
		try {
			result = session.update("moveToNewCmt", brc);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl moveToNewCmt e.getMessage->" + e.getMessage());
		}
		return result;
	}



	@Override
	public List<Paging> myCount(int user_num) {
		System.out.println("chBoardDaoImpl myCount Start...");
		List<Paging> result =null;
		try {
			result = session.selectList("myCount", user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl myCount e.getMessage->" + e.getMessage());
		}
		return result;
	}



	@Override
	public List<Board> mychgBoardList(Board board) {
		System.out.println("chBoardDaoImpl mychgBoardList Start...");
		List<Board> result =null;
		try {
			result = session.selectList("mychgBoardList", board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl mychgBoardList e.getMessage->" + e.getMessage());
		}
		return result;
	}



	@Override
	public int pageMove(Board board) {
		System.out.println("chBoardDaoImpl mychgBoardList Start...");
		int result =0;		
		try {
			result = session.selectOne("userTot", board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl mychgBoardList e.getMessage->" + e.getMessage());
		}
		return result;
	}



	@Override
	public int readAllcmt(int user_num) {
		System.out.println("chBoardDaoImpl mychgBoardList Start...");
		int result =0;		
		try {
			result = session.update("readAllcmt", user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl mychgBoardList e.getMessage->" + e.getMessage());
			result = 0;
		}
		return result;
	}



	@Override
	public int commentAlarm(int brd_num) {
		System.out.println("chBoardDaoImpl commentAlarm Start...");
		int result =0;		
		try {
			result = session.insert("commentAlarm", brd_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("chBoardDaoImpl commentAlarm e.getMessage->" + e.getMessage());
			result = 0;
		}
		return result;
	}

	


}
