<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
     function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
        
<body>
<!-- 필수!! -->
 <div class="container section-mt">
         <div class="row profile">
            <div class="col-md-3">
                <%@ include file="../mypageMenu.jsp" %>
            </div>
             <div class="col-md-9 profile-form">
<!-- 필수!! -->
 <!-- CONTENT -->
    
      <div class="container">
        <div class="row">
          <div class="col-12" style="float: none; margin:0 auto;">

            <!-- Card -->
            <div class="card card-lg">
              <div class="card-body">

                <!-- Heading -->
                <h5 class="mb-4">회원정보 수정</h5>

                <!-- Form -->
                <form action="/updateUser1" method="post" name="frm">
                   <div class="row">
                    
                     <!-- 아이디 -->
                    <div class="col-12 col-md-8">
                      <div class="form-group">
                     	<div class="form-floating mb-3">
	                        <input class="form-control form-control-xs" type="text" id="user_id" name="user_id" value="${user1.user_id}" onchange="checkId()" readonly>
	                        <label for="floatingInput">아이디(5~15자 이내)</label>
	                        <font color = "red" id= "failId" 	  style = "display:none" size="2 rem"> 5~15자 이내로 영문자와 숫자를 조합해 입력해주세요.</font>
                        	<font color = "red" id= "failDupId"   style = "display:none" size="2 rem"> 이미 존재하는 ID입니다.</font>
                        </div>
                      </div>
                    </div>
                    
<!--                     <div class="col-12 col-md-4"> -->
<!-- 	                    <button class="btn btn-sm btn-dark" id="user1IdCheck" type="button" onclick="fn_user1IdCheck()" value="N"> -->
<!-- 	                        	중복확인 -->
<!-- 	                    </button> -->
<!--                     </div> -->
                        
                    

                      <!-- 비밀번호 -->
<!--                     <div class="col-10">  -->
<!--                       <div class="form-group"> -->
<!--                         <div class="form-floating mb-3">																									 -->
<!--                         	<input class="form-control form-control-xs" type="password" id="user_pswd" name="user_pswd" placeholder="비밀번호 *" onchange="checkPwd()" required="required"> -->
<!--                         	<label for="floatingInput">비밀번호 8자 이상 영문,숫자,특수기호 조합</label> -->
<!--                         	<font color ="red" id = "failpwd" style = "display:none" size="2 rem">8자 이상 영문,숫자,특수기호를 조합해 입력해주세요 </font> -->
<!--                         </div>	 -->
<!--                       </div> -->
<!--                     </div> -->
                    
                    
                    <!-- 비밀번호 확인 -->
<!--                     <div class="col-10"> -->
<!--                       <div class="form-group"> -->
<!--                       	<div class="form-floating mb-3"> -->
<!-- 	                        <input class="form-control form-control-sm" id="user_confirmPswd" type="password" name="user_confirmPswd" placeholder="비밀번호  확인 *" onchange="checkConfirmPswd()" required="required"> -->
<!-- 	                        <label for="floatingInput">비밀번호 확인</label> -->
<!-- 	                        <font color ="green" id = "matchPwd" 		style = "display:none" size="2 rem">비밀번호가 일치합니다 </font> -->
<!-- 	                        <font color ="red"   id = "notMatchPwd" 	style = "display:none" size="2 rem">비밀번호가 일치하지 않습니다 </font> -->
<!-- 	                        <font color ="red"   id = "failConfirmpwd" 	style = "display:none" size="2 rem">8자 이상 영문,숫자,특수기호를 조합해 입력해주세요 </font> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </div> -->
                    
                    <!-- 닉네임  -->    
                    <div class="col-12 col-md-8">
                      <div class="form-group">
                      	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="nick" name="nick" value="${user1.nick}"  onchange="checkNick()">
                        	<label for="floatingInput">닉네임(2~12자 이내)</label>
                        	 <font color = "red" id= "failNick"		 style = "display:none" size="2 rem"> 2~12자 이내로 영문자와 숫자를 조합해 입력해주세요.</font>
                        	 <font color = "red" id= "failDupNick"   style = "display:none" size="2 rem"> 이미 존재하는 닉네임입니다.</font>
                        </div>
                      </div>
                    </div>
                    
