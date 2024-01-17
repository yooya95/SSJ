package com.oracle.S202350102.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.BoardLike;
import com.oracle.S202350102.dto.ChallengPick;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.bgService.BgBoardService;
import com.oracle.S202350102.service.chService.ChChallengeService;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.jhService.JhBoardService;
import com.oracle.S202350102.service.jhService.JhCallengeService;
import com.oracle.S202350102.service.main.Level1Service;
import com.oracle.S202350102.service.main.UserService;
import com.oracle.S202350102.service.thService.ThChgService;
import com.oracle.S202350102.service.yrService.YrChallengePickService;
import com.oracle.S202350102.service.yrService.YrChallengerService;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class JhController {
	
	private final JhCallengeService jhCService;
	private final JhBoardService	jhBrdService;
	private final UserService userService;
	
	private final ThChgService tcs;
	
	// yr 작성
	private final YrChallengerService ycs;
	private final YrChallengePickService ycps;
	
	private final BgBoardService bBoardS;
	
	private final Level1Service ls;
	
	
	//HttpServletRequest request 안쓰고 HttpSession session만 해도 되는건가?
	////////챌린지 상세정보 조회/////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "chgDetail")
	public String chgDetail(@RequestParam int chg_id
						  , @RequestParam(value = "sortBy", required = false) String sortBy				// 인증게시판 검색 및 정렬
						  , @RequestParam(value = "searchType", required = false) String searchType
						  , @RequestParam(value = "keyword", required = false) String keyword
						  , HttpSession session
						  , Model model
						  , String currentPage
						  , Board board
						  , String tap //탭 구분을 위한 파라미터 1 인증, 2 소세지, 3 후기
						  ) {

		
		System.out.println("JhController chgDetail Start...");
		System.out.println("JhController chgDetail  chg_id -> "+ chg_id);
		System.out.println("JhController chgDetail  tap -> "+ tap);

		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		} 
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController chgDetail userNum -> " + user);
		model.addAttribute("user", user);
		
		
		//jh 작성
		//챌린지 상세정보 조회
		Challenge chgDetail = jhCService.chgDetail(chg_id);
		System.out.println("JhController chgDetail chg -> " + chgDetail);
		model.addAttribute("chg", chgDetail);
		
		//jh 작성
		//후기 총 개수
		int reviewTotal = jhBrdService.reviewTotal(chg_id);
		model.addAttribute("reviewTotal", reviewTotal);
		System.out.println("JhController chgDetail  reviewTotal -> "+ reviewTotal);
		
		//페이지네이션
		Paging reviewPage = new Paging(reviewTotal, currentPage);
		board.setStart(reviewPage.getStart());
		board.setEnd(reviewPage.getEnd());
		model.addAttribute("reviewPage",reviewPage);
		System.out.println("JhController chgDetail  reviewPage.getStart() -> "+ reviewPage.getStart());
		System.out.println("JhController chgDetail  reviewPage.getTotal() -> "+ reviewPage.getTotal());
		System.out.println("JhController chgDetail  board.getChg_id() -> "+ board.getChg_id());
		
		//후기 목록 조회
		List<Board> chgReviewList = jhBrdService.chgReviewList(board);
		chgReviewList = userService.boardWriterLevelInfo(chgReviewList);
		model.addAttribute("chgReviewList", chgReviewList);
		model.addAttribute("tap", tap);
		
		
		// yr 작성
		// challenger 테이블에서 참여인원 가져오기용
		int chgrParti = ycs.selectChgrParti(chg_id);
		System.out.println("JhController chgDetail chgrParti -> " + chgrParti);
		model.addAttribute("chgrParti", chgrParti);
		
		// challenger 참여 유무 판단용
		Challenger chgr = new Challenger();
		chgr.setUser_num(userNum);
		chgr.setChg_id(chg_id);
		int chgrJoinYN = ycs.selectChgrJoinYN(chgr);
		System.out.println("JhController chgDetail chgrJoinYN -> " + chgrJoinYN);
		model.addAttribute("chgrYN", chgrJoinYN);
		
		// 소세지들 출력용
		List<User1> listSsj = ycs.getListSsj(chg_id);
		listSsj = userService.userLevelList(listSsj);
		model.addAttribute("listSsj", listSsj);
		
		// 찜 여부 판단용
		ChallengPick chgPick = new ChallengPick();
		chgPick.setChg_id(chg_id);
		chgPick.setUser_num(userNum);
		int chgPickYN = ycps.selectChgPickYN(chgPick);
		System.out.println("JhController chgDetail chgPickYN -> " + chgPickYN);
		model.addAttribute("chgPickYN", chgPickYN);
		
		// bg 작성
		
		// 해당 chg_id의 게시글 만을 가져오기 위해 board 객체에 설정
		board.setChg_id(chg_id);
		board.setSearchType(searchType);
		board.setKeyword(keyword);
		board.setSortBy(sortBy);
		
		// yr 작성
		// 로그인 된 정보를 넣기 위함
		board.setB_user_num(userNum);
		  
		// 페이징 작업 
		// 인증 글 개수			mapper 키: certTotal
		System.out.println("JhController board.getSearchType() -> "+board.getSearchType());
		System.out.println("JhController board.getKeyword() -> "+board.getKeyword());
		System.out.println("JhController board.getSortBy() -> "+board.getSortBy());
		// 
		if (searchType == null && sortBy == null ) {
			
			// 카운팅
			int certTotal = bBoardS.certTotal(chg_id);
			model.addAttribute("certTotal", certTotal);
			System.out.println("certTotal -> " + certTotal);
			
			// 페이징
			Paging certBrdPage = new Paging(certTotal, currentPage);
			board.setStart(certBrdPage.getStart()); 
			board.setEnd(certBrdPage.getEnd());
			model.addAttribute("certTotal", certTotal);
			model.addAttribute("certBrdPage", certBrdPage);
			System.out.println("certBrdPage.getStart() -> "+certBrdPage.getStart());
			System.out.println("certBrdPage.getTotal() -> "+certBrdPage.getTotal());
			
			// certBoard: 인증 게시판 글 불러오기		mapper 키: bgCertBoardAll
			List<Board> certBoard = bBoardS.certBoard(board);
			certBoard = userService.boardWriterLevelInfo(certBoard);
			System.out.println("BgController certBoard.size() -> "+certBoard.size());
			model.addAttribute("certBoard", certBoard);
			
			
			// bgChgDetail: 해당 chg_id 회원의 챌린지 상세 정보 조회		mapper 키: bgChgDetail
//			Challenge chg = bBoardD.bgChgDetail(chg_id);
//			System.out.println("BgController bgChgDetail chg -> "+chg);
//			model.addAttribute("chg", chg);
			
		} 
		
		// 키워드가 있을 때
		else {
			System.out.println("keyword3 -> "+keyword);
			System.out.println("searchType3 -> "+searchType);
			System.out.println("chg_id3 -> "+chg_id);
			System.out.println("sortBy3 -> "+sortBy);
			
			// 카운팅
			// mapper key: srchCrtBdCnt		 검색 결과 counting 후, 페이징 작업
			int searchCnt = bBoardS.srchCrtBdCnt(board);
			System.out.println("searchCnt3 -> "+searchCnt);
			
			// 페이징
			Paging page = new Paging(searchCnt, currentPage);
			board.setStart(page.getStart());	// 시작 시 1
			board.setEnd(page.getEnd());		// 시작 시 10
			System.out.println("sortBy3 page.getStart()-> "+page.getStart());
			System.out.println("sortBy3 page.getEnd()-> "+page.getEnd());
			System.out.println("sortBy3 page.getEndPage()-> "+page.getEndPage());
			
			// R
			// mapper key: searchCrtBd		 검색 결과 리스트 R
			List<Board> srchResult = bBoardS.searchCrtBd(board);
			srchResult = userService.boardWriterLevelInfo(srchResult);
			System.out.println("srchResult.size() -> "+srchResult.size());
			
			
			model.addAttribute("keyword", keyword);
			model.addAttribute("searchType", searchType);
			model.addAttribute("sortBy", sortBy);
			model.addAttribute("certTotal", searchCnt);
			model.addAttribute("certBoard", srchResult);
			/// 가공 후 페이지가 안 보이므로 명칭 통일
			model.addAttribute("certBrdPage", page);
			
			
		}
		
		
		
		//작성자 이름옆에 레벨아이콘이 나오게 하기 위한 것 추후 추가할 것!! 카톡 게시글 231107에 등록된 글 확인
//		//hb 
//		List<UserLevel> userLevelInfoList = us.userLevelInfoList();
//		String icon = "";
//		int user_level = 0;
//		int user_exp = 0;
//		for (int i = 0; i < qBoardList.size(); i++) {
//		     user_num = qBoardList.get(i).getUser_num();
//		     for (int j = 0; j < userLevelInfoList.size(); j++) {
//		        if ( user_num == userLevelInfoList.get(j).getUser_num() ) {
//		        icon = userLevelInfoList.get(j).getLv_name();
//		        user_level = userLevelInfoList.get(j).getUser_level();
//		        user_exp = userLevelInfoList.get(j).getUser_exp();
//		        qBoardList.get(i).setIcon(icon);
//		        qBoardList.get(i).setUser_level(user_level);
//		        qBoardList.get(i).setUser_exp(user_exp);
//		        }
//		     }
//		}
		
		return "jh/jhChgDetail";
	}
	
