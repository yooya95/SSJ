package com.oracle.S202350102.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.net.http.HttpHeaders;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONArray;
import org.springframework.beans.propertyeditors.URLEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.jkService.JkBoardService;
import com.oracle.S202350102.service.main.Level1Service;
import com.oracle.S202350102.service.main.UserService;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.SharingList;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.yaService.YaCommunityService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class YaController {

	private final YaCommunityService ycs;
	private final JkBoardService jbs;
	private final UserService us;
	private final Level1Service ls;

	// 커뮤니티 게시글 전체조회
	@RequestMapping(value = "/listCommunity")
	public String listCommunity(Board board, Model model, String currentPage) {
		System.out.println("YaController listCommunity start....");
		String keyword = board.getKeyword();
		int totalCommunity = 0;

		// 전체 게시글 총 수
		if (keyword != null) {
			totalCommunity = ycs.countSearch(keyword);
		} else {
			totalCommunity = ycs.totalCommunity(board);
		}
		System.out.println(totalCommunity);
		model.addAttribute("totalCommunity", totalCommunity);
		System.out.println("YaContorller totalCommunity->" + totalCommunity);

		// 페이징처리
		Paging boardPage = new Paging(totalCommunity, currentPage);
		board.setStart(boardPage.getStart());
		board.setEnd(boardPage.getEnd());
		model.addAttribute("boardPage", boardPage);
		System.out.println(" YaController boardPage start?" + boardPage.getStart());
		System.out.println(" YaControlloer boardpage total?" + boardPage.getTotal());
		System.out.println("boardPage End?" + boardPage.getEnd());

		List<Board> listCommunity = null;
		if (keyword != null) {
			listCommunity = ycs.listSearchBoard(keyword, currentPage);
		} else {
			listCommunity = ycs.listCommunity(board);
		}

		// 한빛 : 리스트에 유저정보 추가하는 메소드
		listCommunity = us.boardWriterLevelInfo(listCommunity);
		System.out.println("YaController list listCommunity.size()?" + listCommunity.size());
		model.addAttribute("listCommunity", listCommunity);
		model.addAttribute("keyword", keyword);

		return "listCommunity";
	}

	// 게시글 제목을 누르면 자세히 보기
	@GetMapping(value = "detailCommunity")
	public String detailCommunity(@RequestParam("brd_num") int brd_num, Model model, HttpSession session) {
		System.out.println("YaController Start detailCommunity start...");

		Board board = ycs.detailCommunity(brd_num);
		// 게시글 댓글수 후가시
		int replyCount = ycs.commentCount(brd_num);

		board.setReplyCount(replyCount);
		board.setBrd_group(board.getBrd_num());

		// 로그인 상태 확인
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}

		// 조회수 증가
		int upViewCnt = 0;
		ycs.upViewCnt(brd_num);

		System.out.println("YaController  commentCount replyCount?" + replyCount);

		model.addAttribute("board", board);
		model.addAttribute("upViewCnt", upViewCnt);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("loggedIn", user_num != 0);

		System.out.println("replyCount:" + board.getReplyCount());
		System.out.println("user_num:" + board.getUser_num());
		System.out.println("sessionScope.usernum: " + session.getAttribute("user_num"));

		return "ya/detailCommunity";
	}

	// 커뮤니티 게시글 작성폼으로 이동
	@RequestMapping(value = "/writeFormCommunity")
	public String writeFormCommunity(Board board, HttpSession session, Model model) {
		System.out.println("YaController writeFormCommunity Start... ");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");

			User1 user1 = ycs.userSelect(user_num);
			model.addAttribute("user1", user1);

		}
		return "ya/writeFormCommunity";

	}

	// 게시글 작성 (************************************진기 파일업로드)
	@PostMapping(value = "/writeCommunity")
	public String insertCommunity(Board board, HttpServletRequest request, HttpSession session,
			@RequestParam(value = "file", required = false) MultipartFile file1) throws IOException {
		System.out.println("YaController start insertCommunity... ");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		board.setUser_num(user_num);

		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/"); // 저장경로 생성
		System.out.println("realPath" + uploadPath);
		log.info("originalName : " + file1.getOriginalFilename());

		String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath); // 진짜 저장
		board.setImg(saveName);
		System.out.println("brd_md->" + board.getBrd_md());
		int result = ycs.insertCommunity(board);
		System.out.println("Insert result->" + result);

		// 한빛 : 자유게시판 글작성 시 유저의 경험치가 오르는 로직
		// 많이 쓸것같으면 메소드로 만들어서 쓸 것.
		if (result > 0) {
			ls.userExp(user_num, 700, 103); // lg, mg 값을 넣어야함 자유게시판은 700,103
			ls.userLevelCheck(user_num); // 경험치가 올랐기 때문에 현재 레벨이 맞는지 체크하는 메소드
		}

		return "redirect:listCommunity";

	}

	// 파일 업로드 (************************************진기)
	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws IOException {
		UUID uid = UUID.randomUUID();
		System.out.println("uploadPath->" + uploadPath);
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdirs();
			System.out.println("시스템 업로드용 폴더 생성 :" + uploadPath);
		}

		String savedName = uid.toString() + "_" + originalName;
		log.info("saveName : " + savedName);
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);

		return savedName;
	}

	// 게시글 수정폼이동
	@GetMapping(value = "/updateCommunityForm")
	public String updateCommunity(int brd_num, Model model, HttpSession session) {
		System.out.println("YaController updaetCommunityForm start...");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}

		Board board = ycs.detailCommunity(brd_num);
		model.addAttribute("board", board);

		User1 user1 = jbs.userSelect(user_num);
		model.addAttribute("user1", user1);

		// 수정전
		System.out.println("title :" + board.getTitle());
		System.out.println("conts :" + board.getConts());

		model.addAttribute("board", board);

		return "ya/updateCommunityForm";
	}

	// 게시글 수정 (파일업로드 진기)
	@PostMapping(value = "/updateCommunity")
	public String updateCommunity(HttpSession session, User1 user1, Model model, Board board,
			HttpServletRequest request, @RequestParam(value = "file1", required = false) MultipartFile file1)
			throws IOException {
		System.out.println("YaController updateCommunity start...");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		user1.setUser_num(user_num);

		ServletContext servletContext = request.getSession().getServletContext();
		String realPath = servletContext.getRealPath("/upload/");
		System.out.println("realPath->" + realPath);

		if (file1 != null) {
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), realPath); // 진짜 저장

			board.setImg(saveName);
		}

		int updateCommunity = ycs.updateCommunity(board);

		System.out.println("YaController ycs.updateCommunity updateBoard updateCommunity?" + updateCommunity);
		model.addAttribute("updateResult", updateCommunity);
		// 수정후
		System.out.println("title update:" + board.getTitle());
		System.out.println("conts update:" + board.getConts());
		System.out.println("updateResult->" + updateCommunity);

		if (updateCommunity > 0) {

			return "redirect:/listCommunity";
		} else {
			model.addAttribute("msg", "수정 실패 확인해 보세요");
			return "forward:/mypage.jsp";
		}
	}

	// 게시글 삭제
	@GetMapping(value = "/deleteCommunity")
	public String deleteCommuinty(int brd_num, Model model) {

		int deleteResult = ycs.deleteCommunity(brd_num);
		System.out.println("YaController ycs.deleteCommunity start....");

		return "redirect:listCommunity";

	}

	// 자유게시판 게시글조건(이름,제목)검색 -> 객체로 변경해야 json 형식으로 데이터 반환 가능
	@GetMapping(value = "/listBoardSearch", produces = "application/json")
	@ResponseBody
	public Map<String, Object> listBoardSearch(HttpServletRequest request, @RequestParam String currentPage) {
		System.out.println("YaController ycs.listSearchBoardart....");
		String keyword = request.getParameter("keyword");
		System.out.println("사용자 검색한 키워드: " + keyword);

		int countSearch = ycs.countSearch(keyword);
		System.out.println("YaController countSearch(keyword):" + countSearch);

		// 페이징 처리
		Paging boardPage = new Paging(countSearch, currentPage);
		List<Board> listSearchBoard = ycs.listSearchBoard(keyword, currentPage);

		int startNum = countSearch - boardPage.getStart() + 1;
		int endNum = countSearch - boardPage.getEnd();

		// 한빛 : 유저의 레벨정보를 불러오는 메소드
		listSearchBoard = us.boardWriterLevelInfo(listSearchBoard);
		System.out.println("YaController listSearchBoard.size?" + listSearchBoard.size());

		// 검색 결과와 페이징 정보를 클라이언트에게 전달
		Map<String, Object> response = new HashMap<>();
		response.put("listSearchBoard", listSearchBoard);
		response.put("boardPage", boardPage);
		response.put("startNum", startNum);
		response.put("endNum", endNum);

		return response;
	}

	@GetMapping("/listBoardSort")
	@ResponseBody
	public Map<String, Object> listBoardSort(HttpServletRequest request, Board board,
			@RequestParam String currentPage) {
		System.out.println("YaController ycs.listBoardSort start....");
		String sortOption = request.getParameter("sort");
		int totalCommunity = ycs.totalCommunity(board);
		// 페이징 처리
		Paging boardPage = new Paging(totalCommunity, currentPage);

		int startNum = totalCommunity - boardPage.getStart() + 1;
		int endNum = totalCommunity - boardPage.getEnd() + 1;

		int start = boardPage.getStart();
		int end = boardPage.getEnd();

		List<Board> listSortedBoard = ycs.listBoardSort(sortOption, start, end);
		System.out.println("YaController listBoardSort size?" + listSortedBoard.size());

		// 한빛 : 리스트에 유저정보 추가하는 메소드
		listSortedBoard = us.boardWriterLevelInfo(listSortedBoard);

		// 페이징 정보를 클라이언트에게 전달
		Map<String, Object> response = new HashMap<>();
		response.put("listSortedBoard", listSortedBoard);
		response.put("boardPage", boardPage);
		response.put("startNum", startNum);
		response.put("endNum", endNum);

		return response;
	}

	// 상세 게시글 댓글 조회
	@RequestMapping(value = "/listComment", method = RequestMethod.GET)
	@ResponseBody
	public List<Board> listComment(@RequestParam("brd_num") int brd_num, Model model, Board board) {
		System.out.println("YaController ycs.listComment start....");

		List<Board> listComment = ycs.listComment(brd_num);
		model.addAttribute(" listCommenty", listComment);
		board.setBrd_group(brd_num);

		System.out.println("YaController listComment size?" + listComment.size());
		System.out.println("YaController listComment brd_group?" + board.getBrd_group());
		return listComment;
	}

	// 게시글 댓글 작성
	@RequestMapping("/commentWrite")
	@ResponseBody
	public Map<String, String> commentWrite(HttpSession session, HttpServletRequest request,
			@ModelAttribute Board board) {
		Map<String, String> response = new HashMap<>();

		try {
			System.out.println("YaController ycs.commentWrite start....");

			int user_num = 0;
			if (session.getAttribute("user_num") != null) {
				user_num = (int) session.getAttribute("user_num");
				board.setUser_num(user_num);

				int brd_num = Integer.parseInt(request.getParameter("brd_num"));

				board.setBrd_group(brd_num);
				board.setBrd_lg(700);

				// 부모 게시물의 댓글 중 가장 큰 brd_step을 가져와 1을 더해 새로운 댓글의 brd_step으로 설정
				try {
					int brd_group = board.getBrd_num();
					int latestBrdStep = ycs.getLatestBrdStep(brd_group);
					board.setBrd_step(latestBrdStep + 1);

				} catch (NumberFormatException e) {
					e.printStackTrace();
					// 실패한 경우
					response.put("result", "failure");
					response.put("error", "Invalid brd_num format");
				}
				ycs.commentWrite(board);
				System.out.println("conts:" + board.getConts());
				// 성공한 경우
				response.put("result", "success");
				response.put("redirectUrl", "/ya/commentForm?brd_num=" + board.getBrd_num());
			} else {
				// 사용자가 로그인되지 않은 경우
				response.put("result", "failure");
				response.put("error", "User not logged in");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 실패한 경우
			response.put("result", "failure");
			response.put("error", "An error occurred");
		}

		return response;
	}

	// 게시글 댓글 수정
	@PostMapping(value = "/commentUpdate")
	@ResponseBody
	public Map<String, Object> commentUpdate(HttpSession session, @RequestParam("brd_num") int brd_num,
			@RequestParam("conts") String conts, @ModelAttribute Board board) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println("YaController ycs.commentUpdate start...");

			int user_num = 0;
			if (session.getAttribute("user_num") != null) {
				user_num = (int) session.getAttribute("user_num");

				board.setUser_num(user_num);
				board.setBrd_num(brd_num);
				board.setConts(conts);

				// 댓글 업데이트 메소드 호출
				ycs.commentUpdate(board);

				// 댓글 정보 확인
				System.out.println("session.getAttributeuser_num?" + session.getAttribute("user_num"));
				System.out.println("board 댓글 수정후 conts?" + board.getConts());
				System.out.println("board brd_num?" + board.getBrd_num());
				System.out.println("board user_num?" + board.getUser_num());

				map.put("result", "success");

			} else {
				// 사용자가 로그인되지 않은 경우
				map.put("result", "failure");
				map.put("error", "User not logged in");
			}
		} catch (Exception e) {
			System.out.println("YaController commentUpdate e.getMessage()" + e.getMessage());
			// 실패한 경우
			map.put("result", "failure");
			map.put("error", "An error occurred");
		}

		return map;
	}

	// 게시글 댓글 삭제
	@PostMapping(value = "/commentDelete")
	@ResponseBody
	public Map<String, Object> commentDelete(HttpSession session, @RequestParam("brd_num") int brd_num,
			@ModelAttribute Board board) {

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println("YaController ycs.commentDelete start...");

			int user_num = 0;
			if (session.getAttribute("user_num") != null) {
				user_num = (int) session.getAttribute("user_num");
				board.setUser_num(user_num);

				ycs.commentDelete(board);

				System.out.println("YaController commentDelete  board brd_num?" + board.getBrd_num());
				System.out.println("YaController commentDelete board user_num?" + board.getUser_num());
			}

		} catch (Exception e) {
			System.out.println("YaControllercommentDelete e.getMessage()" + e.getMessage());
		}

		return map;

	}

	// sharing 참가 신청 모달창 값 전달
	@GetMapping(value = "/sharingParticipate")
	@ResponseBody // 해당 데이터 반환@ResponseBody // 해당 데이터 반환
	public Map<String, Object> sharingParticipate(HttpSession session, Model model,
			@RequestParam("user_num") int user_num, @RequestParam("brd_num") int brd_num) {

		System.out.println("YaController sharingParticipate start...");
		System.out.println("Received user_num: " + user_num);
		System.out.println("Received brd_num: " + brd_num);

		Map<String, Object> result = new HashMap<>();

		// detailSharing 메서드를 통해 Board 객체를 얻어옴
		Board board = jbs.detailSharing(brd_num);

		// Board 객체에 brd_num과 user_num 설정
		board.setBrd_num(brd_num);
		System.out.println("board brd_num ?" + board.getBrd_num());

		model.addAttribute("board", board);

		if (session.getAttribute("user_num") != null) {
			User1 user1 = ycs.userSelect(user_num);
			model.addAttribute("user1", user1);

			result.put("user1", user1);
			result.put("board", board);
			result.put("status", "success");
		} else {
			result.put("status", "error");
		}

		return result;
	}

	// sharing 참가자 등록 데이터 save --> sharingList 똑같은 USER_NUM , 모집인원 마감시 알림창 띄우기
	@PostMapping(value = "/saveSharingInfo")
	@ResponseBody
	public Map<String, String> saveSharingInfo(@RequestBody Map<String, Object> requestBody,
			@ModelAttribute SharingList sharingList) {
		int user_num = Integer.parseInt(requestBody.get("user_num").toString());
		int brd_num = Integer.parseInt(requestBody.get("brd_num").toString());
		String message = (String) requestBody.get("message");

		// 이렇게 하면 안됨...
		/*
		 * public Map<String, String> saveSharingInfo(
		 * 
		 * @RequestParam("user_num") int user_num,
		 * 
		 * @RequestParam("brd_num") int brd_num,
		 * 
		 * @RequestParam("message") String message,
		 * 
		 * @ModelAttribute SharingList sharingList ) {
		 */

		System.out.println("YaController saveSharingInfo start...");
		System.out.println("received user_num?" + user_num);

		Board board = jbs.detailSharing(brd_num);

		sharingList.setBrd_num(board.getBrd_num());
		sharingList.setMessage(message);
		sharingList.setUser_num(user_num);

		System.out.println("brd_num:" + sharingList.getBrd_num());
		System.out.println("message:" + sharingList.getMessage());
		System.out.println("user_num:" + sharingList.getUser_num());

		int saveResult = ycs.saveSharing(sharingList);
		Map<String, String> result = new HashMap<>();

		if (saveResult > 0) {

			result.put("status", "success");

		} else {
			result.put("status", "error");
		}
		result.put("status", "success");

		return result;
	}

	// 마이페이지 쉐어링 관리 - 내가 올린 쉐어링(myuploadSharing), 내가 참가한 쉐어링(myJoinSharing)
	@RequestMapping(value = "/sharingManagement")
	public String SharingManagement(HttpSession session, Board board, SharingList sharingList, Model model,
			@RequestParam(name = "currentPage", defaultValue = "1") String currentPage, HttpServletRequest request) {

		System.out.println("YaController myUploadSharingList start...");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = us.userSelect(user_num);
			model.addAttribute("user1", user1);

			int totalMyUploadsharing = 0;
			totalMyUploadsharing = ycs.totalMyUploadsharing(user_num);
			model.addAttribute("totalMyUploadSharing", totalMyUploadsharing);
			System.out.println("YaController totalMyUploadShairng->" + totalMyUploadsharing);

			// 페이징처리
			Paging myUploadSharingPaging = new Paging(totalMyUploadsharing, currentPage, 3);
			board.setUser_num((int) session.getAttribute("user_num"));
			board.setStart(myUploadSharingPaging.getStart());
			board.setEnd(myUploadSharingPaging.getEnd());
			model.addAttribute("myUploadSharingPaging", myUploadSharingPaging);
			System.out.println("YaController myUploadSharingPage start?" + myUploadSharingPaging.getStart());
			System.out.println(" YaControlloermyUploadSharingPaging total?" + myUploadSharingPaging.getTotal());
			System.out.println("myUploadSharingPaging End?" + myUploadSharingPaging.getEnd());

			// myUploadShairngList
			List<Board> myUploadSharingList = ycs.myUploadSharingList(board);
			System.out.println("YaController sharingManagement.size()?" + myUploadSharingList.size());
			model.addAttribute("myUploadSharingList", myUploadSharingList);

			// myJoinSharingListt 게시글 총 수
			// -----------------------------------------------------------------------------
			int totalJoinSharing = 0;
			totalJoinSharing = ycs.totalJoinSharing(user_num);
			System.out.println("YaController totalJoinSharing->" + totalJoinSharing);

			// 페이징처리
			Paging myJoinSharingPaging = new Paging(totalJoinSharing, currentPage, 3);
			sharingList.setUser_num((int) session.getAttribute("user_num"));
			sharingList.setStart(myJoinSharingPaging.getStart());
			sharingList.setEnd(myJoinSharingPaging.getEnd());
			model.addAttribute("myJoinSharingPaging", myJoinSharingPaging);

			System.out.println("YaController myJoinSharingPaging start?" + myJoinSharingPaging.getStart());
			System.out.println(" YaControlloermyJoinSharingPaging total?" + myJoinSharingPaging.getTotal());
			System.out.println("myJoinSharingPaging End?" + myJoinSharingPaging.getEnd());

			// myJoinSharingList 조회
			List<SharingList> myJoinSharingList = ycs.myJoinSharingList(sharingList);
			System.out.println("YaController myJoinSharingList.size()?" + myJoinSharingList.size());
			model.addAttribute("myJoinSharingList", myJoinSharingList);
			/*
			 * currentPage=request.getParameter("currentPage");
			 * currentPage=request.getParameter(currentPage);
			 * System.out.println("currentPage="+currentPage);
			 * 
			 * //myConfirmSharingList 게시글 총 수
			 * -----------------------------------------------------------------------------
			 * int totalConfirmSharing = 0; totalConfirmSharing =
			 * ycs.totalConfirmSharing(user_num);
			 * System.out.println("YaController totalConfirmSharing->"+totalConfirmSharing);
			 * 
			 * //페이징처리 Paging myConfirmSharingPaging = new Paging(totalConfirmSharing,
			 * currentPage, 3); board.setUser_num((int) session.getAttribute("user_num"));
			 * board.setStart(myConfirmSharingPaging.getStart());
			 * board.setEnd(myConfirmSharingPaging.getEnd());
			 * model.addAttribute("myConfirmSharingPaging" , myConfirmSharingPaging);
			 * System.out.println("YaController myConfirmSharingPaging start?"
			 * +myConfirmSharingPaging.getStart());
			 * System.out.println(" YaControlloer myConfirmSharingPaging total?"
			 * +myConfirmSharingPaging.getTotal());
			 * System.out.println("myConfirmSharingPaging End?"+myConfirmSharingPaging.
			 * getEnd());
			 * 
			 * //myConfirmSharingList 조회 List<Board> myConfirmSharingList =
			 * ycs.myConfirmSharingList(board);
			 * System.out.println("YaController myConfirmSharingList.size()?"
			 * +myConfirmSharingList.size()); model.addAttribute("myConfirmSharingList",
			 * myConfirmSharingList); model.addAttribute("level1List",ls.level1List());
			 * 
			 */

		}

		return "ya/mySharingManagement";

	}

	// 승인완료된 쉐어링 조회
	@GetMapping("/myConfirmSharingList")
	@ResponseBody
	public Map<String, Object> myConfirmSharingList(HttpServletRequest request, HttpSession session, Model model,
			Board board, SharingList sharingList) {
		System.out.println("YaController ycs.myConfirmSharingList start...");

		String currentPage = request.getParameter("currentPage");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = us.userSelect(user_num);
			model.addAttribute("user1", user1);
		}

		// myConfirmSharingList 게시글 총 수
		// -----------------------------------------------------------------------------
		int totalConfirmSharing = 0;
		totalConfirmSharing = ycs.totalConfirmSharing(user_num);
		System.out.println("YaController totalConfirmSharing->" + totalConfirmSharing);

		Paging paging = new Paging(totalConfirmSharing, currentPage);
		List<Board> myConfirmSharingList = ycs.myConfirmSharingList(paging.getStart(), paging.getEnd());

		Map<String, Object> result = new HashMap<>();
		result.put("customerSearchList", myConfirmSharingList);
		result.put("paging", paging);

		return result;
	}
	
	// 마이페이지 쉐어링 관리 - 내가 올린 쉐어링 에서 참가자 리스트 조회 (sharingParticipantsInfo)

	@GetMapping(value = "/sharingParticipantsInfo")
	@ResponseBody
	public List<SharingList> sharingParticipantsList(@RequestParam("brd_num") int brd_num, Model model) {
		System.out.println("YaController sharingParticipantsInfo start..");

		System.out.println("Ya sharingParticipantsInfo Received brd_num: " + brd_num);

		List<SharingList> sharingParticipantsList = ycs.sharingParticipantsList(brd_num);
		model.addAttribute("sharingParticipantsList", sharingParticipantsList);

		return sharingParticipantsList;
	}

	// 마이페이지 쉐어링 관리(내가 올린 쉐어링)-참가자 승인(state_md:101 업데이트), board의 participants가 1씩 증가
	@PostMapping("/sharingConfirm")
	@ResponseBody
	public Map<String, Object> sharingConfirm(@RequestParam("brd_num") int brd_num,
			@RequestParam("user_num") int user_num, @ModelAttribute SharingList sharingList) {
		System.out.println("YaController sharingConfirm start...");
		System.out.println("YaController sharingConfirm Received user_num: " + user_num);
		System.out.println("YaController sharingConfirm Received brd_num: " + brd_num);

		// board의 jk detail Sharing으로 participants 확인
		Board board = jbs.detailSharing(brd_num);
		System.out.println("YaController sharingConfirm board participants : " + board.getParticipants());
		board.getApplicants();

		// applicants를 초과하면 에러 반환
		if (board.getApplicants() <= board.getParticipants()) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", "승인 인원이 모집 인원을 초과하였습니다.");
			return response;
		}

		// 참가자 승인 state_md: 101 update
		SharingList updatedSharingList = new SharingList();
		updatedSharingList.setBrd_num(brd_num);
		updatedSharingList.setUser_num(user_num);

		int sharingConfirm = 0;
		sharingConfirm = ycs.sharingConfirm(updatedSharingList);
		System.out.println("sharingList participants user_num?" + sharingList.getUser_num());
		sharingList.setState_md(101);
		System.out.println("참가자 승인 완료 :" + sharingList);

		// board의 participants +1 증가
		int participantsCnt = 0;
		ycs.upParticipantsCnt(brd_num);

		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "승인처리가 완료되었습니다.");
		return response;

	}

	// 반려처리 , 메세지 sharingList 업데이트, 참가자 승인 state_ md 104
	@PostMapping("/sharingReject")
	@ResponseBody
	public Map<String, Object> sharingReject(@RequestParam("brd_num") int brd_num,
			@RequestParam("user_num") int user_num, @RequestParam("reject_msg") String reject_msg,
			@ModelAttribute SharingList sharingList) {

		System.out.println("YaController sharingreject start...");
		Map<String, Object> result = new HashMap<>();
		System.out.println("YaController sharingreject Received user_num: " + user_num);
		System.out.println("YaController sharingreject Received brd_num: " + brd_num);
		System.out.println("YaController sharingreject Received reject_msg: " + reject_msg);

		try {
			// 참가자 승인 state_md: 101 update & reject message null-->입력
			SharingList updatedRejectSharingList = new SharingList();
			updatedRejectSharingList.setBrd_num(brd_num);
			updatedRejectSharingList.setUser_num(user_num);
			updatedRejectSharingList.setReject_msg(reject_msg);
			updatedRejectSharingList.setState_md(104);

			int sharingReject = 0;

			sharingReject = ycs.sharingReject(sharingList);

			System.out.println("rejectSharing participants user_num?" + sharingList.getUser_num());
			System.out.println("참가자 반려 완료 :" + sharingList);

			// board의 jk detail Sharing으로 participants 확인
			Board board = jbs.detailSharing(brd_num);
			System.out.println("YaController sharingReject board participants : " + board.getParticipants());

			result.put("success", "true");
			result.put("message", "반려가 정상적으로 처리되었습니다.");
		} catch (Exception e) {
			// 처리 중 예외가 발생하면 결과 맵에 실패 메시지 추가
			result.put("success", "false");
			result.put("message", "반려 처리 중 오류가 발생했습니다. " + e.getMessage());
		}

		return result;
	}

	// 관리자 페이지 커뮤니티 게시글 전체 조회
	@RequestMapping(value = "/communityAdminList")
	public String communityAdminList(Board board, Model model, String currentPage) {

		System.out.println("YaController communityAdminList start....");

		// 전체 게시글 총 수
		int totalCommunity = ycs.totalCommunity(board);
		model.addAttribute("totalCommunity", totalCommunity);
		System.out.println("YaContorller totalCommunity->" + totalCommunity);

		// 페이징처리
		Paging boardPage = new Paging(totalCommunity, currentPage);
		board.setStart(boardPage.getStart());
		board.setEnd(boardPage.getEnd());
		model.addAttribute("boardPage", boardPage);
		System.out.println(" YaController boardPage start?" + boardPage.getStart());
		System.out.println(" YaControlloer boardpage total?" + boardPage.getTotal());
		System.out.println("boardPage End?" + boardPage.getEnd());

		List<Board> listCommunity = ycs.listCommunity(board);
		System.out.println("YaController list listCommunity.size()?" + listCommunity.size());
		model.addAttribute("listCommunity", listCommunity);

		return "ya/communityAdmin";

	}

	// 관리자 페이지 쉐어링 게시글 전체 조회 ----jk 컨트롤러 따옴
	@RequestMapping(value = "/sharAdminList")
	public String Sharing(Board board, Model model, String currentPage, HttpSession session) {
		System.out.println("JkController Sharing start...");

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}

		User1 user1 = jbs.userSelect(user_num);

		// ya 쉐어링 전체 게시글 총 수, 페이징 처리 작업
		int totalSharing = ycs.totalSharing(board);
		model.addAttribute("totalSharing", totalSharing);
		System.out.println("JkController Ya totalSharing->" + totalSharing);

		Paging sharBoardPage = new Paging(totalSharing, currentPage);

		board.setStart(sharBoardPage.getStart());
		board.setEnd(sharBoardPage.getEnd());
		model.addAttribute("sharBoardPage", sharBoardPage);
		System.out.println(" YaController boardPage start?" + sharBoardPage.getStart());
		System.out.println("YaControlller boardPage end?" + sharBoardPage.getEnd());
		System.out.println(" YaControlloer boardpage total?" + sharBoardPage.getTotal());

		// yr 작성
		// 쉐어링 찜 여부 판단용
		board.setB_user_num(user_num);

		List<Board> sharing = jbs.sharing(board);
		System.out.println("JkController list Sharing.size()?" + sharing.size());

		model.addAttribute("user1", user1);
		model.addAttribute("sharing", sharing);

		return "ya/sharAdmin";

	}

	// 관리자 페이지 자유게시판 게시글 삭제
	@GetMapping(value = "/deleteCommunityAdmin")
	public String deleteCommunityAdmin(@RequestParam int brd_num, Model model) {

		System.out.println("YaController ycs.deleteCommunity start....");
		int deleteResult = ycs.deleteCommunity(brd_num);
		model.addAttribute("deleteResult", deleteResult);
		System.out.println("YaController deleteResult: " + deleteResult);
		return "redirect:/communityAdminList";

	}

	// 관리자 페이지 쉐어링게시판 게시글 삭제
	@GetMapping(value = "/deleteShareAdmin")
	public String deleteShareAdmin(@RequestParam int brd_num, Model model) {

		System.out.println("YaController ycs.deleteCommunity start....");
		int deleteResult = ycs.deleteCommunity(brd_num);
		model.addAttribute("deleteResult", deleteResult);
		System.out.println("YaController deleteResult: " + deleteResult);
		return "redirect:/sharAdminList";

	}

	// 쉐어링 검색기능
	@GetMapping(value = "/sharingSearchResult")
	public String sharingSearchResult(@RequestParam String keyword, HttpSession session, String currentPage,
			Model model, Board board, String sortOption) {
		List<Board> sharingSearchResult = null;

		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}

		User1 user1 = jbs.userSelect(user_num);

		System.out.println("YaController sharingSearchResult start....");
		System.out.println("사용자 검색한 키워드: " + keyword);

		// ya 쉐어링 검색 게시글 총 수, 페이징 처리 작업
		int searchSharingCnt = 0;
		searchSharingCnt = ycs.searchSharingCnt(keyword);

		System.out.println("YaController searchSharingCnt:" + searchSharingCnt);
		model.addAttribute("searchSharingCnt", searchSharingCnt);

		System.out.println("YaController searchSharingCnt->" + searchSharingCnt);

		Paging sharBoardPage = new Paging(searchSharingCnt, currentPage, 9);

		// yr 작성
		// 쉐어링 찜 여부 판단용
		board.setB_user_num(user_num);

		board.setStart(sharBoardPage.getStart());
		board.setEnd(sharBoardPage.getEnd());
		model.addAttribute("sharBoardPage", sharBoardPage);

		System.out.println("YaController boardPage rowPage?" + sharBoardPage.getRowPage());
		System.out.println(" YaController boardPage start?" + sharBoardPage.getStart());
		System.out.println("YaControlller boardPage end?" + sharBoardPage.getEnd());
		System.out.println(" YaControlloer boardpage total?" + sharBoardPage.getTotal());

		sharingSearchResult = ycs.sharingSearchResult(keyword, currentPage, sortOption, board);

		model.addAttribute("sharingSearchResult", sharingSearchResult);
		model.addAttribute("searchSharingCnt", searchSharingCnt);
		model.addAttribute("sortOption", sortOption);

		return "ya/sharingSearch";
	}

	// 쉐어링 참가 취소기능 구현중..... 예정
	@GetMapping(value = "/deleteJoinSharing")
	public String deleteJoinSharing(@RequestParam int user_num, HttpSession session, Model model) {
		System.out.println("YaController deleteJoinShairng start...");

		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}

		User1 user1 = jbs.userSelect(user_num);

		System.out.println("deleteJoinSharing user_num?" + user_num);
		int deleteResult = 0;
		deleteResult = ycs.deleteJoinSharing(user_num);
		model.addAttribute("deleteResult", deleteResult);
		System.out.println("YaController deleteJoinSharing deleteResult: " + deleteResult);

		return "redirect:/sharingManagement";
	}

}