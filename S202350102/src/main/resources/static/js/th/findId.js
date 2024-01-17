
	function findId_click(){
		var user_name 	= $('#user_name').val()
		var email 		= $('#email').val()
		var str 		= "";
		var str2		= "";
			   if(user_name == "" ) {
				   alert("이름을 입력해주세요");
				   document.getElementById('user_name').focus();
				   return false;
			   } else if(email == "" ) {
				   alert("이메일을 입력해주세요");
				   document.getElementById('email').focus();
				   return false;
			   }
		$.ajax({
			url			:	"/findId",
			type		:	"POST",
			data		:	{"user_name" : user_name, "email" : email},
			dataType	:	"json",
			success 	:	function(data){
								if(data == ""){
									alert("회원이 존재하지 않습니다");
									$('#user_name').val('');
									$('#email').val('');
								} else if (data != '0') {
									var jsonStr = JSON.stringify(data);
									$(data).each(
											function() {
												str2 = this.user_id + "\n"
												str += str2;
											}
									)
									alert("회원님의 아이디 : \n" + str);
									$('#user_name').val('');
									$('#email').val('');
									$('#modalFindId').modal('hide');
								}
			}
		});
	};
	
	function chk(){
		var user_name 	= document.getElementById('user_name').value;
		var email		= document.getElementById('email').value;
			   if(user_name == "" ) {
				   alert("이름을 입력해주세요");
				   document.getElementById('user_name').focus();
				   return false;
			   } else if(email == "" ) {
				   alert("이메일을 입력해주세요");
				   document.getElementById('email').focus();
				   return false;
			   }
	
	}
