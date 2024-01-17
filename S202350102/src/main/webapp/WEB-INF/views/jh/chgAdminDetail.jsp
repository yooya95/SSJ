<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 상세 조회 관리자</title>
<style>
	/* 왜 적용 안됨? */
	th {
	    background-color: #FFB4B4;
	  }
</style>
<script type="text/javascript">
	/* 현재 페이지 클릭시 수정 해야함 */
/* 	function currentPageMove(){
	 	var state_md = ${state_md}
	    var chg_lg = ${chg_lg}
	    var chg_md = ${chg_md}
	    var sortOpt = $('#sortOpt').val()
	    var currentPage = ${page.currentPage}
	    
		location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&sortOpt="+sortOpt+"&currentPage="+currentPage;
			
	} */
	
/* 	$(document).ready(function() {
		var result = ${result}
		
		if(result > 0){
			alert("result ->" + result);
		}
			alert("result ->" + result);
		
	}); */
	
	function approvReturnFn(pApprovReturn){
		var approvReturn	= pApprovReturn
		var chg_id			= ${chg.chg_id}
		var state_md		= ${chg.state_md}
		var user_num		= ${chg.user_num}
		
		if(approvReturn == 1){
			var confirmResult = confirm("챌린지를 승인하시겠습니까?");
			
			if(confirmResult){
				location.href = "approvReturn?chg_id="+chg_id+"&user_num="+user_num+"&approvReturn="+approvReturn;
			} 
		} else{
			
			$('#returnModal').modal('show')
		}
	}
	
	//모달에서 챌린지 반려 버튼 클릭시 확인 함수
	function chk(){
/* 		alert("pApprovReturn 반려 -> " + pApprovReturn);
		var approvReturn	= pApprovReturn
		var return_md		= $('#return_md').val();
		alert('return_md --> ' + return_md)
		var chg_id			= ${chg.chg_id}
		var state_md		= ${chg.state_md} */
		
		var confirmResult = confirm("챌린지를 반려 하시겠습니까?");
		
		if(confirmResult){
			//location.href = "approvReturn?chg_id="+chg_id+"&state_md="+state_md+"&return_md="+return_md+"&approvReturn="+approvReturn;
			//확인 버튼 클릭시 반려 진행
			return true;
		} else {
	        // 취소 버튼을 눌렀을 때 아무 동작도 하지 않고 모달을 열어둠
	        return false;
	    }
		
	} 
	
	//챌린지 삭제시
	function chgDeleteFn(){
		var chg_id 		= ${chg.chg_id}
		var state_md	= ${chg.state_md }
		var thumb		= '${chg.thumb}'
		var sample_img	= '${chg.sample_img }'
		var confirmResult = confirm("챌린지를 삭제 하시겠습니까?");
		if(confirmResult){
			location.href='/chgDelete?chg_id='+chg_id+'&state_md='+state_md+'&thumb='+thumb+'&sample_img='+sample_img;    
		}
	}
	
	//목록 버튼 클릭시
	function chgAdminList(){
	    var pageNum  =  ${currentPage}
		var state_md =  ${state_md}
	    var chg_md 	 =  ${chg.chg_md}
	    var sortOpt  = '${sortOpt}'
	    var chg_lg 	 =  ${chgLg}
    	var keyword 	=	"${chg.keyword}" // 검색 키워드
			    
   	    //검색어 있는 경우
       	if(keyword !== null && keyword !== ""){
       		//alert("검색 함")
		    //진행/종료 챌린지인 경우(필터 있을 때)
	   	    if(sortOpt !== null){
		   			//alert("필터 없음")
			    //카테고리 선택한 경우
		   		if(chg_lg != 0){
		   			//alert("필터 없음")
					location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&sortOpt="+sortOpt+"&currentPage="+pageNum+"&keyword="+keyword;
		   		//카테고리 선택 안한 경우	
		   		}else{
		   			alert("필터 없음")
					location.href = "chgAdminList?state_md="+state_md+"&sortOpt="+sortOpt+"&currentPage="+pageNum+"&keyword="+keyword;
		   			
		   		}
			//신청/반려 챌린지인 경우
		   	}else{
		   		if(chg_lg != 0 ){
		   			//alert("필터 없음")
					location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&currentPage="+pageNum+"&keyword="+keyword;
		   		//카테고리 선택 안한 경우	
		   		}else{
		   			//alert("필터 없음")
					location.href = "chgAdminList?state_md="+state_md+"&currentPage="+pageNum+"&keyword="+keyword;
		   			
		   		}
		   		
		   	}
       	} else{
		    //진행/종료 챌린지인 경우(필터 있을 때)
	   	    if(sortOpt !== null && sortOpt !== 'null'){
		   			//alert("검색없음")
			    //카테고리 선택한 경우
		   		if(chg_lg != 0){
		   			//alert("필터있고 카테고리 있음")
					location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&sortOpt="+sortOpt+"&currentPage="+pageNum;
		   		//카테고리 선택 안한 경우	
		   		}else{
		   			//alert("필터있고 카테고리 없음 " + sortOpt)
					location.href = "chgAdminList?state_md="+state_md+"&sortOpt="+sortOpt+"&currentPage="+pageNum;
		   			
		   		}
			//신청/반려 챌린지인 경우
		   	}else{
		   		if(chg_lg != 0 ){
		   			//alert("필터 없음 카테고리 유")
					location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&currentPage="+pageNum;
		   		//카테고리 선택 안한 경우	
		   		}else{
		   			//alert("필터 없음 카테고리 무")
					location.href = "chgAdminList?state_md="+state_md+"&currentPage="+pageNum;
		   			
		   		}
		   		
		   	}
       		
       	}
		
	}
	
	//댓글 관리
	function chgReviewAdminFn(){
		var chg_id = ${chg.chg_id}
		var title  = '${chg.title }'	
		location.href = "chgReviewAdmin?chg_id="+chg_id+"&title="+title;
		
	}

	
