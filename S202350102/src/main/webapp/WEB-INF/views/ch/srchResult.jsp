<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../../js/jquery.js"></script>
<script type="text/javascript">
	function sh(){
		if($("#shList").css("display") == "none" || $("#shList").css("display") == ""){
		    $("#shList").show();
		} else {
		    $("#shList").hide();
		    
		}
	}
	
	function clickChgResult(srch_word, brd_md) {		
		
		$.ajax(
				{
					data: {"keyword" : srch_word, brd_md : brd_md},
					url: "clickSrchResult",
					dataType:"html",
					success:function(data){
						
						$("#tab"+brd_md).html(data);
					}
				}		
			);
	}
	
	function clickChgResult(srch_word, brd_md,currentPage) {		
		
		$.ajax(
				{
					data: {"keyword" : srch_word, brd_md : brd_md, "currentPage" : currentPage},
					url: "clickSrchResult",
					dataType:"html",
					success:function(data){
						
						$("#tab"+brd_md).html(data);
					}
				}		
			);
	}
	
	function moveAndLoadTab(brd_md, srch_word) {
		
		$(".nav-link").removeClass("active");
	    $(".tab-pane.fade").removeClass("show");
	    $(".tab-pane.fade").removeClass("active");
	    switch(brd_md){
	    	case(200):
	    		$("#nav"+brd_md).addClass("active");
	    		$("#tab"+brd_md).addClass("show active");		    	
	    		break;
	    	case(102):
	    		$("#nav"+brd_md).addClass("active");
	    		$("#tab"+brd_md).addClass("show active");		    	
	    		break;
	    	case(103):
	    		$("#nav"+brd_md).addClass("active");
	    		$("#tab"+brd_md).addClass("show active");		    	
	    		break;
	    }
	   
	    clickChgResult(srch_word,brd_md);
	}
	// 챌린지 찜하기
	function chgPick(p_index) {
		// var chg_id = p_chg_id;
		// alert("chg_id -> " + chg_id);

		$.ajax({
			url : "/chgPickPro",
			type : "POST",
			data : {chg_id : p_index},
			dataType : 'json',
			success : function(chgPickResult) {
				if(chgPickResult.chgPick > 0) {
					$("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
					alert("찜 성공");
				} else {
					$("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
					alert("찜 취소");
				}

			},
			error : function() {
				alert("찜하기 오류");
			}
		});
	}
	
	function sharingPick(p_index) {
        // alert("sharingPick" + p_index);

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
	
	
</script>
<style type="text/css">
	#shList{
		z-index: 999;
		position: absolute;
	}
	
	#srch_btn{
		background-color: transparent;
	}
	
	#searchVar{
		width: 30%
	}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="section-mt">
	<div id="searchVar" class="container">
		<form action="searching">
			<div class="input-group">				
				<input type="search" name="srch_word" id="srch_word" class="form-control form-control-underline form-control-sm border-dark" onclick="sh()" value="${srch_word }"
				>
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
		<h2 style="">'${srch_word }'에 대한 검색결과 입니다.</h2>
	</div>
	
	
	<div class="container">
	        <div class="row">
	        	<div class="col-12">
	            
		            <!-- Nav -->
		            <div class="nav justify-content-center mb-10">
		            	<a class="nav-link active" href="#allResult" data-bs-toggle="tab">통합</a>
		            	<a class="nav-link" href="#tab200" data-bs-toggle="tab"   onclick="clickChgResult('${srch_word }',200)" id="nav200">챌린지</a>
		            	<a class="nav-link" href="#tab102" data-bs-toggle="tab" onclick="clickChgResult('${srch_word }',102)" id="nav102">쉐어링</a>
		            	<a class="nav-link" href="#tab103" data-bs-toggle="tab" onclick="clickChgResult('${srch_word }',103)" id="nav103">자유글</a>
		            </div>	
		            
	            	<!-- Content -->
		            <div class="tab-content">	
		            	<!-- Pane -->
		            	<div class="tab-pane fade show active" id="allResult">
		            		<section>								
								<div class="container">
									<h4>챌린지</h4>
									<c:if test="${empty srch_chgResult }">
										<h6>검색결과가 없습니다.</h6>
									</c:if>
									<div class="row">									
									<c:forEach items="${srch_chgResult }" var="chg" varStatus="status">										
											
								            <div class="col-6 col-md-2">
											
								               <!-- Card -->
								              <div class="card mb-7">
								
								                <!-- Image -->
								                <div class="card-img">
								
													<!-- YR 작성 -->
													<!-- 찜하기 -->
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
								
								                  <!-- Image -->
								                  <a class="text-body" href="chgDetail?chg_id=${chg.chg_id }">
								                  <c:if test="${chg.thumb != null}">
								             		<c:if test="${chg.thumb == 'assets/img/chgDfaultImg.png'}">
								                  		<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
								                  	</c:if>
								                  	<c:if test="${chg.thumb != 'assets/img/chgDfaultImg.png'}">
								                  		<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
								                  	</c:if>
								                  </c:if>
								                  <c:if test="${chg.thumb == null}">
								                  	<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
								                  </c:if>
					
												  </a>
								              </div>
								
								              <!-- Body -->
								              <div class="card-body fw-bold text-start px-0 py-2">
								                <a class="text-body fw-bolder fs-6" href="chgDetail?chg_id=${chg.chg_id }">${chg.title }</a>
								                <div> 
								                 <fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
								                  ~ 
								                 <fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
								                 </div>
								                <div>참여인원: ${chg.chlgerCnt}명</div>
								                <div>찜수: ${chg.pick_cnt }</div>
								              </div>
												
								            </div>
								            	
										  </div>
									</c:forEach>
									</div>
								</div>
							<button onclick="moveAndLoadTab(200, '${srch_word}')" class="btn btn-outline-dark btn-xxs">더보기</button>
							</section>
							
							<hr>
							<section>
								<div class="container">
									<h3>쉐어링</h3>
									<c:if test="${empty srch_shareResult }">
										<h6>검색결과가 없습니다.</h6>
									</c:if>
									
										<div class="row">										
										<c:forEach var="board" items="${srch_shareResult}">
	    					
									        <div class="col-6 col-md-2" style="padding-left: 8px; padding-right: 8px;">
									            <div class="card">
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
									    </div>							
								</div>
							<button onclick="moveAndLoadTab(102, '${srch_word}')" class="btn btn-outline-dark btn-xxs">더보기</button>
							</section>
							
							<hr>
							
							<section>
								<div class="container">
									<h3>자유게시판</h3>
									<c:if test="${empty srch_brdResult }">
										<h6>검색결과가 없습니다.</h6>
									</c:if>
									<table class="table">
										<c:set var="num" value="1"/>	
										<c:forEach items="${srch_brdResult }" var="brdResultList">
											<c:if test="${num < 6 }">
												<tr>
													<td>
														<a href="detailCommunity?user_num=${brdResultList.user_num}&brd_num=${brdResultList.brd_num}">${brdResultList.title }</a>
													</td>
													<td><fmt:formatDate value="${brdResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
													<td>${brdResultList.nick }</td>
												</tr>
												<c:set var="num" value="${num+1 }"/>
											</c:if>			
										</c:forEach>
										
									</table>
									<%-- <a href="srchcommunity?srch_word=${srch_word }">더보기</a> --%>
								</div>
								<button onclick="moveAndLoadTab(103, '${srch_word}')" class="btn btn-outline-dark btn-xxs">더보기</button>
							</section>
		            	</div> 
		            	
		            	
		            	
		            	<div class="tab-pane fade" id="tab200">
		            	 
		            	</div>
		            	
		            	<div class="tab-pane fade" id="tab102">
		            	 
		            	</div>
		            	
		            	<div class="tab-pane fade" id="tab103">
		            	 
		            	</div>
						
		            	
		        	</div> <!-- tab-content -->
				</div> <!-- col-12 -->
			</div> <!-- row -->
		</div> <!-- container -->
</div>
	
	
	
	
	
	
<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>