//	
//	//챌린지 후기글 내용 조회(수정중)
//	@RequestMapping(value = "reviewContent")
//	public String reviewContent(
//			//board에 brd_num 있기 때문에 따로 파라미터 없어도 됨, 페이지네이션 하려고 board를 파라미터로 받음
////								@RequestParam int brd_num 
////								@RequestParam int chg_id 
////								,String 	   rep_brd_num	//댓글 번호(수정 후 그 글번호로 화면 이동하기 위함)
////								,String 	   result		//댓글 수정/삭제 성공여부 전달
//								HttpSession   session 
//								,Model 		   model 
//								,String 	   currentPage	//페이지네이션 위함
//								,Board		   board 		//페이지네이션 위함
//								) {
//		System.out.println("JhController reviewContent Start...");
////		System.out.println("JhController reviewContent chg_id -> " + chg_id);
//
//			
//		//세션에서 회원번호 가져옴
//		int userNum = 0;
//		if(session.getAttribute("user_num") != null) {
//			userNum = (int) session.getAttribute("user_num");
//			System.out.println("JhController reviewContent userNum -> " + userNum);
//		}
//		
//		//유저 정보(회원번호) 조회 -> 일단 유저 dto로 모델에 저장 특정 정보만 필요할 경우 나중에 수정 예정
//		User1 user = userService.userSelect(userNum);
//		System.out.println("JhController reviewContent userNum -> " + user);
//		model.addAttribute("user", user);
//		
//		//원글 번호
//		int brd_num = board.getBrd_num();
//		System.out.println("JhController reviewContent brd_num -> " + brd_num);
//		//후기 글 조회수 +1
//		jhBrdService.viewCntUp(brd_num);
//		
//		//챌린지 후기글 내용 조회
//		Board reviewContent = jhBrdService.reviewContent(brd_num);
//		
//		//후기글 총 댓글 수
//		int replyCount = reviewContent.getReplyCount();
//		
//		//페이지네이션
//		Paging replyPage = new Paging(replyCount, currentPage);
//		board.setStart(replyPage.getStart());
//		board.setEnd(replyPage.getEnd());
//		model.addAttribute("replyPage",replyPage);
//		System.out.println("JhController reviewContent  replyPage.getStart() -> "+ replyPage.getStart());
//		System.out.println("JhController reviewContent  replyPage.getTotal() -> "+ replyPage.getTotal());
//		System.out.println("JhController reviewContent  board.getChg_id() -> "+ board.getChg_id());
//		
//		//챌린지 해당 글에 대한 댓글 조회
//		List<Board> reviewReplyList = jhBrdService.reviewReplyList(board);
//		reviewReplyList = userService.boardWriterLevelInfo(reviewReplyList);
//		
//		// challenger 참여 유무 판단용
//		Challenger chgr = new Challenger();
//		chgr.setUser_num(userNum);
////		chgr.setChg_id(chg_id);
//		int chgrJoinYN = ycs.selectChgrJoinYN(chgr);
//		System.out.println("JhController chgDetail chgrJoinYN -> " + chgrJoinYN);
//		model.addAttribute("chgrYN", chgrJoinYN);
//		
//		
//		System.out.println("JhController reviewContent reviewContent -> " + reviewContent);
//		System.out.println("JhController reviewContent reviewReply -> " + reviewReplyList);
//		model.addAttribute("reviewContent", reviewContent);
//		model.addAttribute("reviewReply", reviewReplyList);
////		model.addAttribute("chg_id", chg_id);
//		
////		//댓글 수정
////		if ( rep_brd_num != null ) {
////			String flag = "flag";
////			model.addAttribute("flag", flag);
////			model.addAttribute("rep_brd_num", rep_brd_num);
////			System.out.println("JhController reviewContent flag -> " + flag);
////			System.out.println("JhController reviewContent rep_brd_num -> " + rep_brd_num);
////		}
////		
//		
//		//댓글 삭제/업데이트 결과정보 전달
////		model.addAttribute("result", result);
////		System.out.println("JhController reviewContent result -> " + result);
//		
//		return "jh/jhReviewContent";
//	}
	
	
	
	
	//챌린지 후기글 내용 조회
	@RequestMapping(value = "reviewContent")
	public String reviewContent(
			//board에 brd_num 있기 때문에 따로 파라미터 없어도 됨, 페이지네이션 하려고 board를 파라미터로 받음
//								@RequestParam int brd_num 
			@RequestParam int chg_id 
			,HttpSession   session 
			,Model 		   model 
			,String 	   rep_brd_num	//댓글 번호(수정 후 그 글번호로 화면 이동하기 위함)
			,String 	   result		//댓글 수정/삭제 성공여부 전달
			,String 	   currentPage	//페이지네이션 위함
			,Board		   board 		//페이지네이션 위함
			) {
		System.out.println("JhController reviewContent Start...");
		System.out.println("JhController reviewContent chg_id -> " + chg_id);
		
		
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController reviewContent userNum -> " + userNum);
		}
		
		//유저 정보(회원번호) 조회 -> 일단 유저 dto로 모델에 저장 특정 정보만 필요할 경우 나중에 수정 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController reviewContent userNum -> " + user);
		model.addAttribute("user", user);
		
		//원글 번호
		int brd_num = board.getBrd_num();
		System.out.println("JhController reviewContent brd_num -> " + brd_num);
		//후기 글 조회수 +1
		jhBrdService.viewCntUp(brd_num);
		
		//챌린지 후기글 내용 조회
		Board reviewContent = jhBrdService.reviewContent(brd_num);
		
		//후기글 총 댓글 수
		int replyCount = reviewContent.getReplyCount();
		
		//페이지네이션
		Paging replyPage = new Paging(replyCount, currentPage);
		board.setStart(replyPage.getStart());
		board.setEnd(replyPage.getEnd());
		model.addAttribute("replyPage",replyPage);
		System.out.println("JhController reviewContent  replyPage.getStart() -> "+ replyPage.getStart());
		System.out.println("JhController reviewContent  replyPage.getTotal() -> "+ replyPage.getTotal());
		System.out.println("JhController reviewContent  board.getChg_id() -> "+ board.getChg_id());
		
		//챌린지 해당 글에 대한 댓글 조회
		List<Board> reviewReplyList = jhBrdService.reviewReplyList(board);
		reviewReplyList = userService.boardWriterLevelInfo(reviewReplyList);
		
		// challenger 참여 유무 판단용
		Challenger chgr = new Challenger();
		chgr.setUser_num(userNum);
		chgr.setChg_id(chg_id);
		int chgrJoinYN = ycs.selectChgrJoinYN(chgr);
		System.out.println("JhController chgDetail chgrJoinYN -> " + chgrJoinYN);
		model.addAttribute("chgrYN", chgrJoinYN);
		
		
		System.out.println("JhController reviewContent reviewContent -> " + reviewContent);
		System.out.println("JhController reviewContent reviewReply -> " + reviewReplyList);
		model.addAttribute("reviewContent", reviewContent);
		model.addAttribute("reviewReply", reviewReplyList);
		model.addAttribute("chg_id", chg_id);
		
		//댓글 수정
		if ( rep_brd_num != null ) {
			String flag = "flag";
			model.addAttribute("flag", flag);
			model.addAttribute("rep_brd_num", rep_brd_num);
			System.out.println("JhController reviewContent flag -> " + flag);
			System.out.println("JhController reviewContent rep_brd_num -> " + rep_brd_num);
		}
		
		
		//댓글 삭제/업데이트 결과정보 전달
		model.addAttribute("result", result);
		System.out.println("JhController reviewContent result -> " + result);
		
		return "jh/jhReviewContent";
	}
	
	
	@RequestMapping(value = "showReplyUpdate")
	public String showReplyUpdate(@RequestParam("rep_brd_num") int rep_brd_num, 
								  @RequestParam("ori_brd_num") int ori_brd_num,
								  @RequestParam("chg_id") 	   int chg_id, 
								  String currentPage,
								  Model model
								  ) {
		System.out.println("JhController showReplyUpdate Start...");
		System.out.println("JhController showReplyUpdate rep_brd_num -> " + rep_brd_num);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rep_brd_num", rep_brd_num); 
		
		//여기서 바로 업데이트 하는 게 아니라 forward 사용 redirect는 디비 수정후에 사용하는 것
		return "forward:reviewContent?brd_num="+ori_brd_num+"&chg_id="+chg_id ;
		
	}
	

	//챌린지 후기 댓글 입력
	@RequestMapping(value = "replyInsert")
	public String replyInsert(Board board, HttpSession session, Model model) {
		System.out.println("JhController replyInsert Start...");
		
		jhBrdService.replyInsert(board);
		
		//디비에 인서트는 이 메소드에서 해결 했으니 새롭게 reviewContent 요청해야하니 redirect 사용
		//forward 사용하면 새로고침시 같은 댓글이 계속 입력되는 문제 발생
		return "redirect:reviewContent?brd_num="+board.getBrd_num()+"&chg_id="+board.getChg_id();
	}
	

	@RequestMapping(value = "replyUpdate")
	public String replyUpdate( @RequestParam("ori_brd_num") int ori_brd_num,
							   Model model,
							   Board board) {
		
		int result = jhBrdService.replyUpdate(board);
		System.out.println("JhController replyInsert replyUpdate -> " + result );
		
		//댓글 수정 결과를 삭제와 어떻게 구분하지? -> 구분 안하고 댓글 변경 완료되었습니다 메세지로 통일
//		return "redirect:reviewContent?brd_num="+ori_brd_num+"&chg_id="+board.getChg_id();
		return "redirect:reviewContent?brd_num="+ori_brd_num+"&chg_id="+board.getChg_id()+"&result="+result;
	}
	
	//후기 댓글 삭제 근데 화면처리는 어떻게?
	@RequestMapping(value = "replyDelete")
	public String replyDelete(@RequestParam(value = "ori_brd_num" , required = false) String brd_num, 
							  @RequestParam("rep_brd_num") String brd_num2,
							  //@RequestParam(required = false) Integer admin,
							  Integer chg_id, 
							  HttpSession session, 
							  Model model) {
		//ori_brd_num : 원글번호(다시 후기 글로 돌아가기 위한 파라미터)
		//rep_brd_num : 삭제할 댓글 파라미터
		System.out.println("JhController replyDelete Start...");
		
		int rep_brd_num = Integer.parseInt(brd_num2);
		
		int result = jhBrdService.replyDelete(rep_brd_num);
		
		System.out.println("JhController replyDelete result -> " + result);
		
		
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController replyDelete userNum -> " + userNum);
		} 
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user = userService.userSelect(userNum);
		int status_md = user.getStatus_md();
		
		
		if(status_md == 102) {
			return "redirect:replyAdminList?brd_num="+brd_num+"&chg_id="+chg_id;
		}
		return "redirect:reviewContent?brd_num="+brd_num+"&chg_id="+chg_id+"&result="+result;
	}
	
	
	
	
	//챌린지 신청 페이지로 이동
	@RequestMapping(value = "chgApplicationForm")
	public String chgApplicationForm (HttpSession session, Model model) {
		System.out.println("JhController chgApplicationForm Start...");
		System.out.println("JhController reviewList user_num -> " + session.getAttribute("user_num"));
		
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		}
		
		//유저 정보(회원번호) 조회 -> 일단 유저 dto로 모델에 저장 특정 정보만 필요할 경우 나중에 수정 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController chgDetail userNum -> " + user);
		
		//유저의 회원상태 가져옴 필요 없는듯
