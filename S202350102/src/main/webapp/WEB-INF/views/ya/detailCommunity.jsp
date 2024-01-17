<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>    

<!DOCTYPE html>
<html>

<style type="text/css">
.form-group input.form-control.form-control-sm {
  background-color: transparent; 
}
.form-group textarea.form-control.form-control-sm {
  background-color: transparent;
}


</style>
<meta charset="UTF-8">
<title>게시글 상세내용</title>
</head>
<body>
<section class="pt-7 pb-12">
      <div class="container section-mt">
       <!-- Heading -->
        <div class="row">
          <div class="col-12 text-center"> 
            <h3 class="mb-10"> 게시글 상세내용 </h3>
          </div>
        </div>
	   <!--form  -->
      <div class="col-12 col-md-9 col-lg-10 offset-lg-1">        	
		<input type="hidden" name="brd_step" value="${board.brd_step}"> 
		<input type="hidden" name="brd_group" value="${board.brd_group}"> 
		            <input type=hidden  value="${board.user_num }">
		<div class="button-container" style="text-align: right;" > 
       <a href="listCommunity?" class="btn btn-dark btn-xs">목록</a> 
        </div>
		<c:choose>
    		<c:when test="${board.brd_step == 0}">
  			Reviews : ${board.replyCount}
              <div class="col-12">
                    <!-- 제목 -->
                    <div class="form-group">
                        <label class="form-label" for="title">제목</label>
                        <input class="form-control form-control-sm" id="title" name="title" type="text"  value="${board.title}" readonly>
                    </div>
               </div>      
                     <!-- 작성자 닉네임 -->
                    <div class="form-group mb-7">                       
                           <label class="form-label" for="nick">닉네임</label>
                           <input class="form-control form-control-sm" id="nick" name="nick" type="text" value="${board.nick}" readonly>
          	   	 	</div>
		  		  <!-- 조회수 -->
                    <div class="form-group mb-7">                       
                           <label class="form-label" for="view_cnt">조회수 </label>
                           <input class="form-control form-control-sm" id="view_cnt" name="view_cnt" type="text" value="${board.view_cnt}" readonly>
          	   		</div>
		    		<!-- 작성일자 -->
                    <div class="form-group mb-7">                       
                           <label class="form-label" for="reg_date">등록일자</label>
                           <fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd" var="formattedDate" />
						  <input class="form-control form-control-sm" id="reg_date" name="reg_date" type="text" value="${formattedDate}"  readonly>
                         
          	   	    </div>
		
					<!-- 상세내용 -->       
					<div class="form-group mb-7">
    					<label class="form-label" for="conts">내용</label>
    					<div class="d-flex align-items-start" style="margin-top: 10px;">
      					 	 <textarea class="form-control form-control-sm" rows="12"  style="height: 200px; overflow-y: auto; font-size: 16px;" readonly >${board.conts}</textarea>
  						</div>
					</div>       
                    <!-- 이미지 업로드 -->	
<div class="form-group mb-7">
    <label class="form-label" for="file">이미지 </label>
    <c:if test="${not empty board.img}">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/upload/${board.img}" alt="..." class="card-img-top" style="width: 300;height: 400;">
        </div>
    </c:if>
    <c:if test="${empty board.img}">
        <!-- 이미지가 비어있을 경우 아무것도 보이지 않도록 설정 -->
        <div class="image-container" style="display: none;">
            <img src="#" alt="..." class="card-img-top" style="width: 250;height: 300;">
        </div>
    </c:if>
</div>

		 	</c:when>
		</c:choose>					


<input type="hidden" name="brd_num" value="${board.brd_num}"> 
<input type="hidden" value="${ sessionScope.user_num} ">
<c:if test="${loggedIn}">
    <c:if test="${board.user_num == sessionScope.user_num}">
        <div class="button-container" >
         <a href="updateCommunityForm?brd_num=${board.brd_num}" class="btn btn-dark btn-sm">수정</a> 
		
		<!--삭제완료버튼 모달창  -->
		<button type="button" class="btn btn-dark btn-sm" id="openModalButton"> 삭제</button>
		<!-- Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-sm" role="document"> <!-- 모달 사이즈를 조절 -->
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="deleteModalLabel">게시물 삭제</h5>
		            </div>
		            <div class="modal-body">
		                게시물을 삭제하시겠습니까?
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-dark btn-sm" onclick="clickDel(formInfo)">삭제하기</button> 
		                <button type="button" class="btn btn-dark btn-sm" data-dismiss="modal">취소하기</button>             
		            </div>
		        </div>
		    </div>
		</div>
		<form name="formInfo">
			<input type="hidden" name="brd_num" value="${board.brd_num}">
		</form>	
				
		<script>
		    // 버튼 클릭 시 모달 열기
		    document.getElementById('openModalButton').addEventListener('click', function() {
		        $('#deleteModal').modal('show');
		    });
		    
		    // 삭제 시 수행 후 
		    function clickDel(formInfo) {
		        // 삭제 작업 수행 후 페이지 이동
		    	formInfo.action = "/deleteCommunity?brd_num=${board.brd_num}";
		    	formInfo.method = "GET";
		    	formInfo.submit();
		    }
		    
		    // 취소 버튼 클릭 시 모달 닫기
		    document.querySelector('.modal-footer button[data-dismiss="modal"]').addEventListener('click', function() {
		        $('#deleteModal').modal('hide');
		    });
		</script>		
				
        </div>
    </c:if>
</c:if>

</div>
</div>
</section>

<%@ include file="./commentForm2.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>