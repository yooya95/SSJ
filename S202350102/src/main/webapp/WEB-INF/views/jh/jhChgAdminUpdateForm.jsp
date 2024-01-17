<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 수정 관리자</title>
<script type="text/javascript">
	// 페이지 로딩 시 실행되는 함수
    $(document).ready(function () {
        // 비공개 라디오 버튼이 변경될 때의 이벤트 처리
        $('input[name="chg_public"]').change(function () {
            if ($('#private').prop('checked')) {
                // 비공개가 선택되었을 때만 비밀번호 입력란 활성화
                $('#priv_pswd').prop('disabled', false);
                $('#priv_pswd').prop('required', true);
            } else {
                // 그 외의 경우에는 비밀번호 입력란 비활성화
                $('#priv_pswd').prop('disabled', true);
            }
        });
    });
	
	
	//DOMContentLoaded : HTML 문서가 완전히 로드되고 파싱되었을 때 발생하는 이벤트
	//					 문서의 모든 요소와 스타일, 스크립트 등이 브라우저에 의해 읽혀지고 해석된 상태
	//아래 함수는  페이지가 완전히 로드되어 브라우저에 표시되는 시점에 , 이미지, 스타일시트, 외부 스크립트 등의 추가 리소스 로딩이 완료되지 않아 DOM 구조를 조작하거나 스크립트를 실행하는 데 사용
	//인증빈도 기존에 입력된 값으로 셀렉트하기 위한 함수
    document.addEventListener("DOMContentLoaded", function() {
        var chgFreqValue = "${chg.freq}"; // ${chg.freq}의 값

        var freqSelect = document.getElementById("freq");

        for (var i = 0; i < freqSelect.options.length; i++) {
            if (freqSelect.options[i].value === chgFreqValue) {
                freqSelect.selectedIndex = i;
                break;
            }
        }
    });
    
    

	
	
	/* 인증 예시 이미지 수정버튼 클릭시 발동*/
	function sampleImgUpdate(){
		
		/* 수정 버튼 숨김 */
		$("#sampImgUpBtn").hide();
		
		/* 파일업로드 버튼 안보이게 되어있으면 보여주고 보이면 숨기기 */
		if($("#sample_img").css("display") == "none"){
			$("#sample_img").show();
		} else {
			$("#sample_img").hide();
			
		}
		 
	}
	
	
	/* 썸네일 수정 버튼 클릭시 발동 */
	function thumbUpdate(){
		
		/* 수정 버튼 숨기기 */
		$("#thumbUpdateBtn").hide();
		
		/* 파일업로드버튼 보이면 숨기고 안보이면 보이기 */
		if($("#thumb").css("display") == "none"){
			$("#thumb").show();
		} else {
			$("#thumb").hide();
		}
	}
	
	/* 썸네일 삭제버튼 클릭시 */
	function Deletethumb(){
		/* 썸네일 이미지 안보이게 숨기고 삭제버튼에 취소 적기 취소버튼 누르면 다시 이미지 보이기 */
		if($("#thumbImg").css("display") != "none"){
			$("#thumbImg").hide();
			$("#delBtn").html("취소");
			$("#delStatus").val(1);
		} else{
			$("#thumbImg").show();
			$("#delBtn").html("삭제");
			$("#delStatus").val(0);
		}
	}
	
	//챌린지 수정 전 확인 알림	
	function chk(){
		return confirm("챌린지를 수정하시겠습니까?");
		 
	}	
