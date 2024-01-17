<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 필수!! -->
	<c:import url="/WEB-INF/views/header4.jsp"/>
	 <div class="container">
         <div class="row profile">
            <div class="col-md-3">
                <%@ include file="../mypageMenu.jsp" %>
            </div>
             <div class="col-md-9 profile-form">
<!-- 필수!! -->
		<input type="button" value="구독하기(결제창)" onclick="location.href='/'">
		<input type="button" value="구독관리" onclick="location.href='/userSubMng'">
	
</div>
</div>
</div>
<c:import url="/WEB-INF/views/footer.jsp"/>
</body>
</html>