//		String userStatus = jhCService.userStatus(userNum);
		
		//챌린지 카테고리 중분류 번호 가져오기
		//챌린지 카테고리 대분류
		int categoryLd = 200;
		List<Comm> category = jhCService.category(categoryLd);
		
		model.addAttribute("category", category);
		
		//추천챌린지(카테고리별 최신 등록순)
		List<Challenge> recomChgList = null;
		if (!category.isEmpty()) {
		    int firstMdValue = category.get(0).getMd();
		    
		    recomChgList = recommendCallenge(firstMdValue);
			
		}
		
		//태현 카테고리 리스트 
		List<Comm> chgCategoryList = tcs.listChgCategory();
		model.addAttribute("chgCategoryList", chgCategoryList);

		
		
		model.addAttribute("recomChgList", recomChgList);
		
		model.addAttribute("user", user);
//		model.addAttribute("userStatus", userStatus);
		
		
		return "jh/jhChgApplicationForm";
	}
	
	
	//추천 챌린지 ajax
	@ResponseBody
	@RequestMapping(value = "recommendCallenge") 
	public List<Challenge>  recommendCallenge(int chg_md){
		System.out.println("JhController recommendCallenge Start...");
		
		List<Challenge> recomChgList = jhCService.recomChgList(chg_md);
//			for (Challenge challenge : chgList) {
//			    System.out.println(challenge.getTitle());
//			}

		return recomChgList;
	}
		
	
	//챌린지 신청 등록
	@PostMapping(value = "chgApplication")
	public String chgApplication (@ModelAttribute Challenge chg, Model model,@RequestParam(value = "sampleImgFile", required = false) MultipartFile sampleImgFile, @RequestParam("thumbFile") MultipartFile thumbFile, HttpServletRequest request) throws IOException  {
		/*
		 * public String chgApplication (@RequestBody Challenge chg, Model
		 * model, @RequestParam(value = "sample_img", required = false) MultipartFile
		 * sample_img, HttpServletRequest request) throws IOException {
		 */		System.out.println("JhController chgApplication Start...");
		System.out.println("JhController chgApplication chg -> " + chg);		
		//유저 번호 저장
		HttpSession session = request.getSession();
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgApplication userNum -> " + userNum);
		} 
		chg.setUser_num(userNum);
		
		//공통코드 저장
		int chgLg = 200;
		chg.setChg_lg(chgLg);
		int stateLg = 300;
		chg.setState_lg(stateLg);
		int stateMd = 100;
		chg.setState_md(stateMd);
		
		
		  //저장 경로 생성 
		String uploadPath =  request.getSession().getServletContext().getRealPath("/upload/");
		  log.info("originalName: " + sampleImgFile.getOriginalFilename());
		  log.info("size: " +sampleImgFile.getSize()); log.info("contentType : " +  sampleImgFile.getContentType()); log.info("uploadPath : " + uploadPath);
		  
		 //진짜 저장 
		  //인증예시 사진
		  String sampleSaveName = uploadFile(sampleImgFile.getOriginalFilename(), sampleImgFile.getBytes(), uploadPath); 
		  chg.setSample_img(sampleSaveName);
		  
		  //썸네일
		  String thumbSaveName 	= null;
		  if(thumbFile != null && !thumbFile.isEmpty()) {
			  thumbSaveName = uploadFile(thumbFile.getOriginalFilename(), thumbFile.getBytes(), uploadPath); 
			  chg.setThumb(thumbSaveName);
		  } else {
			String chgDefaultImg = "assets/img/chgDfaultImg.png";
			chg.setThumb(chgDefaultImg);
		}
		 
		 log.info("Return sampleSaveName: " + sampleSaveName); model.addAttribute("sampleSaveName", sampleSaveName);
		 log.info("Return thumbSaveName: " + thumbSaveName); model.addAttribute("thumbSaveName", thumbSaveName);
		 
		 //챌린지 신청
		 int result = jhCService.chgApplication(chg);
		 
		 
			/* 챌린지 개설 될 경우 경험치 상승
			 * if(result > 0) { ls.userExp(userNum, chgLg, chg.getChg_md());
			 * ls.userLevelCheck(userNum); }
			 */
		 
		 
		 System.out.println("JhController chgApplication result -> " + result);
		 
		//임시로 챌린지 목록으로 이동하게 함
		//나중에 내가 신청한 챌린지 목록으로 이동할 것
		return "redirect:/mypage";
		
	}
	
