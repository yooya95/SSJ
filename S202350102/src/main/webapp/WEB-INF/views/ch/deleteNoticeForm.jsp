<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="section-mt">
		<form action="deleteNotice" method="post">
			<input type="hidden" name="brd_num" value="${brd_num }">
			<input type="hidden" name="brd_md" value="${brd_md }">
			삭제하시겠습니까?<p>
			<input type="submit" value="네">
			<input type="button" value="아니오" onclick="location.href='noticeConts?brd_num=${brd_num}'">
			
		</form>	
	</section>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>