</script>
</head>
<body>
<!-- MODALS -->
    <!-- Newsletter: Horizontal -->
    <div class="modal fade" id="returnModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
    
          <!-- Close -->
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            <i class="fe fe-x" aria-hidden="true"></i>
          </button>
    
          <!-- Content -->
          <div class="row gx-0">
            <div class="col-12 col-lg-12 d-flex flex-column px-md-8">
    
              <!-- Body -->
              <div class="modal-body my-auto py-10">
    
                <!-- Heading -->
                <h4>챌린지 신청 반려</h4>
    
                <!-- Text -->
                <p class="mb-7 fs-lg">
                  	반려 사유를 선택해 주세요
                </p>
    
                <!-- Form -->
                <form action="/approvReturn" method="post" onsubmit="return chk()">
                  <div class="row gx-5">
                    <div class="col">
                    
    				<input type="hidden" name="approvReturn" value="0">
    				<input type="hidden" name="chg_id" value="${chg.chg_id}">
                      <!-- Input -->
                      <select class="form-select" id="return_md" name="return_md" required="required">
                      	<c:forEach var="rtnReason" items="${returnReason }" varStatus="status">
                      		<option value="${rtnReason.md }">${rtnReason.ctn }</option>
                      	</c:forEach>
                      </select>
    
                    </div>
                    <div class="col-auto">
    
                      <!-- Button -->
                      <button class="btn btn-sm btn-dark" type="submit" >
                        <i class="fe fe-send"></i>
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
<section class="py-11">
 <div class="container">
        <div class="row">
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="pt-10 pb-5">
            
            	<h3 class="mb-10">
            	<c:choose>
            		<c:when test="${state_md ==102 }">
		            	진행중 
            		</c:when>
            		<c:when test="${state_md ==103 }">
            			종료
            		</c:when>
            		<c:when test="${state_md ==104 }">
            			반려
            		</c:when>
            		<c:otherwise>
            			신청
            		</c:otherwise>
            	</c:choose>
            	챌린지 관리</h3>
            </div>

          </div>
        </div>
        
        <!--사이드바   관리자인 경우 adminSidebar, 사용자인 경우 mypageMenu  -->
		<div class="row">
	        <c:choose>
				<c:when test="${user1.status_md == 102 }">
	        		<%@ include file="adminSidebar.jsp" %>
			        <div class="col-10">
	        	</c:when>
	        	<c:otherwise>
					<div class="col-md-3">
	        			<%@ include file="/WEB-INF/views/mypageMenu.jsp" %>
	    		  	</div>
			        <div class="col-9">
	        	</c:otherwise>
	        </c:choose>
        		
        
        
		<table class="table table-bordered table-sm mb-0">
			    <tr>
			      <th scope="row" >챌린지명</th>
			      <td>${chg.title }</td>
			      <th rowspan="3">썸네일</th>
				  <td rowspan="3">
 				  <c:choose>
				  	<c:when test="${chg.thumb == 'assets/img/chgDfaultImg.png' }"> 
                      	<img alt="챌린지 썸네일" src="${chg.thumb}" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:when>
				  	<c:when test="${chg.thumb == null }"> 
                      	<img alt="챌린지 썸네일" src="assets/img/chgDfaultImg.png" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:when>
				  	<c:otherwise>
                      	<img alt="챌린지 썸네일" src="${pageContext.request.contextPath}/upload/${chg.thumb}" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:otherwise> 
				  </c:choose>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 아이디  /<br> 개설자 닉네임</th>
			      <td>${chg.userId} / ${chg.nick }</td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 이름</th>
			      <td>${chg.userName }</td>
			    </tr>
			    <tr>
			      <th scope="row">카테고리</th>
			      <td>${chg.ctn }</td>
			      <th>진행상태</th>
			      <td>${chg.stateCtn }</td>
			    </tr>
			    <tr>
			    	<c:if test='${chg.state_md == 104 }'>
				      <th scope="row">반려사유</th>
				      <td colspan="3">${chg.returnReason }</td>
			    	</c:if>
			    </tr>
			    <tr>
			      <th scope="row">참가자수    /  참여정원</th>
			      <td> ${chgrParti }  / ${chg.chg_capacity }</td>
			      <th>찜수</th>
				  <td>${chg.pick_cnt }</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 소개</th>
			      <td colspan="3">${chg.chg_conts }</td>
			    </tr>
			    <tr>
			      <th scope="row">인증방법</th>
			      <td colspan="3">${chg.upload }</td>
			    </tr>
			    
			    <tr>
				    <th scope="row">인증빈도</th>
				      <td>${chg.freq }</td>
				      <th rowspan="3">인증 예시</th>
					  <td rowspan="3">
		                  	<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.sample_img }" alt="userImg" style="width: 100%; height: 150px; border-radius: 10px;" >
					  </td>
				</tr>
			    <tr>
			      <th scope="row">공개여부</th>
			      <td>
					<c:choose>
						<c:when test="${chg.chg_public == 1 }">비공개</c:when>
						<c:otherwise>공개</c:otherwise>
					</c:choose>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">비밀번호</th>
			      <td>${chg.priv_pswd}</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 신청일</th>
			      <td colspan="3"><fmt:formatDate value="${chg.reg_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    </tr>
			    <tr>
			    <c:choose>
			    	<c:when test="${chg.state_md == 104 }">
				      <th scope="row">챌린지 반려일</th>
				      <!-- return_date로 바꾸기 -->
				      <td colspan="3"><fmt:formatDate value="${chg.return_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    	</c:when>
			    	<c:otherwise>
				      <th scope="row">챌린지 개설일</th>
				      <td colspan="3"><fmt:formatDate value="${chg.create_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    	</c:otherwise>
			    </c:choose>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 종료일</th>
			      <td colspan="3"><fmt:formatDate value="${chg.end_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    </tr>
		</table>
		<div class="d-flex justify-content-start mt-5">
				<!-- 챌린지 신청완료 땐 승인/반려 활성화 -->
				<!-- 챌린지 진행중 땐 수정 반려엔 삭제 버튼만 활성화  -->
				<!-- 관리자인 경우  -->
		<c:choose>
			<c:when test="${user1.status_md == 102 }">
				<button class="btn btn-sm btn-dark mx-1" onclick="chgAdminList()">목록</button>
				<c:choose>
					<c:when test="${chg.state_md == 100 }">
						<button class="btn btn-sm btn-info mx-1" onclick="approvReturnFn(1)" id="approval"  >승인</button>
						<button class="btn btn-sm btn-danger mx-1" onclick="approvReturnFn(0)" id="return" >반려</button>
					</c:when>
					<c:when test="${chg.state_md == 102 }">
						<button class="btn btn-sm btn-info mx-1" onclick="location.href='/chgAdminDetail?chg_id=${chg.chg_id}&state_md=${state_md}&chgUpdateMode=1'">수정</button>
					</c:when>
					<c:when test="${chg.state_md == 104}">
						<button class="btn btn-sm btn-danger mx-1" onclick="chgDeleteFn()" id="chgDelete">삭제</button>
					</c:when>
					<c:when test="${chg.state_md == 103}">
						<button class="btn btn-sm btn-outline-dark mx-1" onclick="chgReviewAdminFn()" id="chgReviewAdmin">후기 관리하기</button>
					</c:when>
				</c:choose>
			</c:when>
			
			<c:otherwise>
			    <button class="btn btn-sm btn-dark mx-1" onclick="location.href='/mypage'">목록</button>
			<!-- 사용자인 경우 -->
			    <c:if test="${user1.user_num == chg.user_num && (chg.state_md == 100 || chg.state_md == 104)}">
			        <!-- 수정 버튼 -->
			        <c:if test="${chg.state_md == 100}">
			            <button class="btn btn-sm btn-dark mx-1" onclick="location.href='/myChgUpdate?chg_id=${chg.chg_id}'">수정</button>
			        </c:if>
			
			        <!-- 삭제 버튼 -->
			        <button class="btn btn-sm btn-dark mx-1" onclick="chgDeleteFn()" id="chgDelete">삭제</button>
			    </c:if>
			
			    <c:if test="${chg.state_md == 102 || chg.state_md == 103}">
			        <!-- 챌린지 상세보기 버튼 -->
			        <button class="btn btn-sm btn-dark mx-1" onclick="location.href='/chgDetail?chg_id=${chg.chg_id}'">챌린지 상세보기</button>
			    </c:if>
			</c:otherwise>

		</c:choose>

		</div>	
		</div>
		<div class="py-10"></div>	
      </div>
      </div>
      </section>    
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %> <!-- 이렇게해야 푸터가 꽉차게 들어감 -->
</html>