//		Date start_date = chg.getStart_date();
//		Date end_date = chg.getEnd_date();
//		
	
	//파일 업로드용
	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws IOException {
		System.out.println("JhController uploadFile Start...");
		
		UUID uid = UUID.randomUUID();
		
		System.out.println("uploadPath" + uploadPath);
		
		//Directory 생성
		File fileDirectory = new File(uploadPath);
		if(!fileDirectory.exists()) {
			//신규폴더Directory 생성
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}
		
		String savedName = uid.toString() + "_" + originalName;
		log.info("savedName: " + savedName);
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	
	
	//후기 작성
	@RequestMapping(value = "reviewPost")
	public String reviewPost(Board board, HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file1, Model model) throws IOException {
		System.out.println("JhController reviewPost Start...");
		
		System.out.println("JhController chgApplication file -> " + file1);		
		
		int user_num = board.getUser_num();

		
		if (!file1.isEmpty()) {
			//저장 경로 생성
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			
			log.info("originalName: " + file1.getOriginalFilename());
			log.info("size: " +file1.getSize());
			log.info("contentType : " + file1.getContentType());
			log.info("uploadPath : " + uploadPath);
			
			//진짜 저장
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setImg(saveName);
			
			
			log.info("Return savedName: " + saveName);
			model.addAttribute("savedName", saveName);
			
		} 

		System.out.println("JhController chgApplication 이미지 -> " + board.getImg());		
		
			//후기 글 공통 코드 번호 셋팅
			board.setBrd_lg(700);
			board.setBrd_md(101);
		
			int lg = board.getBrd_lg();
			int md = board.getBrd_md();
		
			
			
			//글 등록
			int result = jhBrdService.reviewPost(board);
			
			if ( result > 0 ) {
				ls.userExp(user_num, lg, md);
				ls.userLevelCheck(user_num);
			}
			System.out.println("JhController chgApplication result -> " + result);		
			
			return "redirect:chgDetail?&chg_id="+board.getChg_id()+"&tap=3";
		
	}
	
	//후기 수정
	@RequestMapping(value = "reviewUpdate")
	// public String reviewUpdate(Board board, HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file1) throws IOException {
	public String reviewUpdate(Board board, HttpServletRequest request, MultipartFile file1) throws Exception {
		System.out.println("JhController reviewUpdate Start...");
		
		//파일값 확인용
		if(file1 != null && !file1.isEmpty()) {
			log.info("size: " +file1.getSize());
			System.out.println("file1 -> " + file1.isEmpty());
			System.out.println("img -> " + board.getImg());
		} else {
			System.out.println("file1 == null ");
		}
		
		//파일삭제 여부 확인용
		int delStatus = board.getDelStatus();
		System.out.println("delStatus -> " +delStatus);
		
		//파일 삭제를 위한 기초 작업
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
		String deleteFile = uploadPath + board.getImg();
		
		//새이미지 올린경우 (사용자가 기존 이미지 파일 삭제 유무와 관계 없이 이미지 대체) -> img에 새로운 파일명 대체
		if (file1 != null && !file1.isEmpty()) {
			
			
			//사용자가 파일을 새로 올리면 기존 이미지 먼저 삭제 처리
			int delResult= upFileDelete(deleteFile);
			System.out.println("delResult1 -> " + delResult);
			
			//사용자가 새로 올린 이미지 board dto에 Img에 저장
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setImg(saveName);
			
		//새이미지 올리지 않고 기존 이미지 파일 삭제 원한 경우(글만 남기는 경우) -> img에 null 셋팅
		} else if (file1 == null || file1.isEmpty() && delStatus == 1) {
			
			int delResult= upFileDelete(deleteFile);
			System.out.println("delResult2 -> " + delResult);
			board.setImg(null);
			
		}//새이미지 올리지 않고 기존 이미지 원하는 경우 board dto에 기존 img값 유지
		
		
		//진짜 이미지 및 글 업데이트
		int result = jhBrdService.reviewUpdate(board);
		
		System.out.println("result -> " + result);
		
		return "redirect:reviewContent?brd_num="+board.getBrd_num()+"&chg_id="+board.getChg_id();
	}


	//후기 삭제
	@RequestMapping(value = "reviewDelete")
	public String reviewDelete(int brd_num, int chg_id, String img, @RequestParam(required = false) Integer admin, HttpServletRequest request) throws Exception {
		
		//파라미터 : brd_num -> 이미지 삭제 위함, chg_id -> redirect로 이동하기 위함, img -> 이미지 삭제 위함
		//admin : 관리자에서 후기 삭제후 관리자 후기관리 페이지로 넘어가기 위한 파라미터
		
		System.out.println("JhController reviewDelete Start...");
		
		//글 삭제
		int reviewDel = jhBrdService.reviewDelete(brd_num);
		
		//글이 삭제 되면 이미지도 같이 삭제 
		if(reviewDel > 0) {
			
			//이미지 삭제를 위한 작업
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			String deleteFile = uploadPath + img;
			
			//실제 upload에 담김 파일 이미지 삭제
			int delResult= upFileDelete(deleteFile);
			
			System.out.println("JhController reviewDelete delResult -> " + delResult);
			
		}
		
		//admin이 없는 경우 사용자가 후기 삭제한 경우라 return이 챌린지 상세페이지 후기 목록으로 이동하는 것
		if(admin == null) {
			return "redirect:chgDetail?&chg_id=" + chg_id +"&tap=3";
		} else 
			//admin이 null이 아닌 경우는 관리자가 후기 삭제 하고 관리자가 후기 관리 목록으로 이동하는 것
			return "redirect:chgReviewAdmin?chg_id=" + chg_id;
	}

	
	
	
	
	//파일 삭제
	private int upFileDelete(String deleteFileName) throws Exception {
		int result = 0;
		log.info("upFileDelete result -> " + deleteFileName);
		File file = new File(deleteFileName);
		if (file.exists()) {
			if (file.delete()) {
				System.out.println("파일삭제 성공");
				result = 1;
				
			} 
			else {
				System.out.println("파일삭제 실패");
				result = 0;
			}
		} else {
			System.out.println("삭제할 파일이 존재하지 않습니다.");
			result = -1;
		}
		return result;
	}
	
	
	//챌린지 관리자 리스트
	@RequestMapping(value = "chgAdminList")
	public String chgAdminList(Challenge chg
							 , String currentPage
							 , @RequestParam(value = "sortOpt", required=false) String sortOpt
							 , Model model
							 , HttpSession session
							 ) {
		System.out.println("JhController chgAdminList Start...");
		System.out.println("키워드 --> "+ chg.getKeyword() );
		
		
		//전체 챌린지수와 리스트, 카테고리명(신청/진행/종료 공통)
		int totalChg 			= 0;
		List<Challenge> chgList = null;
		
		//카테고리 전체일 경우 chg_lg/chg_md = 0
		int chg_md 				= chg.getChg_md();
		int chg_lg 				= chg.getChg_lg();
		System.out.println("JhController chgAdminList state_md -> " + chg.getState_md());
		System.out.println("JhController chgAdminList sortOpt -> " + sortOpt);
		System.out.println("JhController chgAdminList chg_md --> " + chg_md);
		System.out.println("JhController chgAdminList chg_lg --> " + chg_lg);
		System.out.println("JhController chgAdminList chg_lg --> " + currentPage);
		
		//전체 카테고리 때문에 challenge.getChg_lg()로 안가져오고 chgLg를 따로 넣음 카테고리 가져올 때 lg, md, ctn 
		//첨에 lg안 가져오고 직접 int chg_lg = 200으로 해서 전체카테고리 할 때 찜순같은 필터가 적용이 안됨(일단  tcs.totalChgIng에서 chg_lg=200이라 조건을 타지만 chg_md값이 없어서 총 개수가 0이 나옴)
		int chgLg = 200;
		List<Comm> category 	= jhCService.category(chgLg);
		System.out.println("JhController chgAdminList category --> " + category);
		
		//진행상태(대분류는 따로 값을 넣는 부분이 없어서 뺌)
		int state_md 			= chg.getState_md();
		System.out.println("JhController chgAdminList state_md --> " + state_md);
		
		//페이지
		Paging page 			= null;
		
		
		//진행중,종료 챌린지일 경우
		if(chg.getState_md() == 102 || chg.getState_md() == 103) {
			
			//진행중 챌린지 총수
			if (chg.getState_md() ==102  ) {
				System.out.println("JhController chgAdminList 진행 챌린지 ");
				totalChg = tcs.totalChgIng(chg);
				System.out.println("JhController chgAdminList tcs.totalChgIng(challenge) --> " + totalChg);
				
				//종료 챌린지 총수
			} else if (chg.getState_md() == 103) {
				System.out.println("JhController chgAdminList 종료 챌린지 ");
				totalChg = tcs.totalChgFin(chg);
				System.out.println("JhController chgAdminList tcs.totalChgFin(challenge) --> " + totalChg);
			}
			
			
			//진행중,종료 공통 부분들
			//페이지네이션
			page = new Paging(totalChg, currentPage);
			//페이지 셋팅
			chg.setStart(page.getStart());
			chg.setEnd(page.getEnd());
			
			//조회 필터 셋팅(
			if(sortOpt != null) {
				chg.setSortOpt(sortOpt);
				System.out.println("JhController chgAdminList sortOption --> " + sortOpt);
			}
				
			//리스트
			chgList = tcs.listChg(chg);
			System.out.println("JhController chgAdminList listChg.size() --> " + chgList.size());
			System.out.println("JhController chgAdminList chg_lg --> " + chg.getChg_lg());
			System.out.println("JhController chgAdminList chg_md --> " + chg.getChg_md());

			
		//신청 /반려 챌린지인 경우	
		} else {
			System.out.println("JhController chgAdminList 신청 챌린지 ");
//			파라미터 chg_lg=200&state_lg=300&state_md=100
			totalChg = jhCService.chgListTotal(chg);
			System.out.println("JhController chgAdminList 신청/반려 개수--> " + totalChg);
			
			//페이지 네이션
			page = new Paging(totalChg, currentPage);
			//페이지 셋팅
			chg.setStart(page.getStart());
			chg.setEnd(page.getEnd());
			System.out.println("JhController chgAdminList page --> " + page);
			
			chgList = jhCService.chgAplList(chg);
			
			System.out.println("JhController chgAdminList 신청 listChg.size() --> " + chgList.size());
			System.out.println("JhController chgAdminList 신청 totalChg --> " + totalChg);
			
			
		}
		
		System.out.println("JhController chgAdminList page --> " + page);
		
		
		model.addAttribute("sortOpt", sortOpt); 	//필터(찜순, 최근등록순, 참여자순)
		model.addAttribute("totalChg", totalChg); 	//전체 챌린지 수 (신청/진행/종료 공통)
		model.addAttribute("chgList", chgList);		//챌린지 리스트 (신청/진행/종료 공통)
		model.addAttribute("page", page);			//페이지네이션  (신청/진행/종료 공통)
		model.addAttribute("category",category); 	//카테고리별 조회용
		model.addAttribute("state_md",state_md); 	//챌린지 진행 상태 중분류
		model.addAttribute("chg_lg", chg_lg); 		//챌린지 카테고리 대분류
		model.addAttribute("chg_md", chg_md); 		//챌린지 카테고리 중분류
		model.addAttribute("chg", chg); 		//챌린지 카테고리 중분류
		
		
		/*
		 * List<Challenge> chgAdminList = jhCService.chgAdminList(challenge);
		 * 
		 * //총합도 카테고리별, 진행상태별 조건으로 동적쿼리 만들어서 한번에 가져오기 int chgApcTotal = 0;
		 * 
		 * model.addAttribute("chgAdminList", chgAdminList);
		 */
		
//		if(challenge.getState_md() != 100) 
			return "jh/chgAdminList"; //진행/종료 챌린지 리턴
//		else return "jh/chgApplicationAdminList";					 //신청 챌린지 리턴
		
	}
	
	//챌린지 관리자 상세보기
	@RequestMapping(value = "chgAdminDetail")
	public String chgAdminDetail(
								  Challenge chg
								, HttpSession session
								, Model model
								, @RequestParam(value = "chgUpdateMode", required = false) String chgUpdateMode
								//, @RequestParam(value = "result", required = false) String result
								, @RequestParam(value = "currentPage", required = false) String currentPage
								, @RequestParam(value = "chg_lg", required = false) Integer chgLg
								) {
		//chgUpdateMode는 업데이트 페이지로 이동하기 위한 파라미터 0이면 일반 상세 페이지 1이면 업데이트용 페이지
		//result는 업데이트 후 다시 상세 페이지로 돌아와서 성공 유무 알리기 위한 파라미터 -> 지금은 처음 상세펭지 들어왔을 때 result 값이 없어서 발생하는 자바스크립트 오류 ㄷ때문에 삭제 시간 남으면 result 유무 따라 성공 유무 알리는 alert 창 만들 예정
		System.out.println("JhController chgAdminDetail Start...");
		
		System.out.println("JhController chgDetail chgLg -> " + chgLg);
		System.out.println("JhController chgDetail sortOpt -> " + chg.getSortOpt());
		System.out.println("JhController chgDetail keyword -> " + chg.getKeyword());
		
		

		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		} 
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user1 = userService.userSelect(userNum);
		System.out.println("JhController chgDetail userNum -> " + user1);
		model.addAttribute("user1", user1);
		
		//관리자 아닌 사용자면 레벨리스트 가져오기
		if(user1.getStatus_md() != 102) {
			model.addAttribute("level1List",ls.level1List());
		}
		
		//진행상태 중분류 - 신청/반려/진행/종료 모두 한 페이지에 표기하기 위한 것
		int state_md = chg.getState_md();
		
		
		//반려사유 종류
		int returnCategoryLd = 500;
		List<Comm> returnReason = jhCService.category(returnCategoryLd);
		model.addAttribute("returnReason", returnReason);
		System.out.println("JhController chgAdminDetail  returnReason --> " + returnReason);
		
		
		
		//필터 유무 판별용 -> 꼭 챌린지 상세 정보 가져 오기 전에 셋팅해야 함?
		String sortOpt = chg.getSortOpt();
		if(sortOpt == null) {
			sortOpt = "null";
		}
		model.addAttribute("sortOpt", sortOpt);
		
		
		//챌린지 id
		int chg_id = chg.getChg_id();
		System.out.println("JhController chgAdminDetail  chg_id --> " + chg_id);
		
		//검색정보 챌린지 상세정보 가져온 후 저장하기 위함
		String keyword = chg.getKeyword();
		//챌린지 상세 정보
		chg = jhCService.chgDetail(chg_id);
		chg.setKeyword(keyword); //챌린지 상세정보에 검색정보 저장
		System.out.println("JhController chgDetail chg -> " + chg);
		System.out.println("JhController chgDetail keyword -> " + chg.getKeyword());
		
		
		int chgrParti = ycs.selectChgrParti(chg_id);
		System.out.println("JhController chgDetail chgrParti -> " + chgrParti);
		model.addAttribute("chgrParti", chgrParti);
		
		model.addAttribute("chg", chg);
		model.addAttribute("state_md", state_md);
		System.out.println("JhController chgDetail state_md -> " + state_md);
		
		//승인/반려 후 currentPage가 null인경우 chgAdminDetail에서 목록, 삭제 버튼이 클릭되지 않는 문제 때문에 null일 경우 1로 셋팅함
		if(currentPage == null) {
			currentPage = "1";
		}
		model.addAttribute("currentPage", currentPage);
		
		//카테고리 선택 유무 판별용
		if(chgLg == null) {
			chgLg = 0;
		}
		model.addAttribute("chgLg", chgLg);

		
		if(chgUpdateMode==null) {
			chgUpdateMode = "0";
		}
		
		
		/////////관리자 업데이트용 페이지 이동/////////
		System.out.println("JhController chgDetail chgUpdateMode -> " + chgUpdateMode);
		if(chgUpdateMode.equals("1")) {
			System.out.println("JhController chgDetail 수정 페이지로 이동 ");
			
			//챌린지 카테고리 수정용 카테고리
			int chgCategoryLd = 200;
			List<Comm> category = jhCService.category(chgCategoryLd);
			
			model.addAttribute("category", category);

			//진행상태 리스트 가져오기 -> 진행상태 수정 못하게 해서 삭제 예정
			/*
			 * int stateMd = 300; List<Comm> stateMdCategory = jhCService.category(stateMd);
			 * model.addAttribute("stateMdCategory", stateMdCategory);
			 */
			
			//fmt 안쓰고 원하는 형식으로 표현하기 위함
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String end_date = dateFormat.format(chg.getEnd_date());			
			String reg_date = dateFormat.format(chg.getReg_date());
			String create_date = dateFormat.format(chg.getCreate_date());			
			
			model.addAttribute("end_date", end_date);
			model.addAttribute("reg_date", reg_date);
			model.addAttribute("create_date", create_date);
			
			
			//수정 화면으로 이동
			return "jh/jhChgAdminUpdateForm";
		}
		
		//수정 완료 후 돌아왔을 떄 결과 값 저장해서 수정 성공 여부  chgAdminDetail에서 alert 창 보여주기 위한 용도
		//model.addAttribute("result",result);
		
		return "jh/chgAdminDetail";
		
	}
	
	
	//승인반려 처리
	@RequestMapping(value = "approvReturn")
	public String approvReturn(int approvReturn, int chg_id, @RequestParam(required = false) Integer user_num, @RequestParam(required = false) Integer return_md) {
		System.out.println("JhController approvReturn Start...");
		System.out.println("JhController approvReturn approvReturn -> " + approvReturn);
		System.out.println("JhController approvReturn chg_id -> " 		+ chg_id);
		System.out.println("JhController approvReturn user_num -> " 	+ user_num);
		System.out.println("JhController approvReturn return_md-> " 	+ return_md);
		
		Map<String, Object> apvRtnParaMap = new HashMap<String, Object>();
		//승인
		if (approvReturn == 1) {
			
			//챌린저 테이블에 추가 할 user_num
			apvRtnParaMap.put("user_num", user_num);
			
		//반려
		} else {
			//챌린지 테이블에 업데이트 할 반려 사유 중분류
			apvRtnParaMap.put("return_md", return_md);
			
		}
		
		//승인/반려 선택 값
		apvRtnParaMap.put("approvReturn", approvReturn);
		
		//승인/반려 할 챌린지 pk 
		apvRtnParaMap.put("chg_id", chg_id);
		
		//실제 승인/반려 처리할 프로시저 호출
		int result = jhCService.approvReturn(apvRtnParaMap);
		
		System.out.println("JhController approvReturn result -> " + result);
		
		int stateMd = 0;
		//승인 반려 성공시
		if(result > 0) {
			//승인 반려 후 챌린지 진행 상태 가져 오기 위함
			//state_md를 파라미터로 받는 경우 승인/반려 처리 이전 진행상태이므로 chgAdminDetail로 리다이렉트 됐을 경우 승인/반려 이전 진행상태를 계속 가지고 가므로 승인/반려 처리 이후 새롭게 상태 정보 가져옴
			stateMd = jhCService.chgStateMd(chg_id);
		}
		
		System.out.println("JhController approvReturn state_md -> " + stateMd);
		//승인/반려 처리 후 기존  해당 챌린지 관리 상세 페이지로 이동
		return "redirect:chgAdminDetail?chg_id="+chg_id+"&state_md="+stateMd+"&chgUpdateMode='0'";
		
	}
	
	//챌린지 수정
	@RequestMapping(value = "/chgAdminUpdate")
	public String chgAdminUpdate(Challenge chg,  HttpServletRequest request,
			  @RequestParam(value = "sampleImgFile") MultipartFile sampleImgFile,
			  @RequestParam(value = "thumbFile", required = false) MultipartFile thumbFile) throws Exception {
		
		System.out.println("JhController chgAdminUpdate Start...");
		System.out.println("JhController chgAdminUpdate chg -> "+ chg);
		
		int chg_id = chg.getChg_id();
		int state_md = chg.getState_md();
		
		HttpSession session = request.getSession();
		int user_num = 0;
		int result = 0;
		int delResult = 0; //파일 삭제 정공 여부
		
		if(session.getAttribute("user_num") != null) {
			 			
			user_num = (int) session.getAttribute("user_num");
			User1 user = userService.userSelect(user_num);
			
			//썸네일 저장 안해서 기본 이미지 저장할 경우/기본이미지 저장되었는데 다른 썸네일 올린경우 기존 이미지 삭제해야 할 때 기본이미지 삭제되지 않도록 비교하기 위함
			String defaultImg = "assets/img/chgDfaultImg.png";
			
			/*************유저 권한 확인*************/
			if( user.getStatus_md() == 102) { //관리자면
				System.out.println("JhController 관리자 수정 Start...");
				
				String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
				/*************샘플이 바뀌었다면 기존 이미지 삭제 후 샘플 저장*************/
				if(sampleImgFile != null && !sampleImgFile.isEmpty()) {
					System.out.println("JhController sampleImgFile 널 아님 Start...");
					//기존 샘플이미지 파일 삭제 작업
					

					String deleteFile = uploadPath + chg.getSample_img();
						delResult= upFileDelete(deleteFile);
						System.out.println("delResult1 -> " + delResult);
					
					//새 샘플이미지 파일 업로드
					String saveName = uploadFile(sampleImgFile.getOriginalFilename(), sampleImgFile.getBytes(), uploadPath);
					chg.setSample_img(saveName);
				}else {
					chg.setSample_img(null);		
				}	
				
				System.out.println("JhController sampleImgFile 널이라 수정 안함 Start...");
				
				//썸네일 삭제 여부
				int delStatus = chg.getDelStatus();
				System.out.println("JhController chgAdminUpdate delStatus -> " + delStatus);
				/*************썸네일 기존 이미지 삭제 여부 확인*************/
				// 새 썸네일 업로드 한 경우
				if( thumbFile != null && !thumbFile.isEmpty()) {
					
					//새 썸네일 업로드 하면 기존 이미지 먼저 삭제 처리
					String deleteFile = uploadPath + chg.getThumb();
					delResult= upFileDelete(deleteFile);
					System.out.println("delResult2 -> " + delResult);
					
					//새로 올린 썸네일 저장
					String saveName = uploadFile(thumbFile.getOriginalFilename(), thumbFile.getBytes(), uploadPath);
					chg.setThumb(saveName);
					
				//썸네일 아예 없앤 경우	
				}else if (thumbFile == null || thumbFile.isEmpty() && delStatus == 1) {
					
					String deleteFile = uploadPath + chg.getThumb();
					delResult= upFileDelete(deleteFile);
					System.out.println("delResult3 -> " + delResult);
					
					chg.setThumb(defaultImg);
					
				} //기존 썸네일 유지
				
				
				System.out.println("JhController chgAdminUpdate priv_pswd -> "+ chg.getPriv_pswd());
				
				System.out.println("JhController 챌린지 진짜 수정 Start...");
				result = jhCService.chgAdminUpdate(chg);		
				
				
			}
		}
		
		System.out.println("JhController chgAdminUpdate result -> "+ result);
		
			return "redirect:chgAdminDetail?chg_id="+chg_id+"&state_md="+state_md+"&chgUpdateMode='0'"+"&result="+result;
	}
	
	
	@RequestMapping(value = "chgDelete")
	public String chgDelete(int chg_id 
						  , int state_md
						  , String thumb
						  , String sample_img
						  , HttpServletRequest request
						  ) throws Exception {
		System.out.println("JhController chgAdminDelete Start...");
		
		HttpSession session = request.getSession();
		int user_num = 0;
		int delResult = 0; 	//파일 삭제 성공 여부
		int result = 0; 	// 챌린지 삭제 성공 여부
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/"); //삭제를 위한 경로
		
		if(session.getAttribute("user_num") != null) {
			 	
			//원래 관리자만 삭제 가능하게 했다가 유저가 삭제하는 것도 같이 하려고 주석처리함
//			user_num = (int) session.getAttribute("user_num");
//			User1 user = userService.userSelect(user_num);
			
			//썸네일 저장 안해서 기본 이미지 저장할 경우/기본이미지 저장되었는데 다른 썸네일 올린경우 기존 이미지 삭제해야 할 때 기본이미지 삭제되지 않도록 비교하기 위함--없어도 되는 듯
			//String defaultImg = "assets/img/chgDfaultImg.png";
			
			/*************유저 권한 확인*************/
			//if( user.getStatus_md() == 102 ) { //관리자면
				
				//예시사진 삭제
				if(sample_img != null && !sample_img.isEmpty() ) {
					String deleteFile = uploadPath + sample_img;
					delResult = upFileDelete(deleteFile);
				}
				
				//예시 사진 삭제 실패하지 않은 경우 썸네일 삭제
				if(delResult != 0) {
					
					if(thumb != null && !thumb.isEmpty() ) {
						
						String deleteFile = uploadPath + thumb;
						delResult = upFileDelete(deleteFile);
						
						//썸네일 삭제에 실패하지 않은 경우 챌린지 삭제(삭제할 파일 없는 경우는 -1)
						if(delResult != 0) {
							//챌린지 삭제
							result = jhCService.chgDelete(chg_id);
							System.out.println("JhController chgAdminUpdate result -> "+ result);
						}
					}
				}
			//}
		}
		
		return "redirect:chgAdminList?state_md=" + state_md;
		
	}
	
	//후기 관리
	@RequestMapping(value = "chgReviewAdmin")
	public String chgReviewAdmin(Model model, Challenge chg, Board board, HttpSession session, String currentPage) {
		System.out.println("JhController boardImgDelete Start...");
		//파라미터 chg_id로 후기(board)리스트 가져옴
		
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgReviewAdmin userNum -> " + userNum);
		} 
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController chgReviewAdmin userNum -> " + user);
		model.addAttribute("user", user);
		
		//챌린지 번호
		int chg_id = chg.getChg_id();
		
		//후기 원글 제목
		String title = chg.getTitle();
		model.addAttribute("title",title);
		
		System.out.println("JhController chgReviewAdmin title -> " + title);
		System.out.println("JhController chgReviewAdmin chg_id -> " + chg_id);
		
		chg = jhCService.chgDetail(chg_id);
		
		//진행상태(챌린지 관리자 리스트로 돌아가기 위함)
		int state_md = chg.getState_md();
		model.addAttribute("state_md",state_md);
		
		
		//후기 총 개수
		int reviewTotal = jhBrdService.reviewTotal(chg_id);
		model.addAttribute("reviewTotal", reviewTotal);
		System.out.println("JhController chgReviewAdmin  reviewTotal -> "+ reviewTotal);
		
		//페이지네이션
		Paging reviewPage = new Paging(reviewTotal, currentPage);
		board.setStart(reviewPage.getStart());
		board.setEnd(reviewPage.getEnd());
		model.addAttribute("reviewPage",reviewPage);
		System.out.println("JhController chgReviewAdmin  reviewPage.getStart() -> "+ reviewPage.getStart());
		System.out.println("JhController chgReviewAdmin  reviewPage.getTotal() -> "+ reviewPage.getTotal());
		System.out.println("JhController chgReviewAdmin  board.getChg_id() -> "+ board.getChg_id());
		
		//후기 목록 조회
		List<Board> chgReviewList = jhBrdService.chgReviewList(board);
		chgReviewList = userService.boardWriterLevelInfo(chgReviewList);
		model.addAttribute("chgReviewList", chgReviewList);
		
		model.addAttribute("chg", chg);
		
		return "jh/jhChgReviewAdminList";
	}
	
	//댓글 관리
	@RequestMapping(value = "replyAdminList")
	public String replyAdminList(Board board, String currentPage, Model model, HttpSession session) {
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController replyAdminList userNum -> " + userNum);
		} 
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController replyAdminList userNum -> " + user);
		model.addAttribute("user", user);
		
		//brd_num은 원글 글번호
		int brd_num = board.getBrd_num();
		System.out.println("JhController replyAdminList  brd_num -> "+ brd_num);
		System.out.println("JhController replyAdminList  currentPage -> "+ currentPage);
		
		//챌린지 후기 원글 내용 조회
		Board reviewContent = jhBrdService.reviewContent(brd_num);
		//후기 원글 번호
		model.addAttribute("brd_num", brd_num);
		//챌린지 번호
		int chg_id = board.getChg_id();
		model.addAttribute("chg_id", chg_id);
		
		//후기 원글 제목(목록버튼 클릭시 후기글로 돌아가기 위함)
		String title = board.getTitle();
		System.out.println("JhController replyAdminList  title -> "+ title);
		model.addAttribute("title", title);
		
		//후기글 총 댓글 수
		int replyCount = reviewContent.getReplyCount();
		model.addAttribute("replyCount", replyCount);
		
		//페이지네이션
		Paging replyPage = new Paging(replyCount, currentPage);
		board.setStart(replyPage.getStart());
		board.setEnd(replyPage.getEnd());
		model.addAttribute("replyPage",replyPage);
		System.out.println("JhController replyAdminList  replyPage.getStart() -> "+ replyPage.getStart());
		System.out.println("JhController replyAdminList  replyPage.getTotal() -> "+ replyPage.getTotal());
		System.out.println("JhController replyAdminList  board.getChg_id() -> "+ board.getChg_id());
		System.out.println("JhController replyAdminList  currentPage -> "+ replyPage.getCurrentPage());
		
		//챌린지 해당 글에 대한 댓글 조회
		List<Board> reviewReplyList = jhBrdService.reviewReplyList(board);
		reviewReplyList = userService.boardWriterLevelInfo(reviewReplyList);
		model.addAttribute("reviewContent", reviewContent);
		model.addAttribute("reviewReplyList", reviewReplyList);
		
		return "jh/jhChgReplyAdminList";
		
	}
	
	//댓글 관리에 필요한거
