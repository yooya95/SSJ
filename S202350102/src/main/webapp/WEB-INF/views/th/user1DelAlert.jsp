<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function fn_alert(){
		if(${deleteUserCnt} == 1){
			alert('회원 탈퇴가 완료되었습니다')
			location.href="/"
		} else if(${deleteUserCnt} != 1){
			alert('비밀번호가 틀렸습니다.')
			history.back();
		}
		
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="fn_alert()">
</body>
</html>