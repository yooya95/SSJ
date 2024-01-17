	function chk(){
		if(!frm.user_level.value){
			alert('레벨을 입력해주세요')
			frm.user_level.focus();
			return false	
		}
		if(!frm.user_exp.value){
			alert('경험치을 입력해주세요')
			frm.user_exp.focus();
			return false	
		}
		if(!frm.nick.value){
			alert('닉네임을 입력해주세요')
			frm.nick.focus();
			return false	
		}
		if(!frm.email.value){
			alert('이메일을 입력해주세요')
			frm.email.focus();
			return false	
		}
		if(!frm.birth.value){
			alert('생년월일 입력해주세요')
			frm.birth.focus();
			return false	
		}
		if(!frm.addr.value){
			alert('주소를 입력해주세요')
			frm.addr.focus();
			return false	
		}
		if(!frm.tel.value){
			alert('휴대폰 번호를 입력해주세요')
			frm.tel.focus();
			return false	
		}

	
		if(isNaN(frm.user_level.value)){
			alert('레벨은 숫자로 입력해 주세요')
			frm.user_level.focus();
			return false;	
		}
		if(isNaN(frm.user_exp.value)){
			alert('경험치는 숫자로 입력해 주세요')
			frm.user_exp.focus();
			return false;	
		}
		
	}