

var idCheck 	= 0;
var pwdCheck 	= 0;
var nickCheck 	= 0;
var nameCheck 	= 0;
var emailCheck 	= 0;
var phoneCheck 	= 0;


//정규 표현식 (추후 수정 필요)
function regUser_id(user_id) {  //첫글자 영문, 영문자 또는 숫자  5자리 이상 15자리 이하 
   var regExp = /^[a-zA-Z]+[a-zA-Z0-9]{4,14}$/g;
   return regExp.test(user_id);   
}
function regPassword(user_pswd) { // 영문 숫자 특수기호 조합 8자리 이상 20자리이하
   var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/
   return regExp.test(user_pswd);
}

function regConfirmPassword(user_pswd) { // 영문 숫자 특수기호 조합 8자리 이상 20자리이하
   var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/
   return regExp.test(user_pswd);
}


function regNick(nick) { //닉네임 : 2자 이상 12자 이하, 영어 또는 숫자 또는 한글로 구성
	   var regExp = /^(?=.*[a-zA-Z0-9가-힣])[a-zA-Z0-9가-힣]{2,12}$/
	   return regExp.test(nick);
}

function regUser_name(user_name) { //이름:2~6자리 한글
   var regExp = /^[가-힣]{2,6}$/;
   return regExp.test(user_name);
}

function regEmail(email) { // 이메일  : 계정@도메인.최상위도메인
	   var regExp = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/
	   return regExp.test(email);
}

function regTel(tel) { // 휴대폰번호 : 010 시작 -:있을수도 없을수도 숫자만 들어가면서 3~4길이 , -:있을수도 없을수도, 숫자만 들어가면서 4 길이 문자 
   var regExp = /^010-?([0-9]{3,4})-?([0-9]{4})$/
   return regExp.test(tel);
}


function checkId() {
	   var inputed = $('#user_id').val();
	   $.ajax({	
		   		data : { user_id : inputed },
		      	url : "user1IdCheck", // data를 checkid url에 보냄 (Controller에서 받아처리한다. 중복이 되면 1, 아니면 0을 반환하는 함수를 구현했다.)
	      success : function(data) {
	      	var integerData = parseInt(data, 10);
	         if(integerData >= 1) { //아이디가 중복되었을 때
	            $("#failDupId").css("display", "block"); //중복 에러메세지를 띄운다
	            $("#failId").css("display","none"); //중복 에러메세지 말고 다른 에러 메세지를 지운다.
	            $("#user_id").css("border-color", "#FFCECE");
	            $("#user_id").css("border-width", "2px");
	            idCheck = 0;
	         } else if (regUser_id(inputed) == false || inputed.length > 15 ) {
	            $("#failId").css("display","block");
	            $("#failDupId").css("display","none");
	            $("#user_id").css("border-color", "#FFCECE");
	            $("#user_id").css("border-width", "2px");
	            idCheck = 0;
	         } else if( data == 0 && regUser_id(inputed)) { //중복되지않고, 정규식을 통과할 때
	            $("#user_id").css("border-color", "#e5e5e5");
	            $("#user_id").css("border-width", "1px");
	            $("#failDupId").css("display","none");
	            $("#failId").css("display","none");
	            idCheck = 1;  
	         }
	      }
	   });
}

function checkPwd() {
//	   alert("checkPwd Start"); checkPwd와 activateSignupbtn 테스트용 , 펑션이 먼저 호출되고, 아작스가 늦게 수행된다
	   var inputed = $('#user_pswd').val();
	         if(regPassword(inputed) == false) {
	            $("#failpwd").css("display", "block");
	            $("#user_pswd").css("border-color", "#FFCECE").css("border-width", "2px");
	            pwdCheck = 0;
//	            alert("checkPwd() pwdCheck -->" + pwdCheck ); checkPwd와 activateSignupbtn 테스트용 , 펑션이 먼저 호출되고, 아작스가 늦게 수행된다
	         } else if(regPassword(inputed) == true) {
	            $("#user_pswd").css("border-color", "#e5e5e5").css("border-width", "1px");
	            $("#failpwd").css("display", "none");
	            pwdCheck = 1;
//	            alert("checkPwd() pwdCheck -->" + pwdCheck ); checkPwd와 activateSignupbtn 테스트용 , 펑션이 먼저 호출되고, 아작스가 늦게 수행된다
	         }
}

