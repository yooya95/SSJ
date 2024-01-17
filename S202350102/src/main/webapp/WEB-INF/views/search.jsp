<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="topBar.jsp" %>
<%@ include file="header4.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#test{
		width: 200px;
	}
	
	#shList{
		z-index: 999;
		position: absolute;
	}
	#searchVar{
		width: 30%
	}
	.flickity-viewport {  
	  height: 400px !important;
	}
	
	.cell {
  width: 100%; /* full width */
  height: 160px; /* height of carousel */
  margin-right: 10px;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	//yr 작성
	// 찜하기 기능
	function chgPick(p_index) {
	
		$.ajax({
			url : "/chgPickPro",
			type : "POST",
			data : {chg_id : p_index},
			dataType : 'json',
			success : function(chgPickResult) {
				if(chgPickResult.chgPick > 0) {
					$("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
				} else {
					$("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
				}
	
			},
			error : function() {
				alert("찜하기 오류");
			}
		});
	}
	
	function sh(){
		if($("#shList").css("display") == "none" || $("#shList").css("display") == ""){
		    $("#shList").show();
		} else {
		    $("#shList").hide();
		    
		}
	}
	
	$(function(){
		$.ajax(
			{
				type:"GET",
				url: "srch_history",
				dataType:"json",
				success:function(data){
					var str = hisList(data);
					$("#listCont").html(str);
				}
			}		
		);
		
		
		
	})
	
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
<style type="text/css">
	#srch_btn{
		background-color: transparent;
	}
	
	#searchVar{
		width: 30%
	}
	.flickity-viewport {  
	  height: 400px !important;
	  padding: 10px
	}

</style>
</head>
<body>
<h1>검색</h1>
<section>
	<div id="searchVar" class="container">
		<form action="searching">
			<div class="input-group">				
				<input type="search" name="srch_word" id="srch_word" class="form-control form-control-underline form-control-sm border-dark" onclick="sh()" >
				<button type="submit" class="btn-underline btn-sm border-dark" id="srch_btn">
					<i class="fe fe-search"></i>
				</button>
			
			</div>			
		</form>
		<div class="card" id="shList" style="display: none;">
			<c:if test="${user_num != 0 }">
				<div class="card-body">
					<table>
						<c:forEach items="${shList }" var="shList">
							<tr>
								<td>
									<a href="searching?srch_word=${shList.srch_word }">${shList.srch_word }</a>
								</td>
								<td>
									<a href="deleteHis?srch_word=${shList.srch_word }">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
										  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
										</svg>
									</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>
	</div>

    <section class="py-12">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h2 class="mb-4 text-center">HOT</h2>

            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#popChg" data-bs-toggle="tab">challenge</a>
              <a class="nav-link" href="#popShare" data-bs-toggle="tab">Share</a>              
              <a class="nav-link" href="#popCommu" data-bs-toggle="tab">Community</a>              
            </div>

            <!-- Content -->
            <div class="tab-content">

              <!-- Pane -->
              <div class="tab-pane fade show active" id="popChg">
				
                <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true,"setGallerySize": false}'>

                  <!-- Item2 -->
                  <c:forEach var="chg" items="${popchgList }">
                  <div class="col px-4" style="max-width: 400px;">
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
                 <!-- Slider -->
                 
				
              </div>
              <!-- Pane -->
              <!-- Pane popShare -->
             <div class="tab-pane fade" id="popShare">
             
			    <!-- Slider -->
			    <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true,"cellAlign": left}'>
			        <div class="row">
			            <c:forEach var="board" items="${popShareList}">
			                <!-- Item -->
			                <div class="col px-4 " style="max-width: 400px;">
			                    
			                        <div class="card">
			                            <!-- Image -->
			                            <div class="card-img-top">
			                                <button class="btn btn-xs btn-circle btn-white-primary card-action card-action-end"
			                                        onclick="likePost(${board.brd_num})">
			                                    <i class="fe fe-heart"></i>
			                                </button>
			                                <button class="btn btn-xs w-100 btn-dark card-btn"
			                                        onclick="location.href='detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}'">
			                                    <i class="fe fe-eye me-2 mb-1"></i> 자세히 보기
			                                </button>
			                                <img class="card-img-top"
			                                     src="${pageContext.request.contextPath}/upload/${board.img}" alt="..."
			                                     style="width: 100%; height: 200;">
			                            </div>
			                            <!-- Body -->
			                            <div class="card-body py-4 px-0 text-center">
			                                <a class="stretched-link text-body"
			                                   href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
			                                    ${board.title}
			                                </a><p>
			                                <a class="stretched-link text-primary"
			                                   href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
			                                    ${board.price}원
			                                </a><p>
			                                <a class="stretched-link text-primary"><i class="fas fa-heart me-1"></i> ${board.like_cnt}</a>
			                                <i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
			                                <i class="fas fa-comment text-secondary me-1"
			                                   style="margin-left: 20px;"></i>${board.replyCount}
			                            </div>
			                        </div>
			                    
			                </div>
			                <!-- Item -->
			            </c:forEach>
			        </div>
			    </div>
			    <!-- Slider -->
			    
			</div>
			<!-- Pane popShare -->
			<div class="tab-pane fade" id="popCommu">
				<table class="table">
					<tr>
						<td>제목</td><td>작성자</td><td>등록일</td><td>조회수</td><td>댓글수</td>
					</tr>
					<c:forEach var="popBoard" items="${popBoardList }">
						<tr>
							<td><a href="detailCommunity?user_num=${popBoard.user_num}&brd_num=${popBoard.brd_num}">${popBoard.title }</a></td>
							<td>${popBoard.nick }</td>							
							<td><fmt:formatDate value="${popBoard.reg_date }" pattern="yyyy-MM-dd" /></td>
							<td>${popBoard.view_cnt }</td>
							<td>${popBoard.replyCount }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
          </div>
          <!-- Content -->
            
          </div>
        </div>
        <!-- row -->
      </div>
      <!-- container -->
    </section>
		
<%@ include file="footer.jsp" %>
</body>
</html>