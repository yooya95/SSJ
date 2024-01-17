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

.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 0px 0 10px 0;
  background: #fff;
}

.profile-userpic {
  text-align: center;
}

.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 100px;
  height: 100px;
  -webkit-border-radius: 50% !important;
  -moz-border-radius: 50% !important;
  border-radius: 50% !important;
}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}

/* Profile Content */
.profile-content {
  padding: 20px;
  background: #fff;
  min-height: 460px;
}

a, button, code, div, img, input, label, li, p, pre, select, span, svg, table, td, textarea, th, ul {
    -webkit-border-radius: 0!important;
    -moz-border-radius: 0!important;
    border-radius: 0!important;
}

.dashboard-stat, .portlet {
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    -ms-border-radius: 4px;
    -o-border-radius: 4px;
}

.portlet {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 0;
    border-radius: 4px;
}

.portlet.bordered {
    border-left: 2px solid #e6e9ec!important;
}

.portlet.light {
    padding: 12px 20px 15px;
    background-color: #fff;
}

.portlet.light.bordered {
    border: 1px solid #e7ecf1!important;
}

.list-separated {
    margin-top: 10px;
    margin-bottom: 15px;
}

.profile-stat {
    padding-bottom: 0px;
   }

.profile-stat-title {
    color: #7f90a4;
    font-size: 25px;
    text-align: center;
}

.uppercase {
    text-transform: uppercase!important;
}

.profile-stat-text {
    color: #5b9bd1;
    font-size: 10px;
    font-weight: 600;
    text-align: center;
}

.profile-desc-title {
    color: #7f90a4;
    font-size: 17px;
    font-weight: 600;
}

.profile-desc-text {
    color: #7e8c9e;
    font-size: 14px;
}

.margin-top-20 {
    margin-top: 20px!important;
}

[class*=" fa-"]:not(.fa-stack), [class*=" glyphicon-"], [class*=" icon-"], [class^=fa-]:not(.fa-stack), [class^=glyphicon-], [class^=icon-] {
    display: inline-block;
    line-height: 14px;
    -webkit-font-smoothing: antialiased;
}

.profile-desc-link i {
    width: 22px;
    font-size: 19px;
    color: #abb6c4;
    margin-right: 5px;
}
/* 여기부터 */

.profile-card {
  width: 240px;
  overflow: hidden;
  text-align: center;
  position: relative;
  box-shadow: 0 0  4px #111;
}
.top-section {
  padding: 15px ;
  background: #FFBDC2;
}
.message,
.notif {
  position: absolute;
  top: 40px;
  font-size: 20px;
  cursor: pointer;
  color: #ffffff50
}
.message {
  right: 40px;
}
.notif {
  left: 40px;
}
.message:hover,
.notif:hover {
  color: #f1f1f1;
}
.pic {
  width: 120px;
  height:120px;
  margin: auto;
  border: 6px solid #F5EFF1;
  border-radius: 50%;
  position: relative;
}
.pic:after {
  content: '';
  width: 100%;
  height: 100%;
  position: absolute;
  border: 1px solid #fff;
  left: 0;
  top: 0;
  border-radius: 50%;
  box-sizing: border-box;
  animation: wave 1.5s infinite linear;
}
@keyframes wave{
  to {
    transform: scale(1.3);
    opacity: 0;
  }
}
.pic img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
}
.name {
  color: #f1f1f1;
  font-size: 28px;
  letter-spacing: 2px;
  text-transform: uppercase;
}
.tag {
  font-size: 18px;
  color: #222;
}
.bottom-section {
  background: #f1f1f1;
  padding: 60px 14px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: centre;
  text-transform: uppercase;
  font-size: 20px;
}
.bottom-section span {
  font-size: 14px;
  display: block;
}
.border {
  width: 1px; 
  height: 20px;
  background: #bbb;
  margin: 0 20px;
}
.social-media {
  position: absolute;
  width: 100%;
  top: -18px;
  left: 0;
  z-index: 1;
}
.social-media i {
  width: 40px;
  height: 40px;
  background: #2c3e50;
  border-radius: 50%;
  color: #f1f1f1;
  line-height: 40px;
  font-size: 20px;
  margin: 0 1px;
  position: relative;
}
.social-media i:after {
  content: '';
  width: 100%;
  height: 100%;
  position: absolute;
  background: #2c3e50;
  left: 0;
  top: 0;
  box-sizing: border-box;
  border-radius: 50%;
  z-index: -1;
  transition: 0.4s linear;
}
.social-media i:hover:after {
  transform: scale(1.3);
  opacity: 0;
}


</style>
<body>
  
<div class="profile-card" >
  <div class="top-section" style="position: relative;">
    <div class="pic">
    <img src="${pageContext.request.contextPath}/upload/${user1.img}">
  </div>
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
					
					<div class="profile-usertitle-job">
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