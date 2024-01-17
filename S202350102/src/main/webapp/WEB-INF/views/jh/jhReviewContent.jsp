<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 후기</title>
<style>
  /* 테이블을 가운데 정렬하고 화면 너비의 80%를 차지하도록 설정합니다. */
  .card {
    margin: 0 auto;
    width: 80%;
  }
  

</style>
<script type="text/javascript">
	/* 후기 수정에서 이미지 파일 삭제버튼 누른 경우  */
 	function delFile(){
	    delAnswer = confirm("삭제를 하시겠습니까?" );
		if(delAnswer == true) {
			 $('#delFileDiv').remove();   
			 $('#delStatus').val('1');   
			 alert("삭제되었습니다!");
		}
		else {
			 alert("삭제 취소되었습니다 ^^")
		}
	} 

/*  	없어도 되나
 	function fileUpdate(){
		   var fileInput = document.getElementById('fileInput');
		   if(fileInput.style.display == "none"){
		      fileInput.style.display = "block";
		      fileInput.removeAttribute('disabled');
		      $("#imgOroot").hide();
		      // 파일 변경 
		   } else{
		      fileInput.style.display = "none";
		      fileInput.setAttribute('disabled', 'true');
		      $("#imgOroot").show();
		   }
	}  */
 	
 	
/* 	function replyUpdate(${reply.brd_num}){
		/* 아작스 하는 중 함수형태랑 파라미터 이게 맞는지 확인하고 시작하기 */
		
	
	
	
	/* 댓글 공백만 있는 경우 체크 */
	function replyInsertChk(form){
		form.conts.value = form.conts.value.trim();
		
		/* 댓글 미입력시 체크 */
		if(form.conts.value.length == 0 ){
			alert('댓글을 입력해 주세요!');
			form.conts.focus();
			return false;
		} 
		/* 댓글 입력시 인서트 실행 */
		return true;
	} 
	
	
	
	/* 댓글 삭제전 삭제여부 체크 */
	function replyDelete(ori_brd_num, rep_brd_num, chg_id) {
        var confirmMessage = "댓글을 삭제하시겠습니까?";
        if (confirm(confirmMessage)) {
            location.href = '/replyDelete?ori_brd_num=' + ori_brd_num + '&rep_brd_num=' + rep_brd_num + '&chg_id=' + chg_id;
   		}
	}
	
	/* 후기 글 삭제 */
	function reviewDelete(brd_num, chg_id, img) {
        var confirmMessage = "글을 삭제하시겠습니까?";
        if (confirm(confirmMessage)) {
        	location.href='/reviewDelete?brd_num='+ brd_num + '&chg_id=' + chg_id + '&img='+ img;
   		}
	}
	
