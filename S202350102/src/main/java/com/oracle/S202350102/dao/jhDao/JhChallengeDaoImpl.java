package com.oracle.S202350102.dao.jhDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Comm;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JhChallengeDaoImpl implements JhChallengeDao {
	
	private final SqlSession session;

	//챌린지 정보 조회
	@Override
	public Challenge chgDetail(int chg_id) {
		System.out.println("JhChallengeDaoImpl chgDetail Start...");
		System.out.println("JhChallengeDaoImpl chgDetail  chg_id -> " + chg_id);
		
		Challenge chgDetail = null;
		try {
			
			chgDetail = session.selectOne("jhChgDetail", chg_id);
			System.out.println("JhChallengeDaoImpl chgDetail  chg -> " + chgDetail);
			
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgDetail e.getMessage() -> " + e.getMessage());
		}
		
		return chgDetail;
	}

	//보드로
//	@Override
//	public List<Board> chgReviewList(Board board) {
//		System.out.println("JhChallengeDaoImpl chgReviewList Start...");
//		List<Board> chgReviewList = null;
//		
//		try {
//			
//			chgReviewList = session.selectList("jhChgReviewList", board);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl chgReviewList e.getMessage() -> "+ e.getMessage());
//		}
//		
//		System.out.println("JhChallengeDaoImpl chgReviewList  chgReviewList.size() -> " + chgReviewList.size());
//
//		return chgReviewList;
//	}

	@Override
	public String userStatus(int userNum) {
		System.out.println("JhChallengeDaoImpl userStatus Start...");
		System.out.println("JhChallengeDaoImpl userNum -> " + userNum);
		
		String userStatus = null;
		
		try {
			userStatus = session.selectOne("jhUserStatus", userNum);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl userStatus e.getMessage() -> " + e.getMessage());
		}
		
		System.out.println("JhChallengeDaoImpl userStatus -> " + userStatus);
		return userStatus;
	}

	/* 보드 다오로 옮김
	 * @Override public Board reviewContent(int brd_num) {
	 * System.out.println("JhChallengeDaoImpl reviewContent Start..."); Board
	 * reviewContent = null;
	 * 
	 * try { reviewContent = session.selectOne("jhReviewContent" ,brd_num); } catch
	 * (Exception e) {
	 * System.out.println("JhChallengeDaoImpl reviewContent e.getMessage() -> " +
	 * e.getMessage()); }
	 * System.out.println("JhChallengeDaoImpl chgReviewList  reviewContent -> " +
	 * reviewContent);
	 * 
	 * return reviewContent; }
	 */

	//보드
//	@Override
//	public List<Board> reviewReplyList(Board board) {
//		System.out.println("JhChallengeDaoImpl reviewReplyList Start...");
//		
//		List<Board> reviewReplyList = null;
//		
//		try {
//			reviewReplyList = session.selectList("jhReviewReplyList", board);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl reviewReplyList e.getMessage() -> " + e.getMessage());
//		}
//		
//		System.out.println("JhChallengeDaoImpl reviewReplyList  reviewReplyList.size() -> " + reviewReplyList.size());
//		
//		return reviewReplyList;
//	}

	/*보드 다오
	 * @Override public int reviewTotal(int chg_id) {
	 * System.out.println("JhChallengeDaoImpl reviewTotal Start..."); int
	 * reviewTotal = 0;
	 * 
	 * try { reviewTotal = session.selectOne("jhReviewTotal", chg_id); } catch
	 * (Exception e) {
	 * System.out.println("JhChallengeDaoImpl reviewTotal e.getMessage() -> " +
	 * e.getMessage()); }
	 * System.out.println("JhChallengeDaoImpl chgReviewList  reviewTotal -> " +
	 * reviewTotal);
	 * 
	 * 
	 * return reviewTotal; }
	 */


	
	//미완성 //////////////////////////////////////////////
	@Override
	public int ingChgListTotal() {
		System.out.println("JhChallengeDaoImpl chgListTotal Start...");
		int ingChgListTotal = 0;
		
		try {
			ingChgListTotal = session.selectOne("jhIngChgListTotal");
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl ingChgListTotal e.getMessage() -> " + e.getMessage());
		}
		
		System.out.println("JhChallengeDaoImpl ingChgListTotal chgListTotal -> " + ingChgListTotal);
		return ingChgListTotal;
	}

	/*
	 * @Override public List<Challenge> ingChgRecentList(Challenge challenge) {
	 * System.out.println("JhChallengeDaoImpl ingChgRecentList Start...");
	 * List<Challenge> ingChgRecList = null;
	 * 
	 * try { ingChgRecList = session.selectList("jhIngChgRecentList", challenge);
	 * 
	 * } catch (Exception e) {
	 * System.out.println("JhChallengeDaoImpl ingChgRecentList e.getMessage() -> " +
	 * e.getMessage()); } System.out.
	 * println("JhChallengeDaoImpl ingChgRecentList  ingChgRecList.size() -> " +
	 * ingChgRecList.size());
	 * 
	 * 
	 * return ingChgRecList; }
	 * 
	 * 
	 * @Override public List<Challenge> ingChgPickList(Challenge challenge) {
	 * System.out.println("JhChallengeDaoImpl ingChgPickList Start...");
	 * List<Challenge> ingChgPicList = null;
	 * 
	 * try { ingChgPicList = session.selectList("jhIngChgPickList", challenge);
	 * 
	 * } catch (Exception e) {
	 * System.out.println("JhChallengeDaoImpl ingChgPickList e.getMessage() -> " +
	 * e.getMessage()); } System.out.
	 * println("JhChallengeDaoImpl ingChgPickList  ingChgPicList.size() -> " +
	 * ingChgPicList.size());
	 * 
	 * return ingChgPicList; }
	 */

	//미완성 //////////////////////////////////////////////
	
	//보드로 위에 뭐가 미완성이지?
//	@Override
//	public void replyInsert(Board board) {
//		System.out.println("JhChallengeDaoImpl replyInsert Start...");
//		session.selectOne("jhReplyInsertPro", board);
//		System.out.println("JhChallengeDaoImpl replyInsert board.getResultCount() -> "+board.getResultCount());
//
//		
//	}

	//보드
//	@Override
//	public int replyDelete(int brd_num) {
//		System.out.println("JhChallengeDaoImpl replyDelete Start...");
//		System.out.println("JhChallengeDaoImpl replyDelete brd_num -> "+ brd_num);
//		
//		int result = 0;
//		
//		try {
//			result = session.delete("jhReplyDelete", brd_num);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl replyDelete e.getMessage() -> " + e.getMessage());
//		}
//		System.out.println("JhChallengeDaoImpl replyDelete result -> "+ result);
//		
//		return result;
//	}

	//보드로
//	@Override
//	public void viewCntUp(int brd_num) {
//		System.out.println("JhChallengeDaoImpl viewCntUp Start...");
//		
//		int result = 0;
//		
//		try {
//			result = session.update("jhViewCntUp", brd_num);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl viewCntUp e.getMessage() -> " + e.getMessage());
//		}
//		
//		System.out.println("JhChallengeDaoImpl viewCntUp result -> "+ result);
//		
//	}


	//보드로
//	@Override
//	public int replyUpdate(Board board) {
//		System.out.println("JhChallengeDaoImpl replyUpdate Start...");
//		int result = 0;
//		try {
//			result = session.update("jhReplyUpdate", board);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl replyUpdate e.getMessage() -> " + e.getMessage());
//		}
//		return result;
//	}

	
	//보드
//	@Override
//	public int reviewPost(Board board) {
//		System.out.println("JhChallengeDaoImpl reviewPost Start...");
//		
//		int result = 0;
//		
//		try {
//			result = session.insert("jhReviewPost", board);
//			
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl reviewPost e.getMessage() -> " + e.getMessage());
//			
//		}
//		
//		return result;
//	}

	//보드
//	@Override
//	public int reviewUpdate(Board board) {
//		System.out.println("JhChallengeDaoImpl reviewUpdate Start...");
//		int result = 0;
//		try {
//			result = session.update("jhReviewUpdate", board);
//			
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl reviewUpdate e.getMessage() -> " + e.getMessage());
//			
//		}
//		return result;
//	}

	//보드
//	@Override
//	public int reviewDelete(int brd_num) {
//		System.out.println("JhChallengeDaoImpl reviewDelete Start...");
//		
//		int reviewDel = 0; 
//		try {
//			reviewDel = session.delete("jhReviewDelete", brd_num);
//		} catch (Exception e) {
//			System.out.println("JhChallengeDaoImpl reviewDelete e.getMessage() -> " + e.getMessage());
//		}
//		return reviewDel;
//	}

	@Override
	public int boardImgDelete(int brd_num) {
		System.out.println("JhChallengeDaoImpl boardImgDelete Start...");
		int brdImgDel = 0;
		try {
			brdImgDel = session.update("jhBoardImgDelete", brd_num);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl boardImgDelete e.getMessage() -> " + e.getMessage());
		}
		
		return brdImgDel;
		
	}

	@Override
	public List<Challenge> recomChgList(int chg_md) {
		System.out.println("JhChallengeDaoImpl boardImgDelete Start...");
		List<Challenge> chgList = null;
		
		try {
			chgList = session.selectList("jhRecommendChgList", chg_md);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl recomChgList e.getMessage() -> " + e.getMessage());

		}
		
		return chgList;
	}

	@Override
	public List<Comm> category(int categoryLd) {
		System.out.println("JhChallengeDaoImpl category Start...");
		List<Comm> category = null;
		try {
			category = session.selectList("jhCategory", categoryLd);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl category e.getMessage() -> " + e.getMessage());
		}
		return category;
	}

	@Override
	public int chgApplication(Challenge chg) {
		System.out.println("JhChallengeDaoImpl chgApplication Start...");
		int result = 0;
		try {
			result = session.insert("jhChgApplication", chg);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgApplication e.getMessage() -> " + e.getMessage());
		}
		return result;
	}

	/* 삭제 예정
	 * @Override public List<Challenge> chgAdminList(Challenge challenge) {
	 * System.out.println("JhChallengeDaoImpl jhChgAdminList Start...");
	 * 
	 * List<Challenge> chgAdminList = null; try { chgAdminList =
	 * session.selectList("chgAdminList", challenge); } catch (Exception e) {
	 * System.out.println("JhChallengeDaoImpl chgAdminList e.getMessage() -> " +
	 * e.getMessage());
	 * 
	 * } return chgAdminList; }
	 */

	@Override
	public List<Challenge> chgAplList(Challenge challenge) {
		System.out.println("JhChallengeDaoImpl chgAplList Start...");
		
		List<Challenge> chgAplList = null;
		try {
			System.out.println("JhChallengeDaoImpl chgAplList challenge.getStart()-> " + challenge.getStart());
			System.out.println("JhChallengeDaoImpl chgAplList challenge.getEnd()-> " + challenge.getEnd());
			System.out.println("JhChallengeDaoImpl chgAplList challenge.getState_md()-> " + challenge.getState_md());
			chgAplList = session.selectList("jhChgAplList", challenge);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgAplList e.getMessage() -> " + e.getMessage());
		}
		System.out.println("JhChallengeDaoImpl chgAplList chgAplList.size() -> " + chgAplList.size());
		System.out.println("JhChallengeDaoImpl chgAplList jhChgAplList -> " + chgAplList);
		return chgAplList;
	}

	@Override
	public int chgListTotal(Challenge challenge) {
		System.out.println("JhChallengeDaoImpl chgAplList Start...");
		int chgListTotal = 0;
		try {
			chgListTotal = session.selectOne("jhChgListTotal", challenge);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgListTotal e.getMessage() -> " + e.getMessage());
		}
		return chgListTotal;
	}

	@Override
	public int approvReturn(Map<String, Object> apvRtnParaMap) {
		System.out.println("JhChallengeDaoImpl approvReturn Start...");
		System.out.println("JhChallengeDaoImpl approvReturn apvRtnParaMap -> " + apvRtnParaMap);
		
		int resultCount = 0;
		try {
			session.selectOne("jhApprovReturnPro", apvRtnParaMap);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl approvReturn e.getMessage() -> " + e.getMessage());

		}
		resultCount = (int) apvRtnParaMap.get("resultCount");
		System.out.println("JhChallengeDaoImpl approvReturn resultCount -> " + resultCount);
		return resultCount;
	}

	@Override
	public int chgAdminUpdate(Challenge chg) {
		System.out.println("JhChallengeDaoImpl chgAdminUpdate Start...");
		int result = 0;
		
		try {
			result = session.update("jhChgAdminUpdate", chg);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl approvReturn e.getMessage() -> " + e.getMessage());
			
		}
		
		System.out.println("JhChallengeDaoImpl approvReturn result -> " + result);
		
		return result;
	}

	@Override
	public int chgDelete(int chg_id) {
		System.out.println("JhChallengeDaoImpl chgDelete Start...");
		int result = 0;
		
		try {
			result = session.delete("jhChgDelete", chg_id);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgDelete e.getMessage() -> " + e.getMessage());

		}
		
		System.out.println("JhChallengeDaoImpl chgDelete result -> " + result);
		return result;
	}

	@Override
	public int chgStateMd(int chg_id) {
		System.out.println("JhChallengeDaoImpl chgStateMd Start...");
		
		int stateMd = 0;
		
		try {
			stateMd = session.selectOne("jhChgStateMd", chg_id);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgStateMd e.getMessage() -> " + e.getMessage());

		}
		return stateMd;
	}



}
