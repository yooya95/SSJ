package com.oracle.S202350102.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.S202350102.domain.Report;
import com.oracle.S202350102.service.bgService.BgReportJpaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BgJpaController {
	
	private final BgReportJpaService bReportJpaS;
	
	
	@GetMapping(value = "/reportJpa/resetReportCnt")
	public String resetReportCnt(@RequestParam int report_id, Model model) {
		
		System.out.println("BgJpaController listReportAdmin Start...");
		System.out.println("BgJpaController listReportAdmin report_id -> " + report_id);
		
		bReportJpaS.reportUpdate(report_id);
		
		return "redirect:/reportListAdmin";
		
	}
	
	
	// resetReportCnt ver.1  폐기
	@GetMapping(value = "/temporaryResetReportCnt1")
	public String resetReportCnt1(int report_id, Model model) {
		
		System.out.println("BgJpaController listReportAdmin Start...");
		System.out.println("BgJpaController listReportAdmin report_id -> " + report_id);
		
		Report report = null;
		String rtnJsp = "";
		
		// 목적:	객체 Null Check 용이
		Optional<Report> maybeReport = bReportJpaS.findByReportId(report_id);
		
		if (maybeReport.isPresent()) {
			System.out.println("BgJpaController resetReportCnt maybeReport Is Not NULL");
			report = maybeReport.get();
			model.addAttribute("report", report);
			rtnJsp = "redirect:bg/reportListAdmin";
			
		} else {
			System.out.println("BgJpaController resetReportCnt maybeReport Is NULL");
			model.addAttribute("message", "초기화 실패");
		}
		
		return rtnJsp;
	}
	
	// 신고 리스트 만들려다가 폐기 <- 쿼리문이 복잡해서 Mybatis로 진행
	@GetMapping(value = "/temporaryListReportAdmin")
	public String listReportAdmin(Model model) {
		
		System.out.println("BgJpaController listReportAdmin Start...");
		
		
		List<Report> reportList = bReportJpaS.getListAllReport();
		model.addAttribute("reports", reportList);
		return "";
	}

}
