<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
<link rel="stylesheet" href="css/level.css">
<title>Insert title here</title>
</head>
<script>
$(document).ready(function () {
    // mypageMenu 엔드포인트로 AJAX 요청
    $.ajax({
       type: 'GET',
       url: '/mypageMenu',
       success: function (data) {
          // 응답을 처리 (필요한 경우)
          console.log(data);
          
          var jsonData = JSON.parse(data);
          var user1 = jsonData.user1;
          var level1List = jsonData.level1List;
          var followCnt = jsonData.followCnt;
          var followerCount = followCnt.FOLLOWER_CNT;
          var followingCount = followCnt.FOLLOWING_CNT;
          var myBoard_cnt = jsonData.myBoard; 
          
          console.log("Follower Count: " + followerCount);
          console.log("Following Count: " + followingCount);
          
          $('.profile-usertitle-name').text(user1.nick + ' 님');
          $('.follow').text(followCnt.FOLLOWER_CNT);
          $('.following').text(followCnt.FOLLOWING_CNT);
          $('.myBoardCnt').text(myBoard_cnt);
          
       },
       error: function (error) {
          // 오류 처리
          console.error(error);
       }
    });
 });
     $(document).ready(function () {
         $('#editImageModalBtn').click(function () {
             $('#editImageModal').modal('show');
         });

         $('#saveBtn').click(function () {
             // 이미지 업로드 폼을 제출하여 프로필 이미지를 업데이트
             var formData = new FormData($('#imageUploadForm')[0]);
             $.ajax({
                 type: 'POST',
                 url: '/updateProfile',
                 data: formData,
                 contentType: false,
                 processData: false,
                 success: function (result) {
                     // 서버로부터의 응답을 처리 (예: 성공 메시지 또는 오류 메시지)
                     console.log(result);
                      $('#editImageModal').modal('hide');
                 },
                 error: function (error) {
                     // 오류 처리
                     console.error(error);
                 }
             });
         });
     });
     
     function previewImage(input) {
         var file = input.files[0];
         if (file) {
             var reader = new FileReader();
             reader.onload = function (e) {
                 document.getElementById('imagePreview').src = e.target.result;
                 document.getElementById('imagePreview').style.display = 'block';
             };
             reader.readAsDataURL(file);
         }
     }
     
     function confirmGoSub() {
    	 if(confirm('구독 회원이 아닙니다 \n구독하기 페이지로 이동하시겠습니까?')){
    		 location.href = 'thkakaoPayForm'
    	 } else {
    		 
    	 }
    	 
     }
 </script>
<style>


.pCard_card {

  width: 255px;
  height: 425px;
 background-color: #f6fcfe;
  box-shadow: 0px 5px 40px 0px rgba(0, 0, 0, 0.21);
  position: relative;
  overflow: hidden;
}

/****************
UP
****************/

.pCard_card .pCard_up {
  position: absolute;
  width: 100%;
  height: 290px;
  background-image: url('${pageContext.request.contextPath}/upload/${user1.img}');
  background-position: 50%;
  background-size: cover;
  z-index: 3;
  text-align: center;
  border-top-left-radius: 30px;  /* 둥근 테두리 설정 */
  border-top-right-radius: 30px;  /* 둥근 테두리 설정 */
  -webkit-transition: 0.5s ease-in-out;
  -moz-transition: 0.5s ease-in-out;
  -ms-transition: 0.5s ease-in-out;
  -o-transition: 0.5s ease-in-out;
  transition: 0.5s ease-in-out;
}

.pCard_on .pCard_up {
  height: 100px;
  box-shadow: 0 0 30px #cfd8dc;
}

.pCard_card .pCard_up .pCard_text {
  position: absolute;
  top: 230px;
  left: 0;
  right: 0;
  color: #f1f7f9;
  -webkit-transition: 0.5s ease-in-out;
  -moz-transition: 0.5s ease-in-out;
  -ms-transition: 0.5s ease-in-out;
  -o-transition: 0.5s ease-in-out;
  transition: 0.5s ease-in-out;
}

