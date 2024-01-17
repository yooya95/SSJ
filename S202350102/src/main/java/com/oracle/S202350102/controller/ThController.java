package com.oracle.S202350102.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;
import com.oracle.S202350102.dto.KakaoPayApprovalVO;
import com.oracle.S202350102.dto.KakaoPayCancelVO;
import com.oracle.S202350102.dto.Order1;
import com.oracle.S202350102.dto.Refund;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.jkService.JkBoardService;
import com.oracle.S202350102.service.main.Level1Service;
import com.oracle.S202350102.service.main.UserService;
import com.oracle.S202350102.service.thService.ThChgService;
import com.oracle.S202350102.service.thService.ThKakaoPay;
import com.oracle.S202350102.service.thService.ThOrder1Service;
import com.oracle.S202350102.service.thService.ThRefundService;
import com.oracle.S202350102.service.thService.ThUser1Service;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@Data
public class ThController {
	// 태현 작업
	private final ThUser1Service us1;
	private final ThKakaoPay thKakaoPay;
	private final ThOrder1Service os1;
	private final JavaMailSender mailSender;
	private final Level1Service ls;
	private final ThChgService tcs;
	private final JkBoardService jbs;
	private final UserService mus;
	private final ThRefundService rfs;
	
	@PostMapping(value = "/writeUser1")
	public String writeUser1(User1 user1, Model model, @RequestParam("addr_detail") String addr_detail,
													   @RequestParam("birth_year")  String birth_year,
													   @RequestParam("birth_month") String birth_month,
													   @RequestParam("birth_date")  String birth_date) 
													   {
		System.out.println("ThController writeUser1 start...");
		// 기존 주소에 상세 주소를 추가( 주소받는게 API에 2개로 나뉘어 있음)
		String sumAddr	= user1.getAddr() + " " + addr_detail;
		user1.setAddr(sumAddr);
		
		// 생년월일 년+/+월+/+일 
		String sumBirth = birth_year+ "/" + birth_month + "/" + birth_date;
		
		// 년월일 문자열을 Date타입으로 형변환
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		Date strToDate = null;
		try {
			strToDate = formatter.parse(sumBirth);
			System.out.println("strToDate --> " + strToDate);
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}

		// 형변환한 생년월일을 user1에 담음
		user1.setBirth(strToDate);
		
		System.out.println("user1.getZipCode() --> " + user1.getZipCode());
		
		int insertResult = us1.insertUser1(user1);
		model.addAttribute("insertResult",insertResult);
		if(insertResult > 0 ) return "th/writeResult";
		else {
			model.addAttribute("msg", "입력 실패 확인해 보세요");
			return "signUp";
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/login")							// 로그인 유지를 위한 세션 필요
	public String login(User1 user1, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("ThController login start... ");
		System.out.println("ThController login user1.getUser_id() --> " + user1.getUser_id());
		System.out.println("ThController login user1.getUser_pswd() --> " + user1.getUser_pswd());
		User1 loginResult = us1.login(user1);
		System.out.println("ThController loginResult -->" + loginResult);
		
		// 회원정보가 존재 하는경우
		if (loginResult != null) {
			// 정상 회원의경우 로그인처리
			if(loginResult.getDelete_yn().equals("N")) {
				session = request.getSession();
				session.setAttribute("user_num", loginResult.getUser_num());
				session.setAttribute("nick", loginResult.getNick());
				session.setAttribute("status_md", loginResult.getStatus_md());
				int user_num = (int) session.getAttribute("user_num");
		         
		         
		         ls.userLevelCheck(user_num);
		         
		         //로그인 성공시 마지막 로그인 날짜 SYSDATE로 업데이트
		         int updateResult = us1.updateUserLoginDate(user_num);
		         System.out.println("Thcontroller login updateResult --> " + updateResult);
				 System.out.println("session.getAttribute(\"user_num\") -->" + session.getAttribute("user_num"));
				return "loginSuccess";
				
			// 탈퇴처리된 아이디 인경우		
			} else {
				return "delId";
			}
			
		// 회원정보가 없는경우(아이디 비밀번호 틀린경우)
		} else {
			return "wrongValue";
		}
	}
	// 내일 해야할 곳
	@GetMapping("/loginSuc") 
	public void loginSuc(User1 user1, HttpSession session, HttpServletRequest request, Model model ) {
		System.out.println("thController loginSuc Start...");
		User1 login = mus.userSelect(user1);
		
		model.addAttribute("user1", login);
	}
	
	@RequestMapping(value = "/logoutForm")
	public String logoutForm() {
		System.out.println("ThController logoutForm start...");
		
		return "th/logoutForm";
	}
	
	@RequestMapping(value = "/logout")
	public String logout(User1 user1, HttpSession session) {
		System.out.println("ThController logout start... ");
		System.out.println("ThController logout session --> " + session);
		session.invalidate();
		System.out.println("ThController logout session --> " + session);
		return "redirect:/";
	}
	
	@GetMapping(value = "/deleteUser1Form")
	public String deleteUser1Form(HttpSession session) {
		System.out.println("ThController deleteUser1Form Start...");
		return "th/deleteUser1Form";
	}
	
	@PostMapping(value = "/deleteUser1")
	public String deleteUser1(User1 user1, HttpSession session, Model model) {
		System.out.println("ThController deleteUser1 Start... ");
		// 회원상태 탈퇴여부 N에서 Y로 변경, 탈퇴일자 추가
		int deleteUserCnt = us1.deleteUser(user1); 
		System.out.println("ThController deleteUserCnt result --> " + deleteUserCnt);
		if (deleteUserCnt > 0) {
			model.addAttribute("deleteUserCnt",deleteUserCnt);
			session.invalidate(); // 세션 끊어줌
			return "th/user1DelAlert";
		}
		else {
			model.addAttribute("deleteUserCnt",deleteUserCnt);
			return "th/user1DelAlert";
		}
	}
	
	@GetMapping(value = "userSubMng")
	public String userSubMng() {
		return "th/userSubMng";
	}
	
	@RequestMapping(value = "thkakaoPayForm")
	public String thKakaoPayForm(HttpSession session, Model model, User1 user1) {
		if(session.getAttribute("user_num") == null) {
			return "loginForm";
		} else {
			int user_num = (int) session.getAttribute("user_num");
			user1 = mus.userSelect(user_num);
			model.addAttribute("user1", user1);
			return "th/thkakaoPayForm";
		}
	}
	
	@GetMapping("/thKakaoPay")
	public void thKakaoPayGet() {
		System.out.println("ThController thKakaoPay Get Start...");
	}
	
	@PostMapping("/thKakaoPay")
	public String thKakaoPay(Order1 order1, HttpSession session) {
		System.out.println("ThController thKakaoPay Post Start...");
		System.out.println("ThController thKakaoPay Post order1.getMem_num --> "+ order1.getMem_num());
    	
		//세션에서 user_num 가져와서, order1 dto에 저장(set)
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			System.out.println("ThController user_num --> " + user_num);
		} 
		order1.setUser_num(user_num);
		System.out.println("ThController thKakaoPay Post order1.getUser_num()--> "+ order1.getUser_num());
		// 주문번호 생성
		int order_num = 0;		
		// 최대 주문번호 찾기
		int max_order_num = os1.selectMaxOrderNum(); 
		// 주문번호에 최대번호+1 부여
		order_num = max_order_num +1;
		// 주문번호를 order1 객체(DTO) 저장
		order1.setOrder_num(order_num);
		
		// 결제시 멤버쉽번호(=상품번호) 가져오면서 주문테이블에 INSERT
		int insertResult = os1.insertOrder(order1);
		System.out.println("ThController thKakaoPay Post order1table insertResult --> " + insertResult);

		// 주문 관련 조회
		Order1 orderResult = os1.selectOrderJoinMem(order1);
		System.out.println("ThController thKakaoPay orderResult --> " + orderResult);
				
//		
//		System.out.println("thKakaoPay.kakaoPayReady(order1) --> " + thKakaoPay.kakaoPayReady(orderResult));
		// kakaoPayReady에서 orderResult를 Order1 order1으로 받음 착각하지 말기
		return "redirect:" + thKakaoPay.kakaoPayReady(orderResult);
	}
	
// 왜 GetMaping만 되지??
    @GetMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model, HttpSession session, Order1 order1, int order_num) {
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);
        System.out.println("kakaoPaySuccess session.getAttribute(\"user_num\") --> " + session.getAttribute("user_num"));
        System.out.println("kakaoPaySuccess order_num --> " + order_num);
        

