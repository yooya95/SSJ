<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- PRODUCT -->
<section>
    <div class="container section-mt">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <div class="col-12 col-md-6">
                        <!-- Images -->
                        <div class="row gx-5 mb-10 mb-md-0">
                            <div class="col-2">
                                <!-- Slider -->
                                <div class="flickity-nav flickity-vertical" data-flickity='{"asNavFor": "#productSlider", "draggable": false}'>
                                    <!-- Item -->
                                    <div class="ratio ratio-1x1 bg-cover mb-4" style="background-image: url(${pageContext.request.contextPath}/upload/${board.img});"></div>
                                </div>
                            </div>
                            <div class="col-10">
                                <!-- Card -->
                                <div class="card">
                                    <!-- Badge -->
                                  
                                    <!-- Slider -->
                                    <div data-flickity='{"draggable": false, "fade": true}' id="productSlider">
                                        <!-- Item -->
                                        <a href="${pageContext.request.contextPath}/upload/${board.img}">
                                            <img src="${pageContext.request.contextPath}/upload/${board.img}" alt="..." class="card-img-top">
                                        </a>
                                        <!-- Other Items -->
                                        <!-- ... -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 ps-lg-10" style="margin-top: 40px;">
                        <!-- Header -->
                        <div class="row mb-1">
                            <div class="col">
                                <!-- Preheading -->
                                <a class="text-muted" href="../sharing">쉐어링 게시판</a>
                            </div>
         				<input type="hidden" name="brd_group" value="${board.brd_group}"> 
                  
                            <div class="col-auto">
                                <a class="fs-sm text-reset ms-2" href="#reviews">
                                    Reviews (${board.replyCount})
                                </a>	
                            </div>
                        </div>
                        <!-- Heading, Price, Form -->
                        <h3 class="mb-1">${board.title}</h3>
                        <div class="mb-3 text-gray-400">
                            <span class="ms-1 fs-5 fw-bold"><fmt:formatNumber value="${board.price}" pattern="#,###"/>원</span> <a href="sharing" class="btn btn-dark btn-xs">목록</a>
                        </div>
                        <hr class="my-3">
                        
                        <!--  신청내용 -->
                          <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">작성자</a> <br>
	                      <span class="text-muted">${board.nick}</span>
	                    </p>
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">작성일</a> <br>
	                      <span class="text-muted">
						    <fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd"/>
						</span>
	                    </p>
	                    
	                    <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">모집인원</a> <br>
	                      <span class="text-muted">${board.applicants}명</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">참여인원</a> <br>
	                      <span class="text-muted">${board.participants}명</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">거래지역</a> <br>
	                      <span class="text-muted">${board.addr}</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">내용</a> <br>
	                      <span class="text-muted">${board.conts}</span>
	                    </p>
                       
        
        
                                  <!-- Submit Buttons -->
                                <div class="row"> 
                                    <input type="hidden" name="brd_num" value="${board.brd_num}"> 
                                    <input type="hidden" name="b_user_num" value="${board.user_num}">
                                    <input type="hidden" name="user_num" value="${sessionScope.user_num}">		
                                    <div class="col-lg-6 mb-2">
                                       <!--로그인 유저  user_num과 sharingList table user_num이 존재할경우 버튼비활성화   -->
                                       
                                        <!--ya 쉐어링 참가신청 test -------------------------------------------------------------------------->
                                        <button type="button" class="btn btn-dark w-100" id="participateBtn" data-toggle="modal" data-target="#infoModal"
                                            data-user_num="${sessionScope.user_num}" data-brd_num="${board.brd_num}" data-participants="${board.participants}" data-applicants="${board.applicants }">
                                            <i class="fe fe-mail me-2"> 참가신청 </i></button>
                                    </div>
                                    <!--ya 참가자 중복신청 막기 버튼  ------>
									<script>
									    document.addEventListener('DOMContentLoaded', function () {
									        // 페이지 로드 시 실행되는 함수
									        checkAndDisableButton();
									    });
									
									    function checkAndDisableButton() {									        
									        var userNum = ${sessionScope.user_num};
									        var sharingChk = ${sharingChk};
											console.log("userNum : "+userNum );
											console.log("sharingChk:" +sharingChk);
											
									        // 유저의 user_num과 sharingChk 중 하나와 일치하면 버튼 비활성화
									        if (sharingChk.includes(userNum)) {
									            document.getElementById('participateBtn').disabled = true;
									            
									            
									        }
									    }
									</script>
									                                    
                                    
                                         <!-- yr 작성 -->
                        <!-- 쉐어링 찜하기 -->
                        <div class="col-lg-6 mb-2">

                            <c:choose>
                                <c:when test="${sessionScope.user_num != null}">
                                    <!-- 로그인 한 상태 -->
                                    <c:choose>
                                    
                                        <c:when test="${brdLike == 1}">
                                            <!-- 찜 기록 있을 때 -->
                                            <button class="btn btn-dark w-100 mb-2" data-toggle="button" onclick="sharingPick(${board.brd_num})" id="sharingPick">
                                                찜하기 <i class="fe fe-heart ms-2"></i>
                                            </button>	
                                        </c:when>
                                        
                                        <c:otherwise>
                                            <!-- 찜 기록 없을 때 -->
                                            <button class="btn btn-outline-dark w-100 mb-2" data-toggle="button" onclick="sharingPick(${board.brd_num})" id="sharingPick">
                                                찜하기 <i class="fe fe-heart ms-2"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                </c:when>
                                
                                <c:otherwise>
                                    <!-- 로그인 안 한 상태 -> 로그인 페이지로 이동 -->
                                    <button class="btn btn-outline-dark w-100 mb-2" data-toggle="button" onclick="location.href='/loginForm'" id="sharingPick">
                                        찜하기 <i class="fe fe-heart ms-2"></i>
                                    </button>
                                </c:otherwise>

                            </c:choose>

                        </div>

                        <!-- Additional Text with Registration Link -->
                        <span class="text-gray-500">마음에 드시는 물건이 있으신가요?<a class="text-reset text-decoration-underline" data-bs-toggle="modal" href="../loginForm"> 회원가입 후 이용하실 수 있습니다!</a></span>
                        
                    </div>
                </div>
            </div>
        </div>
   
                                </div>
                            </div>
                       
                        
                   
