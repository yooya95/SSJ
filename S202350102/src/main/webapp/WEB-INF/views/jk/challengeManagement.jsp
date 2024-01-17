<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 관리</title>
<script type="text/javascript">



</script>
</head>
<body>
<div class="container">
	<div class="row profile">
	
		<!-- mypageMenu start -->
		<div class="col-md-3">
        	<%@ include file="/WEB-INF/views/mypageMenu.jsp" %>
		</div>
      	<div class="col-md-9 profile-form">
		<!-- mypageMenu end -->
		
		<!-- tab -->
		<div class="container">
	        <div class="row">
	        	<div class="col-12">	
	            	<!-- Heading -->
	            	<h5 class="mb-4">챌린지 관리</h5>
	            
		            <!-- Nav -->
		            <div class="nav justify-content-center mb-10">
		            	<a class="nav-link active" href="#joinChg" data-bs-toggle="tab">참여 챌린지</a>
		            	<a class="nav-link" href="#applyChg" data-bs-toggle="tab">신청한 챌린지</a>
		            	<a class="nav-link" href="#pickChg" data-bs-toggle="tab">찜한 챌린지</a>
		            	<!-- 최근 본 챌린지는 일단 보류. 나중에 시간나면 추가할 예정 -->
		            	<!-- <a class="nav-link" href="#my" data-bs-toggle="tab" onclick="clickLoad(4)">최근 본 챌린지</a> -->
		            </div>	
		            
	            	<!-- Content -->
		            <div class="tab-content">	
		            	<!-- 참여 챌린지 start -->
		            	<div class="tab-pane fade show active" id="joinChg">
		            	  <div class="row justify-content-center py-9">
			                  <div class="col-12 col-lg-10 col-xl-8">
			                    <div class="row">
			                      <div class="col-12">
			                      
			                      
			                      
			                      
			                      <!-- 여기서부터 작업하면 됨 -->
			                      
			                      
			                      
			            	  		</div>
			            	  	</div>
			            	  </div>
			           	  </div>
		            	</div> 
		            	<!-- 참여 챌린지 end -->
		            	
		            	 
		            	<!-- 신청한 챌린지 start -->
		            	<div class="tab-pane fade show active" id="applyChg">
		            	  <div class="row justify-content-center py-9">
			                  <div class="col-12 col-lg-10 col-xl-8">
			                    <div class="row">
			                      <div class="col-12">
			                      
			                      
			                      
			                      
			                      <!-- 여기서부터 작업하면 됨 -->
			                      
			                      
			                      
			            	  		</div>
			            	  	</div>
			            	  </div>
			           	  </div>
		            	</div>
		            	<!-- 신청한 챌린지 end -->
		            	
		            	
		            	<!-- 찜한 챌린지 start -->
		            	<div class="tab-pane fade show active" id="pickChg">
		            	  <div class="row justify-content-center py-9">
			                  <div class="col-12 col-lg-10 col-xl-8">
			                    <div class="row">
			                      <div class="col-12">
				                      <%@ include file="/WEB-INF/views/yr/myPickChgManagement.jsp" %>
			            	  		</div>
			            	  	</div>
			            	  </div>
			           	  </div>
		            	</div>
		            	<!-- 찜한 챌린지 end -->
		            	
		            	
		        	</div> 
		        	<!-- tab-content end -->
				</div> 
				<!-- col-12 end -->
			</div> 
			<!-- row end -->
		</div> 
		<!-- container end -->

	
	
    	</div>	
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>