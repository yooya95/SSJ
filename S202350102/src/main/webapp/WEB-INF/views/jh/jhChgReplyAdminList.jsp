<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 댓글 관리</title>
<script type="text/javascript">
	/* 후기 댓글 삭제 */
	function chgReplyAdminDelete(ori_brd_num, rep_brd_num, chg_id) {
		var admin = 1;
	    var confirmMessage = "글을 삭제하시겠습니까?";
	    if (confirm(confirmMessage)) {
	    	location.href='/replyDelete?ori_brd_num=' + ori_brd_num + '&rep_brd_num=' + rep_brd_num + '&chg_id=' + chg_id ;
			}
	}
	
	function chgReviewAdminFn(chg_id, title){
		location.href='/chgReviewAdmin?chg_id='+chg_id+'&title='+title;
	}
</script>
</head>
<body>
<section class="pt-7 pb-12">
 <div class="container section-mt">
        <div class="row">
        
        
        
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="col-12 text-center">
            
            	<h3 class="mb-10"> "${reviewContent.title }" 댓글 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
		<%@ include file="adminSidebar.jsp" %>	
		
		<div class="col-md-10 ">
		<div class="col-12">
		<div class="col-12 col-md d-flex justify-content-between align-items-center">
		총 댓글 수 : ${replyCount }
		
			<div class="col-auto mb-5"> 
				<button  class="btn btn-xs btn-outline-dark" type="button"  onclick="chgReviewAdminFn('${chg_id}', '${title }')" >목록</button>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${replyCount == 0}">
			<div class="review" id="reply${status.index }">
		  <!-- 댓글 Body -->
		  <div class="review-body">
		    <div class="row">
		
		
			    	<!-- 댓글 내용 -->
					      <div class="col-12 col-md-auto">
						    	
					        <!-- 프로필 사진 -->
					        <div class="avatar avatar-xxl mb-6 mb-md-0">
					          <span class="avatar-title rounded-circle">
					            <i class="fa fa-user"></i>
					          </span>
					        </div>
					
					      </div>
					        <div class="col-12 col-md d-flex justify-content-between align-items-center">
					      
					        <!-- 닉네임 -->
					        <p class="mb-2 fs-lg fw-bold">
					        	작성된 댓글이 없습니다.
					        </p>
					        
					        
					      	</div>
					
	
					      </div>
					
		
		    </div>
		  </div>
		</div>
			</c:when>
			<c:otherwise>

		
		 <c:forEach var="reply" items="${reviewReplyList }" varStatus="status">
    	
	     <div class="review" id="reply${status.index }">
		  <!-- 댓글 Body -->
		  <div class="review-body">
		    <div class="row">
		
		
			    	<!-- 댓글 내용 -->
					      <div class="col-12 col-md-auto">
						    	
					        <!-- 프로필 사진 -->
					        <!-- img -->
                            <div class="col-3">
                              <div class="avatar avatar-xxl mb-6 mb-md-0">
                                <span class="avatar-title rounded-circle">
                                  <img src="${pageContext.request.contextPath}/upload/${reply.img}" alt="profile"
                                    class="avatar-title rounded-circle">
                                </span>
                              </div>
                            </div>
					
					      </div>
					        <div class="col-12 col-md d-flex justify-content-between align-items-center">
					      
					      	<div>
					        <!-- 닉네임 -->
					        <p class="mb-2 fs-lg fw-bold">
					        <span class="col-5"><img title="Lv.${reply.user_level } | exp.${reply.user_exp}(${reply.percentage }%)" src="/images/level/${reply.icon}.gif">${reply.nick }
					        </p>
					        
					        <!-- 댓글 쓴 날짜 및 시간 -->
					        <div class="row mb-6">
					          <div class="col-12">
					            <span class="fs-xs text-muted">
					              <fmt:formatDate value="${reply.reg_date }" pattern="yyyy-MM-dd"/>
					            </span>
					
					          </div>
					        </div>
					
					        <!-- 댓글 내용 -->
					        <p class="text-gray-500">
								${reply.conts }
					        </p>
					      	</div>
					
					        <div class="col-auto ">
					
			
				             <!-- 글쓴이일 경우 수정, 삭제 버튼 활성화 -->
				             <!-- 삭제 눌렀을 때 자스로 삭제하시겠습니까? 확인하는 alert만들기 -->
							  <c:if test="${user.user_num == reply.user_num || user.status_md == 102}">					 
									<button  class="btn btn-xs btn-outline-danger" type="button"  onclick="chgReplyAdminDelete('${reviewContent.brd_num}', '${reply.brd_num}', '${chg_id}')" >삭제</button>
							  </c:if>
							  
					        </div>
					      </div>
					
		
		    </div>
		  </div>
		</div>
     </c:forEach>
     			
			</c:otherwise>
		</c:choose>
		
			 
       		<!-- Pagination -->
			<nav class="d-flex justify-content-center mt-9">
			  <ul class="pagination pagination-sm text-gray-400">
			  <c:if test="${replyPage.startPage > replyPage.pageBlock}">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="replyAdminList?currentPage=${replyPage.startPage-replyPage.pageBlock }&brd_num=${brd_num}&chg_id=${chg_id}&title=${title}">
			        <i class="fa fa-caret-left"></i>
			      </a>
			    </li>
              </c:if>
	          <c:forEach var="i" begin="${replyPage.startPage }" end="${replyPage.endPage }">
			    <li class="page-item">
			    	<c:if test="${i == replyPage.currentPage}">
			      		<a class="page-link" href="replyAdminList?currentPage=${i}&brd_num=${brd_num}&chg_id=${chg_id}&title=${title}"><b class="text-primary">${i}</b></a>
			    	</c:if>
			    	<c:if test="${i != replyPage.currentPage}"> 
			     		<a class="page-link" href="replyAdminList?currentPage=${i}&brd_num=${brd_num}&chg_id=${chg_id}&title=${title}">${i}</a>
			    	</c:if>
			    </li>
	          </c:forEach>
	          <c:if test="${replyPage.endPage < replyPage.totalPage }">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="replyAdminList?currentPage=${replyPage.startPage+replyPage.pageBlock }&brd_num=${brd_num}&chg_id=${chg_id}&title=${title}">
			        <i class="fa fa-caret-right"></i>
			      </a>
			    </li>
	          </c:if>
			  </ul>
			</nav>
			</div>
</div>
</div>
</section>
</body>
</html>
</body>
</html>