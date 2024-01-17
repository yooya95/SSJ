package com.oracle.S202350102.service.jkService;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

public interface JkBoardService {
	// 쉐어링 게시글 전체
	List<Board>     sharing(Board board);
	User1 			userSelect(int user_num);
	Board 			likeService(int brd_num);
	void 			updateLikeStatus(int brd_num);
	int 			writeFormSharing(Board board);
	Board 			detailSharing(int brd_num);
	int 			updateSharing(Board board);
	int 			deleteSharing(int brd_num);
	String 			uploadImage(MultipartFile file);
	List<Board> 	loadSortedPosts(String sortOption);
	
	//댓글기능
	void			commentSharing(Board board);
	List<Board> 	listCommentSharing(int brd_num);
	void 			commentUpdateSharing(Board board);
	void			commentDeleteSharing(Board board);
	int 			commentCountSharing(int brd_num);
	
	// 주변 쉐어링
	List<Board> 	sharingResult(Board board);
	List<Board> 	sharing2(Board board);
	int myBoard		(int user_num);
	
	

	
	


}
