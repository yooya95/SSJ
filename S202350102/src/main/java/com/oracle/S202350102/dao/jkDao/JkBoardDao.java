package com.oracle.S202350102.dao.jkDao;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

public interface JkBoardDao {
	List<Board> 		sharing(Board board);
	User1 				userSelect(int user_num);
	Board 				getboardBybrd_num(int brd_num);
	boolean 			getLikeStatus(int brd_num);
	void 				updateLikeStatus(int brd_num);
	int 				writeFormSharing(Board board);
	Board 				detailSharing(int brd_num);
	int 				updateSharing(Board board);
	int					deleteSharing(int brd_num);
	List<Board> 		getPopularPosts();
	List<Board> 		getRecentPosts();
	
	// 댓글관련
	void 				commentSharing(Board board);
	List<Board> 		listCommentSharing(int brd_num);
	void 				commentUpdateSharing(Board board);
	void 				commentDeleteSharing(Board board);
	int					commentCountSharing(int brd_num);
	
	// 내주변 쉐어링
	List<Board>			sharingResult(Board board);
	List<Board> 		sharing2(Board board);
	int myBoard(int user_num);
	
	
	

	
}
