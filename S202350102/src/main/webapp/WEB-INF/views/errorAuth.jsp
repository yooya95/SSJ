<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>권한 에러</title>
    <script type="text/javascript">
        function adminAlert() {
            alert("접근 권한이 없습니다");
            redirectToHomePage();
        }

        function redirectToHomePage() {
            window.location.href = "/"; // 페이지 이동 코드
        }
    </script>
</head>
<body onload="adminAlert()">
</body>
</html>