package com.oracle.S202350102.service.hbService;

import lombok.Data;

@Data
public class Paging {
	private int currentPage = 1;	private int rowPage   = 10;
	private int pageBlock = 10;		
	private int start;				private int end;
	private int startPage;			private int endPage;
	private int total;				private int totalPage;
    private int brd_md;
	
    public Paging(int total, String currentPage1) {
		this.total = total;
		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);	
		}
		
		start = (currentPage - 1) * rowPage + 1;
		end   = start + rowPage - 1;
		//								7			10
		totalPage = (int) Math.ceil((double)total / rowPage);
		startPage = currentPage - (currentPage - 1) % pageBlock;
		endPage = startPage + pageBlock - 1;
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
	public Paging(int total, String currentPage1, int rowPage1) {
		
		this.total = total;
		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);	
		}
			// rowPage1 값을 주면 rowPage값을 수정
			this.rowPage = rowPage1;	
		
		
		start = (currentPage - 1) * rowPage + 1;
		end   = start + rowPage - 1;
		//								7			10
		totalPage = (int) Math.ceil((double)total / rowPage);
		startPage = currentPage - (currentPage - 1) % pageBlock;
		endPage = startPage + pageBlock - 1;
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
}