.pCard_on .pCard_up .pCard_text {
  top: 20px;
}

.pCard_card .pCard_up .pCard_text h2 {
  margin: 0;
  font-size: 25px;
  font-weight: 600;
}

.pCard_card .pCard_up .pCard_text p {
  margin: 0;
  font-size: 16px;
  color: #e3f1f5;
}

.pCard_card .pCard_up .pCard_add {
  position: absolute;
  top: 275px;
  left: 0;
  right: 0;
  margin: auto;
  width: 35px;
  height: 32px;
  cursor: pointer;
 
}

.pCard_on .pCard_up .pCard_add {
  -webkit-transform: rotate(360deg) scale(0.5);
  -moz-transform: rotate(360deg) scale(0.5);
  -ms-transform: rotate(360deg) scale(0.5);
  -o-transform: rotate(360deg) scale(0.5);
  transform: rotate(360deg) scale(0.5);
  top: 470px;
}

/****************
Down
****************/

.pCard_card .pCard_down {
  background-color: #fff;
  position: absolute;
  bottom: 0px;
  width: 100%;
  height: 80px;
  z-index: 2;
  border-bottom-left-radius: 30px;
  border-bottom-right-radius: 30px;

  transition: 0.5s ease-in-out;
}

.pCard_on .pCard_down {
  height: 100px;
  -webkit-box-shadow: 0 0 30px #cfd8dc;
  -moz-box-shadow: 0 0 30px #cfd8dc;
  -ms-box-shadow: 0 0 30px #cfd8dc;
  -o-box-shadow: 0 0 30px #cfd8dc;
  box-shadow: 0 0 30px #cfd8dc;
}

.pCard_card .pCard_down div {
  width: 33.333%;
  float: left;
  text-align: center;
  font-size: 18px;
  -webkit-transition: 0.5s ease-in-out;
  -moz-transition: 0.5s ease-in-out;
  -ms-transition: 0.5s ease-in-out;
  -o-transition: 0.5s ease-in-out;
  transition: 0.5s ease-in-out;
}

.pCard_on .pCard_down div {
  margin-top: 10px;
}

.pCard_card .pCard_down div p:first-of-type {
  color: #68818c;
  margin-bottom: 5px;
}

.pCard_card .pCard_down div p:last-of-type {
  color: #334750;
  font-weight: 700;
  margin-top: 0;
}
.pCard_card .pCard_back a i {
  margin: 10px;
  padding: 15px;
  -webkit-border-radius: 15px;
  -moz-border-radius: 15px;
  -ms-border-radius: 15px;
  -o-border-radius: 15px;
  border-radius: 15px;
  -webkit-transition: 0.3s ease-in-out;
  -moz-transition: 0.3s ease-in-out;
  -ms-transition: 0.3s ease-in-out;
  -o-transition: 0.3s ease-in-out;
  transition: 0.3s ease-in-out;
}

.pCard_card .pCard_back a i:hover {
  -webkit-transform: scale(1.2);
  -moz-transform: scale(1.2);
  -ms-transform: scale(1.2);
  -o-transform: scale(1.2);
  transform: scale(1.2);
}

.pCard_card .pCard_back a:nth-of-type(1) i {
  color: #3b5998;
  border: 2px solid #3b5998;
}

.pCard_card .pCard_back a:nth-of-type(2) i {
  color: #0077b5;
  border: 2px solid #0077b5;
}

.pCard_card .pCard_back a:nth-of-type(3) i {
  color: #1769ff;
  border: 2px solid #1769ff;
}

.pCard_card .pCard_back a:nth-of-type(4) i {
  color: #000000;
  border: 2px solid #000000;
}

