package com.oracle.S202350102.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.main.BoardService;
import com.oracle.S202350102.service.main.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {
	private final BoardService bs;
	private final UserService us;
	private final UserService userService;
	private final ChController chController;
	
	@RequestMapping(value ="/")
	public String index(HttpSession session, Model model, Board board, String end) {
		System.out.println("MainController index Start...");
		
		// yr 작성
		// session에 저장된 로그인 정보값 가져오기
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("MainController index userNum -> " + userNum);
		}
		
		//유저 정보(회원번호) 조회
		User1 user = userService.userSelect(userNum);
		
		// 인증게시판 출력
		board.setUser_num(userNum);
		if(end == null) {
			board.setEnd(10);
		} else {
			board.setEnd(Integer.parseInt(end));
		}
		
		
		
		List<Board> chgCert = bs.selectChgCert(board);
		chgCert = us.boardWriterLevelInfo(chgCert);
		
		model.addAttribute("chgCertList", chgCert);
		model.addAttribute("user", user);
		model.addAttribute("board", board);
		chController.search(model, session);
		
		return "home2";
	}
	
	@RequestMapping(value ="listChallenge")
	public String listChallenge() {
		System.out.println("MainController listChallenge Start...");
		
		return "listChallenge";
	}

	/*
	 * @RequestMapping(value ="Sharing") public String Sharing() {
	 * System.out.println("MainController Sharing Start...");
	 * 
	 * return "Sharing"; }
	 */
	
	@RequestMapping(value ="Community")
	public String listCommunity() {
		System.out.println("MainController community Start...");

		
		return "community";
	}
	
	@RequestMapping(value ="introduce")
	public String introduce() {
		System.out.println("MainController introduce Start...");
		
		return "introduce";
	}

	
	/*
	 * @RequestMapping(value ="mypage") public String mypage() {
	 * System.out.println("MainController mypage Start...");
	 * 
	 * return "mypage"; }
	 */
	 
	@RequestMapping(value ="master")
	public String master() {
		System.out.println("MainController master Start...");
		
		return "master";
	}
	@RequestMapping(value ="search")
	public String search() {
		System.out.println("MainController search Start...");
		
		return "search";
	}
	@RequestMapping(value ="challengeDetail")
	public String challengeDetail() {
		System.out.println("MainController challengeDetail Start...");
		
		return "challengeDetail";
	}
	@RequestMapping(value ="signUp")
	public String signUp() {
		System.out.println("MainController signUp Start...");
		
		return "signUp";
	}
	@RequestMapping(value ="chatBot")
	public String chatBot() {
		System.out.println("MainController chatBot Start...");
		
		return "chatBot";
	}
	@RequestMapping(value ="questionBoard")
	public String questionBoard() {
		System.out.println("MainController questionBoard Start...");
		
		return "questionBoard";
	}
	@RequestMapping(value ="personalQuestion")
	public String personalQuestion() {
		System.out.println("MainController personalQuestion Start...");
		
		return "personalQuestion";
	}

	@RequestMapping(value ="logIn")
	public String logIn() {
		System.out.println("MainController logIn Start...");
		
		return "logIn";
	}
	
	@RequestMapping(value ="loginForm")
	public String logInForm() {
		System.out.println("MainController loginForm Start...");
		
		return "loginForm";
	}
	
	@RequestMapping(value ="admin")
	public String admin() {
		System.out.println("MainController admin Start...");
		
		return "admin";
	}
	
}