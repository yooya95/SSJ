<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section>
	<div class="container">
		<h3>자유게시판</h3>
		<c:if test="${empty srch_CommuResult }">
			<h6>검색결과가 없습니다.</h6>
		</c:if>
		<table class="table">
			<c:set var="num" value="1"/>	
			<c:forEach items="${srch_CommuResult }" var="brdResultList">
				<c:if test="${num < 6 }">
					<tr>
						<td>
							<a href="detailCommunity?user_num=${brdResultList.user_num}&brd_num=${brdResultList.brd_num}">${brdResultList.title }</a>
						</td>
						<td><fmt:formatDate value="${brdResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
						<td>${brdResultList.nick }</td>
					</tr>
					<c:set var="num" value="${num+1 }"/>
				</c:if>			
			</c:forEach>
			
		</table>
		<%-- <a href="srchcommunity?srch_word=${srch_word }">더보기</a> --%>
		<div class="page">
			<c:if test="${page.startPage >page.pageBlock}">					        
			    <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',103,'${page.startPage-page.pageBlock}'); return false;" >[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">					    	
			    <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',103,'${i}'); return false;" >[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">					        
			    <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',103,'${page.startPage+page.pageBlock}'); return false;" >[다음]</a>
			</c:if>
		</div> 
	</div>	
</section>
</body>
</html>