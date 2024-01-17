package com.oracle.S202350102.dao.bgDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.oracle.S202350102.dto.Report;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BgReportDaoImpl implements BgReportDao {

	private final SqlSession session;
	
	@Override
	public int selectReportRecord(Report burning) {
		int result = 0;
		try {
			result = session.selectOne("selectReportRecord", burning);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl selectReportRecord e.getMessage() -> "+e.getMessage());
		}
		return result;
	}
	
	
	@Override
	public int selectCnt(Report burning) {
		int result = 0;
		try {
			result = session.selectOne("selectCnt", burning);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl selectCnt e.getMessage() -> "+e.getMessage());
		}
		return result;
	}
	
	
	// 현재 급하게 mapper 에 하드 코딩 했지만, 시간 될 때 여기서 값을 줄 것. + 설명 주석 붙이기
	@Override
	public int insertReport(Report burning) {
		
		int result = 0;
		System.out.println("BgReportDaoImpl insertReport burning.getBrd_num() -> "+burning.getBrd_num());
		System.out.println("BgReportDaoImpl insertReport burning.getUser_num() -> "+burning.getUser_num());
		
		try {
			result = session.insert("insertReport", burning);
			System.out.println("BgReportDaoImpl insertReport burning.getBrd_num() -> "+burning.getBrd_num());
			System.out.println("BgReportDaoImpl insertReport burning.getUser_num() -> "+burning.getUser_num());
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl insertReport e.getMessage() -> "+e.getMessage());
			System.out.println("BgReportDaoImpl insertReport burning.getBrd_num() -> "+burning.getBrd_num());
			System.out.println("BgReportDaoImpl insertReport burning.getUser_num() -> "+burning.getUser_num());
			result = -1;
		}
		return result;
	}
	
	
	@Override
	public int cancelCnt(Report burning) {
		
		int result = 0;
		
		try {
			result = session.update("cancelCnt", burning);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl cancelCnt e.getMessage() -> "+e.getMessage());
		}
		
		return result;
	}
	
	
	@Override
	public int undoCnt(Report burning) {
		
		int result = 0;
		
		try {
			result = session.update("undoCnt", burning);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl cancelCnt e.getMessage() -> "+e.getMessage());
		}
		
		return result;
	}
	
	
	@Override
	public int totalReport() {
		
		int totReportCnt = 0;
		System.out.println("BgReportDaoImpl totalReport Start...");
		
		try {
			
			totReportCnt = session.selectOne("reportTotal");
			System.out.println("BgReportDaoImpl totalReport totReportCnt -> "+ totReportCnt);
			
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl totalReport Exception -> "+e.getMessage());
		}
		return totReportCnt;
	}
	
	
	
	@Override
	public int totalSearchReport(Report report) {
		
		int totalSearchReport = 0;
		System.out.println("BgReportDaoImpl totalSearchReport Start...");
		System.out.println("BgReportDaoImpl totalSearchReport report.getSearchType() -> " + report.getSearchType());
		System.out.println("BgReportDaoImpl totalSearchReport report.getKeyword() -> " + report.getKeyword());
		
		try {
			
			totalSearchReport = session.selectOne("totalSearchReport", report);
			System.out.println("BgReportDaoImpl totalSearchReport totalSearchReport -> "+ totalSearchReport);
			
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl totalSearchReport Exception -> "+e.getMessage());
		}
		return totalSearchReport;
	}
	
	
	
	@Override
	public List<Report> listReport(Report report) {
		
		List<Report> reportList = null;
		System.out.println("BgReportDaoImpl listReport Start...");
		
		try {
			reportList = session.selectList("bgReportBoardAll", report);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl listReport Exception -> " + e.getMessage());
		}
		return reportList;
	}
	
	
	
	@Override
	public int resetReportCnts(List<Report> selectedReports) {
		
		System.out.println("BgReportDaoImpl resetReportCnts Start...");
		System.out.println("BgReportDaoImpl resetReportCnts selectedReports.size() -> "+selectedReports.size());
		for(Report report1 : selectedReports) {
			System.out.println("BgReportDaoImpl resetReportCnts report -> "+report1);
			
		}
		
		int result = 0;
		
		try {
			result = session.update("resetReportCnts", selectedReports);
			System.out.println("BgReportDaoImpl resetReportCnts result -> " + result);
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl resetReportCnts e.getMessage() -> "+e.getMessage());
		}
		
		return result;
	}
	

	
	
	// 보류된 DAO들
	@Override
	public Report recordANDCnt(Report burning) {
		
		System.out.println("BgReportDaoImpl recordANDCnt Start... ");
		
		
		burning = null;
		
		try {
			burning = session.selectOne("recordANDCnt", burning);
			System.out.println("BgReportDaoImpl recordANDCnt ing...");
			
			System.out.println("BgReportDaoImpl recordANDCnt burning.getCnt() -> " + burning.getCnt());
			System.out.println("BgReportDaoImpl recordANDCnt burning.getBurningRecord() -> " + burning.getBurningRecord());
			
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl recordANDCnt e.getMessage() -> " + e.getMessage());
		}
		
		return burning;
	}

	
	// 현재 급하게 mapper 에 하드 코딩 했지만, 시간 될 때 여기서 값을 줄 것. + 설명 주석 붙이기
	@Override
	public int insBurningRecord(Report burning) {
		
		int result = 0;
		
		try {
			result = session.insert("insBurningRecord", burning);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl selBurningRecord e.getMessage() -> " + e.getMessage());
			result = 1;
		}
		
		return result;
	}


	@Override
	public int updateCnt(Report resultrecordANDCnt) {
		
		int result = 0;
		
		try {
			result = session.update("updateCnt", resultrecordANDCnt);
		} catch (Exception e) {
			System.out.println("BgReportDaoImpl updateCnt e.getMessage() -> " + e.getMessage());
		}
		
		return result;
	}





	


	


	


	


	


	

	


	
	
}
