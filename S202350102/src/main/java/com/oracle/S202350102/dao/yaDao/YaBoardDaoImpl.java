package com.oracle.S202350102.dao.yaDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.SharingList;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.hbService.Paging;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YaBoardDaoImpl implements YaBoardDao {
		
	private final SqlSession session;

	@Override
	public List<Board> listCommunity(Board board) {
		
		// board테이블 community게시판 조회
		List<Board> listCommunity = null;
		System.out.println("YaBoardDaoImpl listCommunity start...");
		try {
			listCommunity = session.selectList("listCommunity", board);
			System.out.println("YaBoardDaoImpl listCommunity communityList.size()?"+listCommunity.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl listCommunity e.getMessage()?"+e.getMessage());
		}
		
		return listCommunity;
	}
	

	
	@Override
	// board테이블 community 게시판 상세글 내용 확인
	public Board detailCommunity(int brd_num) {
		System.out.println("YaBoarDaoImpl detail start...");
		Board board = new Board();
		try {
			board = session.selectOne("YaCommunityOne", brd_num);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl detai e.getMessage)?"+e.getMessage());
		}
		return board;
	}
	
	// 게시글 조회수 증가
	@Override
	public void upViewCnt(int brd_num) {
		System.out.println("YaBoardDaoImpl upViewCnt start...");
		 	
		try {
			session.update("YaBoardUpviewCnt" , brd_num);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void upViewCnt e.getMessage)?"+e.getMessage());
		}
		
	}
	
	

	@Override
	public int insertCommunity(Board board) {
		
		int insertResult =0;
		System.out.println("YaBoardDaoImpl insertCommunity start..");
		try {
			insertResult = 	session.insert("YaBoardInsert", board);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void upViewCnt e.getMessage?"+e.getMessage());
		}
		return insertResult;

		
	}

	@Override
	public int updateCommunity(Board board) {
		int updateCommunity =0;
		System.out.println("YaBoardDaoImpl updateCommunity start...");
		
		try {
			updateCommunity = session.update("YaBoardUpdate", board);
			
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl updateCommunity e.getMessage?"+e.getMessage());
		}
		return updateCommunity;
	}

	@Override
	public int deleteCommunity(int brd_num) {
		int deleteResult=0;
		System.out.println("YaBoardDaoImpl deleteCommunity start...");
		
		try {
			deleteResult = session.delete("YaBoardDelete", brd_num);
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl deleteCommunity e.getMessage?"+e.getMessage());
		}
		return deleteResult;
	}

	@Override
	public List<Board> boardSearchList(String keyword, String currentPage) {
		List<Board> boardSearchList = null;
		System.out.println("YaBoardDaoImpl boardSearchList start....");
		
		try {
		      // 검색 결과와 페이징 정보 가져오기
	        int countSearch = countSearch(keyword);

	        // 페이징 처리
	        Paging boardPage = new Paging(countSearch, currentPage);

	        // MyBatis를 사용하여 검색 결과 가져오기
	        Map<String, Object> parameterMap = new HashMap<>();
	        parameterMap.put("keyword", keyword);
	        parameterMap.put("start", boardPage.getStart());
	        parameterMap.put("end", boardPage.getEnd());
	        parameterMap.put("total", countSearch);

			boardSearchList = session.selectList("YaBoardSearhList",parameterMap);

			
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl boardSearchList e.getMessage?"+e.getMessage());
		}
		return boardSearchList;
	}
	

	@Override
	public int countSearch(String keyword) {
		int countSearch = 0;
		System.out.println("YaBoardDaoImpl countSearch start.. ");
	    try {
	        countSearch = session.selectOne("countSearch", keyword);
	    } catch (Exception e) {
	        System.out.println("YaBoardDaoImpl countSearch e.getMessage? " + e.getMessage());
	    }
		return countSearch;
	}


	
	
	
	@Override
	public List<Board> sortByViewCnt(int start, int end) {
		List<Board> sortByViewCnt = null;
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("start", start);
            params.put("end", end);      	
        	sortByViewCnt = session.selectList("sortByViewCnt",params);
        } catch (Exception e) {
        	System.out.println("YaBoardDaoImpl sortByViewCnt() e.getMessage?"+e.getMessage());
     
        }
		return sortByViewCnt;
	}

	@Override
	public List<Board> sortByRegDate(int start, int end) {
		List<Board> sortByRegDate =null;
		try {
			 Map<String, Integer> params = new HashMap<>();
	            params.put("start", start);
	            params.put("end", end);      	
	            sortByRegDate = session.selectList("sortByRegDate",params);
	        } catch (Exception e) {
	          	System.out.println("YaBoardDaoImpl sortByRegDate() e.getMessage?"+e.getMessage());
	         
	        }
		   return sortByRegDate;
	}

	@Override
	public User1 userSelect(int user_num) {
		User1 user = new User1();
		try {
			System.out.println("user_num->"+user_num);
			user = session.selectOne("userSelect",user_num);
			System.out.println("user->"+user);
		} catch (Exception e) {
			System.out.println("UserDaoImpl userSelect exception->"+e.getMessage());
		}
		return user;
	}
	// 댓글 조회
	@Override
	public List<Board> listComment(int brd_num) {
		List<Board> listComment = null;
		try {
			System.out.println("YaBoardDaoImpl listComment start....");
			listComment = session.selectList("listComment",brd_num);
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl listComment e.getMessage?"+e.getMessage());
		}
		return listComment;
	}

	@Override
	public void commentWrite(Board board) {
		System.out.println("YaBoardDaoImpl commentWrite start...");
	 	
		try {
			session.insert("YacommentWrite", board);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void commentWrite e.getMessage)?"+e.getMessage());
		}
		
	}

	@Override
	public void commentUpdate(Board board) {
		System.out.println("YaBoardDaoImpl commentUpdate start...");
		try {
			session.update("YaCommentUpdate", board);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void YaCommentUpdate e.getMessage)?"+e.getMessage());
		}
		
	}

	@Override
	public void commentDelete(Board board) {
		System.out.println("YaBoardDaoImpl commentDelete start...");
		try {
			session.delete("YaCommentDelete",board);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void YaCommnetDelte e.getMessage)?"+e.getMessage());
		}
			
	}

	@Override
	public int getLatestBrdStep(int brd_group) {
		System.out.println("YaBoardDaoImpl getLatestBrdStep start...");
		int getLatestBrdStep = 0;
		try {
			session.selectOne("YaGetLatestBrdStep",brd_group);
			
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl etLatestBrdStep e.getMessage)?"+e.getMessage());
		}
		return getLatestBrdStep;
	}

	@Override
	public int commentCount(int brd_num) {
		System.out.println("YaBoardDaoImpl getLatestBrdStep start...");
		int commentCount = 0;
		try {
			commentCount=session.selectOne("YaCommentTotal",brd_num);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl commentCount e.getMessage)?"+e.getMessage());
		}
		return commentCount;
	}


	// 총 게시글 
	@Override
	public int totalCommunity(Board board) {
		System.out.println("YaBoardDaoImpl totalCommunity start....");
		int totalCommunity = 0;
		try {
			totalCommunity = session.selectOne("YaTotalCommunity");
		} catch (Exception e) {
			System.out.println("YaBoardDao YaTotalCommunity e.getmmessage?"+e.getMessage());
		}
		return totalCommunity;
	}


	// 쉐어링리스트 참가자 등록
	@Override
	public int saveSharing(SharingList sharingList) {
		System.out.println("YaBoardDaoImpl saveSahing  start....");
		int saveSharing = 0;
		try {
			saveSharing = session.insert("YaSharingSave", sharingList);
		} catch (Exception e) {
			System.out.println("YaBoardDao saveSahing e.getmmessage?"+e.getMessage());
		}
		return saveSharing;
	}


	//마이페이지-내가올린 쉐어링리스트 조회 
	@Override
	public List<Board> myUploadSharingList(Board board) {
		System.out.println("YaBoardDaoImpl myUploadSharingList start...");
		List<Board> myUploadSharingList = null;
		try {
			myUploadSharingList = session.selectList("myUploadSharingList",  board);
			System.out.println("YaBoardDaoImpl myUploadSharingList List.size()?"+myUploadSharingList.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl myUploadSharingList e.getMessage()?"+e.getMessage());
		}
		
		return myUploadSharingList;

	}


	//마이페이지 - 내가 올린 쉐어링 게시글의 참가자리스트 조회
	@Override
	public List<SharingList> sharingParticipantsList(int brd_num) {
		System.out.println("YaBoardDaoImpl  sharingParticipantsList sharingParticipantsInfo start...");
		List<SharingList> sharingParticipantsList = null;
		try {
			sharingParticipantsList = session.selectList("sharingParticipantsInfo", brd_num);
			
			System.out.println("YaBoardDaoImpl sharingParticipantsList.size()(?"+sharingParticipantsList.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl sharingParticipantsList e.getMessage()?"+e.getMessage());
		}	
		return sharingParticipantsList;
	}

	//마이페이지 내가 참가한 쉐어링 조회
	@Override
	public List<SharingList> myJoinSharingList(SharingList sharingList) {
		System.out.println("YaBoardDaoImpl  myJoinSharingList sharingParticipantsInfo start...");
		List<SharingList> myJoinSharingList = null;
		try {
			myJoinSharingList = session.selectList("YaMyJoinSharingList", sharingList);
			
			System.out.println("YaBoardDaoImpl myJoinSharingList.size()?"+myJoinSharingList.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl myJoinSharingList e.getMessage()?"+e.getMessage());
		}	
		return myJoinSharingList;

	}


	//마이페이지 내가 승인한 쉐어링 조회 
	@Override
	public List<Board> myConfirmSharingList(Board board) {
		System.out.println("YaBoardDaoImpl myConfirmSharingList start...");
		List<Board> myConfirmSharingList = null;
		try {
			myConfirmSharingList = session.selectList("YaMyConfirmSharingList", board);
			
			System.out.println("YaBoardDaoImpl myConfirmSharingList.size()?"+myConfirmSharingList.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl myConfirmSharingList e.getMessage()?"+e.getMessage());
		}	
		return myConfirmSharingList;

	}
	
	// 마이페이지 - 승인처리
	@Override
	public int sharingConfirm(SharingList sharingList) {
		System.out.println("YaBoardDaoImpl sharingConfirm start...");
		int sharingConfirm = 0;
		try {
			
			sharingConfirm = session.update("YaSharingConfirm", sharingList);
			if (sharingConfirm >0) {
				System.out.println("쿼리가 성공적으로 업데이트 되었습니다.");
			}
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl sharingConfirm e.getMessage()?"+e.getMessage());
		}				
		return sharingConfirm;
	}


	// 마이페이지 쉐어링 승인시 참가자 수 증가
	@Override
	public void upParticipantsCnt(int brd_num) {
		System.out.println("YaBoardDaoImpl upParticipantsCnt start...");
	 	
		try {
			session.update("YaUpParticipantsCnt" , brd_num);
		} catch (Exception e) {
			System.out.println("YaUpParticipantsCnt void ParticipantsCnt e.getMessage)?"+e.getMessage());
		}
		
	}


	// 마이페이지 참가자 승인 state_md: 101 update & reject message null-->입력 
	@Override
	public int sharingReject(SharingList sharingList) {
		System.out.println("YaBoardDaoImpl sharingReject start...");
		int sharingReject = 0;
		try {
			
			sharingReject = session.update("YasharingReject", sharingList);

		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl sharingReject e.getMessage()?"+e.getMessage());
		}				
		return sharingReject;
	}


	//반려시 board의 participants -1 감소
	@Override
	public void downParticipantsCnt(int brd_num) {
		System.out.println("YaBoardDaoImpl downParticipantsCnt start...");
	 	
		try {
			session.update("YaDownParticipantsCnt" , brd_num);
		} catch (Exception e) {
			System.out.println("YaDownParticipantsCntt void ParticipantsCnt e.getMessage)?"+e.getMessage());
		}		
	}


	// myTotalUploadSharing 
	@Override
	public int totalMyUploadsharing(int user_num) {
		System.out.println("YaBoardDaoImpl totalMyUploadsharing start....");
		int totalMyUploadsharing = 0;
		try {
			totalMyUploadsharing = session.selectOne("YaMyUploadsharing",user_num);
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl totalMyUploadsharing e.getmmessage?"+e.getMessage());
		}
		return totalMyUploadsharing;
	}
	
	//jointShairng
	@Override
	public int totalJoinSharing(int user_num) {
		System.out.println("YaBoardDaoImpl totalJoinSharing start....");
		int totalJoinSharing = 0;
		try {
			totalJoinSharing = session.selectOne("YaJoinSharing",user_num);
		} catch (Exception e) {
			
			System.out.println("YaBoardDaoImpl totalJoinSharing e.getmmessage?"+e.toString());
		}
		return totalJoinSharing;
		
	}



	@Override
	public int totalConfirmSharing(int user_num) {
		System.out.println("YaBoardDaoImpl totalConfirmSharing start....");
		int totalConfirmSharing = 0;
		try {
			totalConfirmSharing = session.selectOne("YaConfirmSharing",user_num);
		} catch (Exception e) {
			
			System.out.println("YaBoardDaoImpltotalConfirmSharing e.getmmessage?"+e.toString());
		}
		return totalConfirmSharing;
	
	}



	@Override
	public int totalSharing(Board board) {
		System.out.println("YaBoardDaoImpltotalSharing start....");
		int totalSharing = 0;
		try {
			totalSharing = session.selectOne("YaTotalSharing");
		} catch (Exception e) {
			System.out.println("YaBoardDao YaTotalSharing e.getmmessage?"+e.getMessage());
		}
		return totalSharing;
	}



	@Override
	public int likeSharingCnt(int user_num) {
		System.out.println("YaBoardlikeSharingCnt start....");
		int likeSharingCnt = 0;
		try {
			likeSharingCnt = session.selectOne("YaLikeSharingCnt",user_num );
		} catch (Exception e) {
			System.out.println("YaBoardDao YaLikeSharingCnt e.getmmessage?"+e.getMessage());
		}
		return likeSharingCnt;
	}



	@Override
	public List<Board> likeSharingList(Board board) {
		System.out.println("YaBoardDaoImpl likeSharingList start...");
		List<Board> likeSharingList = null;
		//이거하니까 담김***
		board.setUser_num(board.getB_user_num());
		try {
			likeSharingList = session.selectList("YaLikeSharingList", board);
			
			System.out.println("YaBoardDaoImpl myConfirmSharingList.size()?"+likeSharingList.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl myConfirmSharingList e.getMessage()?"+e.getMessage());
		}	
		return likeSharingList;

	}



	@Override
	public int searchSharingCnt(String keyword) {
		 int searchSharingCnt = 0;
		 System.out.println("YaBoardDaoImpl searchSharingCnt start.. ");
		 
		 try {
			 searchSharingCnt = session.selectOne("searchSharingCnt", keyword);
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl SearchSharingCnt e.,getmssage?"+e.getMessage());
		}
		 
		return searchSharingCnt;
	}



	@Override
	public List<Board> sharingSearchResult(String keyword,String sortOption,  String currentPage, Board board) {
		List<Board> sharingSearchResult = null;
		System.out.println("YaBoardDaoImpl sharingSearchResult start...");
		board.setUser_num(board.getB_user_num());
		System.out.println("YaBoardDaoImpl sharingSearchResult b_user_num" + board.getB_user_num());

		
		try {
			// sharingSearchResult = session.selectList("YaSharingSearchResult", keyword);
			
			int searchSharingCnt =searchSharingCnt(keyword);			 
		  	Paging boardPage = new Paging(searchSharingCnt, currentPage,9);
		  	 	
		  		
		        Map<String, Object> paramMap = new HashMap<>();
		        paramMap.put("keyword", keyword);
		        paramMap.put("b_user_num", board.getB_user_num());
		       
		        paramMap.put("currentPage", currentPage);
		        paramMap.put("start", boardPage.getStart());
		        paramMap.put("sortOption", sortOption);
		        paramMap.put("end", boardPage.getEnd());
		        paramMap.put("searchSharingCnt", searchSharingCnt);
		        sharingSearchResult = session.selectList("YaSharingSearchResult", paramMap);
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl YaSharingSearchResult e.,getmssage?"+e.getMessage());
		}
		return  sharingSearchResult;
	}


	//쉐어링 참가 확인
	@Override
	public List<SharingList> sharingChk(int brd_num) {
		System.out.println("ybdSharingChk start...");
		System.out.println("brd_num?"+brd_num);
		
		List<SharingList> sharingChk = null;
		try {
			sharingChk = session.selectList("YaSharingChk", brd_num);
			
		} catch (Exception e) {
		
			System.out.println("YaBoardDaoImpl sharingChk e.getmssage?"+e.getMessage());
		}
		return sharingChk;
	}



	@Override
	public int deleteJoinSharing(int user_num) {
		System.out.println("ybd deletejoinShairng start...");
		int deleteJoinSharing = 0;
		try {
			
			deleteJoinSharing = session.delete("YaDeleteSharing", user_num);
			System.out.println("deleteJoinSharing:"+deleteJoinSharing);
			
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl deleteJoinSharing  e.getmssage?"+e.getMessage());
		}
		return deleteJoinSharing;
	}


	//쉐어링 승인자 조회
	@Override
	public List<Board> myConfirmSharingList(int start, int end) {
		List<Board> myConfirmSharingList=null;
		System.out.println("ybd myConfirmSharingList start...");
		try {
	        Map<String, Object> parameters = new HashMap<>();
	        parameters.put("start", start);
	        parameters.put("end", end);
	        myConfirmSharingList = session.selectList("YaMyConfirmSharingList", parameters);
		} catch (Exception e) {
			System.out.println("YaCustomerDaoImpl  myConfirmSharingList e.getMessage()?"+e.getMessage());
		}
		
		return myConfirmSharingList;
	}
	





	
	
}

	


	


