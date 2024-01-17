<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<!--모달창-->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>쉐어링관리</title>
</head>
<body>
<section class="py-11">
<!-- 필수!! -->
 <div class="container">
    <div class="row profile">
       <div class="col-md-3">
            <%@ include file="../mypageMenu.jsp" %>
       </div>
    <div class="col-md-9 profile-form">
<!-- 필수!! -->

	<div class="container text-center" style="margin-top: 20px;">
    	<h3>My Page</h3>
    </div>

<!--내가 개설한 쉐어링 제목 누르면  brd_num으로 해당하는 상세페이지로 이동시키게 설정하기-------------------------------------------------------->
    <section class="myUploadSharing" style="width: 900px; height: 500px; margin-top: 30px;">
        <div class="page-title">
            <div class="container">
                <h6>내가 개설한 쉐어링 </h6>
               
                <hr class="my6">
            </div>
        </div>
   <!-- 게시판리스트  -->
      <div class="container" >
        <div class="col-12">
         <c:set var="num" value="${myUploadSharingPaging.total - myUploadSharingPaging.start+1 }"></c:set> 
                <table class="table table-bordered table-sm mb-0" >
                     <thead class="table-dark">
                        <tr class="p-2 text-center">
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants" >모집인원</th>
                            <th scope="col" class="th-particpants">승인인원</th>
                            <th scope="col" class="th-bank_duedate">입금기한</th>
                            <th scope="col" class="th-check">지원자</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${myUploadSharingList}" varStatus="status">
                        <input type = "hidden" value="${board.brd_num }">
                             <tr>
                                <td>${num}</td>
                                <td><a href="detailSharing?brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.applicants}명</td>            
                                <td>${board.participants}명</td>      
                                <td>${board.bank_duedate}</td>
				         		<td><button type="button" class="btn  btn-xs openModalButton" data-toggle="modal" data-target="#joinInfoModal" 
				         					data-brd_num="${board.brd_num}" style=" background-color: #E56D90; color:#FFFFFF; padding-left: 10px;   padding-right: 10px; padding-top: 5px; padding-bottom: 5px">
				         					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
  											<path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018Z"/>
  											<path d="M13 6.5a6.471 6.471 0 0 1-1.258 3.844c.04.03.078.062.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1.007 1.007 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5ZM6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11Z"/>
											</svg>		
				         			 조회</button></td>
				         		 <c:set var="num" value="${num-1}"></c:set> 	 	        
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>   
         </div>             
        </div>
        
			<nav class="d-flex justify-content-center justify-content-md-center mt-3">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${myUploadSharingPaging.startPage >myUploadSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage-myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${myUploadSharingPaging.startPage}" end="${myUploadSharingPaging.endPage}">
			            <li class="page-item <c:if test='${myUploadSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${myUploadSharingPaging.endPage <myUploadSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage+myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			 </nav>        
    </section>
    <!--내가 신청한 쉐어링 joinsharingList ------------------------------------------------------------------------------ -->
	    <section class="myJoinSharing" style="width: 900px; height: 500px">
        <div class="page-title">
            <div class="container" >
                <h6>내가 신청한 쉐어링 </h6>
                <hr class="my6">
            </div>
        </div>
      <!-- 게시판리스트  -->
      	 <div class="container" >
         <div class="col-12">
         <c:set var="num" value="${myJoinSharingPaging.total - myJoinSharingPaging.start+1 }"></c:set> 
                <table class="table table-bordered table-sm mb-0" >
                     <thead class="table-dark">
                         <tr class="p-2 text-center">
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants">승인상태</th>
                            <th scope="col" class="th-bank_duedate">입금정보</th>
                            <th scope="col" class="th-reject_msg">반려사유</th>
                       <!-- 추후 진행할 예정     <th scope="col" class="th-delete_shar">신청취소</th> -->
                            
                        </tr>
                    </thead>                 
                    <tbody>             
                        <c:forEach var="sharingList" items="${myJoinSharingList}" varStatus="status" >
                            <input type="hidden" value="${sharingList.brd_num}">
                            <input type="hidden" value="${sharingList.user_num }">
                            <input type="hidden" value="${sessionScope.user_num} ">
                            <tr>
                                <td>${num}</td>    
                                <td><a href="detailSharing?brd_num=${sharingList.brd_num}">${sharingList.title}</a></td>
                                 <td>
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 100}">신청완료</c:when>
                                 		<c:when test="${sharingList.state_md == 101}">승인완료</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>
                                <td>
							    <c:choose>
							        <c:when test="${sharingList.state_md == 101}">
							            <button class="btn btn-xs" type="button" data-toggle="collapse" 
							                    data-target="#collapse-${status.index}" aria-expanded="false" 
							                    aria-controls="collapse-${status.index}" data-bs-index="${status.index}" 
							                    style=" background-color: #E56D90; color:#FFFFFF; padding-left: 10px;   padding-right: 10px; padding-top: 5px; padding-bottom: 5px">
							                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
  											<path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018Z"/>
  											<path d="M13 6.5a6.471 6.471 0 0 1-1.258 3.844c.04.03.078.062.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1.007 1.007 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5ZM6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11Z"/>
											</svg>		
							         	       확인
							            </button>
							        </c:when>
							       <c:otherwise>  </c:otherwise>
							    </c:choose>
                                </td>
                            
                                <td>${sharingList.reject_msg} </td>  
                                <c:choose> 
                                <c:when test="${sharingList.state_md == 100}">
                                <%--  추후 진행할 예정<td><a class="btn btn-xs btn-outline-dark w-100" href="/deleteJoinSharing?user_num=${sharingList.user_num}">취소</a></td> --%>
                               
                              	</c:when>
                              	<c:otherwise>  </c:otherwise>
                              	</c:choose>
						        </tr>
					            <!-- 폼 내용 추가 -->
					            <tr>
					                <td colspan="6" class="p-0">
					                	
				                   <div class="collapse" id="collapse-${status.index}" data-bs-parent="#boardTable">
					                        <form class="p-0">
					                            <input type="hidden" name="brd_num" value="${sharingList.brd_num}" id=" ">
								                <table class="table table-bordered table-sm mb-0" id="boardTable">
							                    <thead class ="table-light">
							                        <tr class="p-2 text-center">
							                            <th scope="col" class="th-tilte">이름</th>
							                            <th scope="col" class="th-bank_info">계좌정보</th>
							                            <th scope="col" class="th-price">입금액</th>
							                            <th scope="col" class="th-bank_duedate">입금기한</th>
							                            <th scope="col" class="th-addr">거래주소</th>
							                        </tr>
							                    </thead>
							                    <tbody>
							                    <c:forEach var="board"  items="${myConfirmSharingList}" varStatus="status">
							                     <c:if test="${board.brd_num eq sharingList.brd_num}">
                       						    <input type="hidden" value="${board.applicants}">
							                    	 <tr>
						                                <td>${board.user_name}</td>
						                                <td>${board.bank_info}</td>    
						                                <td><fmt:formatNumber value="${board.price div board.applicants}" pattern="#,###"/>원</td>        
						                                <td>${board.bank_duedate}</td>
						                                <td>${board.addr}</td> 
						                             </tr>  
						                           </c:if>
						                         </c:forEach>          
							                    </tbody>			
							                	</table>					                       
					                        </form>
					                    </div>
					        
					                    
						<script>
						    function showConfirmation(index, currentPage) {
						        var collapseId = "collapse-" + index;
						
						        // AJAX 요청
						        $.ajax({
						            url: '/myConfirmSharingList', 
						            type: 'GET',
						            data: {currentPage: currentPage },
						            success: function (response) {
						                // collapse 요소 내용을 업데이트
						                $("#" + collapseId).html(response);
						                $("#" + collapseId).collapse('toggle'); // 토글하여 내용을 보여줌
						            },
						            error: function (error) {
						                console.error('데이터를 가져오는 동안 오류 발생:', error);
						            }
						        });
						    }
						</script>				                    
					                				                    
					                </td>
					            </tr>
							            <c:set var="num" value="${num - 1}"></c:set>
						        </c:forEach>
						    </tbody>
						</table>             
						</div>                       					

	
        		<nav class="d-flex justify-content-center justify-content-md-center mt-3">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${ myJoinSharingPaging.startPage >  myJoinSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myJoinSharingPaging.startPage-myJoinSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${ myJoinSharingPaging.startPage}" end="${ myJoinSharingPaging.endPage}">
			            <li class="page-item <c:if test='${ myJoinSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${ myJoinSharingPaging.endPage <  myJoinSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${ myJoinSharingPaging.startPage+ myJoinSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			</nav>        
       </div>
    </section>
</div>
</div>
</div>

<!-----------내가올린 쉐어링모달창 띄우기------------------------------------------------------------------------------------------------------->
<div class="modal  fade" id="joinInfoModal">
    <div class="modal-dialog  modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">쉐어링 참가자 조회</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    			<span aria-hidden="true">&times;</span>
				</button>
            </div>

            <div class="modal-body">
            	<input type="hidden" name="brd_num" value="${board.brd_num}"> 
            	<h6 id="totalParticipants">총 지원자 : </h6>
            	
            	<table class="table small table-hover" id="joinInfoForm" >		
                    <thead class="table-light" >
                        <tr>
                           <!--  <th scope="col" class="th-user_num">번호</th> -->
                            <th scope="col" class="th-name">이름</th>
                            <th scope="col" class="th-message">메시지</th>
                            <th scope="col" class="th-addr">주소</th>
                            <th scope="col" class="th-tel">연락처</th>
                            <th scope="col" class="th-reg_date">신청일자</th>
                            <th scope="col" class="th-check">승인처리</th>
                            <th scope="col" class="th-check-result">결과</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="sharingList" items="${sharingParticipantsInfo}" varStatus="status" >

                        <input type="hidden" value="${sharingList.brd_num}">
                        <input type="hidden" value="${sharingList.user_num}">
                            <tr>
                            	<%-- <td id="user_num">${sharingList.user_num}</td>   --%>                   	
                                <td id="user_name">${sharingList.user_name}</td>
                                <td id="message">${sharingList.message}</td>  
                                <td id="addr">${sharingList.addr }</td>                
                                <td id="tel">${sharingList.tel}</td>
                                <td id="reg_date">${sharingList.reg_date}</td>                              
				         		<td>
				         			<button type="button" class="btn btn-dark btn-xs confirmModalButton"  data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"  >승인</button>
        							<button type="button" class="btn btn-dark btn-xs rejectModalButton" data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"
        														data-reject_msg="${sharingList.reject_msg}">반려</button>
				         		</td>  
                                 <td class="th-check-result">
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 101}">승인</c:when>
                                 		<c:when test="${sharingList.state_md == 104}">반려</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>  
                            </tr>
                        </c:forEach>
                    </tbody>                           
                </table>
        
                
            </div>
        </div>	  	 
    </div>
