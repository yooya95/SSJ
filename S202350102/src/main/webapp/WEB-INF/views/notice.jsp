<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ include file="header4.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
   font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
   
}

/* 타이틀 스타일 */
.page-title {
  	margin-bottom: 30px;
}

.page-title h3 {
  font-size: 28px;
  color: #333333;
  font-weight: 400;
  text-align: center;
}



#searchButton:hover {
  background-color: #fff;
}

/* 검색 결과 스타일 */
#searchResults {
    margin-top: 50px;
}


/* Select 조회와 글작성 부분 스타일--------------------------------------- */
#options {
    float: right; /* 오른쪽 정렬 */
    right: 0;
    margin-right: 500px;
    position: inherit;
 
}

#options select {

    border: none;
    border-radius: 5px;
}

#options input[type="submit"] {
  color: #fff; /* 글자색을 흰색(#fff)으로 설정 */
  background-color: #000; /* 배경색을 검정색(#000)으로 설정 */
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

#options input[type="submit"]:hover {
    background-color: #999; /* 이동 시 조금 어두운 그레이톤 색상 */
}


/* 테이블 스타일 */
#boardtable {
  font-size: 15px;
  height: 500px;
  width: 100%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

#boardtable a {
  color: #333;
  display: inline-block;
  line-height: 1.4;
  word-break: break-all;
  vertical-align: middle;
}
#boardtable a:hover {
  text-decoration: underline;
}
#boardtable th {
  text-align: center;
}

#boardtable .th-num {
  width: 100px;
  text-align: center;
}

#boardtable .th-date {
  width: 200px;
}

#boardtable .th-view_cnt {
  width: 200px;
}

#boardtable .th-replyCount{
  width: 200px;
}

#boardtable th, .board-table td {
  padding: 14px 0;
}

#boardtable tbody td {
  border-top: 1px solid #e7e7e7;
  text-align: center;
}

#boardtable tbody th {
  padding-left: 28px;
  padding-right: 14px;
  border-top: 1px solid #e7e7e7;
  text-align: left;
}

</style>
<title>Insert title here</title>
</head>
<body>
<section class="section-mt" style="padding-top: 30px;">
	<div class="container">
		<div class="row">
			<div class="col-12 text-center">
				<c:if test="${brd_md == 105 }"><h3 class="mb-10">공지사항</h3></c:if>
				<c:if test="${brd_md == 106 }"><h3 class="mb-10">이벤트</h3></c:if>								
			</div>
		
		
			<div class="row" >
				<div class="col-3">
					
					<nav class="mb-10 mb-md-0">
						<div class="list-group list-group-sm list-group-strong list-group-flush-x">
							<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=105">공지사항</a>
							<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=106">이벤트</a>							
						</div>
					</nav>
					<c:if test="${status_md == 102 }">						
						<form action="noticeWriteForm" method="post">
							<input type="hidden" value="${brd_md }" name="brd_md">
							<button class="btn w-100 btn-dark mb-2">글쓰기</button>
						</form>							
					</c:if>
					
				</div>
				
		        <div class="col-9">
					<c:set var="num" value="${page.total-page.start+1 }"></c:set>
					
					<table id="boardtable">
						<thead>
							<tr>
								<th>No</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th>
							</tr>
						</thead>
						<c:forEach var="noticeList" items="${noticeList }">
							<tr>
								<td>${num}</td>
								<td><a href="noticeConts?brd_num=${noticeList.brd_num}">${noticeList.title}</a></td>
								<td>${noticeList.nick}</td>
								<td><fmt:formatDate value="${noticeList.reg_date }" pattern="yyyy-MM-dd"/></td>				
								<td>${noticeList.view_cnt}</td>
							</tr>
							<c:set var="num" value="${num -1 }"></c:set>
						</c:forEach>					
					</table>
					<div class="row">
						<nav class="d-flex justify-content-center justify-content-md-center">
							<c:if test="${page.startPage > page.pageBlock }">
							<a href="notice?currentPage=${page.startPage - page.pageBlock }&brd_md=${brd_md }">[이전]</a>		
							</c:if>
							<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">
								<a href="notice?currentPage=${i }&brd_md=${brd_md }">[${i }]</a><!-- 바꾸고 싶다면 currentPage와 keyword를 가져가는 알고리즘을 짜면 될 듯  -->
							</c:forEach>
							<c:if test="${page.endPage < page.totalPage }">
								<a href="notice?currentPage=${page.startPage + page.pageBlock }&brd_md=${brd_md }">[다음]</a>
							</c:if>	
						</nav>			
					</div>
				</div>
				   
				
				
			</div>
		</div> <!-- row -->
	</div><!-- container -->
</section><!-- 전체 section -->
<%@ include file="footer.jsp" %>
</body>
</html>