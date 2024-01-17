<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
      <div class="container section-mt">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">쉐어링 게시판</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle " href="../sharing">
                  	전체 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/myLikeSharing">
                 	찜한 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle active" href="/mySharing">
                 	내가 쓴 글
                </a>
               <a class="btn w-100 btn-dark mb-2" href="sharingUserDetail" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 			<!-- Nav End -->
          </div>
              
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between mb-3">
                <!-- 공간을 벌리기 위해 클래스 추가 -->
            </div>
			<div class="d-flex justify-content-end mb-3">
			    총  ${totalMyUploadSharing}건의 게시글이 존재합니다.
			</div>
            </div>
  <div class="row">
  <%-- 	<c:set var="usernum" value="${sessionScope.user_num}" /> --%>
  <c:set var="mySharingList" value="${mySharing}" />
  <input type="hidden" name="brd_num" value="${board.brd_num}"> 
  <input type="hidden" value="${sessionScope.user_num} ">
    <c:forEach var="board" items="${myUploadSharingList}"> <!--연아 서비스 껄로 변경-->
  	<c:if test = "${board.user_num == sessionScope.user_num}">
        <div class="col-6 col-md-4" style="padding-left: 8px; padding-right: 8px;">
            <div class="card mb-7">
                <div class="card-img">
                  
                   <button class="btn btn-xs w-100 btn-dark card-btn" onclick="location.href='myDetailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}'">
				    <i class="fe fe-eye me-2 mb-1"></i> 자세히 보기
					</button>

                  <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${board.img}" alt="..." style="width: 100%; height: 200;">
					 </div>
                <div class="card-body fw-bold text-left"> <!--text-center  -->
                <input type="hidden" value="${board.user_num }"> <input type="hidden" value="${board.brd_num }">
                    <a class="text-body" href="myDetailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                        ${board.title} 
                        <p> ${board.applicants}명 모집 | ${board.participants}명  참가중
                    </a>
                    <a class="text-primary" href="myDetailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                          <fmt:formatNumber value= "${board.price}"  pattern="#,###"/>원</a>    <p>
                    <a class="text-primary"><i class="fas fa-heart me-1"></i> ${board.like_cnt}</a>
                    						<i class="fe fe-eye me-1 mb-1" style="margin-left: 30px;"></i> ${board.view_cnt}
                    						<i class="fas fa-comment text-secondary me-1" style="margin-left: 20px;"></i>${board.replyCount}
                    				
				</div>
				 
            </div>
        </div>
    </c:if>
    </c:forEach>
    </div>
    <!--YA페이징 추가  -->
     <div class="container text-center">
    <ul class="pagination pagination-sm justify-content-center">
        <c:if test="${mySharingPaging.startPage > mySharingPaging.pageBlock}">
            <li class="page-item">
                <a class="page-link page-link-arrow" href="mySharing?currentPage=${mySharingPaging.startPage-mySharingPaging.pageBlock}">
                    <i class="fa fa-caret-left"></i>
                </a>
            </li>
        </c:if>

        <c:forEach var="i" begin="${mySharingPaging.startPage}" end="${mySharingPaging.endPage}">
            <li class="page-item <c:if test='${mySharingPaging.currentPage == i}'>active</c:if>">
                <a class="page-link" href="mySharing?currentPage=${i}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${mySharingPaging.endPage < mySharingPaging.totalPage}">
            <li class="page-item">
                <a class="page-link page-link-arrow" href="mySharing?currentPage=${mySharingPaging.startPage+mySharingPaging.pageBlock}">
                    <i class="fa fa-caret-right"></i>
                </a>
            </li>
        </c:if>
    </ul>
</div> 
    
</div>


          </div>
        </div>
      </div>
    </section>
  
  
  
  
  
  
  
  
  
  
  
   
</body>
<%@ include file="../footer.jsp" %>
</html>
