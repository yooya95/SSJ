<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>인증 게시판 관리</title>
		<style type="text/css">
		
			/* th 칼럼이 증가해도 글씨가 아래로 내려가지 않게 고정함 */
			table {
		        table-layout: fixed;
		        width: 100%;
		    }
		
		    th {
		        white-space: nowrap; /* 글자를 줄 바꿈하지 않고 한 줄에 표시 */
			    /* overflow: hidden; */ /* 넘치는 부분은 숨김 */
			    /* text-overflow: ellipsis; */ /* 넘치면 ...으로 표시 */
		    }
		    
		    #report_dateSearchInput {
			  visibility: hidden;
			}
			
			
			.pink-link:hover {
			    color: pink; /* 마우스를 가져갔을 때 텍스트 색상을 핑크로 변경하세요. */
			    text-decoration: underline; /* 밑줄을 추가하세요. */
			    cursor: pointer; /* 마우스 커서를 손가락으로 변경하세요. */
			  }
		    
		    
		    
		</style>
		
		<script type="text/javascript">
			
			// 신고된 인증글 불러오는 모달창입니다
			function modalCall(index) {
				
				// alert("modal start");
				
				var brd_num			=	$("#brd_num"+index).val();  		
				var reported_nick	=	$("#reported_nick"+index).val();  		
				var reg_date		=	$("#reg_date"+index).val();  
				var title			=	$("#title"+index).val();  
				var conts			=	$("#conts"+index).val();  
				var img				=	$("#img"+index).val();  
				var user_img		=	$("#user_img"+index).val();
				var cnt				=	$("#cnt"+index).val();
				var report_id		=	$("#report_id"+index).val();
				
				
				/* alert(brd_num);
				alert(reported_nick);
				alert(reg_date);
				alert(title);
				alert(conts);
				alert(img);
				alert(cnt);
				alert(user_img); */
				
				
				// 이미지 설정
				$('#modalImg').attr('src', '${pageContext.request.contextPath}/upload/'+img);
				$('#modalUserImg').attr('src', '${pageContext.request.contextPath}/upload/'+user_img);
				
				//  모달 창 안의 태그 -> 화면 출력용  <span> <p> -> text
				$('#modalReported_nick').text(reported_nick);
				$('#modalReg_date').text(reg_date); 

				$('#modalTitle').text(title);
				$('#modalConts').text(conts);
				
				//   글 수정 모달 창 안의 태그 input Tag -> Form 전달용		<input> -> <val>
				$('#modalReport_id').val(report_id); 
				
				
				$('#modalShow').modal('show');
			}
			
			
			
			// 리스트의 헤더 체크박스 선택 시, 전체 선택 되도록 
			function toggleCheckboxes() {
				
				var headerCheckbox = document.getElementById('headerCheckbox');
				var rowCheckboxes = document.getElementsByClassName('rowCheckbox');
				
				for (var i = 0; i < rowCheckboxes.length; i++) {
					rowCheckboxes[i].checked = headerCheckbox.checked;
				}
			}
			
			
			
			// 체크박스에 선택된 항목들을 신고 점수 초기화 할 수 있도록
	         function resetReportCnts() {
				
	        	// 확인 및 초기화 다이얼로그 표시
	     		var confirmed = confirm("선택한 항목을 초기화 하시겠습니까?");
	        	
				var reportList = [];
				
                
                $('.form-check-input.rowCheckbox:checked').each(function() {
                   var index = $(this).attr('id').replace('rowCheckbox', '');
                   var report_id = $('#report_id' + index).val();
                   var rowReport = '{report_id : ' + report_id+'}';
	   			   const reportItem = { 
		    		        "report_id":report_id
		    		    };

	   			   reportList.push(reportItem);
                });
                
  /*               var paramList = {
                		   "paramList" : JSON.stringify(selectedReports)
                		}
  */               
  				console.log(reportList);
                alert(JSON.stringify(reportList));
                
                $.ajax({
                	
                	 type:	'POST'	// 또는 'GET'에 따라서
                	,url:	'/resetReportCnts'
                	,data:	JSON.stringify(reportList) //JSON 객체를 불러와서 stringify() 함수 안에 배열
                	,contentType:	'application/json'
                	// contentType 이란, 클라이언트가 서버로 전송하는 데이터의 형식
                	// 클라이언트가 JSON 형식으로 데이터를 전송한다면 
                	// contentType: 'application/json' 으로 설정
                	// 이 설정이 없으면 서버는 기본적으로 폼 데이터를 기대하게 되어 제대로 된 처리가 이뤄지지 않을 수 있음
                	// ,traditional:	true	// 배열 전송을 위한 옵션
                	,success:	function (response) {
                		location.reload();
                	},
                	error:   function() {
     	               alert("초기화 실패하였습니다");
     	            }
                	
                });
	             
	          }
			
			
			
			
			// 날짜 검색 전후 화면 숨기고 띄우기
	         $(document).ready(function () {
	        	// 페이지 로드 시 초기에 report_dateSearchInput을 숨깁니다.
	        	var selectedCategory = $('#modalSearchCategories').val();
	        	
	        	if (selectedCategory === 'report_date') {
	                $('#defaultSearchInput').hide();
	                $('#report_dateSearchInput').css('visibility', 'visible');
	            } else {
	                $('#defaultSearchInput').show();
	                $('#report_dateSearchInput').css('visibility', 'hidden');
	            }

	            $('#modalSearchCategories').change(function () {
	                var selectedCategory = $(this).val();

	                if (selectedCategory === 'report_date') {
	                    $('#defaultSearchInput').hide();
	                    $('#report_dateSearchInput').css('visibility', 'visible');
	                } else {
	                    $('#defaultSearchInput').show();
	                    $('#report_dateSearchInput').css('visibility', 'hidden');
	        	    }
	        	  });
	        	});
	         
	         
	         
	         function searchDate() {
	        	 
	        	 // alert("searchDate");
	        	 
	        	// Input 엘리먼트에서 값을 가져와서 URL에 추가
	            var startDate = document.getElementById('startDate').value;
        		var endDate = document.getElementById('endDate').value;
        		var report_date = document.getElementById('report_date').value;
        		
        		// alert("startDate -> "+startDate);
        		// alert("endDate -> "+endDate);
        		// startDate가 비어 있으면 endDate에 startDate 값을 설정
				if (!startDate.trim() && endDate.trim()) {
					startDate = endDate;
				}
        		
        		// alert("startDate -> "+startDate);
				// alert("endDate -> "+endDate);

				// endDate가 비어 있으면 startDate에 endDate 값을 설정
        		if (!endDate.trim() && startDate.trim()) {
					endDate = startDate;
				}
        		  
        		// alert("startDate -> "+startDate);
				// alert("endDate -> "+endDate);

	            // reportListAdmin으로 이동하면서 startDate와 endDate를 매개변수로 전달
	            window.location.href = 'reportListAdmin?startDate=' + startDate + '&endDate=' + endDate + '&searchType=' + report_date;
	         }
	         

			
			
		</script>
	</head>
	<body>
		<section class="pt-7 pb-12">
			 <div class="container">
			        <div class="row">
			          <div class="col-12 text-center">
						
			            <!-- Heading -->
			            <div class="pt-10 pb-5">
			            
			            	<h3 class="mb-10">
			            	인증 게시판 관리</h3>
			            </div>
			
			          </div>
			        </div>
			        
			        <div class="row">
			        <!--사이드바   -->
			        <%@ include file="../jh/adminSidebar.jsp" %>
			          
			       <!--  <div class="row align-items-center col-md-10"> -->
			       <div class="col-md-10 ">
			       
					<form>
						<div class="row">
						  <div class="col">
						    <label class="visually-hidden" for="modalSearchCategories">Categories:</label>
					            <select class="form-select" id="modalSearchCategories" name="searchType">
					              <option selected value="null">All Categories</option>
					              <option value="brd_num" <c:if test="${searchType eq 'brd_num' }"> selected="selected"</c:if>>글 번호</option>
					              <option value="reporter_id" <c:if test="${searchType eq 'reporter_id' }"> selected="selected"</c:if>>신고자 아이디</option>
					              <option value="report_date" id="report_date" <c:if test="${searchType eq 'report_date' }"> selected="selected"</c:if>>신고일</option>
					            </select>
						  </div>
						  <div class="col">
						  
						  
							<div class="input-group input-group-merge" id="defaultSearchInput"  >
					            <input class="form-control" type="search" placeholder="Search" name="keyword" value="${keyword }">
					            <div class="input-group-append">
					              <button class="btn btn-outline-border" type="submit">
					                <i class="fe fe-search"></i>
					              </button>
					            </div>
							</div>
						  
						  
							<!-- Range -->
		                    <div class="d-flex align-items-center" id="report_dateSearchInput" >
	
		                      	<!-- Input -->
		                      	<input type="date" class="form-control form-control-xs" id="startDate" value="${startDate }">
		
		                      	<!-- Divider -->
		                      	<div class="text-gray-350 mx-2"></div>
		
		                      	<!-- Input -->
		                      	<input type="date" class="form-control form-control-xs" id="endDate" value="${endDate }">
		                      
		                      	<div class="text-gray-350 mx-2"></div>
	                      
				              	<a class="nav-link" onclick="searchDate()">
				                	<i class="fe fe-search"></i>
				              	</a>

                    		</div>
                    
						  </div>
						  
						</div>
						
					</form>
			       
			       <div class="row mb-5">
			       
			          
				                <!-- Count 총 인증 수 -->
				                <strong class="text-end">Total ${totalReport }</strong>
				              
			          
			        </div>
			        
					<div class="col-12">
						<form action="${pageContext.request.contextPath}/reportJpa/resetReportCnts" method="get">
							<c:set var="num" value="${page.total-page.start+1 }"></c:set>
							
								<table class="table table-bordered table-sm mb-0 table-hover">
								  <thead class="table-dark">
									<tr class="p-2 text-center">
										<th style="width: 60px;">
							            	<input class="form-check-input" type="checkbox" value="" id="headerCheckbox" onchange="toggleCheckboxes()">
							            </th>
										<th style="width: 100px;">신고 번호</th>
							            <th>신고자 아이디</th>
							            <th style="width: 120px;">신고일</th>
							            <th>작성자 아이디</th>
							            <th style="width:85px;">글 번호</th>
							            <th>글 제목</th>
							            <th style="width: 100px;">신고 점수</th>
							            
									</tr>
								  </thead>
								  <tbody>
									<c:forEach var="listReport" items="${listReport  }"			varStatus="status">
										<input type="hidden" id="img${status.index }"			value="${listReport.img }">
				                        <input type="hidden" id="user_img${status.index }"		value="${listReport.user_img }">
				                        <input type="hidden" id="reported_nick${status.index }"	value="${listReport.reported_nick }">
				                        <input type="hidden" id="reg_date${status.index }"      value="${listReport.reg_date }">
				                        <input type="hidden" id="conts${status.index }"         value="${listReport.conts }">
				                        <input type="hidden" id="title${status.index }"         value="${listReport.title }">
				                        <input type="hidden" id="cnt${status.index }"			value="${listReport.cnt }">
				                        <input type="hidden" id="report_id${status.index }"		value="${listReport.report_id }">
				                        <input type="hidden" id="brd_num${status.index }"		value="${listReport.brd_num }">
										<tr class="text-center">
											<td>
												<input class="form-check-input rowCheckbox" id="rowCheckbox${status.index }" type="checkbox">
											</td>
											<td>${listReport.report_id }</td>
							                <td>${listReport.reporter_id }</td>
							                <td><fmt:formatDate value="${listReport.report_date }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
							                <td>${listReport.reported_id }</td>
							                <td>${listReport.brd_num }</td>
							                <td>
							                	<a class="pink-link" onclick="modalCall(${status.index})" onmouseover="bold">${listReport.title }</a>
							                </td>
							                <td>${listReport.cnt }</td>
										</tr>
									</c:forEach>
								 </tbody>
								</table>
								
									<!-- 페이지네이션  -->
									 <nav class="d-flex justify-content-center justify-content-md-center mt-3">
					      	   		 <ul class="pagination pagination-lg text-gray-400">
									  	<c:if test="${page.startPage > page.pageBlock }">
									  		<li class="page-item">
												<a class="page-link page-link-arrow" href="reportListAdmin?searchType=${searchType }&keyword=${keyword }&startDate=${startDate}&endDate=${endDate}&currentPage=${page.startPage-page.pageBlock }">
												<i class="fa fa-caret-left">이전</i></a>
											</li>
										</c:if>
										
									    <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
											<li class="page-item">
												<c:if test="${i == page.currentPage }">
													<a class="page-link px-2" href="reportListAdmin?searchType=${searchType }&keyword=${keyword }&startDate=${startDate}&endDate=${endDate}&currentPage=${i }"><b class="text-primary">${i}</b></a>
												</c:if>
												<c:if test="${i != page.currentPage }">
													<a class="page-link px-2" onclick="pageNavigation(${i })" href="reportListAdmin?searchType=${searchType }&keyword=${keyword }&startDate=${startDate}&endDate=${endDate}&currentPage=${i }">${i}</a>
												</c:if>
											</li>
										</c:forEach>
									    <c:if test="${page.endPage < page.totalPage }">
									    	<li class="page-item">
												<a class="page-link page-link-arrow" href="reportListAdmin?searchType=${searchType }&keyword=${keyword }&startDate=${startDate}&endDate=${endDate}&currentPage=${page.startPage + page.pageBlock }">
												<i class="fa fa-caret-right">다음</i></a>
											</li>
										</c:if>
									 </ul>
							  		</nav>
							  		
							  		<div class="col-12">
		
					                  <!-- Button -->
					                  <button class="btn btn-dark" type="button" onclick="resetReportCnts()">신고 점수 초기화</button>
					
					                </div>
					  		</form>
						  </div>
					  	</div>
					  	</div>
					  	</div>
					  	<div class="py-10"></div>	
					 </section>
					 
					 
					 
					 <!-- 더보기 모달 창 Product -->
				    <div class="modal fade" id="modalShow" tabindex="-1" role="dialog" aria-hidden="true">
				      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
				        <div class="modal-content">
				    
				          <!-- Close -->
				          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				            <i class="fe fe-x" aria-hidden="true"></i>
				          </button>
				    
				          <!-- Content -->
				          <div class="container-fluid px-xl-0">
				            <div class="row align-items-center mx-xl-0">
			            	
								<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
				                <!-- Image 더보기 모달창 인증샷 -->
					                <img class="img-fluid" alt="더보기 모달창 인증샷" id="modalImg">
				             	</div>
				              
				              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
				                <!-- 신고 점수 초기화 Form -->
				                <!-- context 로 설정을 못해서 pageContext로 넣었는데 다시 확인해볼 것 -->
					            <form action="${pageContext.request.contextPath}/reportJpa/resetReportCnt" method="get" enctype="multipart/form-data">
					              <input type="hidden" name="report_id" id="modalReport_id">
					                
									<div class="avatar avatar-xl">
									  <img src="" alt="profile" class="avatar-img rounded-circle" id="modalUserImg">
									</div>
				                      
				                      
					                <div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold" id="modalReported_nick">
					                      </p>
				                    </div>
					                </div>
		                    
			                      <!-- Header -->
				                      <div class="row mb-6">
				                        <div class="col-12">
				                          <!-- Time -->
				                          <span class="fs-xs text-muted">
				                            <time datetime="2019-07-25" id="modalReg_date"></time>
				                          </span>
				                        </div>
				                      </div>
					                

		        					<div class="col-12"><!--  -->
					                  <!-- 제목 -->
					                  <div class="form-group"><!--  -->
					                  	<h5 class="modal-title" id="modalTitle"></h5>
					                  	<!-- <h4 id="moreTitle"></h4> -->
					                  	<!-- <strong class="mx-auto" id="moreTitle"></strong> -->
					                    <!-- <h5 class="mb-3" id="moreTitle"></h5> -->
					                  </div>
					                </div>
	
					                <div class="col-12">
					                  <!-- 인증글 -->
					                  <div class="form-group">
					                  	<div class="modal-body" id="modalConts"></div>
					                  	<!-- <p class="mb-7 fs-lg" id="moreConts"></p> -->
					                    	<!-- <h4 class="mb-3" id="moreConts"></h4> -->
					                  </div>
					                </div>
					                
					                <div class="class=form-group mb-0">
					                	<div class="class=col-12 col-lg auto">
							                <button class="btn btn-outline-dark" type="submit">
						                      	신고 점수 초기화
						                    </button>
					                	</div>
					                </div>
					                
					            </form>
							
				              </div>
				              
				            </div>
				          </div>
				    
				        </div>
				      </div>
				    </div>
	
	</body>
</html>