</div>



<!-- 반려시 모달창 띄우기------------------------------------------------------------------------------------------------------------>
<div class="modal" tabindex="-1" role="dialog" id="rejectReasonModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">반려사유 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="rejectReasonForm">
                    <div class="form-group">
                        <label for="rejectReason">반려 사유:</label>
                        <textarea class="form-control" id="reject_msg" name="reject_msg" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-xs">확인</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-------------------------------- 참가자 조회 모달창 자바스크립트 (중복 승인/반려 막기 해야함 )  applicants(모집인원) <= participants(참가인원) ------------------------------------------------------------------------>
<script type="text/javascript">

//참가자 조회 모달창  열때 
var participantCount = 0;
$(document).on('click', '.openModalButton', function () {
    // 버튼의 데이터 속성에서 게시글 번호 가져오기
    var brd_num = $(this).data('brd_num');
    var user_num = $(this).data('user_num');
    
    // 모달 내부의 숨겨진 입력란에 값 설정
    $('#joinInfoModal input[name="brd_num"]').val(brd_num);
    // 모달 내부의 숨겨진 입력란에 값 설정
    $('#joinInfoModal input[name="user_num"]').val(user_num);

    // 서버에 데이터를 요청하여 참가자 정보 가져오기
    fetch('/sharingParticipantsInfo?brd_num=' + brd_num)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // 가져온 데이터를 사용하여 모달 내용을 업데이트
            var tbody = $('#joinInfoForm tbody');
            tbody.empty();
            // 참가자 수 초기화
            participantCount = 0;
            
            if (Array.isArray(data) && data.length > 0) {
                data.forEach(sharingList => {
                    // 참가자 정보를 테이블 행으로 추가
                    var regDate = new Date(sharingList.reg_date);
                    var options = { year: '2-digit', month: '2-digit', day: '2-digit' };
                    var formattedRegDate = regDate.toLocaleDateString('en-US', options);
                    
                    // state_md가 101이거나 104이면 버튼을 비활성화
                     var isButtonsDisabled = (sharingList.state_md === 101 || sharingList.state_md === 104);

                    var row = '<tr>' +
                       /*  '<td>' + sharingList.user_num + '</td>' + */
                        '<td>' + sharingList.user_name + '</td>' +
                        '<td>' + sharingList.message + '</td>' +
                        '<td>' + sharingList.addr + '</td>' +
                        '<td>' + sharingList.tel + '</td>' +
                        '<td>' + formattedRegDate + '</td>' +
                        '<td>' + '<div class="btn-group ' + (isButtonsDisabled ? 'disabled' : '') + '" role="group" aria-label="Basic example">' +
                        '<button type="button" class="btn btn-dark btn-xs confirmModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" ' + (isButtonsDisabled ? 'disabled' : '')+'>승인</button>' +
                        '<button type="button" class="btn btn-dark btn-xs rejectModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" '+ (isButtonsDisabled ? 'disabled' : '') + '>반려</button>' +
                        '</td>' + '</div>' +
                        '<td>' + (sharingList.state_md == 101 ? '승인' : (sharingList.state_md == 104 ? '반려' : '')) + '</td>' +
                        '</tr>';
                    tbody.append(row);
                    
                    // 버튼 그룹 상위 엘리먼트에 클래스 추가
                    var buttonGroup = tbody.find('.btn-group[data-brd_num="' + sharingList.brd_num + '"][data-user_num="' + sharingList.user_num + '"]');
                    buttonGroup.addClass('disabled');
                    
                    participantCount++;
                });
                //참가자 수 모달에 표시
                updateVisibleParticipants();
               
            } else {
                console.error('Received JSON data is not in the expected format:', data);
            }
         	// 참가자 수 업데이트 함수
            function updateVisibleParticipants() {
                // 참가자 수 업데이트
                $('#totalParticipants').text('총 지원자 수: ' + participantCount+'명');
            }
           
        })

        });

