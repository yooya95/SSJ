package com.oracle.S202350102.dao.bgDao;

import java.util.List;

import com.oracle.S202350102.dto.Report;

public interface BgReportDao {

	Report			recordANDCnt(Report report);
	int				insBurningRecord(Report burning);
	int				updateCnt(Report resultrecordANDCnt);
	int				selectReportRecord(Report burning);
	int				insertReport(Report burning);
	int				selectCnt(Report burning);
	int				cancelCnt(Report burning);
	int				undoCnt(Report burning);
	int				totalReport();
	List<Report>	listReport(Report report);
	int             resetReportCnts(List<Report> selectedReports);
	int             totalSearchReport(Report report);

}
