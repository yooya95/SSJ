<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 유저 조회</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		// 검색어 입력 후 엔터키 입력하면 검색버튼 클릭
		$("#keyword").keypress(function(e){	
			if(e.keyCode && e.keyCode == 13){
				$("#searchButton").trigger("click");
				return false;
			}
		});
	});
	
	// 검색 구현
	$(function() {
		$("#searchButton").click(function () {
			var keyword 	=	$("#keyword").val();
			// 진행중,종료된 챌린지를 체크하기위해서 status_md를 넣어줌
			location.href = '/listUserAdmin?keyword='+keyword
		})
	})
	
	// 현재 페이지 그대로 이동
	function moveCurrentPage() {
		var currentPage	=	${page.currentPage}
		var keyword 	=	"${chg.keyword}"
		
		location.href= '/listUserAdmin?currentPage='+currentPage+'&keyword='+keyword;
	}
	// 다른 페이지로 이동
	function movePage(p_index) {
		//	movaPage에 index를 넣어서 페이지이동 시킴
 		var pageNum		=	document.getElementById('movePage'+p_index).innerText
 		var keyword 	=	"${user1.keyword}"
		location.href= '/listUserAdmin?currentPage='+pageNum+'&keyword='+keyword;
	}
	
	// 이전 블럭 이동
	function movePrevBlock() {
		var pageNum		=	${page.startPage - page.pageBlock }
		var keyword 	=	"${user1.keyword}"
		location.href= '/listUserAdmin?&currentPage='+pageNum+'&keyword='+keyword;
	}
	
	// 다음 블럭 이동
	function moveNextBlock() {
		var pageNum		=	${page.startPage + page.pageBlock }
		var keyword 	=	"${user1.keyword}"
		location.href= '/listUserAdmin?&currentPage='+pageNum+'&keyword='+keyword;
	}
	
</script>
</head>
<body>
<section class="pt-7 pb-12">
 	<div class="container section-mt">
 	
	 	<!-- TITLE  -->
	 	<div class="col-12 text-center">    
				<h3 class="mb-10">회원 관리</h3>
	    </div>
	    
	    <div class="row">
	    
		<%@ include file="../jh/adminSidebar.jsp" %>
	
			<div class="col-10">
			<c:set var="num" value="${page.total-page.start+1 }"></c:set>
			
				<table class="table table-bordered table-hover table-sm mb-0">
				  <thead class="table-dark">
					<tr class="p-2 text-center">
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>회원상태</th>
						<th class="text-center"> 탈퇴여부 </th>
						<th class="text-center"> 상세정보 </th>
					</tr>
				  </thead>
				  <tbody>
					<c:forEach var="user1" items="${user1List }" varStatus="status">
						<tr class="text-center" id="user${status.index }">
							<input type="hidden" id="user_num${status.index}" value="${user1.user_num }">
							<input type="hidden" id="delete_yn${status.index}" value="${user1.delete_yn }">
							<td>${num }</td>
							<td>${user1.user_id }</td>
							<td>${user1.user_name}</td>
							<td>${user1.tel }</td>
							<c:choose>
								<c:when test="${user1.status_md == 100 }"><td>일반</td></c:when>
								<c:when test="${user1.status_md == 101 }"><td>멤버쉽</td></c:when>
								<c:when test="${user1.status_md == 102 }"><td>관리자</td></c:when>
								<c:when test="${user1.status_md == '' }"><td></td></c:when>
							</c:choose>						
							<td>${user1.delete_yn }</td>
							<td class="justify-content-center">
								<button type="button" class="btn btn-secondary btn-xs" onclick="location.href='/detailUserByAdmin?user_num=${user1.user_num}&pageNum=${page.currentPage}&keyword=${keyword }'">상세보기</button>
							</td>
						</tr>
						<c:set var="num" value="${num -1 }"></c:set>
					</c:forEach>
				 </tbody>
				</table>
				
					<!-- 페이지네이션  -->
						 <nav class="d-flex justify-content-center justify-content-md-center mt-3">
							 <ul class="pagination pagination-sm text-gray-400">
			      	   		 <!-- 이전 블럭 이동 -->
							  	<c:if test="${page.startPage > page.pageBlock }">
							  		<li class="page-item">
										<a class="page-link page-link-arrow" href="#" onclick="movePrevBlock()">
										<i class="fa fa-caret-left"></i></a>
									</li>
								</c:if>
								
							    <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }" varStatus="status">
									<li class="page-item">
										<c:if test="${i == page.currentPage }">
											<a class="page-link" onclick="moveCurrentPage()" href="#" id="moveCurrentPage"><b class="text-primary">${i}</b></a>
										</c:if>
										<c:if test="${i != page.currentPage }">
											<a class="page-link" onclick="movePage(${status.index })" href="#" id="movePage${status.index }">${i}</a>
										</c:if>
									</li>
								</c:forEach>
								<!-- 다음 블럭 이동 -->
							    <c:if test="${page.endPage < page.totalPage }">
							    	<li class="page-item">
										<a class="page-link page-link-arrow" href="#" onclick="moveNextBlock()">
										<i class="fa fa-caret-right"></i></a>
									</li>
								</c:if>
							 </ul>
				  		</nav>
				  		
			  		<!-- 나중에 이름 검색 추가하기 검색 옆에 sort 값줘서 -->
					<div class="container d-flex justify-content-center my-5">
					    <div class="d-flex justify-content-center">
					        <div class="input-group input-group-merge">
					            <input class="form-control form-control-sm" id="keyword" type="search" placeholder="아이디 검색" value="${keyword}">
								<div class="input-group-append">
<!-- 									부트스트랩에서 button or div 내 이미지 수평+수직정렬					 -->
								    <button class="btn btn-outline-border btn-search d-flex justify-content-center align-items-center"  id="searchButton">
								        <i class="fe fe-search"></i>
								    </button>
								</div>
					        </div>
					    </div>
					</div>
					
				  </div>
			  	</div>
			  	
	
		  	<div class="py-10"></div>	
</div>
</section>	  		

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>

</html>