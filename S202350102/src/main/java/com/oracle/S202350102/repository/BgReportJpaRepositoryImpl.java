package com.oracle.S202350102.repository;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;

import com.oracle.S202350102.domain.Report;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BgReportJpaRepositoryImpl implements BgReportJpaRepository {
	
	private final EntityManager em;
	
	
	@Override
	public void updateByReport(int report_id) {
		// merge		--> 현재 Setting 된 것만 수정, 나머지는 Null
		// em.merge(report);
		// 고전적 방식 아래
		Report report = em.find(Report.class, report_id);
		report.setCnt(0);
		em.persist(report);
		return;
		
	}
	
	
	// resetReportCnt ver.1  폐기
	@Override
	public Optional<Report> findByReportId(int report_id) {
		
		Report report = em.find(Report.class, report_id);
		
		return Optional.ofNullable(report);
	}
	
	
	// 신고 리스트 만들려다가 폐기 <- 쿼리문이 복잡해서 Mybatis로 진행
	@Override
	public List<Report> findAll() {
		System.out.println("BgReportJpaRepositoryImpl findAll Start...");
		List<Report> reportList = em.createQuery("select r.report_id, u.user_id, r.report_date, b.title, Reported_author_info_func(b.brd_num) " 
												+"from Report r "
												+"Inner Join user1 u On r.user_num = u.user_num "
												+"Inner Join Board b On r.brd_num = b.brd_num", Report.class)
									.getResultList();
		return reportList;
	}


	
	
	

}
