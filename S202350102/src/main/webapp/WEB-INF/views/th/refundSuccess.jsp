<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불 성공</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
</head>
<body>
<!-- CONTENT -->
    <section class="py-12">
      <div class="container section-mt">
        <div class="row justify-content-center">
          <div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center">

            <!-- Icon -->
            <div class="row justify-content-center mb-5">
	            <div class="mb-7 fs-1" style="max-width: 170px;">
	             <!-- Image -->
	                  <img class="card-img-top" src="images/th/refund.png" alt="refund.png">
	            </div>
            </div>

            <!-- Heading -->
            <h2 class="mb-5">환불이 정상적으로 완료되었습니다 <p></h2>

            <!-- Text -->
            <p class="mb-7 text-gray-500 text-start">
				&emsp;환불일시:     &emsp;<fmt:formatDate value="${kakaoPayCancelVO.approved_at}" pattern="yyyy년 MM월 dd일, HH시 mm분 ss초"></fmt:formatDate><br/>
				&emsp;주문번호:     &emsp;${kakaoPayCancelVO.partner_order_id}<br/>
				&emsp;구독상품:     &emsp;${kakaoPayCancelVO.item_name}<br/>
				&emsp;환불금액:     &emsp;<fmt:formatNumber value="${kakaoPayCancelVO.approved_cancel_amount.total}" pattern="#,###"/>원<br/>
				&emsp;결제방법:     &emsp;카카오페이<br/>
            </p>
			  
				   <div class="row d-flex justify-content-center">
                     <div class="col-4 g-0">
                       	<div class="form-floating mb-3">
                    		<button class="btn btn-dark" onclick="location.href='/mypage'">마이페이지로 이동</button>    	
                        </div>
                      </div>	
                    </div>
                  </div>
			
          </div>
        </div>
      
    </section>


<%-- 	${kakaoPayCancelVO } --%>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>