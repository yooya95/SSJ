package com.oracle.S202350102.service.bgService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.bgDao.BgReportDao;
import com.oracle.S202350102.dto.Report;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BgReportServiceImpl implements BgReportService {

	public final BgReportDao bReportD;
	
	// 1. 태워요 전적 조회	mapper key:	selectReportRecord
	public int selectReportRecord(Report burning) {
		
		System.out.println("BgReportServiceImpl selectReportRecord Start...");
		int result = bReportD.selectReportRecord(burning);
		
		System.out.println("BgReportServiceImpl selectReportRecord result -> "+result);
		
		return result;
	}
	
	// 1-2. 신고 전적이 있으면 현재 CNT 조회
	public int selectCnt(Report burning) {
		System.out.println("BgReportServiceImpl selectCnt Start...");
		int result = bReportD.selectCnt(burning);
		
		System.out.println("BgReportServiceImpl selectCnt result -> "+result);
		
		return result;
	}
	
	
	@Override
	public int burning(Report burning) {
		
		int result = 0;
		
		System.out.println("BgReportServiceImpl burning Start...");
		
		// 1-1. 전적이 없다면 새 Report insert		mapper key: insertReport
		if (this.selectReportRecord(burning) == 0) {
			
			System.out.println("BgReportServiceImpl burning burning.getBrd_num() -> "+burning.getBrd_num());
			System.out.println("BgReportServiceImpl burning burning.getUser_num() -> "+burning.getUser_num());
			bReportD.insertReport(burning);
			
			result = 1;
			
		// 1-3. CNT 값에 따라서 업데이트 수행		
		} else if (this.selectReportRecord(burning) == 1) {
			// mapper key:	cancelCnt
			if (this.selectCnt(burning) == 10) {
				bReportD.cancelCnt(burning);
				result = 0;
			// mapper key:	undoCnt
			} else if (this.selectCnt(burning) == 0) {
				bReportD.undoCnt(burning);
				result = 2;
			}
		}
		
		System.out.println("BgReportServiceImpl burning result -> " + result);
		
		return result;
	}

	

	
	@Override
	public int totalReport() {
		
		System.out.println("BgReportServiceImpl totalReport Start...");
		int totReportCnt = bReportD.totalReport();
		System.out.println("BgReportServiceImpl totalReport totReportCnt -> " + totReportCnt);
		
		return totReportCnt;
	}
	
	
	@Override
	public int totalSearchReport(Report report) {
		
		System.out.println("BgReportServiceImpl totalSearchReport Start...");
		System.out.println("BgReportServiceImpl totalSearchReport report.getKeyword() -> " + report.getKeyword());
		int totalSearchReport = bReportD.totalSearchReport(report);
		System.out.println("BgReportServiceImpl totalSearchReport totalSearchReport -> " + totalSearchReport);
		
		return totalSearchReport;
	}
	

	@Override
	public List<Report> listReport(Report report) {
		
		List<Report> reportList = null;
		System.out.println("BgReportServiceImpl listReport Start...");
		
		reportList = bReportD.listReport(report);
		System.out.println("BgReportServiceImpl listReport reportList.size() -> " + reportList.size());
		
		return reportList;
	}
	
	
	
	@Override
	public int resetReportCnts(List<Report> selectedReports) {
		
		int result = 0;
		System.out.println("BgReportServiceImpl resetReportCnts Start...");
		System.out.println("BgReportServiceImpl resetReportCnts selectedReports.size() -> "+selectedReports.size());
		
		result = bReportD.resetReportCnts(selectedReports);
		
		System.out.println("BgReportServiceImpl resetReportCnts result -> " + result);
		
		return result;
	}



	
}
