<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function fileUpdate(){
	var fileInput = document.getElementById('fileInput');
	if(fileInput.style.display == "none"){
		fileInput.style.display = "block";
		fileInput.removeAttribute('disabled');
		$("#imgOroot").hide();
	} else{
		fileInput.style.display = "none";
		fileInput.setAttribute('disabled', 'true');
		$("#imgOroot").show();
	}
}
</script>
</head>


<body>
  <section class="pt-7 pb-12">
      <div class="container">
       <!-- Heading -->
        <div class="row">
          <div class="col-12 text-center"> 
            <h3 class="mb-10"> 게시글 수정</h3>
          </div>
        </div>

	   <!--form  -->
      <div class="col-12 col-md-9 col-lg-10 offset-lg-1">             
     	<!--제목, 닉네임, 내용, 작성일자, 첨부파일 -->
 		<form action="/updateCommunity" method="post" enctype="multipart/form-data"> 	 	
			<input type="hidden" name="brd_num" value="${board.brd_num}">
			<input type="hidden" value="${board.brd_md}" name="brd_md">
			
              <div class="col-12">
                    <!-- 제목 -->
                    <div class="form-group">
                        <label class="form-label" for="title">제목</label>
                        <input class="form-control form-control-sm" id="title" name="title" type="text"  value="${board.title}" required>
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
                           <label class="form-label" for="reg_Date">날짜</label>
                           <input class="form-control form-control-sm" id="view_cnt" name="view_cnt" type="text" value="${board.reg_date}" readonly>
                           
          	   		 </div>
		
					<!-- 상세내용 -->       
					<div class="form-group mb-7">
    					<label class="form-label" for="conts">내용 *</label>
    					<div class="d-flex align-items-start" style="margin-top: 10px;">
      					 	 <textarea class="form-control form-control-sm" id="conts" name="conts" rows="8" required>${board.conts}</textarea>
  						</div>
					</div>       
                 	    <!-- 이미지 미리보기 -->
					<div class="form-group mb-7">
					<span id="imgOroot">${pageContext.request.contextPath}/upload/${board.img}</span>
					<input type="file" name="file1" style="display: none;" id="fileInput" disabled="disabled">
					<button type="button" onclick="fileUpdate()">파일 변경</button>
							
					</div>
					    
					    
		<!--수정완료버튼 모달창  -->
		<div class="button-container" >
		<button type="button" class="btn btn-dark btn-sm" id="openModalButton">수정완료</button>
        <a href="listCommunity?" class="btn btn-dark btn-sm">취소</a> 	
		</div>
		<!-- Modal -->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-sm" role="document"> <!-- 모달 사이즈를 조절 -->
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="updateModalLabel">게시물 수정</h5>
		            </div>
		            <div class="modal-body">
		              	  게시물 수정이 완료되었습니다.
		            </div>
		            <div class="modal-footer">
		                <button type="submit" class="btn btn-dark btn-sm"  data-dismiss="modal">확인</button>
		            </div>
		        </div>
		    </div>
		</div>
		
		<script>
		    // 버튼 클릭 시 모달 열기
		    document.getElementById('openModalButton').addEventListener('click', function() {
		        $('#updateModal').modal('show');
		    });		    
		</script>
		</form>
	</div>	        
 	</div>
    </section>	


<%-- <form action="/updateCommunity" method="get">
    <input type="hidden" name="brd_num" value="${board.brd_num}">
    <!-- 제목, 닉네임, 조회수, 작성일자, 내용, 댓글창 수정 삭제, 목록이동 -->
    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="${board.title}"></td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td>${board.nick}</td>
        </tr>
        <tr>
            <td> 조회수 </td>
            <td> ${board.view_cnt} </td>
        </tr>
        <tr>
            <th>작성일자</th>
            <td>${board.reg_date}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea rows="10" name="conts">${board.conts}</textarea></td>
        </tr>
    </table>
    <input type="submit" value="수정완료">
</form> --%>
</body>
<%@ include file="../footer.jsp" %>
</html>