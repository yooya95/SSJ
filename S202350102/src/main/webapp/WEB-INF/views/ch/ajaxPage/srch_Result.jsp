<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
</script>
</head>
<body>
	<section>						
		<div class="container">
			<c:if test="${empty srch_chgResult }">
				<h6>검색결과가 없습니다.</h6>
			</c:if>
			<div class="row">
	            <c:set var="num" value="${page.total-page.start+1 }"></c:set>
	            	<c:forEach var="chg" items="${srch_chgResult }">
			            <div class="col-6 col-md-4" style="max-width: 250px;">
						
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
					  <c:set var="num" value="${num -1 }"></c:set>
				</c:forEach>
				
				<!-- 페이지네이션  -->
				  <div class="page">
				    <c:if test="${page.startPage >page.pageBlock}">					        
				        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',200,'${page.startPage-page.pageBlock}'); return false;" >[이전]</a>
				    </c:if>
				    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">					    	
				        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',200,'${i}'); return false;" >[${i}]</a>
				    </c:forEach>
				    <c:if test="${page.endPage < page.totalPage}">					        
				        <a href="javascript:void(0);" onclick="clickChgResult('${srch_word }',200,'${page.startPage+page.pageBlock}'); return false;" >[다음]</a>
				    </c:if>
				  </div> 
			</div>
		</div>
								
	</section>
</body>
</html>