.pCard_card .pCard_back a:nth-of-type(5) i {
  color: #eb5e95;
  border: 2px solid #eb5e95;
}

.pCard_card .pCard_back a:nth-of-type(6) i {
  color: #3f729b;
  border: 2px solid #3f729b;
}

.pCard_card .pCard_up .pCard_add i {
  color: white;
  font-size: 38px;
  line-height: 88px;
}

</style>
<body>
  <div class="pCard_card">
   <div class="pCard_up">
      <div class="pCard_text">
         <label>${user1.nick }님</label>
      </div>
      <div class="pCard_add"><i class="fa-solid fa-circle-plus fa-beat fa-2xl" style="color: #e56d90; "></i></div>
      
   </div>
   <div class="pCard_down">
       <div class="text-center">
      <p class="fs-sm">Follow</p>
	 <div class="follow mx-auto"></div>
      </div>
      <div>
       <p class="fs-sm">Following</p>
          <div class="following"></div>
      </div>
      <div>
       <p class="fs-sm">Likes</p>
        <div class="myBoardCnt"></div>
      </div>
   </div>

</div>
<div class="profile-card" >
  <div class="top-section" style="position: relative;">
    
<button type="button" class="btn btn-secondary btn-xxs fs-xxs" id="editImageModalBtn" style="position: absolute; bottom: 0; right: 0;">
        <i class="fa-regular fa-pen-to-square"></i>
    </button>
</div>

			<div class="profile-sidebar">
			
				<!-- SIDEBAR USER TITLE -->
    
				<div class="profile-usertitle">
				<!--  닉네임   -->
					<div class="profile-usertitle-name">
					</div>
					       	<button id="modalOpenBtn">경험치 정보</button>
		<div id="modal">
			<div class="hidden" id="modalContainer">
				<div id="modalContent">
					<button id="modalCloseBtn">X</button>
					<div class="user_info">
						<div class="userInfoBox1">
							<img id="user_icon" alt="user_icon" src="images/level/${user1.user_level }.gif">
							<span id="user_level">
								<label>${user1.nick }님</label>
								<label>현재 레벨 : ${user1.user_level }</label> 
							</span>
						</div>

						<div class="progress" style="height: 50px">
							<div class="progress-bar" role="progressbar" style="width: ${user1.percentage}%;">${user1.percentage}%</div>
						</div>
						<div class="userInfoBox2">
							<span class="user_exp">
								<label>현재 경험치 ${user1.user_exp }</label>
							</span>
							<span class="remain_exp">
								<label>남은 경험치 ${user1.remain_exp }</label>
							</span>
						</div>

					</div>
					<button id="levelInfoBtn">레벨표 보기</button>
					<div class="hidden" id="level_info_container">
						<table border="1" style="width:500px;">
							<thead>
								<tr>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">레벨</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">아이콘</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">경험치</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">설명</span></span></td>
								</tr>
							</thead>	
							<c:forEach var="level" items="${level1List }">
								<tbody>
									<tr>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.user_level }</span></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><img alt="${level.user_level }" src="/images/level/${level.lv_name }.gif"></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.tot_exp }.Exp</span></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.lv_name }레벨</span></span></td>
									</tr>
								</tbody>
							</c:forEach>
						</table>			
					</div>
				</div>
			</div>
		</div>
					

					<div class="row list-separated profile-stat">
                   <div class="col-md-4 col-sm-4 col-xs-6">
                       <div class="uppercase profile-stat-title">
                       <div class="follow"></div></div>
                       <div class="uppercase profile-stat-text"> 팔로우 </div>
                   </div>
                   <div class="col-md-4 col-sm-4 col-xs-6">
                       <div class="uppercase profile-stat-title">
                       <div class="following"></div></div>
                       <div class="uppercase profile-stat-text"> 팔로잉 </div>
                   </div>
                   <div class="col-md-4 col-sm-4 col-xs-6">
                       <div class="uppercase profile-stat-title"> 
                       <div class="myBoardCnt"></div> </div>
                       <div class="uppercase profile-stat-text"> 내가 쓴 글</div>
                   </div>
                   
               </div>
					
				</div>
				</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
           <div class="portlet light bordered">
         
                 
               <div class="col-12 col-md-16">
                   <!-- Nav -->
                   <nav class="mb-10 mb-md-0" >
                       <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                           <a class="list-group-item list-group-item-action dropend-toggle " href="/mypage">
                               활동정보
                           </a>
                           <a class="list-group-item list-group-item-action dropend-toggle " href="/challengeManagement">
                               챌린지 관리
                           </a>
                           <a class="list-group-item list-group-item-action dropend-toggle " href="/followList">
                               팔로우 관리
                           </a>
                           	
                           <!-- 일반 회원일때 구독하기 페이지로 이동  -->
                           <c:if test="${user1.status_md == 100 }">
	                           <a class="list-group-item list-group-item-action dropend-toggle " href="#" onclick="confirmGoSub()">구독 관리</a>
                           </c:if>
                           <!-- 구독자일때 구독관리 창 보임  -->
                           <c:if test="${user1.status_md == 101 }">
	                           <a class="list-group-item list-group-item-action dropend-toggle " href="/thSubscriptManagement">구독 관리</a>
                           </c:if>
                           <!-- 관리자일때 안보임  -->
                           <c:if test="${user1.status_md == 102 }">
								
                           </c:if>
                           <!-- 블랙리스트일때 안보임  -->
                            <c:if test="${user1.status_md == 103 }">
								
                           </c:if>
                           
                           <a class="list-group-item list-group-item-action dropend-toggle " href="/sharingManagement">
                               쉐어링 관리
                           </a>
                           <a class="btn w-100 btn-dark mb-2" href="/userDetail" style=" margin-top: 50px;">
                               회원정보수정
                           </a>
                       </div>
                   </nav>
                   <!-- Nav End -->
               </div>
               <!-- END STAT -->
           </div>
     

