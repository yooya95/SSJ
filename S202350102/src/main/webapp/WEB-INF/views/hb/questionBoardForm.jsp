<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/header4.jsp"/>
	<h1>문의게시판</h1>
	<div id="container section-mt">
		<table border="1">
			<thead>
				<tr><td>번호</td><td>제목</td><td>조회수</td><td>작성일</td></tr>
				<c:forEach var="board" items="${qBoardList }">
					<tr>
						<td>${board.brd_num }</td>
						<td><a href="qBoardDetail?brd_num=${brd_num }">${board.title }</a></td>
						<td>${board.view_cnt }</td>
						<td>${board.reg_date }</td>
				</c:forEach>
			</thead>
		</table>
		<a href="qBoardInsertForm" class="btn">글쓰기</a>
	</div>
<c:import url="/WEB-INF/views/footer.jsp"/>
</body>
</html>