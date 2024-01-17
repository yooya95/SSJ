package com.oracle.S202350102.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.buf.UDecoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Level1;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.hbService.QBoardService;
import com.oracle.S202350102.service.main.Level1Service;
import com.oracle.S202350102.service.main.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HbController {
	private final QBoardService qbs;
	private final UserService   us;
	private final Level1Service ls;
	
	// 문의게시판 리스트
	@RequestMapping("qBoardList")
	public String qBoardList(@ModelAttribute Board board, 
							 Model model,
							 String currentPage,
							 HttpSession session) {
		String keyword = board.getKeyword();
		if ( keyword == null ) {
			// 유저 세션 불러오기
			int user_num = 0;
			if(session.getAttribute("user_num") != null) {
				user_num = (int) session.getAttribute("user_num");
				User1 user1 = us.userSelect(user_num);
				ls.userLevelCheck(user_num);
				
				// 전체 게시글 수 
				// 로그인한 유저의 status_md 값으로 조건을 태우기 위함
				int total = qbs.totalQBoard(user1);
				System.out.println(total);
				
				// Paging 작업
				Paging page = new Paging(total, currentPage);
				
				board.setStart(page.getStart());
				board.setEnd(page.getEnd());
				board.setStatus_md(user1.getStatus_md());
				
				// 보드 리스트 불러오기
				if ( user1.getStatus_md() != 102 ) {
					board.setUser_num(user_num);
				}
				
				List<Board> qBoardList = qbs.qBoardList(board);
				System.out.println(qBoardList);

				// 게시판 유저 정보 BoardList에 저장하기
				qBoardList = us.boardWriterLevelInfo(qBoardList);
				
				model.addAttribute("total", total);
				model.addAttribute("page", page);		
				model.addAttribute("user1", user1);
				model.addAttribute("qBoardList", qBoardList);
				
				return "hb/qBoardList";
			} else {
				return "redirect:/loginForm";
			}
			
		} else { // 키워드가 있을 때, 페이징
			int user_num = 0;
			if(session.getAttribute("user_num") != null) {
				// 전체 게시글 수
				int total = qbs.qBoardSearchListCount(board);
				System.out.println(total);
				// Paging 작업
				Paging page = new Paging(total, currentPage);
				
				board.setStart(page.getStart());
				board.setEnd(page.getEnd());
				
				// 보드 리스트 불러오기
				List<Board> qboardListSearch = qbs.qboardListSearch(board);
				
				user_num = (int) session.getAttribute("user_num");
				
				// 유저 정보 불러오기
				User1 user1 = us.userSelect(user_num);
				ls.userLevelCheck(user_num); // 현재 유저 경험치가 레벨업 경험치를 넘는지 확인 (넘으면 레벨업)
				// 게시판 유저 정보 BoardList에 저장하기
				qboardListSearch = us.boardWriterLevelInfo(qboardListSearch); // boardList 에 게시판 작성자에 대한 레벨정보 조회를 위함
				
				model.addAttribute("searchInfo",board);
				model.addAttribute("total", total);
				model.addAttribute("page", page);		
				model.addAttribute("user1", user1);
				model.addAttribute("qBoardList", qboardListSearch);
				
				return "hb/qBoardList";
			} else {
				return "redirect:/loginForm";
			}
		}
		

	}
	
	// 문의 게시판 상세보기
	@RequestMapping("qBoardDetail")
	public String qBoardDetail(@RequestParam("brd_num") int brd_num, Model model, HttpSession session) {
		System.out.println("qBoardDetail controller start..");
		qbs.readCnt(brd_num);
		Board board = qbs.qBoardSelect(brd_num);
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		System.out.println(board.getImg());
		User1 user1 = us.userSelect(user_num);
		
		model.addAttribute("user1", user1);
		model.addAttribute("board", board);
		
		return "hb/qBoardDetail";
	}
	
	// 문의게시판 수정화면
	@RequestMapping("qBoardUpdateForm")
	public String qBoardUpdateForm(@RequestParam("brd_num") int brd_num, Model model, HttpSession session) {
		System.out.println("qBoardUpdateForm contoller start...");
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = us.userSelect(user_num);
			System.out.println("brd_num->"+brd_num);
			Board board = qbs.qBoardSelect(brd_num);
			if (user_num == board.getUser_num() || user1.getStatus_md() == 102) {
				System.out.println("board->"+board);
				model.addAttribute("board", board);
				return "hb/qBoardUpdate";
			}
			return "잘못된 접근";
		}
		return "잘못된 접근";
	}
	
	// 문의게시판 수정로직
	@RequestMapping("qBoardUpdate")
	public String qBoardUpdate(Board board, HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file1) throws IOException {
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/qBoard/");
		int delResult = 0;
		if (file1.getSize() != 0 ) {
			String deleteFile = uploadPath + board.getImg();
			delResult = fileDelete(deleteFile);
		}
		
		if (delResult != 0) {
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setImg(saveName);
		}
		int result = qbs.qBoardUpdate(board);
		
		return "forward:qBoardDetail?&brd_num="+board.getBrd_num();
	}
	
	// 글작성 페이지
	@RequestMapping("qBoardWriteForm")
	public String qBoardInsertForm(Model model, HttpSession session) {
		
		
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			
			User1 user1 = us.userSelect(user_num);
			model.addAttribute("user1", user1);
			return "hb/qBoardWrite";
		}
		return "잘못된접근";
	}
	
	// 글작성 로직
	@RequestMapping(value = "qBoardWrite", method = RequestMethod.POST)
	public String qBoardInsert(Board board, 
											 Model model, 
											 HttpSession session, 
											 HttpServletRequest request,
											 @RequestParam(value = "file", required = false) MultipartFile file1) throws IOException {	
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/qBoard/");
		System.out.println("uploadPath->" + uploadPath);
		System.out.println("originalName : " + file1.getOriginalFilename());
		System.out.println("fileByte : " + file1.getBytes());
		System.out.println("fileSize : " + file1.getSize());
		if ( file1.getSize() > 0 ) {
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setImg(saveName);
		} else {
			board.setImg("");
		}
		

		
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			ls.userExp(user_num, board.getBrd_lg(), board.getBrd_md());
			ls.userLevelCheck(user_num);
			
		}
		board.setUser_num(user_num);
		int result = qbs.qBoardInsert(board);
		User1 user1 = us.userSelect(user_num);
		board.setNick(user1.getNick());
		request.setAttribute("board", board);
		System.out.println("user exp ->" + user1.getUser_exp());
		
		return "redirect:qBoardList";
	}
	
	// 글삭제
	@RequestMapping("qBoardDelete")
	public String qBoardDelete(@ModelAttribute Board board, Model model, HttpSession session, HttpServletRequest request) {
		int brd_num = board.getBrd_num();
		String img = board.getImg();
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		int result = qbs.qBoardDelete(brd_num);
		
		if ( result > 0 ) {
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/qBoard/");
			String deleteFile = uploadPath + img;
			int delResult = fileDelete(deleteFile);
			
			System.out.println("delResult -> " + delResult);
		}
		
		model.addAttribute("result",result);
		
		return "forward:qBoardList";
	}
	
	private int fileDelete(String deleteFile) {
		int result = 0;
		File file = new File(deleteFile);
		if (file.exists()) {
			if (file.delete()) {
				result = 1;
			} else {
				result = 0;
			}
		} else {
			result = -1;
		}
		return result;
	}

	// 레벨 리스트
	@RequestMapping("level")
	public String levelView(Model model, HttpSession session) {
		int user_num = 0;
		if ( session.getAttribute("user_num") != null ) {
			user_num = (int) session.getAttribute("user_num");
		}
		User1 user1 = us.userSelect(user_num);
		
		List<Level1> level1List = ls.level1List();
		
		model.addAttribute("user1", user1);
		model.addAttribute("level1List", level1List);
		
		return "hb/level";
	}
	
	// 문의게시판 검색
	@ResponseBody
	@RequestMapping(value = "qboardListSearch", method = RequestMethod.GET)
	public Map<String, Object> qboardListSearch(@ModelAttribute Board board, String currentPage){
		Map<String, Object> response = new HashMap<String, Object>();
		int totalCnt = qbs.qBoardSearchListCount(board);
		System.out.println("qboardListSearch cont totalcnt->"+totalCnt);
		Paging page = new Paging(totalCnt, currentPage);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		List<Board> qboardListSearch = qbs.qboardListSearch(board);
		qboardListSearch = us.boardWriterLevelInfo(qboardListSearch);
		response.put("list", qboardListSearch);
		response.put("page", page);
		
		return response;
	}
	
	@ResponseBody
	@RequestMapping(value = "qBoardCommentList", method = RequestMethod.GET)
	public List<Board> qBoardCommentList(@RequestParam int brd_group,
																HttpSession session){
		
		List<Board> qBoardCommentList = qbs.qBoardCommentList(brd_group);
		qBoardCommentList = us.boardWriterLevelInfo(qBoardCommentList);
		
		return qBoardCommentList;
	}
	
	@ResponseBody
	@RequestMapping(value = "qBoardCommentWrite", method = RequestMethod.POST)
	public Map<String, Object>  qBoardCommentWrite(@ModelAttribute Board board, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		int result = 0;
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			board.setUser_num(user_num);
			result = qbs.qBoardCommentWrite(board);
			
			response.put("result", result);
		}
		return response;

	}
	
	@ResponseBody
	@PostMapping(value = "qBoardCommentUpdate")
	public Map<String, String> qBoardCommentUpdate(@ModelAttribute Board board) {
		Map<String, String> response = new HashMap<>();
		
		int result = 0;
		result = qbs.qBoardCommentUpdate(board);
		
		if ( result > 0 ) {
			response.put("result", "success");
		} else {
			response.put("result", "fail");
		}
		
		return response;
	}
	
	@ResponseBody
	@DeleteMapping(value = "qBoardCommentDelete")
	public Map<String, String> qBoardCommentDelete(@RequestParam int brd_num) {
		Map<String, String> response = new HashMap<>();
		
		int result = 0;
		result = qbs.qBoardCommentDelete(brd_num);
		
		if ( result > 0 ) {
			response.put("result", "success");
		} else {
			response.put("result", "fail");
		}
		
		return response;
	}
	
	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws IOException {
		UUID uid = UUID.randomUUID();  // universally unique identifier 국제 유일 식별자, 해당 객체를 사용한다면 같은 파일을 올려도 서로 다른 이름을 갖는다. 
		// requestPath = requestPath + "/resources/image";
		System.out.println("uploadPath->" + uploadPath);
		//Directory 생성, jsp는 폴더가 없을 때 수동으로 폴더를 만들어주지만 spring boot는 없을경우 자동으로 만들 수 있음 
		File fileDirectory = new File(uploadPath);  
		if (!fileDirectory.exists()) { // 해당 경로에 폴더가 없다면 신규폴더를 생성 
			//신규 폴더 생성 
			fileDirectory.mkdirs(); // 해당 메서드를 사용하면 자동으로 디렉토리(폴더)를 만들 수 있음 
			System.out.println("시스템 업로드용 폴더 생성 :" + uploadPath);			
		}
		
		String savedName = uid.toString() + "_" + originalName;
		log.info("saveName : " + savedName); 
		File target = new File(uploadPath, savedName);
		//file target = new file(requestPath, savedName
		// file UpLoad ----> uploadPath / UUID + _ + originalname
		FileCopyUtils.copy(fileData, target);  // import org.springframework.util.FileCopyUtils;
		// 용량, target을 넣으면 내부적으로 업로드
		// 만든 타겟을 카피하면 업로드, 시스템적으로 떨어져 있더라도 업로드 시킨다.
		return savedName;
	}
	
	@RequestMapping(value = "test2")
	public String test() {
		return "hb/test2";
	}
}