</section>
<!----------------------Ya 쉐어링 신청 모달창 띄우기 test------------------------------------------------------------------------------------------>
<div class="modal" id="infoModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">전달할  메세지를 입력해주세요!</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">
                <form id="infoForm">
                    <input type="hidden" name="brd_num" value="${board.brd_num}"> 
                    <input type="hidden" name="user_num" value="${sessionScope.user_num}">
            	
                    <div class="form-group">
                        <label for="nick">닉네임</label>
                        <input type="text" class="form-control" id="nick" name="nick" value="${user1.nick}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="user_name">이름</label>
                        <input type="text" class="form-control" id="user_name" name="user_name" value="${user1.user_name}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="tel">번호</label>
                        <input type="text" class="form-control" id="tel" name="tel" type="text" value="${user1.tel}"  readonly >
                    </div>
                    <div class="form-group">
                        <label for="add">주소</label>
                        <input type="text" class="form-control" id="addr" name="addr" value="${user1.addr}"  readonly >
                    </div>
                    <div class="form-group">
                        <label for="add">전달할 메세지</label>
                        <input type="text" class="form-control" id="message" name="message">
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-dark btn-sm" data-dismiss="modal">닫기</button>
               <button type="button" class="btn btn-dark btn-sm" id="saveBtn">신청</button> <!-- onclick="submitInfo()" -->
            </div>
        </div>
    </div>
