<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // yr 작성
	// 찜하기 기능
	function sharingPick(p_index) {
    	
        $.ajax({
            url: "/likePro",
            type: "POST",
            data: { brd_num: p_index },
            dataType: 'json',
            success: function (likeResult) {
                if (likeResult.likeProResult > 0) {
                    $("#sharingPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
                    alert("찜 성공");
                } else {
                    $("#sharingPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
                    alert("찜 취소");
                }
				$('#likeCnt' + p_index).text(likeResult.brdLikeCnt);
            },
            error: function () {
                alert("찜하기 오류");
            }
        });
    }
    
    
	 $(document).ready(function() {
		 $("#keyword").keypress(function(e){	
		 	if(e.keyCode && e.keyCode == 13){
		 		$("#searchButton").trigger("click");
		 		return false;
		 	}
		 });
		  });
    
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
                <a class="list-group-item list-group-item-action dropend-toggle active" href="../sharing">
                  	전체 쉐어링
                </a>
                <a  id="options" class="list-group-item list-group-item-action dropend-toggle " href="/myLikeSharing">
                 	찜한 쉐어링
                </a>
                <a  id="options" class="list-group-item list-group-item-action dropend-toggle " href="/mySharing">
                 	내가 쓴 글
                </a>
               <a class="btn w-100 btn-dark mb-2"  id="options" href="sharingUserDetail" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 			<!-- Nav End -->
          </div>
              
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <div class="row">
<!--         <div class="col-12">
            <div class="d-flex justify-content-between mb-3">
                공간을 벌리기 위해 클래스 추가
            </div> -->
				<div class="container d-flex justify-content-center my-5">
				    <div class="d-flex justify-content-center">
				        <div class="input-group input-group-merge">
				            <input class="form-control form-control-sm" id="keyword" type="search" placeholder="구매할 제품을 검색해주세요!" value="${keyword}">
							<div class="input-group-append">
								<!-- 부트스트랩에서 button or div 내 이미지 수평+수직정렬 -->					
							    <button class="btn btn-outline-border btn-search d-flex justify-content-center align-items-center"  id="searchButton"
							   onclick="location.href='sharingSearchResult?keyword=${keyword}'"  >
							        <i class="fe fe-search"></i>
							    </button>
							</div>
				        </div>
				    </div>
				</div>      
<script>
    // 검색 버튼 클릭 시
    document.getElementById('searchButton').addEventListener('click', function() {
        // 현재 검색어 값 가져오기
        var keywordValue = document.getElementById('keyword').value;

        // URL에 검색어 추가하고 페이지 다시로드
        window.location.href = 'sharingSearchResult?keyword=' + keywordValue;
    });
</script>

            
            <div class="d-flex justify-content-end mb-3">
			<select class="form-select form-select-xxs w-auto" id ="sortOption"name="sortOption"  onchange="applySortOption()">
			    <option value="reg_date" ${sortOption == 'reg_date' ? 'selected' : ''}>최근 게시물</option>
			    <option value="view_cnt" ${sortOption == 'view_cnt' ? 'selected' : ''}>조회수 높은 순</option>
			</select>
            </div>
            
<script>
    function applySortOption() {
        // 선택한 정렬 옵션 가져오기
        var sortOption = document.getElementById('sortOption').value;

        // 현재 검색어 값 가져오기
        var keywordValue = document.getElementById('keyword').value;

        // URL에 검색어와 정렬 옵션 추가하고 페이지 다시로드
        window.location.href = 'sharingSearchResult?keyword=' + keywordValue + '&sortOption=' + sortOption;
    }
</script>            
            
            
            </div>
  <div class="row" id="boardtable">
    <c:forEach var="board" items="${sharingSearchResult}">
    
        <div class="col-6 col-md-4" style="padding-left: 8px; padding-right: 8px;">
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
                
                <div class="card-body fw-bold text-left"> <!-------연아 수정: 링크 에러로 input으로 value값 넣어줌 좌측정렬로 변경, price 원단위 ------->
                	<input type="hidden" value="${board.user_num }"> <input type="hidden" value="${board.brd_num }">
                    <a class="text-body " href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                        ${board.title} <p> ${board.applicants}명 모집 | ${board.participants }명  참가중
                    </a>          	
                        <a class="text-primary " href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                            <fmt:formatNumber value= "${board.price}"  pattern="#,###"/>원</a>                        
                    <p>
                        <i class="fas fa-heart me-1 text-primary"></i>
                        <a class="text-primary" id="likeCnt${board.brd_num}"> ${board.like_cnt}</a>
                        <i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
                        <i class="fas fa-comment text-secondary me-1" style="margin-left: 20px;"></i>${board.replyCount}
                </div>
    
            </div>
        </div>
    </c:forEach>
</div>


 <div class="container text-center">
    <ul class="pagination pagination-sm justify-content-center">
        <c:if test="${sharBoardPage.startPage > sharBoardPage.pageBlock}">
            <li class="page-item">
                <a class="page-link page-link-arrow" href="sharingSearchResult?currentPage=${sharBoardPage.startPage-sharBoardPage.pageBlock}&keyword=${keyword}">
                    <i class="fa fa-caret-left"></i>
                </a>
            </li>
        </c:if>

        <c:forEach var="i" begin="${sharBoardPage.startPage}" end="${sharBoardPage.endPage}">
            <li class="page-item <c:if test='${sharBoardPage.currentPage == i}'>active</c:if>">
                <a class="page-link" href="sharingSearchResult?currentPage=${i}&keyword=${keyword}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${sharBoardPage.endPage < sharBoardPage.totalPage}">
            <li class="page-item">
                <a class="page-link page-link-arrow" href="sharingSearchResult?currentPage=${sharBoardPage.startPage+sharBoardPage.pageBlock}&keyword=${keyword}">
                    <i class="fa fa-caret-right"></i>
                </a>
            </li>
        </c:if>
    </ul>
</div> 



          </div>
        </div>
      </div>
    </section>
  
  
  <!--ya 비로그인 자가 글작성, 내가쓴글 확인  시도시 알람창 띄우면서 로그인 페이지로 넘겨버리기  ---------->
<script>
    document.addEventListener('DOMContentLoaded', function () {
    	  const form = document.getElementById('options');
          form.addEventListener('click', function (event) {
            // 세션의 user_num 값 확인
            const userNum = <%= session.getAttribute("user_num") %>;

            // user_num이 null인 경우 알림창 띄우고 로그인 페이지로 이동
            if (userNum === null) {
                alert('로그인 후 이용해주세요!');
                event.preventDefault(); // 폼 전송을 막음
                window.location.href = '/loginForm'; // 로그인 페이지로 이동
            }
        });
    });
</script>
  
  
  
  
  
  
  
  
   
</body>

<%@ include file="../footer.jsp" %>
</html>