//	int brd_num = board.getBrd_num();
//	System.out.println("JhController reviewContent brd_num -> " + brd_num);
//	//후기 글 조회수 +1
//	jhBrdService.viewCntUp(brd_num);
//	
//	//챌린지 후기글 내용 조회
//	Board reviewContent = jhBrdService.reviewContent(brd_num);
//	
//	//후기글 총 댓글 수
//	int replyCount = reviewContent.getReplyCount();
//	
//	//페이지네이션
//	Paging replyPage = new Paging(replyCount, currentPage);
//	board.setStart(replyPage.getStart());
//	board.setEnd(replyPage.getEnd());
//	model.addAttribute("replyPage",replyPage);
//	System.out.println("JhController reviewContent  replyPage.getStart() -> "+ replyPage.getStart());
//	System.out.println("JhController reviewContent  replyPage.getTotal() -> "+ replyPage.getTotal());
//	System.out.println("JhController reviewContent  board.getChg_id() -> "+ board.getChg_id());
//	
//	//챌린지 해당 글에 대한 댓글 조회
//	List<Board> reviewReplyList = jhBrdService.reviewReplyList(board);
//	reviewReplyList = userService.boardWriterLevelInfo(reviewReplyList);
//	
//	// challenger 참여 유무 판단용
//	Challenger chgr = new Challenger();
//	chgr.setUser_num(userNum);
//	chgr.setChg_id(chg_id);
//	int chgrJoinYN = ycs.selectChgrJoinYN(chgr);
//	System.out.println("JhController chgDetail chgrJoinYN -> " + chgrJoinYN);
//	model.addAttribute("chgrYN", chgrJoinYN);
//	
//	
//	System.out.println("JhController reviewContent reviewContent -> " + reviewContent);
//	System.out.println("JhController reviewContent reviewReply -> " + reviewReplyList);
//	model.addAttribute("reviewContent", reviewContent);
//	model.addAttribute("reviewReply", reviewReplyList);
//	model.addAttribute("chg_id", chg_id);
//	
//	//댓글 수정
//	if ( rep_brd_num != null ) {
//		String flag = "flag";
//		model.addAttribute("flag", flag);
//		model.addAttribute("rep_brd_num", rep_brd_num);
//		System.out.println("JhController reviewContent flag -> " + flag);
//		System.out.println("JhController reviewContent rep_brd_num -> " + rep_brd_num);
//	}
//	
//	
//	//댓글 삭제/업데이트 결과정보 전달
//	model.addAttribute("result", result);
//	System.out.println("JhController reviewContent result -> " + result);
//	
	
	
	
	
	
	
	
	/*
	 * @RequestMapping(value = "modify") public String modify() {
	 * 
	 * return "jh/modify"; }
	 */
	
	
	/*
	 * @Data public class RecommendChg { private int chg_id; private String title;
	 * private String thumb;
	 * 
	 * }
	 * 
	 * 
	 * 
	 * @Data private static class Result { private final List<?> List; private final
	 * int listSize; }
	 */
	
	
	
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "boardImgDelete") public String boardImgDelete(int
	 * brd_num, String img, HttpServletRequest request) throws Exception {
	 * System.out.println("JhController boardImgDelete Start...");
	 * 
	 * 
	 * //해당글의 이미지 디비에서 null로 만듦 int brdImgDel = jhCService.boardImgDelete(brd_num);
	 * String delStatusStr = null; if ( brdImgDel > 0 ) {
	 * 
	 * //upload에 담김 파일 삭제 String uploadPath =
	 * request.getSession().getServletContext().getRealPath("/upload/"); String
	 * deleteFile = uploadPath + img; int delResult = upFileDelete(deleteFile);
	 * delStatusStr = Integer.toString(delResult);
	 * 
	 * System.out.println("JhController boardImgDelete delResult -> " + delResult);
	 * }
	 * 
	 * return delStatusStr; }
	 */
	 
	
}
