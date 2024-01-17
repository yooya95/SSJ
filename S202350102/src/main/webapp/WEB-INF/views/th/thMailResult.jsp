<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 결과</title>
<script type="text/javascript">
	function mailAlert(){
		if(${check} == 1){
			alert('회원님의 이메일로 임시비밀번호가 발송 되었습니다');
			location.href = '/loginForm';
		} 
		if(${check} == 2){
			alert('해당 아이디및 이메일에 일치하는 회원이 없습니다');
			location.href = '/loginForm';
		}
		if(${check} == 3){
			alert('해당 아이디및 이메일에 일치하는 회원이 없습니다');
			location.href = '/loginForm';
		}
	}
</script>
</head>
<body onload="mailAlert()">
	
</body>
</html>