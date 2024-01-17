package com.oracle.S202350102.service.jhService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.jhDao.JhChallengeDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Comm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JhCallengeServiceImpl implements JhCallengeService {
	
	private final JhChallengeDao jhChgDao;
	
	//챌린지 정보 조회
	@Override
	public Challenge chgDetail(int chg_id) {
		System.out.println("JhCallengeServiceImpl chgDetail Start...");

		System.out.println("JhCallengeServiceImpl chgDetail  chg_id -> "+ chg_id);

		Challenge chgDetail = jhChgDao.chgDetail(chg_id);
		
		
		return chgDetail;
	}

	/* 보드로 
	 * @Override public List<Board> chgReviewList(Board board) {
	 * System.out.println("JhCallengeServiceImpl chgReviewList Start...");
	 * 
	 * List<Board> chgReviewList = jhChgDao.chgReviewList(board);
	 * 
	 * return chgReviewList; }
	 */

	@Override
	public String userStatus(int userNum) {
		System.out.println("JhCallengeServiceImpl userStatus Start...");
		
		String userStatus = jhChgDao.userStatus(userNum);
		
		return userStatus;
	}

	/*//보드서비스로 옮김
	 * @Override public Board reviewContent(int brd_num) {
	 * System.out.println("JhCallengeServiceImpl reviewContent Start..."); Board
	 * reviewContent = jhChgDao.reviewContent(brd_num);
	 * 
	 * return reviewContent; }
	 */

	//보드로
//	@Override
//	public List<Board> reviewReplyList(Board board) {
//		System.out.println("JhCallengeServiceImpl reviewReplyList Start...");
//		
//		List<Board> reviewReplyList = jhChgDao.reviewReplyList(board);
//		
//		return reviewReplyList;
//	}

	/*보드 서비스
	 * @Override public int reviewTotal(int chg_id) {
	 * System.out.println("JhCallengeServiceImpl reviewTotal Start..."); int
	 * reviewTotal = jhChgDao.reviewTotal(chg_id);
	 * 
	 * return reviewTotal; }
	 */

	@Override
	public int ingChgListTotal() {
		System.out.println("JhCallengeServiceImpl ingChgListTotal Start...");
		int chgListTotal = jhChgDao.ingChgListTotal();
		return chgListTotal;
	}

	/*삭제 예정
	 * @Override public List<Challenge> ingChgRecentList(Challenge challenge) {
	 * System.out.println("JhCallengeServiceImpl ingChgRecentList Start...");
	 * List<Challenge> ingChgRecList = jhChgDao.ingChgRecentList(challenge); return
	 * ingChgRecList; }
	 * 
	 * @Override public List<Challenge> ingChgPickList(Challenge challenge) {
	 * System.out.println("JhCallengeServiceImpl ingChgPickList Start...");
	 * List<Challenge> ingChgPicList = jhChgDao.ingChgPickList(challenge); return
	 * ingChgPicList; }
	 */

//	보드
//	@Override
//	public void replyInsert(Board board) {
//		System.out.println("JhCallengeServiceImpl replyInsert Start...");
//		jhChgDao.replyInsert(board);
//		
//	}

	//보드로
//	@Override
//	public int replyDelete(int brd_num) {
//		System.out.println("JhCallengeServiceImpl replyDelete Start...");
//		int result = jhChgDao.replyDelete(brd_num);
//		
//		return result;
//	}

	//보드로
//	@Override
//	public void viewCntUp(int brd_num) {
//		System.out.println("JhCallengeServiceImpl viewCntUp Start...");
//		jhChgDao.viewCntUp(brd_num);
//	}


//	보드로
//	@Override
//	public int replyUpdate(Board board) {
//		System.out.println("JhCallengeServiceImpl replyUpdate Start...");
//		int result = jhChgDao.replyUpdate(board);
//		return result;
//	}

	//보드로
//	@Override
//	public int reviewPost(Board board) {
//		System.out.println("JhCallengeServiceImpl reviewPost Start...");
//		
//		int result = jhChgDao.reviewPost(board);
//		
//		return result;
//	}

//	@Override
//	public int reviewUpdate(Board board) {
//		System.out.println("JhCallengeServiceImpl reviewUpdate Start...");
//		int result = jhChgDao.reviewUpdate(board);
//		return result;
//	}

	//보드
//	@Override
//	public int reviewDelete(int brd_num) {
//		System.out.println("JhCallengeServiceImpl reviewDelete Start...");
//		
//		int reviewDel = jhChgDao.reviewDelete(brd_num);
//		return reviewDel;
//	}

	@Override
	public int boardImgDelete(int brd_num) {
		System.out.println("JhCallengeServiceImpl boardImgDelete Start...");
		int brdImgDel = jhChgDao.boardImgDelete(brd_num);
		
		return brdImgDel;
		
		
	}

	@Override
	public List<Challenge> recomChgList(int chg_md) {
		System.out.println("JhCallengeServiceImpl recomChgList Start...");
		
		List<Challenge> chgList = jhChgDao.recomChgList(chg_md);
		
		return chgList;
	}

	@Override
	public List<Comm> category(int categoryLd) {
		System.out.println("JhCallengeServiceImpl category Start...");
		List<Comm> category = jhChgDao.category(categoryLd);
		
		
		return category;
	}

	@Override
	public int chgApplication(Challenge chg) {
		System.out.println("JhCallengeServiceImpl chgApplication Start...");
		int result = jhChgDao.chgApplication(chg);
		return result;
	}

	/* 삭제 예정
	 * @Override public List<Challenge> chgAdminList(Challenge challenge) {
	 * System.out.println("JhCallengeServiceImpl chgAdminList Start...");
	 * List<Challenge> chgAdminList = jhChgDao.chgAdminList(challenge);
	 * 
	 * return chgAdminList; }
	 */

	@Override
	public List<Challenge> chgAplList(Challenge challenge) {
		System.out.println("JhCallengeServiceImpl chgAplList Start...");
		List<Challenge> chgAplList = jhChgDao.chgAplList(challenge);
		return chgAplList;
	}

	@Override
	public int chgListTotal(Challenge challenge) {
		System.out.println("JhCallengeServiceImpl chgListTotal Start...");
		int chgListTotal = jhChgDao.chgListTotal(challenge);
		return chgListTotal;
	}

	@Override
	public int approvReturn(Map<String, Object> apvRtnParaMap) {
		System.out.println("JhCallengeServiceImpl approvReturn Start...");
		
		int result = jhChgDao.approvReturn(apvRtnParaMap);
		return result;
	}

	@Override
	public int chgAdminUpdate(Challenge chg) {
		System.out.println("JhCallengeServiceImpl chgAdminUpdate Start...");
		int result = jhChgDao.chgAdminUpdate(chg);
		
		return result;
	}

	@Override
	public int chgDelete(int chg_id) {
		System.out.println("JhCallengeServiceImpl chgDelete Start...");
		int result = jhChgDao.chgDelete(chg_id);
		return result;
	}

	@Override
	public int chgStateMd(int chg_id) {
		System.out.println("JhCallengeServiceImpl chgStateMd Start...");
		int stateMd = jhChgDao.chgStateMd(chg_id);
		return stateMd;
	}
 

	
	

}
