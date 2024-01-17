<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%@ include file="/WEB-INF/views/header4.jsp"%>
</head>
<body class="bg-light">

	<!-- MODALS  -->

	<!-- 비밀번호 리셋 MODAL -->
	<div class="modal fade" id="modalPasswordReset" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">

				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close">
					<i class="fe fe-x" aria-hidden="true"></i>
				</button>

				<!-- Header-->
				<div class="modal-header lh-fixed fs-lg">
					<strong class="mx-auto">비밀번호 찾기</strong>
				</div>

				<!-- Body -->
				<div class="modal-body text-center">

					<!-- Text -->
					<p class="mb-7 fs-sm text-gray-500">
						아이디와 이메일을 입력해주세요 <br> 해당 이메일로 새로운 비밀번호를 발급 받으실 수 있습니다
					</p>

					<!-- Form -->
					<form action="/sendMailForResetPswd">

						<!-- 아이디 -->
						<div class="form-group">
							<label class="visually-hidden" for="modalPasswordResetEmail">
								아이디 * </label> <input class="form-control form-control-sm"
								id="modalPasswordResetEmail" name="user_id" type="text"
								placeholder="아이디 " required>
						</div>

						<!-- Email -->
						<div class="form-group">
							<label class="visually-hidden" for="modalPasswordResetEmail">
								이메일 * </label> <input class="form-control form-control-sm"
								id="modalPasswordResetEmail" name="email" type="email"
								placeholder="이메일 you@xxx.xxx" required>
						</div>



						<!-- Button type ="submit을" 안걸어도 알아서 연동됨 ;; 왜지?-->
						<button class="btn btn-sm btn-dark">비밀번호 리셋</button>

					</form>

				</div>

			</div>

		</div>
	</div>

	<!-- 아이디 찾기 MODAL  -->

	<div class="modal fade" id="modalFindId" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">

				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close">
					<i class="fe fe-x" aria-hidden="true"></i>
				</button>

				<!-- Header-->
				<div class="modal-header lh-fixed fs-lg">
					<strong class="mx-auto">아이디 찾기</strong>
				</div>

				<!-- Body -->
				<div class="modal-body text-center">

					<!-- Text -->
					<p class="mb-7 fs-sm text-gray-500">이름과 이메일을 입력해주세요</p>

					<!-- Form -->
					<!--             <form action="findId"> -->

					<!-- 아이디 -->
					<div class="form-group">
						<label class="visually-hidden" for="user_name"> 이름 * </label> 
						<input class="form-control form-control-sm" id="user_name" name="user_name" type="text" placeholder="이름  " required>
					</div>

					<!-- Email -->
					<div class="form-group">
						<label class="visually-hidden" for="email"> 이메일 * </label> 
						<input class="form-control form-control-sm" id="email" name="email" type="email" placeholder="이메일 you@xxx.xxx" required>
					</div>

					<button class="btn btn-sm btn-dark" id="findIdBtn" onclick="return findId_click()">
						아이디 찾기</button>

					<!--             </form> -->

				</div>

			</div>

		</div>
	</div>	

	<!-- CONTENT -->
	<section class="py-12">
		<div class="container section-mt">
			<div class="row">
				<div class="col-12 col-md-6" style="float: none; margin: 0 auto;">

					<!-- Card -->
					<div class="card card-lg mb-10 mb-md-0">
						<div class="card-body">

							<!-- Heading -->
							<h6 class="mb-7">로그인</h6>

							<!-- Form -->
							<!-- ajax로 사용하려고 잠시 form 지움 -->
							<!--                 <form action="login" method="post"> -->
							<div class="row">

								<div class="col-12">
									<!-- Email -->
									<div class="form-group">
										<label class="visually-hidden" for="user_id"> 아이디 * </label> <input
											class="form-control form-control-sm" id="user_id" type="text"
											name="user_id" placeholder="ID *" required>
									</div>
								</div>

								<div class="col-12">
									<!-- Password -->
									<div class="form-group">
										<label class="visually-hidden" for="user_pswd"> 비밀번호 *
										</label> <input class="form-control form-control-sm" id="user_pswd"
											type="password" name="user_pswd" placeholder="Password *"
											required>
									</div>
								</div>

								<div class="col-12 col-md">
									<!-- Remember -->
									<div class="form-group">
										<div class="form-check">
											<input class="form-check-input" id="loginRemember"
												type="checkbox"> <label class="form-check-label"
												for="loginRemember"> 아이디 기억하기 </label>
										</div>
									</div>
								</div>

								<!-- Link -->
								<div class="col-12 col-md-auto">
									<div class="form-group">
										<a class="fs-sm text-reset" href="/signUp">회원가입 </a> <small
											class="fs-sm text-reset"> | </small> <a
											class="fs-sm text-reset" data-bs-toggle="modal"
											href="#modalFindId">아이디 찾기 </a> <small
											class="fs-sm text-reset"> | </small> <a
											class="fs-sm text-reset" data-bs-toggle="modal"
											href="#modalPasswordReset">비밀번호 찾기 </a>
									</div>
								</div>

								<div class="col-12">
									<!-- Button -->
									<button class="btn btn-sm btn-dark" id="loginBtn">로그인
									</button>
								</div>
							</div>

							<!-- ajax로 수정하기위해 지움 -->
							<!--                 </form> -->

						</div>
					</div>

				</div>
			</div>
		</div>
	</section>

	<!-- JAVASCRIPT -->
	<script type="text/javascript">
		
		$(document).ready(function() {
			// 모달 값 지우기
			// 모달창을 끌 때, hidden.bs.modal이라는 이벤트가 발생하고 이때 함수를 실행시킨다
			// 해당모달의 input창의 모든 값을 비운다
			// $(document).ready(function() : 이부분을 사용하지않으면 문서가 모달 이벤트 수신할 때 아래코드가 준비되지 않아 작동 안할수있음, 문서가준비된 이후 코드가 작동하도록 보장하기위해 jQuery의 document.ready 이벤트 사용
			$('.modal').on('hidden.bs.modal', function(e) {
				$(this).find('input').val('');
			});
			
			// 아이디입력창에서 엔터키 입력시 로그인 버튼 클릭
			$("#user_id").keypress(function(e){
				//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
				if(e.keyCode && e.keyCode == 13){
					$("#loginBtn").trigger("click");
					return false;
				}
			});
			
			// 비밀번호 입력창에서 엔터키 입력시 로그인 버튼 클릭
			$("#user_pswd").keypress(function(e){				
				//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
				if(e.keyCode && e.keyCode == 13){
					$("#loginBtn").trigger("click");
					return false;
				}

			});
			
			// 비밀번호 입력창에서 엔터키 입력시 아이디 찾기 버튼 클릭
			$("#user_name").keypress(function(e){	
				//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
				if(e.keyCode && e.keyCode == 13){
					$("#findIdBtn").trigger("click");
					return false;
				}
			});
			
			// 비밀번호 입력창에서 엔터키 입력시 아이디 찾기 버튼 클릭
			$("#email").keypress(function(e){	
				//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
				if(e.keyCode && e.keyCode == 13){
					$("#findIdBtn").trigger("click");
					return false;
				}
			});
			
		});


		// 아이디 찾기
		function findId_click() {
			var user_name = $('#user_name').val()
			var email = $('#email').val()
			var str = "";
			var str2 = "";
			if (user_name == "") {
				alert("이름을 입력해주세요");
				document.getElementById('user_name').focus();
				return false;
			} else if (email == "") {
				alert("이메일을 입력해주세요");
				document.getElementById('email').focus();
				return false;
			}
			$.ajax({
				url : "/findId",
				type : "POST",
				data : {
					"user_name" : user_name,
					"email" : email
				},
				dataType : "json",
				success : function(data) {
					if (data == "") {
						alert("회원이 존재하지 않습니다");
						$('#user_name').val('');
						$('#email').val('');
					} else if (data != '0') {
						var jsonStr = JSON.stringify(data);
						$(data).each(function() {
							str2 = this.user_id + "\n"
							str += str2;
						})
						alert("회원님의 아이디 : \n" + str);
						$('#user_name').val('');
						$('#email').val('');
						$('#modalFindId').modal('hide');
					}
				}
			});
		};
		// 아이디 찾기 - 이름, 이메일 유효성 검사
		function chk() {
			var user_name = document.getElementById('user_name').value;
			var email = document.getElementById('email').value;
			if (user_name == "") {
				alert("이름을 입력해주세요");
				document.getElementById('user_name').focus();
				return false;
			} else if (email == "") {
				alert("이메일을 입력해주세요");
				document.getElementById('email').focus();
				return false;
			}

		}
		// 문자열 비교할때 EL표기법에도 "${chk}" 큰따옴표 처리하면 됨
		function chkIdPassword() {
			if ("${chk}" == "wrongValue") {
				alert('아이디 또는 비밀번호가 틀렸습니다')
			}
			if ("${chk}" == "delId") {
				alert('탈퇴한 회원입니다')
			}
			if ("${chk}" == "") {
				return true;
			}
		}

		// Ajax 통한 로그인
		$('#loginBtn').click(function() {
			var user_id = $('#user_id').val();
			var user_pswd = $('#user_pswd').val();
			$.ajax({
				type : "POST",
				url : "/login",
				data : {
					"user_id" : user_id,
					"user_pswd" : user_pswd
				},
				dataType : "text",
				success : function(data) {
					if (data == 'wrongValue') {
						alert('아이디 또는 비밀번호가 틀립니다');
					} else if (data == 'delId') {
						alert('탈퇴한 회원입니다')
					} else {
// 						alert('로그인 되었습니다 메인페이지로 이동합니다')
						location.href = '/loginSuc?user_id='+user_id;
					}
				}
			});
		});
	</script>


	<!--  아이디 기억하기 -->
	<script type="text/javascript">
		$(document).ready(
				function() {

					// 1.view단 loginForm.jsp에 Remember me 체크박스 생성

					// 2.저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
					var key = getCookie("key");
					$("#user_id").val(key);

					// 3.그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
					if ($("#user_id").val() != "") {
						$("#loginRemember").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
					}

					// 4.아이디 저장하기 부분을 체크했다면 값을 쿠키에 보관한다, 체크 해제했다면 쿠키를 제거한다.
					$("#loginRemember").change(function() { // 체크박스에 변화가 있다면,
						if ($("#loginRemember").is(":checked")) { // ID 저장하기 체크했을 때,
							setCookie("key", $("#user_id").val(), 7); // 7일 동안 쿠키 보관
						} else { // ID 저장하기 체크 해제 시,
							deleteCookie("key");
						}
					});

					// 5.아이디 저장하기를 체크한 상태에서 아이디를 입력하는 경우에도 쿠키에 저장한다
					$("#user_id").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
						if ($("#loginRemember").is(":checked")) { // ID 저장하기를 체크한 상태라면,
							setCookie("key", $("#user_id").val(), 7); // 7일 동안 쿠키 보관
						}
					});

					// 6.쿠키 저장, 쿠키 가져오기, 쿠키 삭제등의 함수를 구현한다
					// 쿠키 저장하기 
					// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
					function setCookie(cookieName, value, exdays) {
						var exdate = new Date();
						exdate.setDate(exdate.getDate() + exdays);
						var cookieValue = escape(value)
								+ ((exdays == null) ? "" : "; expires="
										+ exdate.toGMTString());
						document.cookie = cookieName + "=" + cookieValue;
					}

					// 쿠키 삭제
					function deleteCookie(cookieName) {
						var expireDate = new Date();
						expireDate.setDate(expireDate.getDate() - 1);
						document.cookie = cookieName + "= " + "; expires="
								+ expireDate.toGMTString();
					}

					// 쿠키 가져오기
					function getCookie(cookieName) {
						cookieName = cookieName + '=';
						var cookieData = document.cookie;
						var start = cookieData.indexOf(cookieName);
						var cookieValue = '';
						if (start != -1) { // 쿠키가 존재하면
							start += cookieName.length;
							var end = cookieData.indexOf(';', start);
							if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
								end = cookieData.length;
							console.log("end위치  : " + end);
							cookieValue = cookieData.substring(start, end);
						}
						return unescape(cookieValue);
					}
					
				});
	</script>
</body>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</html>