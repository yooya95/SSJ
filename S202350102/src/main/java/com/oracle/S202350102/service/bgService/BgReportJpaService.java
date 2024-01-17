package com.oracle.S202350102.service.bgService;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.S202350102.domain.Report;
import com.oracle.S202350102.repository.BgReportJpaRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class BgReportJpaService {
	
	private final BgReportJpaRepository bReportJpaR;

	
	public void reportUpdate(int report_id) {
		
		System.out.println("BgReportJpaRepository reportUpdate report_id -> " + report_id);
		bReportJpaR.updateByReport(report_id);
		
		return;
		
	}
	
	
	// resetReportCnt ver.1  폐기
	public Optional<Report> findByReportId(int report_id) {
		
		System.out.println("BgReportJpaService findByReportId Start...");
		Optional<Report> report = bReportJpaR.findByReportId(report_id);
		
		return report;
	}
	
	
	// 신고 리스트 만들려다가 폐기 <- 쿼리문이 복잡해서 Mybatis로 진행
	public List<Report> getListAllReport() {
		List<Report> listReport = bReportJpaR.findAll();
		System.out.println("BgReportJpaService getListAllReport listReport.size() -> "+listReport.size());
		return listReport;
	}


	

}