function checkConfirmPswd() {
	 var inputed = $('#user_confirmPswd').val();
	  if(regConfirmPassword(inputed) == false) {
	            $("#failConfirmpwd").css("display", "block");
	            $("#matchPwd").css("display", "none");
        	    $("#notMatchPwd").css("display", "none");
        	    $("#user_confirmPswd").css("border-color", "#FFCECE").css("border-width", "2px");
	 } else if(document.getElementById('user_pswd').value != '' && document.getElementById('user_confirmPswd').value != ''){
         if(document.getElementById('user_pswd').value == document.getElementById('user_confirmPswd').value){
        	 $("#matchPwd").css("display", "block");
        	 $("#notMatchPwd").css("display", "none");
        	 $("#failConfirmpwd").css("display", "none");
        	 $("#user_confirmPswd").css("border-color", "#e5e5e5").css("border-width", "1px");
         }
         else{
        	 $("#notMatchPwd").css("display", "block");
        	 $("#matchPwd").css("display", "none");
        	 $("#failConfirmpwd").css("display", "none");
        	 $("#user_confirmPswd").css("border-color", "#FFCECE").css("border-width", "2px");
         }
     }
}
function checkNick() {
	   var inputed = $('#nick').val(); //닉네임에 입력한 값
	   $.ajax({
		   		data 	: {nick : inputed},
		   		url		: "user1NickCheck",	
	      success: function(data) {
	    	  if(data >= '1'){
	    		$("#failDupNick").css("display", "block"); //중복 에러메세지를 띄운다
	            $("#failNick").css("display","none"); //중복 에러메세지 말고 다른 에러 메세지를 지운다.
	            $("#nick").css("border-color", "#FFCECE").css("border-width", "2px");  // input 테두리 붉은색으로 바꾸기  테두리 굵기 2px
	            nickCheck = 0; // 회원 가입 전 값들 체크하기 위해 (0은 불가, 1은 가능)
	         } else if(regNick(inputed) == false) { 
	        	$("#failNick").css("display","block");
 		        $("#failDupNick").css("display","none"); 
	            $("#nick").css("border-color", "#FFCECE").css("border-width", "2px"); 
	            nickCheck = 0;
	         } else if(regNick(inputed) == true && data == '0'){	//정규표현식에 true + 중복 되지않을때
    	 	    $("#nick").css("border-color", "#e5e5e5");
		            $("#nick").css("border-width", "1px");
		            $("#failDupNick").css("display","none");
		            $("#failNick").css("display","none");
		            nickCheck = 1; 
	         }
	      }
	   })
}


function checkName() {
	   var inputed = $('#user_name').val(); //이름에 입력한 값

	         if(regUser_name(inputed) == false) { //입력한 값이 정규표현식에 해당되지 않을 때
	            $("#user_name").css("border-color", "#FFCECE");  // input 테두리 붉은색으로 바꾸기  Q) 아랫라인과 한줄로 합치는거 있을까??
	            $("#user_name").css("border-width", "2px");
	            nameCheck = 0; // 회원 가입 전 값들 체크하기 위해 (0은 불가, 1은 가능)
	         } else if(regUser_name(inputed) == true) { //정규표현식에 해당할 때
	            $("#user_name").css("border-color", "#e5e5e5"); // input 테두리 초록색으로 바꾸기
	            $("#user_name").css("border-width", "1px");
	            nameCheck = 1;
	         }

}


function checkEmail() {
	   var inputed = $('#email').val(); //이메일에 입력한 값

	         if(regEmail(inputed) == false) { //입력한 값이 정규표현식에 해당되지 않을 때
	            $("#email").css("border-color", "#FFCECE").css("border-width", "2px");  // input 테두리 붉은색으로 바꾸기  테두리 굵기 2px
	            $("#failemail").css("display", "block");
	            emailCheck = 0; // 회원 가입 전 값들 체크하기 위해 (0은 불가, 1은 가능)
	         } else if(regEmail(inputed) == true) { //정규표현식에 해당할 때
	            $("#email").css("border-color", "#e5e5e5").css("border-width", "1px"); // input 테두리 초록색으로 바꾸기
	            $("#failemail").css("display", "none");
	            emailCheck = 1;
	         }

}


