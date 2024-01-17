<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
	    <meta name="viewport" content="width=device-width, initial-scale=1" />
	
	    <!-- Favicon -->
	    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
	
	    <!-- Libs CSS -->
	    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
	
	    <!-- Theme CSS -->
	    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
	
	    <!-- Title -->
	    <title>챌린지 상세</title>
		
		<!-- jQuery 라이브러리를 불러옵니다. -->
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
		
			
			
			function writeCertBoard() {
				
				//alert("writeCertBoard Start");
				
				// EL값을 JavaScript 변수에 저장
				var user_num = ${user1.user_num};
				// chg_id 챌린지 페이지 아직 없어서 임시용으로 변수에 저장함
				var chg_id = 1;
				
				// 이미지 파일 선택
				var screenshot = $("#screenshot")[0].files[0];
				
				
				// 이미지 파일, 제목, 내용을 FormData 에 추가
				var formData = new FormData();
				formData.append("title", $('title').val());
				formData.append("conts", $('conts').val());
				formData.append("chg_id", chg_id);
				formData.append("user_num", user_num);
				formData.append("screenshot", screenshot);
				
				
				// 사용자가 입력한 내용 가져오기 -> ver.1:  이미지도 전달해야 해서 보류
				//var paramData = {
				//					"title"	:	$('#title').val(),
				//					"conts"	:	$('#conts').val(),
				//					"chg_id":	chg_id,
				//					"user_num":	user_num
				//};
				
				// alert("paramData $('#title').val() ->"+$('#title').val());
				// alert("paramData $('#conts').val() ->"+$('#conts').val());
				// alert("paramData chg_id ->"+chg_id);
				// alert("paramData user_num ->"+user_num); 
				
				// 서버로 데이터 전송
				$.ajax({
					url	:	"/writeCertBoard",
					type:	"POST",
					data:	formData,
					dataType:	"text",
					processData: false,		// 이미지 파일 처리를 위해 false로 설정
					contentType: false,		// 이미지 파일 처리를 위해 false로 설정
					success	:	function(rtnStr) {
						alert("success ajax Data -> "+rtnStr);
						// 서버 응답을 처리하는 코드
					},
					error: function() {
						// Ajax 요청 자체가 실패한 경우
						alert("error: 글 등록에 실패했습니다");
					}
				});
			}
			
			
			
			//  '수정' 버튼 클릭 시    ->   글 수정용 모달 창 열기
			function updateModalCall(index) {
				
				// alert("updateModalCall Start...");
				
				// 모달창에 넘겨줄 값을 저장 
				var brd_num =   $("#brd_num"+index).val();  		
				var nick =   	$("#nick"+index).val();  		
				var reg_date =	$("#reg_date"+index).val();  
				var title =		$("#title"+index).val();  
				var conts =		$("#conts"+index).val();  
				/*
 				 alert("updateModalCall nick -> "+nick);
				 alert("updateModalCall reg_date -> "+reg_date);
				 alert("updateModalCall title -> "+title);
				 alert("updateModalCall conts -> "+conts); 
				 */
				 
				//  글 수정 모달 창 안의 태그 -> 화면 출력용  <span> <p> -> text
				$('#displayNick').text(nick);     
				$('#displayReg_date').text(reg_date); 
				
				//   글 수정 모달 창 안의 태그 input Tag -> Form 전달용		<input> -> <val>
				$('#editBrd_num').val(brd_num);     
				$('#editNick').val(nick);     
				$('#editTitle').val(title);     
				$('#editConts').val(conts);     
				
				// 모달 창 표시
				$('#updateCertBrdForm').modal('show');
			}
			
			
			
			// '삭제' 버튼 클릭 시
			function deleteCertBrd(index) {
				
				var brd_num = $("#brd_num"+index).val();
				
				$.ajax({
					url:"/brdNumDelete",
					data:{brd_num : brd_num},
					dataType:'text',
					
					success:function(data){
						alert(".ajax deleteCertBrd data -> "+data);
						if (data == '1') {
							// id 가 review +index 성공하면 아래 라인 수행
							$('#review'+index).remove();		/* Delete Tag */
							
						}
					}
				});
			}
			
			

		</script>
		
		
	</head>
	<body>
		
		
		
		<!-- Nav -->
	            <div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
	              <a class="nav-link active" data-bs-toggle="tab" href="#descriptionTab">
					챌린지 소개
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#certBoard">
					인증 게시판
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#shippingTab">
					소시지들
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#shippingTab">
					후기 게시판
	              </a>
	            </div>
	      
	      
	
	    <!-- 인증 게시판 -->
	    <section class="pt-9 pb-11" id="certBoard">
	      <div class="container">
	        <div class="row">
	          <div class="col-12">
	
	            <!-- Heading -->
	            <h4 class="mb-10 text-center">인증 게시판</h4>
	
	            <!-- Header -->
	            <div class="row align-items-center">
	              <div class="col-12 col-md-auto">
	
	                <!-- Dropdown -->
	                <div class="dropdown mb-4 mb-md-0">
	
	                  <!-- Toggle -->
	                  <a class="dropdown-toggle text-reset" data-bs-toggle="dropdown" href="#">
	                    <strong>Sort by: Newest</strong>
	                  </a>
	
	                  <!-- Menu -->
	                  <div class="dropdown-menu mt-3">
	                    <a class="dropdown-item" href="#!">Newest</a>
	                    <a class="dropdown-item" href="#!">Oldest</a>
	                  </div>
	
	                </div>
	
	              </div>
	              <div class="col-12 col-md text-md-center">
	

	
	                <!-- Count -->
	                <strong class="fs-sm ms-2">Reviews ${totalCert }</strong>
	
	              </div>
	              <div class="col-12 col-md-auto">
	
	                <!-- Button -->
	                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
	                  	인증하기
	                </a>
	
	              </div>
	            </div>
	
	            <!-- New Review -->
	            <div class="collapse" id="reviewForm">
	
	              <!-- Divider -->
	              <hr class="my-8">
	
	
	
	              <!-- 인증 글쓰기 Form -->
	              <form id="certForm">
	                <div class="row">
	                  
	                  <div class="col-12 col-md-6">
	                    <!-- 유저 닉네임 표시하는 란 Name -->
	                    <div class="form-group">
		                      <p class="mb-2 fs-lg fw-bold">
		                        ${user1.nick }
		                      </p>
	                    </div>
	                  </div>
	                  
	                  <div class="col-12">
	                    <!-- 제목 입력란  Name -->
	                    <div class="form-group">
	                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
	                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
	                    </div>
	                  </div>
	                  
	                  <div class="col-12">
	                    <!-- 인증글 입력란 Name -->
	                    <div class="form-group">
	                      <label class="visually-hidden" for="reviewText">Review:</label>
	                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
	                    </div>
	                  </div>
	                  
	                  <div class="mb-3">
	                  	<!-- 인증샷 -->
					  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
						<input class="form-control" type="file" id="screenshot" name="screenshot">
					  </div>
							                  
	                  <div class="col-12 text-center">
	                    <!-- 등록 Button -->
	                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBoard()">
	                      	등록
	                    </button>
	                  </div>
	                </div>
	              </form>
	
	            </div>
	
	
	
	            <!-- Reviews -->
	            <div class="mt-8">
	
	              <!-- Review 여기부터 첫번째 인증글 -->
	              <c:forEach var="certBoard" items="${certBoard }" varStatus="status">
	              
		              <div class="review" id="review${status.index}">
		                <div class="review-body">
		                  <div class="row" id="certBoard${status.index}">
		                  	<input type="hidden" id="brd_num${status.index}" value="${certBoard.brd_num }">
		                  	<input type="hidden" id="nick${status.index}" value="${certBoard.nick }">
		                  	<input type="hidden" id="reg_date${status.index}" value="${certBoard.reg_date }">
		                  	<input type="hidden" id="title${status.index}" value="${certBoard.title }">
		                  	<input type="hidden" id="conts${status.index}" value="${certBoard.conts }">
		                  	
		                  	
		                  	<div class="col-5 col-md-3 col-xl-2">
								<!-- 인증샷 Image -->
		                    	<img src="assets/img/products/product-6.jpg" alt="..." class="img-fluid">
		                    </div>
		                    
		                    
		                    
		                    <div class="col-12 col-md">
		                    
								<!-- Avatar -->
		                    	<div class="avatar avatar-lg">
								  <img src="../assets/img/avatars/avatar-1.jpg" alt="..." class="avatar-img rounded-circle">
								</div>
		                    
		                      <!-- Header -->
		                      <div class="row mb-6">
		                        <div class="col-12">
		                          <!-- Time -->
		                          <span class="fs-xs text-muted">
		                            ${certBoard.nick}, <time datetime="2019-07-25">${certBoard.reg_date }</time>
		                          </span>
		                        </div>
		                      </div>
		                      
		
		                      <!-- Title -->
		                      <p class="mb-2 fs-lg fw-bold">
		                        ${certBoard.title }
		                      </p>
		
		                      <!-- Text -->
		                      <p class="text-gray-500">
		                      	${certBoard.conts }
		                      </p>
		                      
		
		                      <!-- Footer -->
		                      <div class="row align-items-center">
		                      
								
		                      
		                        <div class="col-auto d-none d-lg-block">
		                          <!-- Text -->
		                          <p class="mb-0 fs-sm">좋아요</p>
		                        </div>
		                        
		                        <div class="col-auto me-auto">
		                          <!-- Rate -->
		                          <div class="rate">
		                            <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
		                              <i class="fe fe-thumbs-up"></i>
		                            </a>
		                          </div>
		                        </div>
		                        
		                        
		                        <div class="col-auto d-none d-lg-block">
		                          <!-- Text -->
		                          <p class="mb-0 fs-sm">Comments (0)</p>
		                        </div>
		                        
		                        
		                        <c:if test="${user1.user_num eq certBoard.user_num }">
		                        
			                        <div class="col-auto">
			                        
			                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
			                          <a class="btn btn-xs btn-outline-border" 
			                          	 href="#!" 
			                          	 id="showModalButton"
			                          	 onclick="updateModalCall(${status.index})"
			                          >
										수정
			                          </a>
			                          
			                          <!-- Button -->
			                          <a class="btn btn-xs btn-outline-border" href="#!" onclick="deleteCertBrd(${status.index})">
										삭제
			                          </a>
			                          
			                        </div>
		                        
		                        </c:if>
		                        
		                        
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
	              </c:forEach>
	
	              
	            </div>
	            
	            
	            
	            <!-- 수정하기 모달 창 Product -->
			    <div class="modal fade" id="updateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"><!--  -->
			      <div class="modal-dialog modal-dialog-centered modal-xl" role="document"><!--  -->
			        <div class="modal-content"><!--  -->
			    
			          <!-- Close -->
			          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
			            <i class="fe fe-x" aria-hidden="true"></i>
			          </button>
			    
			          <!-- Content -->
			          <div class="container-fluid px-xl-0"><!--  -->
			            <div class="row align-items-center mx-xl-0"><!--  -->
			              <div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0"><!--  -->
			    
			                <!-- Image -->
			                <img class="img-fluid" src="./assets/img/products/product-7.jpg" alt="...">
			    
			                <!-- Button -->
			                <a class="btn btn-sm w-100 btn-primary" href="./product.html">
			                  More Product Info <i class="fe fe-info ms-2"></i>
			                </a>
			    
			              </div><!-- <div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0"> -->
			              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"><!--  -->
			    
                  

			                <!-- 수정 Form -->
					            <form action="updateCertBrd" method="post">
					              <input type="hidden" name="brd_num" id="editBrd_num">
					              <input type="hidden" name="nick" id="editNick">
					                
									<div class="avatar avatar-xl">
									  <img src="../assets/img/avatars/avatar-1.jpg" alt="..." class="avatar-img rounded-circle">
									</div>
				                      
				                      
					                <div class="col-12 col-md-6"><!--  -->
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group"><!--  -->
					                      <p class="mb-2 fs-lg fw-bold" id="displayNick">
					                      </p>
				                    </div>
					                </div>
		                    
			                      <!-- Header -->
				                      <div class="row mb-6"><!--  -->
				                        <div class="col-12"><!--  -->
				                          <!-- Time -->
				                          <span class="fs-xs text-muted">
				                            <time datetime="2019-07-25" id="displayReg_date"></time>
				                          </span>
				                        </div>
				                      </div>
					                

		        					<div class="col-12"><!--  -->
					                  <!-- Email -->
					                  <div class="form-group"><!--  -->
					                    <label class="form-label" for="accountEmail">
					                     	 제목 *
					                    </label>
					                      <input class="form-control form-control-sm" id="editTitle" name="title" type="text" placeholder="제목을 작성해주세요 *" required>
					                  </div>
					                </div>
	
					                <div class="col-12">
					                  <!-- Email -->
					                  <div class="form-group">
					                    <label class="form-label" for="accountEmail">
					                     	 인증글 *
					                    </label>
					                      <textarea class="form-control form-control-sm" id="editConts" name="conts" rows="4" placeholder="인증글을 작성해주세요 *" required></textarea>
					                  </div>
					                </div>
					                
					                <div class="row">
					                  <div class="col-12 text-center">
					                    <!-- 인증 글쓰기에서 가져온 글 수정 Form 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="updateCertBoard()">
					                      	수정하기
					                    </button>
					                  </div>
					                </div>
					                
					            </form>
						
						
			    
			              </div><!-- <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"> -->
			            </div><!-- <div class="row align-items-center mx-xl-0"> -->
			          </div><!-- <div class="container-fluid px-xl-0"> -->
			    
			        </div><!-- <div class="modal-content"> -->
			      </div><!-- <div class="modal-dialog modal-dialog-centered modal-xl" role="document"> -->
			    </div><!-- <div class="modal fade" id="updateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"> -->
			    
			    
			    
	            <!-- Pagination -->
	            <nav class="d-flex justify-content-center mt-9">
	              <ul class="pagination pagination-sm text-gray-400">
	                <li class="page-item">
	                  <a class="page-link page-link-arrow" href="#">
	                    <i class="fa fa-caret-left"></i>
	                  </a>
	                </li>
	                <li class="page-item active">
	                  <a class="page-link" href="#">1</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link" href="#">2</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link" href="#">3</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link page-link-arrow" href="#">
	                    <i class="fa fa-caret-right"></i>
	                  </a>
	                </li>
	              </ul>
	            </nav>
	
	          </div>
	        </div>
	      </div>
	    </section>
		
	</body>
</html>