<!--                     <div class="col-12 col-md-6"> -->
<!-- 	                    <button class="btn btn-sm btn-dark" type="button" onclick="nickCheck()" value="N"> -->
<!-- 	                        	중복확인 -->
<!-- 	                    </button> -->
<!--                     </div> -->
                    
                    <!-- 이름 -->
                     <div class="col-12 col-md-6">
                      <div class="form-group">
                     	 <div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="user_name" name="user_name" value="${user1.user_name}" onchange="checkName()" readonly>
                        	<label for="floatingInput">이름(2~6자 이내)</label>
                         </div>
                      </div>
                    </div>
                    
                   
                    <!-- 이메일 -->
					<div class="col-12">
                      <div class="form-group">
                      	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="email" name="email" value="${user1.email}" onchange="checkEmail()">
                        	<label for="floatingInput">이메일 you@xxx.xxx</label>
                        	<font color ="red" id = "failemail" style = "display:none" size="2 rem">you@example.com 형태로 입력해주세요 </font>
                        </div>
                      </div>

                    </div>

                    
                   
                   <!-- 생년월일 년 -->
					<div class="col-5">
					  <div class="form-group">
					    <select class="form-select" id="birth_year" name="birth_year" class="form-control">
					      <option value="">생년월일(년)</option>
					      <c:forEach var="i" begin="1950" end="2023">
					        <option value="${i}" <c:if test="${formattedBirth != null && formattedBirth.substring(0, 4) == i}">selected</c:if>>${i}</option>
					      </c:forEach>
					    </select>
					  </div>
					</div>
					
					<!-- 생년월일 월 -->
					<div class="col-3">
					  <div class="form-group">
					    <select class="form-select" id="birth_month" name="birth_month" class="form-control">
					      <option value="">월</option>
					      <c:forEach var="i" begin="1" end="12">
					        <c:choose>
					          <c:when test="${i lt 10}">
					            <option value="0${i}" <c:if test="${formattedBirth != null && formattedBirth.substring(5, 7) == i}">selected</c:if>>0${i}</option>
					          </c:when>
					          <c:otherwise>
					            <option value="${i}" <c:if test="${formattedBirth != null && formattedBirth.substring(5, 7) == i}">selected</c:if>>${i}</option>
					          </c:otherwise>
					        </c:choose>
					      </c:forEach>
					    </select>
					  </div>
					</div>
					
					<!-- 생년월일 일 -->
					<div class="col-3">
					  <div class="form-group">
					    <select class="form-select" id="birth_date" name="birth_date" class="form-control">
					      <option value="">일</option>
					      <c:forEach var="i" begin="1" end="31">
					        <c:choose>
					          <c:when test="${i lt 10}">
					            <option value="0${i}" <c:if test="${formattedBirth != null && formattedBirth.substring(8, 10) == i}">selected</c:if>>0${i}</option>
					          </c:when>
					          <c:otherwise>
					            <option value="${i}" <c:if test="${formattedBirth != null && formattedBirth.substring(8, 10) == i}">selected</c:if>>${i}</option>
					          </c:otherwise>
					        </c:choose>
					      </c:forEach>
					    </select>
					  </div>
					</div>

                  
                    
                    <!-- 주소  -->
                    <!-- 우편번호  -->
                    <div class="col-6">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="sample6_postcode" name="zipCode" placeholder="우편번호">
                        	<label for="floatingInput">우편번호</label>
                        </div>
                      </div>
                   </div>
                    
                    <!-- 주소 우편번호 찾기(버튼) -->
                    <div class="col-6">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<button class="btn btn-sm btn-dark" type="button" onclick="sample6_execDaumPostcode()"> 우편번호 찾기<br></button>
                        </div>
                      </div>	
                    </div>
                    
                    <!-- 사용자 입력 주소 -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="sample6_address" name="addr" value="${user1.addr}">
                        	<label for="floatingInput">주소</label>
                        </div>
                      </div>
                   </div>
                   
                    <!-- 상세 주소 -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="sample6_detailAddress" name="addr_detail" placeholder="상세주소">
                        	<label for="floatingInput">상세주소</label>
                        </div>
                      </div>
                   </div>
					<!-- 다음 주소API에서 이거 안담으면 실행안되서 hidden으로 받아 놓음  -->
					<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">							        
							             
                    <!-- 휴대폰번호  -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" id="tel" type="tel" name="tel" value="${user1.tel}" onchange="checkTel()">
                        	<label for="floatingInput">휴대폰번호 010-XXXX-XXXX</label>
                        	<font color ="red" id = "failtel" style = "display:none" size="2 rem">010-XXXX-XXXX 형태로 입력해주세요 </font>
                        </div>
                      </div>
                    </div>
                
                    <div class="col-12 text-center" >

                      <!-- Button -->
                      <button class="btn btn-sm btn-dark" type="submit" id="signupbtn" onclick="return checkSignupbtn()">
                        	수정완료
                      </button>
					  <button class="btn btn-sm btn-dark" type="reset"onclick="location.href='/mypage'">
                        	취소
                      </button>
                       <button class="btn btn-sm btn-dark" type="button"onclick="location.href='/deleteUser1Form'">
                        	탈퇴
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
</div>
</div>



</body>
<%@ include file="../footer.jsp" %>
</html>
