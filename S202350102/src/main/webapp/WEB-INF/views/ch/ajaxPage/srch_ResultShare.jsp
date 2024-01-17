<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../js/jquery.js"></script>
<script>
$(document).ready(function() {
function likePost(brd_num) {
  
	$.ajax({
	    type: 'POST',
	    url: '/board/' + brd_num + '/like', // 좋아요 업데이트를 처리할 서버 엔드포인트
	    data: { brd_num : brd_num }, // 업데이트할 게시물의 ID를 전송
	    success: function (response) {
	        // 성공 시 수행할 작업
	    },
	    error: function (error) {
	        // 오류 발생 시 수행할 작업
	    }
	});
}
</script>
</head>
<body>
<section class="pt-7 pb-12">
	<div class="row" id="boardtable">
		<c:if test="${empty srch_ShareResult }">
			<h6>검색결과가 없습니다.</h6>
		</c:if>
	    <c:forEach var="board" items="${srch_ShareResult}">
	    
	        <div class="col-6 col-md-4" style="padding-left: 8px; padding-right: 8px; max-width: 250px;">
	            <div class="card mb-7">
	                <div class="card-img">
	    
	                    <!-- YR 작성 -->
	                    <!-- 쉐어링 찜하기 -->
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
	    
	                    <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${board.img}" alt="..."
	                        style="width: 100%; height: 200;">
	                </div>
	                
	                <div class="card-body fw-bold text-center">
	                    <a class="text-body" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
	                        ${board.title}
	                    </a>
	                    <p>
	                        <a class="text-primary" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
	                            ${board.price}원</a>
	                    <p>
	                        <a class="text-primary" id="likeCnt${board.brd_num}">
	                            <i class="fas fa-heart me-1"></i> ${board.like_cnt}
	                        </a>
	                        <i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
	                        <i class="fas fa-comment text-secondary me-1" style="margin-left: 20px;"></i>${board.replyCount}
	                </div>
	    
	            </div>
	        </div>
	    </c:forEach>
	     <div class="page">
		    <c:if test="${page.startPage >page.pageBlock}">					        
		        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',102,'${page.startPage-page.pageBlock}'); return false;" >[이전]</a>
		    </c:if>
		    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">					    	
		        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',102,'${i}'); return false;" >[${i}]</a>
		    </c:forEach>
		    <c:if test="${page.endPage < page.totalPage}">					        
		        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',102,'${page.startPage+page.pageBlock}'); return false;" >[다음]</a>
		    </c:if>
		</div> 
</div>
</section>
</body>
</html>