function handleButtonClick(brd_num, user_num) {
    // 버튼 그룹 상위 엘리먼트에서 클래스를 추가하여 버튼들을 동시에 비활성화
   var buttonGroup = $('.btn-group[data-brd_num="' + brd_num + '"][data-user_num="' + user_num + '"]');
    buttonGroup.addClass('disabled-btn-group');
}        



<!--참가 승인 반려  버튼처리----------------------------------------------------------------------------------->
document.getElementById('joinInfoForm').addEventListener('click', function (event) {
	  event.stopPropagation();
	// 클릭된 요소가 버튼인지 확인
    if (event.target.tagName === 'BUTTON') {
        // 버튼의 속성 출력
        console.log('Button attributes:', event.target.attributes);

        // 버튼의 데이터 속성에서 필요한 정보를 가져옵니다.
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;

        console.log('brd_num:', brd_num);
        console.log('user_num:', user_num);
    }
             
    // 승인 버튼이 클릭된 경우-------------------------------------------------------------------
    if (event.target.classList.contains('confirmModalButton')) {
        var formData = new FormData();
    	formData.append('brd_num', parseInt(brd_num, 10));
    	formData.append('user_num', parseInt(user_num, 10));
    	
    	var button = $(event.target);
     	if (!button.hasClass('disabled')) {
    		button.addClass('disabled');
    	} 
    	
      
    	// 서버로 데이터를 전송하는 fetch API 사용
        fetch('/sharingConfirm', {
            method: 'POST',
             headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body:  'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num),  
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {

                // 성공적으로 처리된 경우
                alert(data.message); // "승인이 완료되었습니다" 메시지를 띄웁니다.
           
                // 페이지를 새로 고침합니다.
                location.reload(true);
   
            } else {
                // 처리에 실패한 경우
                alert(data.message); // "승인 실패되었습니다" 메시지를 띄웁니다.
            }
            
        })
        .catch(error => {
            // 서버 요청 중 에러가 발생한 경우
            alert("서버 오류가 발생했습니다.");
        });
    }

 // 반려 버튼이 클릭된 경우----------------------------------------------------------------------------
    else if (event.target.classList.contains('rejectModalButton')) {
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;	
    	var button = $(event.target);
    	
        // 반려 이유 모달을 표시합니다.
        $('#rejectReasonModal').modal('show');

        // 반려 이유 폼 제출을 처리합니다.
        $('#rejectReasonForm').on('submit', function (e) {
            e.preventDefault();
            var reject_msg = $('#reject_msg').val();

            // 서버에 반려 이유를 전송합니다.
            fetch('/sharingReject', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num) + '&reject_msg=' + encodeURIComponent(reject_msg),
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message); // 성공 메시지를 표시합니다.
                 	
                	if (!button.hasClass('disabled')) {
                		button.addClass('disabled');
                	}
                    
                    // 페이지를 새로 고침합니다.
                    location.reload(true);
                    
                    $('#rejectReasonModal').modal('hide'); // 반려 이유 모달을 닫습니다.
                    
                    
                    
                } else {
                    alert(data.message); // 실패 메시지를 표시합니다.
                }
            })
            .catch(error => {
                alert("서버 오류가 발생했습니다.");
            });
        });
        // 반려 이유 모달 닫기 버튼 클릭 이벤트 핸들러
        document.getElementById('closeRejectReasonModalButton').addEventListener('click', function () {
            $('#rejectReasonModal').modal('hide');
        });
    }

    function closeModal() {
        $('#joinInfoModal').modal('hide');
    }

}); 

</script>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>		 
</body>
</html>