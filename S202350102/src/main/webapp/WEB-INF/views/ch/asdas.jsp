<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
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
</head>
<body>
<h1>검색</h1>
<div class="container">
	<div id="searchVar" class="mb-3">
		<form action="searching">
			<label for="srch_word">검색</label>
			<input type="text" name="srch_word" id="srch_word" list="wordList" class="form-control form-control-sm">
			
			<button type="submit">검색</button>				
		</form>
		<div class="card">
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
	
	<hr>
	
	<div class="container">
        
        
              <div class="tab-pane fade show active" id="popChg">
				
                <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>

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
      	  
    
  </div>
	
	<hr>

      <div class="container">      
        
          
              
          <div class="col-12 col-md-9 col-lg-8 ">
           
       		<div class="row align-items-center mb-7">
              <div class="col-12 col-md">

                <!-- Heading -->
                <h3 class="mb-1">인기 쉐어링</h3>

              </div>
              
            </div>
            
			
			    
			  
			        <div class="row">
			             <!-- Slider -->
						                <div class="flickity-buttons-lg flickity-buttons-offset px-lg-6" data-flickity='{"prevNextButtons": true}'>			
										 <c:forEach var="board" items="${popShareList}">
										 <div class="col">
										 	<div class="card mb-7">
							                <div class="card-img">
							                    <button class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" onclick="likePost(${board.brd_num})">
							                        <i class="fe fe-heart"></i>
							                    </button>
							                   <button class="btn btn-xs w-100 btn-dark card-btn" onclick="location.href='detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}'">
											    <i class="fe fe-eye me-2 mb-1"></i> 자세히 보기
												</button>
							
							                  <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${board.img}" alt="..." style="width: 100%; height: 200;">
											</div>
							                <div class="card-body fw-bold text-center">
							                    <a class="text-body" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
							                        ${board.title}
							                    </a><p>
							                    <a class="text-primary" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
							                        ${board.price}원</a><p>
							                    <a class="text-primary"><i class="fas fa-heart me-1"></i> ${board.like_cnt}</a>
							                    						<i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
							                    						<i class="fas fa-comment text-secondary me-1" style="margin-left: 20px;"></i>${board.replyCount}
							                    				
											</div>
											 
							            	</div>
										</div>	  
										</c:forEach>		
						                		          
						                </div> <!-- slider -->
			        </div>
			    
		


           

         
        </div>
      </div>
      
	
	<hr>
	
	<div id="popcommu">
		<h4>인기자유글</h4>
		<table>
			<tr>
				<td>제목</td><td>작성자</td><td>좋아요</td><td>등록일</td>
			</tr>
			<c:forEach var="popBoard" items="${popBoardList }">
				<tr>
					<td><a href="commu?brd_num=${popBoard.brd_num }">${popBoard.title }</a></td>
					<td>${popBoard.nick }</td>
					<td>${popBoard.like_cnt }</td>
					<td><fmt:formatDate value="${popBoard.reg_date }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
		
<%@ include file="footer.jsp" %>
</body>
</html>