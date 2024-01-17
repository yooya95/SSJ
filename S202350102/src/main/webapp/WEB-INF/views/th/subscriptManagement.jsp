<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독관리</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<script type="text/javascript">
	function chkDate(){
		if(confirm('정말 구독취소 하시겠습니까?')){
			var suc_date	= new Date($('#suc_date').text())
			
			// 현재 날짜를 년-월-일 로 변환 (시간 버림)
			var today 		= new Date();
			let year 		= today.getFullYear(); 		// 년도
			let month 		= today.getMonth() + 1;  	// 월
			let date 		= today.getDate();  		// 날짜
			var todayString = year + "-" + month +"-" + date			
			
// 			alert('결제한 날짜 --> '+ $('#suc_date').text());
// 			alert('현재 날짜 -->' + todayString);
			
			// 문자형 날짜를 다시 Date형으로 변환
			var 	Todayfloor = new Date(todayString)
			var 	diffDate = Todayfloor.getTime() - suc_date.getTime();
			
			// 두 날짜사이 시간차를 구함 --> / 밀리초    60초  60분 = /h 단위로 계산됨
			const diffHour = diffDate/(1000 * 60 * 60);
// 			alert('두 날짜사이 시간 --> ' + diffHour + '시간')
			if(diffHour > 24){
				alert('구독취소는 구독후 24시간 이내에만 가능 합니다');
				return false;
			}
			return true;	
			
		} else {
			return false;	
		}
	}
</script>
</head>
<body>

	 <div class="container section-mt">
         <div class="row profile">
			<!-- 마이페이지 사이드바  -->         
            <div class="col-md-3">
                <%@ include file="../mypageMenu.jsp" %>
            </div>
            
            <!-- 마이페이지 본문 -->
<!--             <div class="row"> -->
         
             <div class="col-md-9 profile-form">
             	<div class="container text-center" style="margin-top: 20px;">
			    	<h3>My Page</h3>
			    </div>
                 <form action="/kakaoPayRefund" method="post" onsubmit="return chkDate()">
                 <!-- tid price 가져와서 refund테이블에 추가하려 했었음(미완성) -->
                 	<input type="hidden" name="tid"  		id="tid" 		value="${order1.tid }">
					<input type="hidden" name="price" 		id="price"		value="${order1.price }">
					<div id="suc_date" style="display:none"><fmt:formatDate value="${order1.suc_date }" pattern="yyyy-MM-dd"></fmt:formatDate></div>
	             	<div class="row">
						<div class="col-md-12 my-3"><b>멤버쉽</b></div>
						
						<div class="col-md-9">
						<table class="table table-bordered table-sm">
						  <thead>
						    <tr>
						      <th scope="row" colspan="3"> <img alt="premiumLogo.png" src="images/th/premiumLogo.png" width="100px" height="30px"><br>
						      								개인 멤버쉽: ₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${order1.price }" />원</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr  class="py-5" style="border-bottom: none; border-top: none;">
						      <th  class="py-4" scope="row" colspan="3">${user1.user_name }님 안녕하세요. <br>
						      							  ${order1.mem_name } 상품을 구매 해주셔서 감사합니다.</th>
						    </tr>
						    <tr class="py-2" style="border-bottom: none; border-top: none;">
						      <th class="py-2" scope="row" colspan="3">결제 완료일: <fmt:formatDate value="${order1.suc_date }" pattern="yyyy년 MM월 dd일, HH시 mm분 ss초"></fmt:formatDate></th>
						    </tr>
						    <tr class="py-2" style="border-bottom: none; border-top: none;">
						      <th class="py-2" scope="row" colspan="3">결제 수단: ${order1.pay_type }</th>
						    </tr>
						    <tr style="border-top: none;">
						      <th class="d-flex justify-content-end" ><button type="submit" class="btn btn-dark btn-sm">구독취소</button></th>
						    </tr>
						  </tbody>
						</table>
						</div>
						
						<div class="col-md-2"></div>
					</div>
				</form>
			</div>
		
		</div>
	</div>

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>