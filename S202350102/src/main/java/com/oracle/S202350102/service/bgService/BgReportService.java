package com.oracle.S202350102.service.bgService;

import java.util.List;

import com.oracle.S202350102.dto.Report;

public interface BgReportService {

	int 			burning(Report burning);
	int				totalReport();
	List<Report>	listReport(Report report);
	int            resetReportCnts(List<Report> selectedReports);
	int             totalSearchReport(Report report);

}
