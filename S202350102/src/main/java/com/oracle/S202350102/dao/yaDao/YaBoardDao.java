package com.oracle.S202350102.dao.yaDao;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.SharingList;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.hbService.Paging;

public interface YaBoardDao {
	//커뮤니티게시판 관련
	List<Board> listCommunity(Board board);
	Board        detailCommunity(int brd_num);
	void         upViewCnt(int brd_num);	
	int          insertCommunity(Board board);
	int          updateCommunity(Board board);
	int          deleteCommunity(int brd_num);

	// 검색관련
	List<Board>  boardSearchList(String keyword, String currentPage);
	List<Board>  sortByViewCnt(int start, int end);
	List<Board>  sortByRegDate(int start, int end);
	User1        userSelect(int user_num);
	List<Board>  listComment(int brd_num);

	// 댓글관련
	void         commentWrite(Board board);
	void		 commentUpdate(Board board);
	void         commentDelete(Board board);
	int          getLatestBrdStep(int brd_group);
	int 	 	 commentCount(int brd_num);
	int 		 totalCommunity(Board board);

	
	// 쉐어링 참가신청관련
	int         	  saveSharing(SharingList sharingList);
	List<Board>       myUploadSharingList(Board board);
	List<SharingList> sharingParticipantsList(int brd_num);
	int         	  sharingConfirm(SharingList sharingList);
	void              upParticipantsCnt(int brd_num);
	List<SharingList> myJoinSharingList(SharingList sharingList);
	List<Board>       myConfirmSharingList(Board board);
	int               sharingReject(SharingList sharingList);
	void              downParticipantsCnt(int brd_num);
	
	//mySharing 페이징
	int               totalMyUploadsharing(int user_num);
	int               totalJoinSharing(int user_num);
	int               totalConfirmSharing(int user_num);
	int                totalSharing(Board board);
	
	//자유게시판검색수
	int				 countSearch(String keyword);
	
	//sharing 내가 찜한 게시글	
	int 			likeSharingCnt(int user_num);
	List<Board> 	likeSharingList(Board board);
	//sharing 검색
	int 			searchSharingCnt(String keyword);
	List<Board> 	sharingSearchResult(String keyword, String currentPage, String sortOption, Board board);
	
	
	List<SharingList>  			sharingChk(int brd_num);
	int deleteJoinSharing(int user_num);
	List<Board> myConfirmSharingList(int start, int end);

	
	
	
	
	

	
	

	
	
}
