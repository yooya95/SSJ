<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function fn_alert() {
		alert('회원가입이 완료 되었습니다 \n로그인 페이지로 이동합니다')
		location.href="/loginForm";
	}
</script>
</head>
<body onload="fn_alert()">

</body>
</html>