</script>
</head>
<body>
<section class="py-11">
 <div class="container section-mt">
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
            	챌린지 수정 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
        <%@ include file="adminSidebar.jsp" %>
        
        <div class="col-10">
        <form action="/chgAdminUpdate" method="post" onsubmit="return chk()" enctype="multipart/form-data">
        	<!-- 챌린지 id -->
        	<input type="hidden" name="chg_id" value="${chg.chg_id}">
        	<!-- 챌린지 진행상태 -->
        	<input type="hidden" name="state_md" value="${chg.state_md}">
        	<!-- 챌린지 개설자 user_num-->
        	<input type="hidden" name="user_num" value="${chg.user_num}">
		<table class="table table-bordered table-sm mb-0">
			    <tr>
			      <th scope="row" style="width: 350px;" >챌린지명</th>
			      <td style="width: 350px;">
			      	<input type="text" maxlength="20" class="form-control form-control-sm" id="title" name="title" value="${chg.title }" required>
			      </td>
			      <th rowspan="3" style="width: 200px;">썸네일</th>
				  <td rowspan="3" style="text-align: center; width: 300px;">
				  <c:choose>
				  	<c:when test="${chg.thumb == 'assets/img/chgDfaultImg.png'}"> 
                      	<img alt="챌린지 썸네일" src="${chg.thumb}" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:when>
				  	<c:otherwise>
                      	<img alt="챌린지 썸네일" src="${pageContext.request.contextPath}/upload/${chg.thumb}" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:otherwise> 
				  </c:choose>
	                      	<input type="hidden" name="thumb" value="${chg.thumb}"><p>
	                      	
	                      	<!-- 썸네일 이미지 수정 / 삭제 버튼  -->
		                    <div class="pt-1">
			                    <button  type="button" class="btn btn-xxs btn-info mx-1" id="thumbUpdateBtn" onclick="thumbUpdate()">수정</button>
		    	                <button  type="button" class="btn btn-xxs btn-danger mx-1"  onclick="Deletethumb()" id="delBtn">삭제</button>
		                    </div>
		                    <!-- 썸네일 삭제 유무 -->
		                    <input type="hidden" name="delStatus" value="0" id="delStatus">
		                    <!-- 파일업로드 버튼 -->
							<input type="file" class="form-control" id="thumb" name="thumbFile" style="display: none;">
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 아이디 </th>
			      <td>
			      	${chg.userId } 
		      	  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자  닉네임</th>
			      <td>
			      	${chg.nick }
		      	  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 이름</th>
			      <td>
			      	${chg.userName }
			      </td>
			      <th scope="row">카테고리</th>
			      <td>                    
				      <select class="form-select" style="width: 200px;" id="chg_md" name="chg_md" required>
	                      	<c:forEach var="category" items="${category }" varStatus="status">
	                      		<option  value="${category.md }" ${category.md == chg.chg_md ? 'selected' : ''}>${category.ctn }</option>
	                      	</c:forEach>
	                   </select>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">참가자 수 </th>
			      <td>${chgrParti }</td>
			      <th>참여 정원</th>
				  <td>
				      <input type="number" max="100" min="1" class="form-control form-control-xs" style="width: 200px;" name="chg_capacity" value="${chg.chg_capacity }" required>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 소개</th>
			      <td colspan="3">
			       <textarea class="form-control form-control-zs" rows="5" id="chg_conts" type="text" name="chg_conts" maxlength="200" required >${chg.chg_conts }</textarea>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">인증방법</th>
			      <td colspan="3"><input type="text" class="form-control form-control-xs" name="upload" value="${chg.upload }" maxlength="100" required></td>
			    </tr>
			    
			    <tr>
				    <th scope="row">인증빈도</th>
				    	<td> 
					    	<select class="form-select" id="freq" name="freq" required>
						    <option value="1">1일</option>
						    <option value="2">2일</option>
						    <option value="3">3일</option>
						    <option value="4">4일</option>
						    <option value="5">5일</option>
						    <option value="6">6일</option>
						    <option value="7">매일</option>
				  		</select>
				  		</td>
				      <th rowspan="3">인증 예시</th>
					  <td rowspan="3"  style="text-align: center;">
                      	<img alt="인증 방법" src="${pageContext.request.contextPath}/upload/${chg.sample_img}" style="width: 100%; height: 150px; border-radius: 10px;">
                      	<input type="hidden" value="${chg.sample_img}" name="sample_img">
                      	<div class="pt-2">
	                    	<button type="button" class="btn btn-xxs btn-info mx-1" onclick="sampleImgUpdate()" id="sampImgUpBtn">수정</button>                    
	                    </div>
                    	<input type="file" class="form-control" id="sample_img" name="sampleImgFile" style="display: none;">
					  </td>
				</tr>
			    <tr>
			      <th scope="row">공개여부</th>
			      <td>
                   	<div class="text-center">
	                      <input class="btn-check btn-xs" type="radio" name="chg_public" id="public" value="0" ${chg.chg_public == '0' ? 'checked' : ''} >
	                      <label class="btn btn-xs btn-outline-border" for="public">공개</label>
	                      <input class="btn-check btn-xs" type="radio" name="chg_public" id="private" value="1" ${chg.chg_public == '1' ? 'checked' : ''}>
	                      <label class="btn btn-xs btn-outline-border" for="private">비공개</label>
                      	
                    </div>

			      </td>
			    </tr>
			    <tr>
			      <th scope="row">비밀번호</th>
			      <td><input type="text" pattern="[0-9]{4}" title="4자리 숫자로 입력하세요." class="form-control form-control-xs" name="priv_pswd" value="${chg.priv_pswd != 0 ? chg.priv_pswd : ''}" ${chg.priv_pswd == 0 ? 'disabled' : ''} maxlength="4" id="priv_pswd" ></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 신청일</th>
			      <td colspan="3">${reg_date }</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 개설일</th>
			      <td colspan="3">${create_date }</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 종료일</th>
			      <td colspan="3"><input class="form-control form-control-sm" name="end_date" id="end_date" type="date" required value="${end_date }"></td>
			    </tr>
		</table>
		<div class="d-flex justify-content-end mt-5">
			<button class="btn btn-sm btn-dark mx-1" onclick="currentPageMove()">목록</button>
			<button class="btn btn-sm btn-info mx-1" type="submit" id="chgUpdate"  >수정</button>
			<button class="btn btn-sm btn-dark mx-1" onclick="location.href='/chgDelete?chg_id=${chg.chg_id}&thumb=${chg.thumb}&sample_img=${chg.sample_img }" id="chgDelete" >삭제</button>
		</div>	
        </form>
		</div>
      </div>
      </div>
      </section>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>