/*     
 * 왜 이것만 있으면 댓글쓰기에 대한 자바스크립트가 실행이 안되지?*/
 	/* $(document).ready(function() {
        var delResult = ${delResult};
          if (delResult != 1) {
              // 댓글이 삭제되었다는 alert 메시지
              alert('댓글이 삭제되었습니다.');
          }
      });  */
      
    /* 이건 왜 안됨? 제이쿼리 떄문에 버튼 안먹힘 아작스로 바꾸면 삭제해도 될듯 수정하고 돌어왔을 때 스크롤 움직이게 하는 것*/
     $(document).ready(function() {
	        var flag = $("#updateFlag").val();
	        if (flag == 'flag') {
					var targetElement = $('#reviewReplyUpdate');
					if(targetElement.length > 0) {
						 $('html, body').animate({
			                    scrollTop: targetElement.offset().top -400
			                }, 1000);
					}
	        }
	        
	        var result = $("#result").val();
	        if (result != 0){
	        	alert('댓글 변경이 완료되었습니다.');
	        }
      }); 
	
      /* 글 수정 눌렀을 때 모달창 띄우기 */
      function updateModal(){
    	  
    	  $('#updateFormModal').modal('show')
      }
      
   // 유저 닉네임 클릭 시 modal 창 띄우기
  	function userInfoModal(index) {
  		// 모달창에 넘겨줄 값을 저장 
  		var user_num, user_nick, user_img, user_level, user_exp, percentage, icon;

		user_num 	= $("#replyUserNum" 	+ index).val();
		user_nick 	= $("#replyNick" 		+ index).val();
		user_img 	= $("#replyImg" 		+ index).val();
		user_level 	= $("#replyUserLevel"   + index).val();
		user_exp 	= $("#replyUserExp" 	+ index).val();
		percentage 	= $("#replyPercentage"  + index).val();
		icon 		= $("#replyIcon" 		+ index).val();
  		
  		// DB에 있는지 존재 유무 체크
  		$.ajax({
  			url : "/followingCheck",
  			type : "POST",
  			data:{following_id : user_num},
  			dataType : 'json',
  			success : function(followingCheck) {
  				if(followingCheck.fStatus > 0) {
  					$("#follow").removeClass("btn-danger");
  					$("#follow").addClass("btn-light");
   					$("#follow").text("팔로잉");
  				} else {
  					$("#follow").removeClass("btn-light");
  					$("#follow").addClass("btn-danger");
  					$("#follow").text("팔로우");
  				}
  			},
  			error : function() {
  				alert("팔로우 오류");
  			}

  		});

  		// userShowModal 모달 안의 태그 -> 화면 출력용  <span> <p> -> text
  		$('#displayUserNick').text(user_nick);
  		$('#displayUserImg').attr('src', '${pageContext.request.contextPath}/upload/' + user_img);
  		$('#displayUserLevel').attr('title', 'Lv.' + user_level + ' | exp.' + user_exp + '(' + percentage + '%)').attr('src', '/images/level/' + icon + '.gif');
  		
  		// userShowModal 모달 안의 태그 input Tag -> Form 전달용		<input> -> <val>
  		$('#inputUserNum1').val(user_num);	// following()
  		$('#inputUserNum2').val(user_num);	// sendMessage()

  		// 모달 창 표시
  		$('#userShowModal').modal('show');
  	}
   
 	// 팔로우 하기 버튼
	function following() {
		var sendData = $('#followingForm').serialize();	// user_num=?

		$.ajax({
			url : "/followingPro",
			type : "POST",
			data : sendData,
			dataType : 'json',
			success : function(followResult) {

				if(followResult.following > 0) {
					$("#follow").removeClass("btn-danger");
					$("#follow").addClass("btn-light");
					$("#follow").text("팔로잉");
				} else if(followResult.following == 0) {
					$("#follow").removeClass("btn-light");
					$("#follow").addClass("btn-danger");
					$("#follow").text("팔로우");
				} else {
					alert("자신의 계정은 팔로우 할 수 없습니다");
				}
			},
			error : function() {
				alert("팔로우 오류");
			}

		});
		
	}
      
</script>
</head>
<body>
 <section>
      <div class="container section-mt">
        <div class="row">
        
        
        
 <!-- 글 수정 모달 창 -->
    <div class="modal fade" id="updateFormModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
    
          <!-- Close -->
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            <i class="fe fe-x" aria-hidden="true"></i>
          </button>
    
          <!-- Content -->
          <div class="row gx-0">
            
            <div class="col-12 col-lg-10 d-flex flex-column px-md-8 mx-auto " >
    
              <!-- Body -->
              <div class="modal-body my-auto py-10">
    
    			
    			<h4>${user.nick}</h4>
                <!-- Form -->
                <form action="reviewUpdate"  method="post"  enctype="multipart/form-data">
                  <div class="row gx-5">
                    <div class="col">
						<input type="hidden" 	name="img" 			value="${reviewContent.img}" >
						<input type="hidden" 	name="brd_num" 		value="${reviewContent.brd_num}" >
						<input type="hidden" 	name="user_num" 	value="${user.user_num}" >
						<input type="hidden" 	name="chg_id" 		value="${chg_id}" >
    	
						<!-- Input -->
						<div class="form-group">
							<label class="form-label" for="title">
							제목
							</label>
							<input class="form-control form-control-sm" id="reviewTitle" type="text" name="title" value="${reviewContent.title }" required><p>
						</div>
						
						<div class="form-group">
							<label class="form-label" for="reviewText">내용</label>
							<textarea class="form-control form-control-sm" id="reviewText" rows="5" name="conts"  required>${reviewContent.conts}</textarea>
						</div>
						
		                <div class="alert alert-warning">
		                	<strong>수정 유의사항</strong><br>
		                	이미지 파일은 최대 1개만 업로드 하실 수 있습니다.<br> 
		                	기존 이미지를 삭제하고 싶으면 파일 삭제 버튼을 눌러주세요!<br>
		                	기존 이미지를 삭제하지 않고 새로운 이미지를 업로드 하셔도 새로운 이미지로 대체 됩니다.<br>
		                </div>
						<div class="input-group mb-3">
							<input type="file" class="form-control" name="file1" id="inputGroupFile">
		                    <input type="hidden" name="delStatus" id="delStatus" value="0">
						</div>  
						
						<div class="input-group mb-3" id="delFileDiv">
							<c:if test="${reviewContent.img != null}">
					       		<button class="btn btn-outline-secondary" type="button" id="delFile1" onclick="delFile()">파일 삭제</button>
								<span class="input-group-text" id="imagePath">${reviewContent.img}</span>
							</c:if>
						</div>  
                    </div>
                  </div>
 					<div class="col-12 text-center">
    
         
				       <button class="btn btn-outline-dark" type="submit">수정</button>
                    </div>
                </form>
    
              </div>
    
            </div>
          </div>
    
        </div>
    
      </div>
    </div>
    


