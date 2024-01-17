<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 리스트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<%@ include file="/WEB-INF/views/header4.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {

		
		// 검색어 입력 후 엔터키 입력하면 검색버튼 클릭
		$("#keyword").keypress(function(e){	
			if(e.keyCode && e.keyCode == 13){
				$("#searchButton").trigger("click");
				return false;
			}
		});
	});
	
	// 필터별 정렬
	function fn_sortOpt(){
		var sortOpt = $('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var currentPage	=	${page.currentPage}
		var keyword 	=	"${chg.keyword}"
		
		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+currentPage
								+'&keyword='+keyword;
	}

	// yr 작성
	// 찜하기 기능
	function chgPick(p_index) {

		$.ajax({
			url : "/chgPickPro",
			type : "POST",
			data : {chg_id : p_index},
			dataType : 'json',
			success : function(chgPickResult) {
				if(chgPickResult.chgPick > 0) {
					$("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
					alert("찜 성공");
				} else {
					$("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
					alert("찜 취소");
				}
				$("#inputPickCnt" + p_index).html('<div style="color: #e56d90;" id="inputPickCnt${chg.chg_id }"><i class="fa-solid fa-heart" style="width:16px"></i>&ensp;' + chgPickResult.chgPickCnt + '</div>');
				
			},
			error : function() {
				alert("찜하기 오류");
			}
		});
	}

	// 비공개방 비밀번호 확인
	function confirmPswd(p_index){
		var input_priv_pswd = $('#input_priv_pswd'+p_index).val()
		var chg_priv_pswd 	= $('#chg_priv_pswd'+p_index).val();
		var chg_id			= $('#chg_id'+p_index).val();
// 		alert('input_priv_pswd --> ' + input_priv_pswd);
// 		alert('chg_priv_pswd --> ' + chg_priv_pswd);
		if(input_priv_pswd == chg_priv_pswd){
			location.href = "chgDetail?chg_id="+chg_id
		} else {
			alert('비밀번호가 틀렸습니다');
			$('#modalMatchPswd'+p_index).modal('hide');
			return false;
		}	
	}
	
	
	
	// 현재 페이지 그대로 이동
	function moveCurrentPage() {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var currentPage	=	${page.currentPage}
		var keyword 	=	"${chg.keyword}"
		
		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+currentPage
								+'&keyword='+keyword;
	}
	// 다른 페이지로 이동
	function movePage(p_index) {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		//	movaPage에 index를 넣어서 페이지이동 시킴
 		var pageNum		=	document.getElementById('movePage'+p_index).innerText
 		var keyword 	=	"${chg.keyword}"
		
		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+pageNum
								+'&keyword='+keyword;
	}
	
	// 이전 블럭 이동
	function movePrevBlock() {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var pageNum		=	${page.startPage - page.pageBlock }
		var keyword 	=	"${chg.keyword}"

		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+pageNum
								+'&keyword='+keyword;
	}
	
	// 다음 블럭 이동
	function moveNextBlock() {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var pageNum		=	${page.startPage + page.pageBlock }
		var keyword 	=	"${chg.keyword}"

		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+pageNum
								+'&keyword='+keyword;
	}
	
	// 검색 구현
	$(function() {
		$("#searchButton").click(function () {
			var keyword 	=	$("#keyword").val();
			var state_md 	=	${chg.state_md}
			var chg_lg 		= 	${chg.chg_lg}
	 		var chg_md 		= 	${chg.chg_md}
			// 진행중,종료된 챌린지를 체크하기위해서 status_md를 넣어줌
			location.href = '/thChgList?keyword='+keyword
							+'&state_md='+state_md
							+'&chg_lg='+chg_lg
							+'&chg_md='+chg_md
		})
	})

</script>
</head>

<body>
  
    <section class="pt-7 pb-12">
      <div class="container section-mt">
        <div class="row">
       		<div class="col-12 text-center">
				    <!-- Heading -->
				    <h3 class="mb-10">
				    	<c:if test="${chg.state_md == 103 }">종료된 </c:if>
                		챌린지
                	<span class="fs-5">
                	 	<c:choose>
		                	<c:when test="${chg.chg_md == ''}"></c:when>	
		                	<c:when test="${chg.chg_md == 100}"> - 운동</c:when>
		                	<c:when test="${chg.chg_md == 101}"> - 공부</c:when>
		                	<c:when test="${chg.chg_md == 102}"> - 취미</c:when>
		                	<c:when test="${chg.chg_md == 103}"> - 습관</c:when>
		                </c:choose>
		            </span>
		            </h3>
       		</div>
       		<%@ include file="/WEB-INF/views/chgSidebar.jsp" %>
		  	
		  	<div class="col-12 col-md-8 col-lg-9">
            <div class="row align-items-center mb-4">
              <div class="col-12 col-md">

              </div>
              <div class="col-12 col-md-auto">

                <!-- 필터 조회 -->
                <select class="form-select form-select-xs" id="sortOpt" onchange="fn_sortOpt()"> 
                  <option value="create_date" 	<c:if test="${sortOpt eq 'create_date' }">	selected="selected"</c:if>>최신등록순</option>
                  <option value="pick_cnt" 		<c:if test="${sortOpt eq 'pick_cnt' }">		selected="selected"</c:if>>찜순</option>
                  <option value="participants" 	<c:if test="${sortOpt eq 'participants' }">	selected="selected"</c:if>>참여자순</option>
                </select>

              </div>
            </div> 
             
            <!-- 챌린지 리스트 조회  -->
            <div class="row">
	            <c:set var="num" value="${page.total-page.start+1 }"></c:set>
	            	<c:forEach var="chg" items="${listChg }" varStatus="status">
			            <div class="col-6 col-md-4">
						
			               <!-- Card -->
			              <div class="card mb-7">
							
							<!-- Badge -->
							<!-- 찜수  10이상 시 인기 챌린지 태그 달아줌 -->
							<c:if test="${chg.pick_cnt >= 10 }">
			                  	<div class="badge bg-primary card-badge text-uppercase">인기</div>
			                </c:if>					
				            

			                
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
			                  <button class="btn btn-xs w-100 btn-dark card-btn" 
			                  	<c:if test="${chg.chg_public == 1 }"> 
			                  		data-bs-toggle="modal" 
			                  		data-bs-target="#modalMatchPswd${status.index }"
			                  	</c:if>
			                  	<c:if test="${chg.chg_public == 0 }"> 
			                  		onclick ="location.href='chgDetail?chg_id=${chg.chg_id }'"
			                  	</c:if>
			             	  >
			                    <i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
			                  </button>
			
			                  <!-- Image -->
			                  <a class="text-body" <c:if test="${chg.chg_public == 1 }"> href="#modalMatchPswd${status.index }" data-bs-toggle="modal"</c:if>
			                  					   <c:if test="${chg.chg_public == 0 }"> href="/chgDetail?chg_id=${chg.chg_id }"</c:if>
			                  					   >
			                  <c:if test="${chg.thumb != null}">
			             		<c:if test="${chg.thumb == 'assets/img/chgDfaultImg.png'}">
			                  		<img class="card-img-top" src="assets/img/chgDfaultImg2.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 25px;">
			                  	</c:if>
			                  	<c:if test="${chg.thumb != 'assets/img/chgDfaultImg.png'}">
			                  		<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 25px;" >
			                  	</c:if>
			                  </c:if>
			                  <c:if test="${chg.thumb == null}">
			                  	<img class="card-img-top" src="assets/img/chgDfaultImg2.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 25px;">
			                  	
			                  </c:if>
								
							  </a>
			              </div>
			              
			              <!-- Body -->
			              <div class="card-body fw-bold text-start px-0 py-2">
			                <div class="mb-1">
				                <a class="text-body fw-bolder fs-6" 	
				                	<c:if test="${chg.chg_public == 1 }"> href="#modalMatchPswd${status.index }" data-bs-toggle="modal"</c:if>
									<c:if test="${chg.chg_public == 0 }"> href="/chgDetail?chg_id=${chg.chg_id }"</c:if>
				                id="title">${chg.title }</a>
			                </div>
			                <div class="text-muted"><i class="bi bi-alarm-fill" style="width:16px"></i>&ensp;<fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
			                  	~ 
			                	<fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
			                </div>
			               
								<div class="text-muted">
									<i class="fa-solid fa-user" style="width:16px"></i>&ensp;${chg.chlgerCnt}명 참여중
								</div>

							<div class="row">
			                	<div class="col-4" style="color: #e56d90;" id="inputPickCnt${chg.chg_id }"><i class="fa-solid fa-heart" style="width:16px"></i>&ensp;${chg.pick_cnt }</div>
								<div class="text-muted col-5 text-start">
									<c:if test="${chg.chg_public == 0 }"><span style="color: #5478e3;"><i class="fa-solid fa-lock-open"></i>&ensp;공개</span></c:if>
									<c:if test="${chg.chg_public == 1 }"><i class="fa-solid fa-lock"></i>&ensp;비공개</c:if>
								</div>			                	
			                </div>
			              </div>
							
			            </div>
			            	
					  </div>
					 
					  
					 <!-- MODAL -->
					 <!-- 비공개방  -->
				     <div class="modal fade" id="modalMatchPswd${status.index }" tabindex="-1" role="dialog" aria-hidden="true">
				      <div class="modal-dialog modal-dialog-centered" role="document">
				        <div class="modal-content">
				          <!-- Close -->
				          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				            <i class="fe fe-x" aria-hidden="true"></i>
				          </button>
				    
				          <!-- Header-->
				          <div class="modal-header lh-fixed fs-lg">
				            <strong class="mx-auto">비공개 방</strong>
				          </div>
				    
				          <!-- Body -->
				          <div class="modal-body text-center">
				    
				            <!-- Text -->
				            <p class="mb-7 fs-sm text-gray-500">
				              	비밀번호를 입력해 주세요 
				              	
				            </p>
				    
				
				    			
				    		  <!-- 모달 -->
				              <div class="form-group">
				                
				                <label class="visually-hidden" for="input_priv_pswd${status.index }">
				                  	비밀번호 *
				                </label>
				                
				                <input class="form-control form-control-sm input_priv_pswd" id="input_priv_pswd${status.index }" name="input_priv_pswd" type="password"  placeholder="비밀번호 " required>
				                
				                <c:if test="${chg.chg_public == 1 }">
				                	<input class="form-control form-control-sm" id="chg_priv_pswd${status.index }" name="chg_priv_pswd" type="hidden" value="${chg.priv_pswd }">
				                	<input class="form-control form-control-sm" id="chg_id${status.index }" 	   name="chg_id" 		type="hidden" value="${chg.chg_id }">
				                </c:if>
				              </div>
				                					    			    				     
				              <button class="btn btn-sm btn-dark" id='confirmPswd${status.index }' onclick="return confirmPswd(${status.index })">
				                	확인
				              </button>
				              
 				                
			                	<script type="text/javascript">
			                	    //비공개방 모달창 비밀번호 입력칸에서 엔터키 클릭시 확인 버튼 클릭 
				            		// 검색어 입력 후 엔터키 입력하면 검색버튼 클릭
				            		$("#input_priv_pswd"+${status.index}).keypress(function(e){	
				            			if(e.keyCode && e.keyCode == 13){
				            				$("#confirmPswd"+${status.index }).trigger("click");
				            				return false;
				            			}
				            		});
				            		// 모달창 끌때 input값 비우기
				            		$('.modal').on('hidden.bs.modal', function(e) {
				             			$('#input_priv_pswd'+${status.index }).val('');
				            		});
			    			    </script>
				    
				          </div>
				    
				        </div>
				    
				      </div>
				    </div>
				     <c:set var="num" value="${num -1 }"></c:set>
				</c:forEach>
				
				<!-- 페이지네이션  -->
				 <nav class="d-flex justify-content-center justify-content-md-center">
      	   		 <ul class="pagination pagination-sm text-gray-400">
      	   		 <!-- 이전 블럭 이동 -->
				  	<c:if test="${page.startPage > page.pageBlock }">
				  		<li class="page-item">
							<a class="page-link page-link-arrow" href="#" onclick="movePrevBlock()">
							<i class="fa fa-caret-left"></i></a>
						</li>
					</c:if>
					
				    <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }" varStatus="status">
						<li class="page-item">
							<c:if test="${i == page.currentPage }">
								<a class="page-link" onclick="moveCurrentPage()" href="#" id="moveCurrentPage"><b class="text-primary">${i}</b></a>
							</c:if>
							<c:if test="${i != page.currentPage }">
								<a class="page-link" onclick="movePage(${status.index })" href="#" id="movePage${status.index }">${i}</a>
							</c:if>
						</li>
					</c:forEach>
					<!-- 다음 블럭 이동 -->
				    <c:if test="${page.endPage < page.totalPage }">
				    	<li class="page-item">
							<a class="page-link page-link-arrow" href="#" onclick="moveNextBlock()">
							<i class="fa fa-caret-right"></i></a>
						</li>
					</c:if>
				 </ul>
		  		</nav>
		  		
		  		<!-- 게시판 검색 (옵션 제목, 작성자)-->
				<div class="container d-flex justify-content-center my-5">
				    <div class="d-flex justify-content-center">
				        <div class="input-group input-group-merge">
				            <input class="form-control form-control-sm" id="keyword" type="search" placeholder="제목/내용 검색" value="${chg.keyword}">
							<div class="input-group-append">
								<!-- 부트스트랩에서 button or div 내 이미지 수평+수직정렬 -->					
							    <button class="btn btn-outline-border btn-search d-flex justify-content-center align-items-center"  id="searchButton">
							        <i class="fe fe-search"></i>
							    </button>
							</div>
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