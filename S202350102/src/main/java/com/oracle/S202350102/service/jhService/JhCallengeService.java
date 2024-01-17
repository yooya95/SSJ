package com.oracle.S202350102.service.jhService;

import java.util.List;
import java.util.Map;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Comm;

public interface JhCallengeService {

	Challenge 			chgDetail(int chg_id);


	//chgReviewList랑 reviewReplyList를 합칠 수 없는가 생각해보기
//	List<Board> 		chgReviewList(Board board); //보드 서비스

	
//	List<Board>			reviewReplyList(Board board); //보드로
	

	String 				userStatus(int userNum);


//	Board 				reviewContent(int brd_num); //보드서비스로 옮김


//	int 				reviewTotal(int chg_id); //보드 서비스


	int 				ingChgListTotal();


//	List<Challenge> 	ingChgRecentList(Challenge challenge);


//	List<Challenge> 	ingChgPickList(Challenge challenge);


//	void 				replyInsert(Board board); 보드로


//	int 				replyDelete(int brd_num); //보드로


//	void 				viewCntUp(int brd_num);//보드로


//	int 				replyUpdate(Board board); //보드로


//	int 				reviewPost(Board board); //보드로


//	int 				reviewUpdate(Board board); //보드


//	int 				reviewDelete(int brd_num); //보드


	int 				boardImgDelete(int brd_num);


	List<Challenge> 	recomChgList(int chg_md);


	List<Comm> 			category(int categoryLd);


	int 				chgApplication(Challenge chg);


//	List<Challenge> 	chgAdminList(Challenge challenge);


	List<Challenge> 	chgAplList(Challenge challenge);


	int 				chgListTotal(Challenge challenge);


	int 				approvReturn(Map<String, Object> apvRtnParaMap);


	int 				chgAdminUpdate(Challenge chg);


	int 				chgDelete(int chg_id);

	//승인 반려 후 챌린지 진행 상태 가져 오기 위함
	int 				chgStateMd(int chg_id); 
  
    
	
        
       
 

}
