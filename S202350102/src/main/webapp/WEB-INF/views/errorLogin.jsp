<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인 에러</title>
     <script type="text/javascript">
        function loginAlert() {
            alert("로그인이 필요합니다.");
            redirectToLoginForm();
        }

        function redirectToLoginForm() {
            window.location.href = "/loginForm"; // 페이지 이동 코드
        }
    </script>
</head>
<body onload="loginAlert()">

</body>
</html>