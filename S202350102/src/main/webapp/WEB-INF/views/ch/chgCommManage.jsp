<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery.js"></script>
<script type="text/javascript">
	function deleComm(){
		$("#delComm").submit();
	}
</script>
</head>
<body>
	<div class="container section-mt">
			<div class="row">
	            <!-- Heading -->
	            <div class="col-12 text-center">
            		<h3>챌린지 카테고리 관리</h3>
          		</div>
        	</div>
        	
		<div class="row">
			<%@ include file="../jh/adminSidebar.jsp" %>
			
			<div class="col-md-10 profile-form">
        	
	            <div class="row justify-content-center py-9">
	              <div class="col-12 col-lg-10 col-xl-8">
	                <div class="row">
	                  <div class="col-12">
	                  		<div class="review">
                  				<form action="deleteChgComm" method="post" class="row d-flex justify-content-between align-items-center mb-0" id="delComm">
			                  		<table>
										<tbody class="col-12 text-center">
											<c:set value="1" var="i"></c:set>
											<c:forEach items="${chgCommList }" var="chgCommList">
												<tr>
													<td class="col-3"><label for="ctn${i }">${chgCommList.ctn }</label></td>									
													<td class="col-3"><input type="checkbox" name="ctn" id="ctn${i }" value="${chgCommList.ctn }"></td>					
												</tr>		
														
												<c:set value="${i +1 }" var="i"></c:set>
											</c:forEach>										
										</tbody>										
									</table>									
								</form>
								<div class="text-center py-1">
									<button type="button" onclick="deleComm()" class="btn-dark">선택항목 삭제</button>
								</div>
								<div class="row justify-content-center">
									<div class="col-12">
										<form action="insertChgComm" method="post" class="text-center">
											챌린지 카테고 입력: <input type="text" name="ctn"> <input type="submit" value="추가" class="btn-dark">
										</form>
									</div>
								</div>
	                  		</div>
						</div>
	                  
	                  </div>
	                </div>
	              </div>
           </div>
		                
			
			
		</div>
	</div>
		
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>
