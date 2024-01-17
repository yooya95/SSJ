package com.oracle.S202350102.dao.jkDao;


import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class JkBoardDaoImpl implements JkBoardDao {
	
	private final SqlSession session;

	@Override
	public List<Board> sharing(Board board) {
		// board 테이블 쉐어링게시판조회
		List<Board> sharing = null;
		System.out.println("JkBoardDaoImpl Sharing start...");
		try {
			sharing = session.selectList("sharing", board);
			System.out.println("JkBoardDaoImpl Sharing.size()-->"+sharing.size());
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl Sharing e.getMessage()?"+e.getMessage());
		}
		
		return sharing;
	}

	@Override
	public User1 userSelect(int user_num) {
		 return session.selectOne("userSelect", user_num);
	}

		
	@Override
	public Board getboardBybrd_num(int brd_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean getLikeStatus(int brd_num) {
	    try {
	        return session.selectOne("getLikeStatus", brd_num);
	    } catch (Exception e) {
	        System.out.println("Error while getting like status: " + e.getMessage());
	        return false;
	    }
	}

	@Override
	 public void updateLikeStatus(int brd_num) {
        System.out.println("MyBatisBoardRepository updateLikeStatus start..." + brd_num);
        session.update("updateLikeStatus", brd_num);
	}

	@Override
	public int writeFormSharing(Board board) {
	    System.out.println("JkBoardDaoImpl writeFormSharing start...");
	   
	    int insertResult=0;
	    try {
	        insertResult = session.insert("writeFormSharing", board);
	    } catch (Exception e) {
	    	System.out.println("jkBoarDaoImpl void upViewCnt e.getMessage?"+e.getMessage());
		}
	        return insertResult;
	    }

	@Override
	public Board detailSharing(int brd_num) {
		System.out.println("JkBoardDaoImpl detailSharing start...");
		Board board = new Board();
		try {
			board = session.selectOne("detailSharing", brd_num);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl dtailSHaring e.getMessage)?"+e.getMessage());
		}
		return board;
	}

	@Override
	public int updateSharing(Board board) {
		System.out.println("JkBoardDaoImpl updateSharing start...");
		int updateResult = 0;
		try {
			updateResult = session.update("updateSharing", board);
			System.out.println("updateresult"+updateResult);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl updateSharing e.getMessage"+e.getMessage());
			e.printStackTrace();
		}
		return updateResult;
	}

	@Override
	public int deleteSharing(int brd_num) {
		System.out.println("JkBoardDaoImpl deleteSharing start...");
		int deleteResult = 0;
		try {
			deleteResult = session.update("deleteSharing", brd_num);
			System.out.println("deleteresult"+deleteResult);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl deleteSharing e.getMessage"+e.getMessage());
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Board> getPopularPosts() {
		List<Board> getPopularPosts = null;
        try {
            return session.selectList("getPopularPosts");
        } catch (Exception e) {
        	System.out.println("jkBoardDaoImpl getPopularPosts() e.getMessage?"+e.getMessage());
            return getPopularPosts;
        }
	}

	@Override
	public List<Board> getRecentPosts() {
		List<Board> getRecentPosts =null;
		try {
	          return session.selectList("getRecentPosts");
	        } catch (Exception e) {
	          	System.out.println("jkBoardDaoImpl getRecentPosts() e.getMessage?"+e.getMessage());
	            return getRecentPosts;
	        }
	}

	@Override
	public void commentSharing(Board board) {
		System.out.println("JkBoardDaoImpl commentSharing start...");
	 	
		try {
			session.insert("commentSharing", board);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl void commentSharing e.getMessage)?"+e.getMessage());
		}
	}

	@Override
	public List<Board> listCommentSharing(int brd_num) {
		List<Board> listCommentSharing = null;
		try {
			System.out.println("JkBoardDaoImpl listCommentSharing start....");
			listCommentSharing = session.selectList("listCommentSharing",brd_num);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl listComment e.getMessage?"+e.getMessage());
		}
		return listCommentSharing;
	}

	@Override
	public void commentUpdateSharing(Board board) {
		System.out.println("JkBoardDaoImpl commentUpdateSharing start...");
		try {
			session.update("commentUpdateSharing", board);
		} catch (Exception e) {
			System.out.println("JkBoarDaoImpl void commentUpdateSharing e.getMessage)?"+e.getMessage());
		}
		
	}

	@Override
	public void commentDeleteSharing(Board board) {
		System.out.println("JkBoardDaoImpl commentDeleteSharing start...");
		try {
			session.delete("commentDeleteSharing",board);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl void commentDeleteSharing e.getMessage)?"+e.getMessage());
		}
			
	}

	@Override
	public int commentCountSharing(int brd_num) {
		System.out.println("JkBoardDaoImpl commentCountSharing start...");
		int commentCountSharing = 0;
		try {
			commentCountSharing = session.selectOne("commentCountSharing",brd_num);
		} catch (Exception e) {
			System.out.println("JkaBoarDaoImpl commentCountSharing e.getMessage)?"+e.getMessage());
		
		}
		return commentCountSharing;
	}

	@Override
	public List<Board> sharingResult(Board board) {
		List<Board> sharingResult = null;
		System.out.println("JkBoardDaoImpl sharingResult start...");
		try {
			sharingResult = session.selectList("sharingResult", board);
			System.out.println("JkBoardDaoImpl sharingResult.size()-->"+sharingResult.size());
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl sharingResult e.getMessage()?"+e.getMessage());
		}
		
		return sharingResult;
	
	}

	@Override
	public List<Board> sharing2(Board board) {
		// board 테이블 쉐어링게시판조회
		List<Board> sharing2 = null;
		System.out.println("JkBoardDaoImpl Sharing start...");
		try {
			sharing2 = session.selectList("sharing2", board);
			System.out.println("JkBoardDaoImpl Sharing.size()-->"+sharing2.size());
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl Sharing e.getMessage()?"+e.getMessage());
		}
		
		return sharing2;
	}

	@Override
	public int myBoard(int user_num) {
		int myBoard = 0;
		try {
			myBoard = session.selectOne("myBoard", user_num);
			System.out.println("myboardCnt-->" + myBoard);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("JkBoardDaoImpl myBoard e.getMessage->" + e.getMessage());
		}
		return myBoard;
	}
}