		int	user_num = (int) session.getAttribute("user_num");
		// 트랜잭션 묶음(결제성공시 주문상태 성공(1), 회원상태 구독회원(101)로 변경
		int updateOrderUserResult = os1.tranxOrdUsrUptSuc(order_num,user_num);
		System.out.println("ThController kakaoPaySuccess updateOrderUserResult --> " + updateOrderUserResult);
		


 		// 객체째로 못들고 다니므로(approval url에 객체 넣었다가 에러발생함) 주문번호만 가져옴
 		// order_num을 order1에 담고,
 		order1.setOrder_num(order_num);
 		// orderResult 객체에 order1을 담고,
        Order1 orderResult = os1.selectOrderJoinMem(order1);
        // kakaoPayInfo에 pg_token과 orderResult를 파라미터로 넣어줌 ( pg_token은  결제승인 api호출시 사용, 결제승인 요청을 인증하는 token 
        //													  사용자 결제 수단 선택 완료 시, approval_url로 redirection해줄 때 pg_token을 query string으로 전달)
        Object kakaoSucInfo = thKakaoPay.kakaoPayInfo(pg_token, orderResult);
        
        
        
        model.addAttribute("info", kakaoSucInfo);
        model.addAttribute("order1", orderResult);
                return "th/kakaoPaySuccess";
    }
	// 결제도중 취소눌렀을때 구독안내 창으로 이동
    @GetMapping("/kakaoPayCancel")
    public String kakaoPayCancel() {
    	
    	return "redirect:/thkakaoPayForm";
    	
    }
    
    // 카카오페이 환불
    @PostMapping("/kakaoPayRefund")
    public String kakaoPayRefund(HttpSession session, User1 user1, Order1 order1,Refund refund, Model model) {
    	System.out.println("ThController kakaoPayRefund Start...");
    	KakaoPayCancelVO kakaoPayCancelVO = thKakaoPay.kakaoPayCancel(order1);
    	
    	// 환불처리가 성공한경우(null이 아닌경우) 
    	if (kakaoPayCancelVO != null) {
    		int user_num = Integer.parseInt(kakaoPayCancelVO.getPartner_user_id());
        	System.out.println(" ThController kakaoPayRefund kakaoPayCancelVO --> " + kakaoPayCancelVO);

        	// 트랜잭션 묶음처리 
        	// Tid의 주문상태를 환불(2)으로, 결제완료날짜(=환불완료날짜)를 SYSDATE로  UPDATE + 해당 유저의 상태를 멤버쉽 회원 --> 일반 회원으로 변경
            int updateOrderUserResult 	= os1.transactionOrderInsertUpdate(kakaoPayCancelVO.getTid(),user_num);
            System.out.println("ThController kakaoPayRefund transactionOrderInsertUpdateResult -->" + updateOrderUserResult);
            
//            해당 주문번호에 대한 환불처리를 환불 테이블에 INSERT
//            CancelVO에 저장된 order_id(=order_num)이 문자열이라 정수형으로 변환
//            refund.setOrder_num(Integer.parseInt(kakaoPayCancelVO.getPartner_order_id()));
//            refund.setPrice(Integer.parseInt(kakaoPayCancelVO.getApproved_cancel_amount()));
//            int insertRefundResult 	= rfs.insertRefundSucess(kakaoPayCancelVO);
//            System.out.println("ThController kakaoPayRefund insertRefundResult -->" + insertRefundResult);
            
           

    		
            model.addAttribute("kakaoPayCancelVO", kakaoPayCancelVO);
    		return "th/refundSuccess";
		}
    	// 환불처리 실패한경우 일단 마이페이지로 이동
    	return "redirect:/thSubscriptManagement";
    }
    

    // 아작스 아이디 중복체크할때쓰는데, 왜 Getmapping일까? id가져가는데 postMapping이어야 하지않나? (getmapping하면 안됨)
    // 중복확인 버튼클릭으로 넘어갈때는 Postmapping만 가능
    @ResponseBody
    @GetMapping(value = "/user1IdCheck")
    public int user1IdCheck(String user_id) {
    	System.out.println("ThController user1IdCheck Start...");
    	System.out.println("ThController user_id --> " + user_id);
    	int result = us1.user1IdCheck(user_id);
    	System.out.println("ThController user1IdCheck result --> " + result);
    	return result;
    }

    // 닉네임 중복 체크
    @ResponseBody
    @GetMapping(value = "user1NickCheck")
    public int user1NickCheck(String nick) {
    	System.out.println("ThController user1NickCheck Start...");
    	System.out.println("ThController nick --> " + nick);
    	int result = us1.user1NickCheck(nick);
    	System.out.println("ThController user1NickCheck result --> " + result);
    	return result;
    }
    
    @ResponseBody
    @RequestMapping(value = "/findId")
    public List<User1> findId(User1 user1, Model model) {
    	System.out.println("ThController findId Start...");
    	List<User1> user_id_List = us1.findId(user1);
    	System.out.println("ThController user_id_List --> " + user_id_List);
    	model.addAttribute("user_id_List" , user_id_List);
    	
    	return user_id_List;
    }
    
    
    @RequestMapping(value = "/sendMailForResetPswd")
    public String sendMailForResetPswd(HttpServletRequest request, Model model, User1 user1) {
		System.out.println("ThController sendMailForResetPswd mailSending Start..");
		
		//1.아이디와 이메일이 일치하는 유저 조회
		User1 findUser1 = us1.findUser1ByIdAndEmail(user1);
		System.out.println("ThController sendMailForResetPswd findUser1 --> " + findUser1);
		
		if(findUser1 == null) {
			model.addAttribute("check", 2);
			return "th/thMailResult";
		}
		
		//2.임시 비밀번호 생성(rndPswd: 랜덤패스워드)
		String rndPswd = us1.crRndPswd();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", findUser1.getUser_id());
		map.put("rndPswd", rndPswd);
		
		//3.비밀번호를 임시비밀번호로 변경
		int updateResult = us1.user1PswdUpdate(map);
		System.out.println("ThController sendMailForResetPswd updateResult --> " + updateResult);
		
		//4. 메일 발송
		String tomail = findUser1.getEmail();		// 받는사람
		System.out.println(tomail);
		String setfrom = "teamssj02@gmail.com";	// 보내는 사람
		String title =   "안녕하세요 Ssj 입니다 요청하신 임시 비밀번호입니다"; // 제목
		
		
		try {
			// Mime 전자우편 Internet 표준 Format
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom);		// 보내는 사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(tomail);		// 받는사람 이메일
			messageHelper.setSubject(title);	// 메일 제목은 생략은 가능하지만(보내기는 가능) 받는쪽에서 스팸메일인줄알고 거르는경우가 많기때문에 생략하지 않는게 좋다.
			String tempPassword = rndPswd;
			messageHelper.setText("임시 비밀번호입니다: " + tempPassword); // 메일 내용
			System.out.println("임시 비밀번호입니다: " + tempPassword);
			mailSender.send(message);
			model.addAttribute("check", 1); // 정상전달
			// DB Logic 구성
		} catch (Exception e) {
			System.out.println("mailTransport e.getMessage() -->" + e.getMessage());
			model.addAttribute("check", 3); // 메일 전달 실패
		}
				
		return "th/thMailResult";
		
	}
    
    @RequestMapping(value ="thChgList")
	public String thChgList(Challenge chg, String currentPage, Model model, @RequestParam(value = "sortOpt", required=false) String sortOpt, HttpSession session) {
		System.out.println("chg.getKeyword()--> "+ chg.getKeyword() );
    	System.out.println("thController thChgList Start...");
		System.out.println("State_md --> " + chg.getState_md());

		// 카테고리 적용한 전체 게시글 수
		int totalChg = 0;
		// 		진행중				  or 		 nav 챌린지 클릭했을 때
		//		검색에 값이 있으면 그 검색내용에 해당하는 게시글 수도 가져옴
		if ( chg.getState_md() == 102 || chg.getState_md() == 0 ) {
				totalChg = tcs.totalChgIng(chg);
				System.out.println("tcs.totalChgIng(chg) --> " + totalChg);
				
		//				종료된 챌린지
		} else if( chg.getState_md() == 103) {
				totalChg = tcs.totalChgFin(chg);
				System.out.println("tcs.totalChgFin(chg) --> " + totalChg);
		}
		
		
		// 챌린지 카테고리 가져오기
		List<Comm> chgCategoryList = tcs.listChgCategory();
		// 						전체 챌린지수가 아니라  조회된 챌린지수로 페이징 작업을 해야한다. (= listChg.size() 사용)
		// Paging 작업			  	7			0	   rowPage값 입력(한페이지에 리스트 몇개 출력할지)	
		Paging page = new Paging(totalChg, currentPage, 9);
		System.out.println(" page --> " + page);
		
		

		chg.setStart(page.getStart());
		chg.setEnd(page.getEnd());
	

		
		// 찜하기
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			chg.setMy_user_num(userNum);
		}
		
		// 조회 필터 가져오기
		if(sortOpt != null) {
			chg.setSortOpt(sortOpt);
			System.out.println("ThController thChgList sortOption --> " + sortOpt);
		}
		
		// 챌린지 리스트 가져오기
		List<Challenge> listChg = tcs.listChg(chg);
		System.out.println("thController list listChg.size() --> " + listChg.size());
		System.out.println("chg_lg --> " + chg.getChg_lg());
		System.out.println("chg_md --> " + chg.getChg_md());
		for(int i =0; i <3; i++) {
//		System.out.println("챌린지리스트 체크  --> ["+ i+"] --> " + listChg.get(i) );
		}

			
		// Model에 메소드 수행한 결과(전체게시글수, 게시글리스트, 페이지) 넣음
		model.addAttribute("totalChg", totalChg);
		model.addAttribute("listChg", listChg);
		model.addAttribute("page", page);
		model.addAttribute("sortOpt", sortOpt);
		model.addAttribute("chgCategoryList", chgCategoryList);
		model.addAttribute("chg", chg);	
		
		return "th/thChgList";
	}
    
    @GetMapping(value = "/listUserAdmin")
    public String listUserByAdmin(User1 user1, String currentPage, Model model) {
    	System.out.println("thController listUserAdmin Start...");
    	// 전체 유저수 Count
    	int totalUser = us1.totalUser(user1);

    	
    	// 페이징 작업
    	Paging page = new Paging(totalUser, currentPage);
    	user1.setStart(page.getStart());
    	user1.setEnd(page.getEnd());
    	
    	// 유저 리스트 조회
    	List<User1> user1List = us1.listUser(user1);
    	System.out.println("ThController user1List.size()=>" + user1List.size());
    	
    	// Model에 저장
    	model.addAttribute("totalUser", totalUser);
    	model.addAttribute("user1List", user1List);
    	model.addAttribute("page"	  ,	page );
    	model.addAttribute("keyword", user1.getKeyword());
    	return	"th/listUserAdmin";
    }
    
    @GetMapping(value = "/delUserByAdmin")
    public String delUserByAdmin(User1 user1, Model model, String pageNum) {
    	System.out.println("thController delUserByAdmin Start...");
    	System.out.println("thController user1.getUser_num() --> " + user1.getUser_num());
    	System.out.println("thController user1.getDelete_yn() --> " + user1.getDelete_yn());
    	int deleteResult = 0;

    	// 유저의 탈퇴여부가 N이면 탈퇴 시킴 
    	if(user1.getDelete_yn().equals("N")) {			// user_num 파라미터 넘겨줌
    		deleteResult = us1.deleteUserByAdmin(user1.getUser_num());
    	// 유저의 탈퇴여부가 Y면 다시 활성화 	
    	} else if (user1.getDelete_yn().equals("Y")) {
    		deleteResult = us1.activeUserByAdmin(user1.getUser_num());
		}
    	System.out.println("thController deleteResult --> " + deleteResult);
//    	model.addAttribute("pageNum", pageNum);
    	
		return "forward:/detailUserByAdmin?user_num="+user1.getUser_num();
    }
    
    @GetMapping(value = "/detailUserByAdmin")
    public String detailUserByAdmin(User1 user1, int user_num, String pageNum, Model model, String keyword) {
    	System.out.println("thController detailUserByAdmin Start...");
    	System.out.println("detailUserByAdmin 키워드 --> "+ user1.getKeyword());
    	user1 = jbs.userSelect(user_num);
    	model.addAttribute("user1", user1);
    	model.addAttribute("pageNum",pageNum);
    	model.addAttribute("keyword", keyword);
    	return "th/detailUserByAdmin";
    }
    
    @GetMapping(value = "updateUserFormAdmin")
    public String updateUserFormAdmin(User1 user1, int user_num, String pageNum, Model model, String keyword) {
    	System.out.println("thController updateUserFormAdmin Start...");
    	user1 = jbs.userSelect(user_num);
    	model.addAttribute("user1", user1);
    	model.addAttribute("pageNum", pageNum);
    	model.addAttribute("keyword", keyword);
    	return "th/updateUserFormAdmin";
    }
    
    @GetMapping(value = "/updateUserAdmin")
    public String updateUserAdmin(User1 user1, String pageNum, Model model) {
    	System.out.println("thController updateUserAdmin Start...");
    	int updateResult = us1.updateUserAdmin(user1);
    	System.out.println("thController updateUserAdmin updateResult -->" + updateResult);
    	if (updateResult == 1) { return "forward:/detailUserByAdmin?user_num="+user1.getUser_num(); }
    	else { return "redirect:/updateUserFormAdmin?user_num="+user1.getUser_num(); }
    	
    }
    
	
	@RequestMapping("/thSubscriptManagement")
	public String thSubscriptManagement(User1 user1, HttpSession session, Model model, Order1 order1) {
		System.out.println("thController thSubscriptManagement start...");
		int	user_num = (int) session.getAttribute("user_num");
		
		// 메인에서 유저 정보 가져옴 --> 마이페이지 사이드바에서 사용(구독관리에대한 조건)
		user1 = mus.userSelect(user_num);
		
		// 주문(order1)테이블에서 해당 유저번호를 가지고, 결제 상태가 1(성공)인 값을  조회함
		order1 = os1.selectOrderSucess(user_num);
		System.out.println("thController thSubscriptManagement order1 --> " + order1);
		
		model.addAttribute("user1", user1);
		model.addAttribute("order1", order1);
		return "th/subscriptManagement";
	}
	
	@RequestMapping("/errorLogin")
	public String errorLogin() {
		System.out.println("thController errorLogin Start...");
		return "errorLogin";
	}
	
	@RequestMapping("/errorAuth")
	public String errorAuth() {
		System.out.println("thController errorAuth Start...");
		return "errorAuth";
	}
		
}