</div>
<!--------------------------------YA모달창 자바스크립트 ------------------------------------------------------------------------>
<script type="text/javascript">
    
    // 참가신청버튼 클릭 모달창열기
    document.addEventListener('DOMContentLoaded', function() {
        const modalBtn = document.querySelector('[data-target="#infoModal"]');
        const participateBtn = document.getElementById('participateBtn');
        
        modalBtn.addEventListener('click', function() {
        	const user_num = parseInt(modalBtn.getAttribute('data-user_num'), 10);
        	const brd_num = parseInt(modalBtn.getAttribute('data-brd_num'), 10);
            const participants = parseInt(participateBtn.getAttribute('data-participants'), 10);
            const applicants = parseInt(participateBtn.getAttribute('data-applicants'), 10);
            
        	// 비로그인 상태 확인
            if (isNaN(user_num)) {
                // 비로그인일 경우 알림창 띄우고 로그인 페이지로 이동
                alert('로그인 후 이용해주세요!');
                window.location.href = '/loginForm'; // 로그인 페이지로 이동
                return;
            }
       

            // 참여인원이 모집인원을 초과하는 경우 참가하기 버튼 비활성화
            if (participants >= applicants) {
            	alert('모집인원이 마감되었습니다.');
                participateBtn.disabled = true;
            } else {
                participateBtn.disabled = false;
            }
        	
        	const url = `/sharingParticipate?user_num=${user_num}&brd_num=${board.brd_num}`;
       		console.log("login user_num :"+user_num);
       		console.log("board brd_num  :"+brd_num);
            // 사용자 정보 불러오기 
            fetch(url)
                .then(response => response.json())
                .then(userData => {                	
                 	/* document.getElementById('brd_num').value= userData.board.brd_num; */
                 	/* document.getElementById('b_user_num').value = userData.board.user_num; */
                	document.getElementById('user_num').value = userData.user1.user_num;
                    document.getElementById('nick').value = userData.user1.nick;
                    document.getElementById('user_name').value = userData.user1.user_name;
                    document.getElementById('tel').value = userData.user1.tel;
                    document.getElementById('addr').value = userData.user1.addr;

                    
                    console.log("userData :" +userData)
                    console.log("participate user_num :" + user_num);
                	console.log("board brd_num :" + brd_num);
                })
                .catch(error => {
                    console.error('Error fetching user data:', error);
                });
        });
		
		   	  
		  // 신청 버튼 클릭 시 데이터 저장
		    document.getElementById('saveBtn').addEventListener('click', function() {
		        /* const brd_num = document.getElementById('brd_num').value;         */
		        const user_num = document.getElementById('user_num').value;
		        const message = document.getElementById('message').value;
		
		        // 데이터를 서버에 전송
		        const saveUrl = `/saveSharingInfo?user_num=${user_num}&brd_num=${board.brd_num}&message=${message}`;
		        fetch(saveUrl, {
		            method: 'POST',
		            headers: {
		            	'Content-Type': 'application/json',
		        
		            },
		          /*   body: `user_num=${user_num}&brd_num=${brd_num}&message=${message}`  */
		        		  body: JSON.stringify({
		              	  user_num: user_num,
		               	  brd_num: brd_num,
		                  message: message, 
		            }), 
		        })
		            .then(response => response.json())
		            .then(result => {
		                console.log('Save result:', result);
		                console.log('Message:', message);

		                if (result.status === 'success') {
		                    alert('신청이 완료되었습니다 마이페이지에서 승인상태를 확인해주세요.');
		                    location.reload();
		                } else {
		                    alert('신청 저장에 실패했습니다.');
		                }
		            })
		            .catch(error => {
		                console.error('Error saving sharing info:', error);
		            });
		    });
		});

    
    // yr 작성
    // 찜하기 기능
    function sharingPick(p_index) {
        // alert("sharingPick" + p_index);

        $.ajax({
            url: "/likePro",
            type: "POST",
            data: { brd_num: p_index },
            dataType: 'json',
            success: function (likeResult) {
                if (likeResult.likeProResult > 0) {
                    $("#sharingPick").removeClass("btn-outline-dark").addClass("btn-dark");
                    alert("찜 성공");
                } else {
                    $("#sharingPick").removeClass("btn-dark").addClass("btn-outline-dark");
                    alert("찜 취소");
                }

            },
            error: function () {
                alert("찜하기 오류");
            }
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<%@ include file="commentSharing.jsp" %>
<%@ include file="../footer.jsp" %>
</html>
