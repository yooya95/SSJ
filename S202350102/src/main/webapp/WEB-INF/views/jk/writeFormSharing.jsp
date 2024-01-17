<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
   <section class="pt-7 pb-12">
      <div class="container section-mt">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">게시글 올리기</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle active" href="../sharing">
                  	전체 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/myLikeSharing">
                 	찜한 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/mySharing">
                 	내가 쓴 글
                </a>
               <a class="btn w-100 btn-dark mb-2" href="sharingUserDetail" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 		  </div>
             <!-- Nav End --> 
        
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">

             <!-- Form -->
                    <form id="options" method="post" action="/writeShare" enctype="multipart/form-data">
                       
                            <div class="col-12">
                                <!-- 제목 -->
                                <div class="form-group">
                                <input class="form-control form-control-sm" id="user_num" name="user_num" type="hidden" value="${user1.user_num}" required>
                                
                                    <label class="form-label" for="title">게시글 제목 *</label>
                                    <input class="form-control form-control-sm" id="title" name="title" type="text" value="" required>
                                </div>
                            </div>
                            <!-- 작성자명 및 연락처 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="nick">닉네임 *</label>
                                        <input class="form-control form-control-sm" id="nick" name="nick" type="text" value="${user1.nick}" readonly>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="user_tel">연락처 *</label>
                                        <input class="form-control form-control-sm" id="user_tel" name="user_tel" type="text" value="" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 금액 및 모집 인원 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="price">금액 *</label>
                                        <input class="form-control form-control-sm" id="price" type="number" name="price" value="" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="applicants">모집인원 *</label>
                                        <input class="form-control form-control-sm" id="applicants" name="applicants" type="number" value="" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 계좌번호 및 입금기한 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_info">계좌번호 *</label>
                                        <input class="form-control form-control-sm" id="bank_info" name="bank_info" type="text" value="" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_duedate">입금기한 *</label>
                                        <input class="form-control form-control-sm" id="bank_duedate" name="bank_duedate" type="text" placeholder="예시) 2023-11-22" value="" required>
                                    </div>
                                </div>
                            </div>
                            
                    <!-- 주소  -->
                    <!-- 우편번호  -->
                    <div class="row">
                    <div class="col-6">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="sample6_postcode" name="zipCode" value="" placeholder="우편번호">
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
                    </div>
                    <!-- 사용자 입력 주소 -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="sample6_address" name="addr" placeholder="주소">
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
                                                    
                             <!-- 이미지 업로드 -->
							<div class="form-group mb-7">
							    <label class="form-label" for="file">이미지 *</label>
							    <input class="form-control form-control-sm me-3" id="file" name="file" type="file" required>
							    <img id="imgPreview" style="max-width: 200px; margin-top: 10px;" />
							</div>

 							<!-- 상세내용 -->
					<div class="form-group mb-7">
					    <label class="form-label" for="conts">상세내용 *</label>
					    <div class="d-flex align-items-start" style="margin-top: 10px;">
					        <textarea class="form-control form-control-sm" id="conts" name="conts" rows="8" required></textarea>
					    </div>
					</div>
					<div class="row">
						<!-- Button (input 요소로 submit) ya 추가 -->
						<div class="col-lg-6 mb-2">
						    <button type="submit" class="btn btn-outline-dark w-100">
						        작성완료
						    </button>
						 </div>
					
					 <div class="col-lg-6 mb-2">
						  <a href="sharing" class="btn btn-outline-dark w-100">작성취소</a> 
					 </div>
				 </div>               
				 </form>
                </div>
            </div>
        </div>
    </section>
  

  
  
   
  
  
  
   <!-- JAVASCRIPT -->
	<!--     {{> partials/scripts}} -->
	<!--	카카오 주소 API  -->
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
</body>
<%@ include file="../footer.jsp" %>
</html>