<!-- 후기 본문  -->
<input type="hidden" name="updateFlag" id="updateFlag" value="${flag }">
<input type="hidden" name="result" id="result" value="${result }">
<!-- 글쓴이일 경우 수정, 삭제 버튼 활성화 -->

<!-- 버튼 위치 조정하기 -->
<div class="d-flex justify-content-end align-items-between mt-5">
	<div class="col-auto">
		<button  class="btn btn-xs btn-dark" type="button"  onclick="location.href='chgDetail?chg_id=${chg_id}&tap=3'" >목록</button>
		<c:if test="${user.user_num == reviewContent.user_num }">
			<button  class="btn btn-xs btn-dark" type="button" id="showUpdateModalBtn" onclick="updateModal()" >수정</button>
		</c:if>
		<c:if test="${user.user_num == reviewContent.user_num || user.status_md == 102 }">
			<button  class="btn btn-xs  btn-danger" type="button"  onclick="reviewDelete('${reviewContent.brd_num}', '${chg_id}', '${reviewContent.img}')" >삭제</button>
		</c:if>
	</div>
</div>

<div class="card mb-3">
  	
  	
	<!-- 후기 글 내용 -->
	<div class="card-body">

	  <h3 class="card-title">${reviewContent.title }</h3>
	  
	  <!-- 프로필 사진 -->