function checkTel() {
   var inputed = $('#tel').val();
         if(regTel(inputed) ==  false) {
            $("#tel").css("border-color", "#FFCECE");
            $("#tel").css("border-width", "2px");
            $("#failtel").css("display", "block");
            inputed = $('#tel').val();
            phoneCheck = 0;
         }
         else if(regTel(inputed)== true) {
            $("#tel").css("border-color", "#e5e5e5");
            $("#tel").css("border-width", "1px");
            $("#failtel").css("display", "none");
            phoneCheck = 1;
         }
}


function checkSignupbtn() {
   if(idCheck == 0 ) {
	   alert("아이디를 형식에 맞게 입력해주세요");
	   frm.user_id.focus();
	   return false;
   }
   if(pwdCheck == 0 ) {
	   alert("비밀번호를 형식에 맞게 입력해주세요");
	   frm.user_pswd.focus();
	   return false;
   }
   if(!frm.user_confirmPswd.value) {
   	   alert("비밀번호 확인을 형식에 맞게 입력해주세요");
	   frm.user_confirmPswd.focus();
	   return false;
   }
   if(nickCheck == 0 ) {
	   alert("닉네임을 형식에 맞게 입력해주세요");
	   frm.nick.focus();
	   return false;
   }
   if(nameCheck == 0 ) {
	   alert("이름을 형식에 맞게 입력해주세요");
	   frm.user_name.focus();
	   return false;
   }
   
   if($("input[name=gender]:radio:checked").length < 1) {
	   alert("성별을 선택해주세요");
	   frm.gender[1].focus();
	   return false;
   }
   if(emailCheck == 0 ) {
	   alert("이메일을 형식에 맞게 입력해주세요");
	   frm.email.focus();
	   return false;
   }
   if(!frm.birth_year.value ) {
	   alert("생년월일을 입력해주세요");
	   frm.birth_year.focus();
	   return false;
   }
   if(!frm.birth_month.value ) {
	   alert("생년월일을 입력해주세요");
	   frm.birth_month.focus();
	   return false;
   }
   if(!frm.birth_date.value ) {
	   alert("생년월일을 입력해주세요");
	   frm.birth_date.focus();
	   return false;
   }
   if(!frm.zipCode.value ) {
	   alert("주소를 입력해주세요");
	   frm.zipCode.focus();
	   return false;
   }
   if(!frm.addr.value ) {
	   alert("주소를 입력해주세요");
	   frm.addr.focus();
	   return false;
   }
   if(!frm.addr_detail.value ) {
	   alert("상세주소를 입력해주세요");
	   frm.addr_detail.focus();
	   return false;
   }
   if(!frm.tel.value ) {
	   alert("휴대폰번호를 입력해주세요");
	   frm.tel.focus();
	   return false;
   }
   if(document.getElementById('user_pswd').value != document.getElementById('user_confirmPswd').value) {
   		alert("비밀번호와 확인용 비밀번호가 일치하지 않습니다. 다시 입력해주세요");
   		frm.user_pswd.focus();
   		return false;
   }
	return true;   
}

function resetAll(){
		/* 메세지 전부삭제  */
		 $("#failId").css("display","none");	
		 $("#failDupId").css("display","none");
		 $("#failpwd").css("display", "none");
		 $("#notMatchPwd").css("display", "none");
		 $("#matchPwd").css("display", "none");
		 $("#failConfirmpwd").css("display", "none");
		 $("#failNick").css("display","none"); 
		 $("#failDupNick").css("display","none");
		 $("#failemail").css("display", "none");
		 $("#failtel").css("display", "none");
		 
		 /* 색깔 삭제 */
		 $("#user_id").css("border-color", "#e5e5e5");
         $("#user_id").css("border-width", "1px");
		 
         $("#user_pswd").css("border-color", "#e5e5e5");
         $("#user_pswd").css("border-width", "1px");
         
         $("#user_confirmPswd").css("border-color", "#e5e5e5");
         $("#user_confirmPswd").css("border-width", "1px");
         
         $("#nick").css("border-color", "#e5e5e5");
         $("#nick").css("border-width", "1px");
         
         $("#user_name").css("border-color", "#e5e5e5");
         $("#user_name").css("border-width", "1px");
         
         $("#email").css("border-color", "#e5e5e5");
         $("#email").css("border-width", "1px");
         
         $("#tel").css("border-color", "#e5e5e5");
         $("#tel").css("border-width", "1px");
         
         
}

