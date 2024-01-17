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
<div id="mySlider" class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>
	<c:forEach var="chg" items="${popchgList }">
		<div class="col px-4" style="max-width: 250px;">
			<div class="card">
			
			  <!-- Image -->
				<c:choose>
					<c:when test="${sessionScope.user_num != null}">
					<!-- 로그인 한 상태 -->
						<c:choose>
							<c:when test="${chg.pickyn > 0}">
						<!-- 찜하기 있음 -->
								<button type="button" class="btn btn-xs btn-circle btn-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
									<i class="fe fe-heart"></i>
								</button>
							</c:when>
						
							<c:otherwise>
									<!-- 찜하기 없음 -->
								<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
									<i class="fe fe-heart"></i>
								</button>
							</c:otherwise>
						</c:choose>
					</c:when>
			
					<c:otherwise>
						<!-- 로그인 안 한 상태 -->
						<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button"
							onclick="location.href='/loginForm'">
							<i class="fe fe-heart"></i>
						</button>
					</c:otherwise>
				</c:choose>
			
			              <!-- Button -->
				<button class="btn btn-xs w-100 btn-dark card-btn">
					<i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
				</button>
			
			
				<a class="text-body" href="chgDetail?chg_id=${chg.chg_id }">
					<c:if test="${chg.thumb != null}">
						<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
					</c:if>
					<c:if test="${chg.thumb == null}">
						<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
					</c:if>
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
	</div>
</body>
</html>