<!-------------------------------- 모달창 자바스크립트 ------------------------------------------------------------------------>
<!-- 모달 창 -->
<div class="modal fade" id="editImageModal" tabindex="-1" role="dialog" aria-labelledby="editImageModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editImageModalLabel">프로필 편집</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
		<div style="display: flex; justify-content: center; align-items: center;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${user1.img}" alt="..." style="width: 50%; height: 50%;">
		</div>

            <div class="modal-body">
               <!-- 이미지 업로드 폼 -->
                <form id="imageUploadForm" action="/updateProfile" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="file1">프로필 이미지 선택:</label>
                        <input type="file" class="form-control-file" id="file1" name="file1" onchange="previewImage(this);">
					<div style="display: flex; justify-content: center; align-items: center;">
                        <img id="imagePreview" src="#" alt="미리보기 이미지" style="display: none; max-width: 100%; max-height: 200px; margin-top: 10px;">
                    </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-dark btn-sm" data-bs-dismiss="modal">닫기</button>

                <button type="button" class="btn btn-dark btn-sm" id="saveBtn">완료</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
const modalOpenBtn = document.getElementById('modalOpenBtn');
const modalCloseBtn = document.getElementById('modalCloseBtn');
const modal = document.getElementById('modalContainer');
const levelInfoContainer = document.getElementById('level_info_container');

modalOpenBtn.addEventListener('click', () => {
    modal.classList.remove('hidden');
});

modalCloseBtn.addEventListener('click', () => {
    modal.classList.add('hidden');
    levelInfoContainer.classList.add('hidden'); // 모달이 닫힐 때 level_info도 숨김
});

const levelInfoBtn = document.getElementById('levelInfoBtn');

levelInfoBtn.addEventListener('click', () => {
    levelInfoContainer.classList.toggle('hidden'); // 보이기/숨기기 전환
});

</script>
</body>
</html>