<!-- img -->
		<div class="d-flex justify-content-start align-items-center mt-6 mb-4">
		  <div class="avatar avatar-lg mb-6 mb-md-0">
		    <span class="avatar-title rounded-circle">
		      <img src="${pageContext.request.contextPath}/upload/${reviewContent.user_img}" alt="profile" class="avatar-title rounded-circle">
		    </span>
		  </div>
		  <h6 class="card-subtitle mb-2 text-muted align-self-center">${reviewContent.nick }</h6>
		</div>

		<div class="d-flex justify-content-between align-items-center mb-4 mt-4">
			<div>
			  <small class="text-muted " style="margin-right: 10px;">조회수  ${reviewContent.view_cnt } </small>
			  <small class="text-muted">
			  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
				<path
						d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
					<path
						d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2" />
				</svg>
															
				 ${reviewContent.replyCount } </small>
			</div>
		  <div>
		  <small class="text-muted"><fmt:formatDate value="${reviewContent.reg_date }" pattern="yyyy-MM-dd"/></small>
		  </div>
		  </div>
		
		
		
		
		
		
		
		<div class="d-flex justify-content-center mt-7 mb-10">
		 <c:choose>
		    <c:when test="${empty reviewContent.img}">
				<img src="assets/img/chgDfaultImg.png" alt="이미지가 없습니다" style="max-width: 700px; max-height: 600px; width: auto; height: auto;">
		    </c:when>
		    <c:otherwise>
				 <img src="${pageContext.request.contextPath}/upload/${reviewContent.img}" class="card-img-top" alt="이미지 불러오기에 실패했습니다." style="max-width: 700px; max-height: 600px; width: auto; height: auto;">
		    </c:otherwise>
		</c:choose>
		</div>


	  <p class="card-text">${reviewContent.conts }</p>
	 </div>
	
     <!-- 댓글 쓰기 -->
     <div class="py-9">
       <!-- Form -->
       <form action="/replyInsert" method="post" onsubmit="return replyInsertChk(this)">
         <div class="row gx-5 align-items-center">
         	<c:choose>
         	  <c:when test="${chgrYN == 1 }">
	            <!-- 참여자일 경우 -->
	   			<div class="col">
	   				<input type="hidden" name="chg_id" value="${chg_id}">
	   				<input type="hidden" name="brd_num" value="${reviewContent.brd_num}">
	   				<input type="hidden" name="user_num" value="${user.user_num}">
	   				<%-- <input class="form-control form-control-sm" id="reviewReply" name="conts" type="text"  maxlength="100" placeholder="${user.nick }님 댓글을 남겨주세요!"> --%>
	   				<textarea class="form-control form-control-sm" id="reviewReply" rows="3" name="conts" maxlength="100" placeholder="${user.nick }님 댓글을 남겨주세요!"></textarea>
	   				
	 			</div>
	 			
	            <div class="col-auto">
					<!-- Button -->
					<button class="btn btn-sm btn-dark" type="submit" id="replyInsertBtn" >
					  	댓글 쓰기
					</button>
	            </div>
	            
         	   </c:when>
         	   <c:when test="${user == null  }">
	            <!-- 로그인 전일 경우 -->
	   			<div class="col">
	   				<input type="hidden" name="chg_id" value="${chg_id}">
	   				<input type="hidden" name="brd_num" value="${reviewContent.brd_num}">
	   				<input class="form-control form-control-sm" id="reviewReply" name="conts" type="text" placeholder="로그인을 해주세요!">
	 			</div>
	            <div class="col-auto">
					<!-- Button -->
					<button class="btn btn-sm btn-dark" type="submit" id="replyInsertBtn" >
					  	댓글 쓰기
					</button>
	            </div>
         	   </c:when>
         	
         	   <c:otherwise>
         	   <!-- 로그인 했지만 참가자 아닌 경우  -->
	   			<div class="col">
	   				<input class="form-control form-control-sm" id="reviewReply" type="text"  placeholder="챌린지 참가자만 댓글을 남길 수 있습니다!" disabled="disabled">
	 			</div>
	            <div class="col-auto">
					<!-- Button -->
					<button class="btn btn-sm btn-dark" type="submit" id="replyInsertBtn" disabled="disabled">
					  	댓글 쓰기
					</button>
	            </div>
         	   </c:otherwise>
         	</c:choose>
         </div>
       </form>

     </div>
     
     <!-- 후기 댓글 리스트 -->
     <c:forEach var="reply" items="${reviewReply }" varStatus="status">
    	
	     <div class="review">
		
		  <!-- 댓글 Body -->
		  <div class="review-body">
		    <div class="row">
		
		
		     	 <c:choose>
		     	 
			     	<c:when test="${flag == 'flag' && rep_brd_num == reply.brd_num}">
		     	 <!-- 댓글 수정 버튼 눌렀을 때 -->
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
					    <div class="col-12 col-md">
					      
					        <!-- 닉네임 -->
					        <p class="mb-2 fs-lg fw-bold">
							  ${reply.nick }
					        </p>
			               <form action="/replyUpdate?ori_brd_num=${reviewContent.brd_num }&chg_id=${chg_id}" method="post" onsubmit="return replyInsertChk(this)">
						        <!-- 댓글 쓴 날짜 및 시간 sysdate로 update할 것-->
								<input type="hidden" name="brd_num" value="${reply.brd_num }">
						        <!-- 댓글 내용 -->
						        <p class="text-gray-500">
						        <input class="form-control form-control-sm" id="reviewReplyUpdate" name="conts" type="text"  maxlength="100" value="${reply.conts }">
						        </p>
						
						        <div class="col-auto">
								<button class="btn btn-xs btn-outline-border btn-dark" type="submit" id="replyUpdateBtn">수정</button>
								<button class="btn btn-xs btn-outline-border" type="button" id="resetBtn" onclick="window.history.back();" >취소</button>
						        </div>
			     			</form>
			     		</div>
			    	</c:when>
			    	
			    	<c:otherwise>
			    	<!-- 댓글 내용 -->
					      <div class="col-12 col-md-auto">
					      <input type="hidden" id="replyImg${status.index}" 		value="${reply.img}">
						  <input type="hidden" id="replyNick${status.index}" 		value="${reply.nick}">
						  <input type="hidden" id="replyUserNum${status.index}" 	value="${reply.user_num}">
				          <input type="hidden" id="replyUserLevel${status.index}" 	value="${reply.user_level}">
						  <input type="hidden" id="replyUserExp${status.index}" 	value="${reply.user_exp}">
						  <input type="hidden" id="replyPercentage${status.index}" 	value="${reply.percentage}">
						  <input type="hidden" id="replyIcon${status.index}" 		value="${reply.icon}">
						    	
					       <!-- 프로필 사진 -->
					        <!-- img -->
                            <div class="col-3">
                            <a href="#" data-bs-toggle="modal" onclick="userInfoModal(${status.index})" class="col-2">
                              <div class="avatar avatar-xxl mb-6 mb-md-0">
                                <span class="avatar-title rounded-circle">
                                  <img src="${pageContext.request.contextPath}/upload/${reply.img}" alt="profile"
                                    class="avatar-title rounded-circle">
                                </span>
                              </div>
                            </a>
                            </div>
					
					      </div>
					        <div class="col-12 col-md d-flex justify-content-between align-items-center">
					      	<div>
					        <!-- 닉네임 -->
					        <a href="#" data-bs-toggle="modal" onclick="userInfoModal(${status.index})" class="col-2">
						        <p class="mb-2 fs-lg fw-bold">
						        <span class="col-5">
						        	<img title="Lv.${reply.user_level } | exp.${reply.user_exp}(${reply.percentage }%)" src="/images/level/${reply.icon}.gif">
						        	<span style="color: black;">${reply.nick }</span>
						        </span>
						        </p>
					        </a>
					        
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
					
					        <div class="col-auto">
					
			
				             <!-- 글쓴이일 경우 수정, 삭제 버튼 활성화 -->
				             <!-- 삭제 눌렀을 때 자스로 삭제하시겠습니까? 확인하는 alert만들기 -->
							  <c:if test="${user.user_num == reply.user_num }">					 
									<button  class="btn btn-xs btn-outline-dark" type="button"  onclick="location.href='/showReplyUpdate?rep_brd_num=${reply.brd_num}&ori_brd_num=${reviewContent.brd_num }&chg_id=${chg_id}&currentPage=${replyPage.currentPage }'">수정</button>
							  </c:if>
							  <c:if test="${user.user_num == reply.user_num || user.status_md == 102 }">					 
									<button  class="btn btn-xs btn-outline-danger" type="button"  onclick="replyDelete('${reviewContent.brd_num}', '${reply.brd_num}', '${chg_id}')" >삭제</button>
							  </c:if>
							  
					        </div>
					      </div>
					
		
			    	</c:otherwise>
		     	</c:choose>
		    </div>
		  </div>
		</div>
     </c:forEach>
