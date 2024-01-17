<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<script type="text/javascript">
	function goBack() {
		history.back();
	}
</script>
</head>
<body>
	<h2>로그아웃하시겠습니까?</h2>
	<form action="/logout">
		<input type="submit" value="네">
		<input type="button" value="돌아가기" onclick="goBack()"> <p>
	</form>
	
	<form action="/deleteUser1Form">
		<input type="submit" value="회원탈퇴">
	</form>

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>

