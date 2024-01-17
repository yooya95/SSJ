<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수정 성공</title>
	<script type="text/javascript">
			function updateSuccess() {
			    alert('회원정보 수정 성공');
			    redirectToUserDetail();
			}
			
			function redirectToUserDetail() {
			    window.location.href = "/userDetail"; // 페이지 이동 코드
			}
	</script>
</head>
<body onload="updateSuccess()">
</body>
</html>