</div>
								
<!-- Pagination -->
<nav class="d-flex justify-content-center mt-2 mb-5">
  <ul class="pagination pagination-sm text-gray-400">
  <c:if test="${replyPage.startPage > replyPage.pageBlock}">
    <li class="page-item">
      <a class="page-link page-link-arrow" href="reviewContent?currentPage=${replyPage.startPage-replyPage.pageBlock }&brd_num=${reviewContent.brd_num}&chg_id=${chg_id}">
        <i class="fa fa-caret-left"></i>
      </a>
    </li>
  </c:if>
        <c:forEach var="i" begin="${replyPage.startPage }" end="${replyPage.endPage }">
    <li class="page-item">
    	<c:if test="${i == replyPage.currentPage}">
      <a class="page-link" href="reviewContent?currentPage=${i}&brd_num=${reviewContent.brd_num}&chg_id=${chg_id}"><b class="text-primary">${i}</b></a>
    	</c:if>
    	<c:if test="${i != replyPage.currentPage}"> 
      <a class="page-link" href="reviewContent?currentPage=${i}&brd_num=${reviewContent.brd_num}&chg_id=${chg_id}">${i}</a>
    	</c:if>
    </li>
        </c:forEach>
        <c:if test="${replyPage.endPage < replyPage.totalPage }">
    <li class="page-item">
      <a class="page-link page-link-arrow" href="reviewContent?currentPage=${replyPage.startPage+replyPage.pageBlock }&brd_num=${reviewContent.brd_num}&chg_id=${chg_id}">
        <i class="fa fa-caret-right"></i>
      </a>
    </li>
        </c:if>
  </ul>
</nav>

			<!-- yr 작성 -->
            <!-- nick 클릭 시 나타나는 modal -->
			<!-- 인증게시판, 소세지들, 후기게시판 사용 -->
			<div class="modal fade" id="userShowModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-body">
							<div class="col-12 col-md-auto">
								<div class="avatar avatar-xxl mb-6 mb-md-0">
									<span class="avatar-title rounded-circle">
										<img src="" alt="profile" class="avatar-title rounded-circle" id="displayUserImg">
									</span>
								</div>
							</div>
							
							<div class="col-12">
								<img title="" src="" id="displayUserLevel">
								<span id="displayUserNick"></span>
							</div>
							
							<div class="text-end">
									<button type="button" class="btn btn-danger btn-xs" name="user_num" onclick="following(${status.index})"
										id="follow">팔로우</button>
									
									<!-- 
										<button type="button" class="btn btn-info" onclick="sendMessage(${status.index})">쪽지보내기</button>
										<form id="sendMessageForm">
											<input type="hidden" id="inputUserNum2" name="user_num">
										</form>
									 -->
									 
									<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal" aria-label="Close">닫기</button>
									
									<form id="followingForm">
										<input type="hidden" id="inputUserNum1" name="user_num">
									</form>
							</div>
						</div>
					</div>
				</div>
			</div>
</div>
</div>
    </section>

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>