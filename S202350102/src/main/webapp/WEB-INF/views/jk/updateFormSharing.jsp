<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">게시글 수정하기</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-orders.html">
                  	전체 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-wishlist.html">
                 	찜한 쉐어링
                </a>
               <a class="btn w-100 btn-dark mb-2" href="checkout.html" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 		  </div>
             <!-- Nav End --> 
        
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">

             <!-- Form -->
                    <form method="post" action="/updateSharing2" enctype="multipart/form-data">
                    <input type="hidden" value="${board.brd_num}" name="brd_num">
					<input type="hidden" value="${board.brd_md}" name="brd_md">
                        <div class="row">
                            <div class="col-12">
                                <!-- 제목 -->
                                <div class="form-group">
                                
                                
                                    <label class="form-label" for="title">게시글 제목 *</label>
                                    <input class="form-control form-control-sm" id="title" name="title" type="text" value="${board.title}" required>
                                </div>
                            </div>
                            <!-- 작성자명 및 연락처 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="nick">닉네임 *</label>
                                        <input class="form-control form-control-sm" id="nick" name="nick" type="text" value="${board.nick}" readonly>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="user_tel">연락처 *</label>
                                        <input class="form-control form-control-sm" id="user_tel" name="user_tel" type="text" value="${board.user_tel}" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 금액 및 모집 인원 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="price">금액 *</label>
                                        <input class="form-control form-control-sm" id="price" type="number" name="price" value="${board.price}" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="applicants">모집인원 *</label>
                                        <input class="form-control form-control-sm" id="applicants" name="applicants" type="number" value="${board.applicants}" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 계좌번호 및 입금기한 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_info">계좌번호 *</label>
                                        <input class="form-control form-control-sm" id="bank_info" name="bank_info" type="text" value="${board.bank_info}" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_duedate">입금기한 *</label>
                                        <input class="form-control form-control-sm" id="bank_duedate" name="bank_duedate" type="text" value="${board.bank_duedate}">
                                    </div>
                                </div>
                            </div>
                            <!-- 주소 -->
                            <div class="form-group">
                                <div class="col-12">
                                    <label class="form-label" for="addr">주소 *</label>
                                    <input class="form-control form-control-sm" id="addr" name="addr" type="text" value="${board.addr}" required>
                                </div>
                            </div>
                                                    
                           <!-- 이미지 미리보기 -->
							<div class="form-group mb-7">
							<span id="imgOroot">${pageContext.request.contextPath}/upload/${board.img}</span>
							<input type="file" name="file1" style="display: none;" id="fileInput" disabled="disabled">
							<button type="button" onclick="fileUpdate()">파일 변경</button>
									
							</div>
							
							<!-- 상세내용 -->
							<div class="form-group mb-7">
							    <label class="form-label" for="conts">상세내용 *</label>
							    <div class="d-flex align-items-start" style="margin-top: 10px;">
							    
							     <textarea class="form-control form-control-sm" id="conts" name="conts" rows="5" required>${board.conts}</textarea>
							    </div>
							</div>
							<div class="button-container" >
							<button type="button" class="btn btn-dark btn-sm" id="openModalButton">수정완료</button>
					        <a href="myDetailSharing?brd_num=${board.brd_num}" class="btn btn-dark btn-sm">취소</a>          <!--ya취소버튼 추가  -->          
                            <!-- Button -->
                           <!--  <button class="btn btn-dark" type="submit" >작성완료</button> -->
                        </div>
					    <!--ya 수정완료버튼 모달창 ---------------------------------->
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
        </div>
    </section>
  
  
</body>
<%@ include file="../footer.jsp" %>
</html>
