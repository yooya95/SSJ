<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- Item2 참여한 챌린지 -->
<c:forEach items="${mychgrList }" var="chg">
	<div class="col px-4" style="max-width: 250px;">
		<div class="card">
			
			  <!-- Image -->		
			
			
			<a class="text-body" href="chgDetail?chg_id=${chg.chg_id }">
				<c:choose>
					<c:when test="${chg.thumb == 'assets/img/chgDfaultImg.png'}">
						<img class="card-img-top thumb-img" src="/assets/img/chgDfaultImg.png" alt="chgDfault">
					</c:when>
					
					<c:otherwise>
						<img class="card-img-top thumb-img" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb">
					</c:otherwise>
				</c:choose> 
			</a>
			
			               <!-- Body -->
			<div class="card-body py-4 px-0 text-center">
			
				<a class="text-body fw-bolder text-muted fs-6" href="chgDetail?chg_id=${chg.chg_id }">${chg.title }</a>
				<div class="text-muted"> 
					<fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
					~ 
					<fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
				</div>
				<div class="text-muted">참여인원: ${chg.chlgerCnt}
				</div>
				
			</div>
			
		</div>
	</div>
</c:forEach>
</body>
</html>