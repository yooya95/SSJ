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
<table class="table">
	<tr>
		<td>제목</td><td>작성자</td><td>등록일</td><td>조회수</td><td>댓글수</td>
	</tr>
	<c:forEach var="popBoard" items="${popBoardList }">
		<tr>
			<td><a href="detailCommunity?user_num=${popBoard.user_num}&brd_num=${popBoard.brd_num}">${popBoard.title }</a></td>
			<td>${popBoard.nick }</td>							
			<td><fmt:formatDate value="${popBoard.reg_date }" pattern="yyyy-MM-dd" /></td>
			<td>${popBoard.view_cnt }</td>
			<td>${popBoard.replyCount }</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>