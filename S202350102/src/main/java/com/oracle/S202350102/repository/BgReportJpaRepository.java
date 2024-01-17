package com.oracle.S202350102.repository;

import java.util.List;
import java.util.Optional;

import com.oracle.S202350102.domain.Report;

public interface BgReportJpaRepository {

	
	void updateByReport(int report_id);
	
	// resetReportCnt ver.1  폐기
	Optional<Report> findByReportId(int report_id);
	
	// 신고 리스트 만들려다가 폐기 <- 쿼리문이 복잡해서 Mybatis로 진행
	List<Report> findAll();



}
