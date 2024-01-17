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
	<c:forEach var="board" items="${popShareList}">
	    <!-- Item -->
	    <div class="col px-4 " style="max-width: 250px;">
	        
	            <div class="card">
	                <!-- Image -->
	                <div class="card-img-top">
	                
	                	<c:choose>
	               <c:when test="${sessionScope.user_num != null}">
	                   <!-- 로그인 한 상태 -->
	                   <c:choose>
	                       <c:when test="${board.likeyn > 0}">
	                           <!-- 찜하기 있음 -->
	                           <button type="button"
	                               class="btn btn-xs btn-circle btn-primary card-action card-action-end"
	                               data-toggle="button" onclick="sharingPick(${board.brd_num})"
	                               id="sharingPick${board.brd_num}">
	                               <i class="fe fe-heart"></i>
	                           </button>
	                       </c:when>
	
	                       <c:otherwise>
	                           <!-- 찜하기 없음 -->
	                           <button type="button"
	                               class="btn btn-xs btn-circle btn-white-primary card-action card-action-end"
	                               data-toggle="button" onclick="sharingPick(${board.brd_num})"
	                               id="sharingPick${board.brd_num}">
	                               <i class="fe fe-heart"></i>
	                           </button>
	                       </c:otherwise>
	                   </c:choose>
	               </c:when>
	
	               <c:otherwise>
	                   <!-- 로그인 안 한 상태 -->
	                   <button type="button"
	                       class="btn btn-xs btn-circle btn-white-primary card-action card-action-end"
	                       data-toggle="button" onclick="location.href='/loginForm'">
	                       <i class="fe fe-heart"></i>
	                   </button>
	               </c:otherwise>
	           </c:choose>
	           
	                    <button class="btn btn-xs w-100 btn-dark card-btn"
	                            onclick="location.href='detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}'">
	                        <i class="fe fe-eye me-2 mb-1"></i> 자세히 보기
	                    </button>
	                    <a class="text-body"
	                       href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
	                     <img class="card-img-top"
	                          src="${pageContext.request.contextPath}/upload/${board.img}" alt="..."
	                          style="width: 100%; height: 200;">
	                    </a>
	                </div>
	                <!-- Body -->
	                <div class="card-body py-4 px-0 text-center">
	                    <a class="text-body"
	                       href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
	                        ${board.title}
	                    </a><p>
	                    <a class="text-primary"
	                       href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
	                        ${board.price}원
	                    </a><p>
	                    <i class="fas fa-heart me-1 text-primary"></i>
	                    <a class="text-primary" id="likeCnt${board.brd_num}"> ${board.like_cnt}</a>
	                    <i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
	                    <i class="fas fa-comment text-secondary me-1"
	                       style="margin-left: 20px;"></i>${board.replyCount}
	                </div>
	            </div>
	        
	    </div>
	    <!-- Item -->
	</c:forEach>
	</div>
</body>
</html>