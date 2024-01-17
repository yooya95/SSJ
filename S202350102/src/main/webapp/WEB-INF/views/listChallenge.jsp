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
<h1>챌린지 목록</h1>
<a href="/challengeDetail">챌린지 상세</a><p>
<p>${sessionScope.user_id }님</p>

<a href="/chgDetail">jh 챌린지 상세</a><p>
<a href="/chgApplicationPage">jh 챌린지 신청</a><p>
<a href="/reviewTab">jh 챌린지 후기 목록</a><p>

<a href="/bgChgDetail">bg 챌린지 상세</a><p>
<a href="/thChgList">jh 챌린지 목록(태현)</a><p>

</body>
</html>