package com.oracle.S202350102.service.yaService;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.SharingList;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.hbService.Paging;

public interface YaCommunityService {
	
	List<Board>  listCommunity(Board board);
	Board        detailCommunity(int brd_num);
	void         upViewCnt(int brd_num);
	int          insertCommunity(Board board);
	int          updateCommunity(Board board);
	int          deleteCommunity(int brd_num);
	
	List<Board>  listSearchBoard(String keyword, String currentPage);
	List<Board>  listBoardSort(String sort, int start, int ebd);
	User1        userSelect(int user_num);
	List<Board>  listComment(int brd_num);
	
	void         commentWrite(Board board);
	void		 commentUpdate(Board board);
	void         commentDelete(Board board);
	int          getLatestBrdStep(int brd_group);

	int			 commentCount(int brd_num);
	int 		 totalCommunity(Board board);

	int                		 saveSharing(SharingList sharingList);
	List<Board>       		 myUploadSharingList(Board board);
	List<SharingList> 		 sharingParticipantsList(int brd_num);
	int            	 		 sharingConfirm(SharingList updatedSharingList);
	void              		 upParticipantsCnt(int brd_num);
	List<SharingList>        myJoinSharingList(SharingList sharingList);
	List<Board>              myConfirmSharingList(Board board);
	int 					 sharingReject(SharingList updatedRejectSharingList);
	void 					 downParticipantsCnt(int brd_num);
	
	//마이페이지 sharing 페이징   count
	int                      totalMyUploadsharing(int user_num);
	int                      totalJoinSharing(int user_num);
	int                      totalConfirmSharing(int user_num);
	int                      totalSharing(Board board);
	
	//검색어 수 구하기 
	int                      countSearch(String keyword);
	
	
	// sharing 내가 찜한 게시글
	int 					likeSharingCnt(int user_num);
	List<Board> 			likeSharingList(Board board);
	
	//sharing 검색
	int searchSharingCnt(String keyword);
	List<Board> sharingSearchResult(String keyword, String currentPage, String sortOption, Board board);
	
	// 쉐어링 참가쪽
	List<SharingList> 		sharingChk(int brd_num);
	int 					deleteJoinSharing(int user_num);

	List<Board> myConfirmSharingList(int start, int end);

	
	
	
	
	


	
	
}
