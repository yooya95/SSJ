<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ include file="/WEB-INF/views/header4.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeWriteForm공지 및 이벤트 글 작성 </title>
</head>
<body>
		
	<div class="container">
		<div class="row text-center">
			<c:if test="${brd_md == 105 }"><h3>공지</h3></c:if>
			<c:if test="${brd_md == 106 }"><h3>이벤트</h3></c:if>
		</div>
		<form action="noticeWrite" method="post" enctype="multipart/form-data">
			<div id="qbd-main" class="qbd-main" style="height: auto;">
				<div class="qbd-mainbody" style="height: auto;">
					<div id="qbd-title" class="qbd-title" style="height: 80px;">
						<div class="qbd-title-content">
							<div class="col-8">						
								<span class="title-text">제목:<input type="text" name="title"></span>								
								<input type="hidden" value="${user1.user_num  }" name="user_num">
								<input type="hidden" value="${brd_md}" name="brd_md">
							</div>												
						</div>
						
							
					</div>
					<div class="qbd-line">
						<div class="qbd-line-box">
							<span class="qbd-line-box-text">작성자: ${user1.nick }</span>&nbsp;&nbsp;&nbsp;&nbsp;							
						</div>
						<!-- <div class="qbd-line-li"></div> -->
					</div>
					<hr class="custom-hr">
					<div class="container">
		    			<div class="row border" style="height: auto;">
		    				<div class="col-8 p-4 mt-4" >
								<div class="qbd-content">
									<div class="qbd-content text"  id="test">													
										<span>
											<textarea rows="20" cols="50" name="conts"></textarea>
										</span>
									</div>						
								</div>						
								<input type="file" name="file1">								
							</div>   			
						</div>
					</div>
					<div class="col-4">
						<input type="submit" value="글쓰기" class="btn-danger btn-xxs">									
						<input type="button" value="취소" onclick="location.href='notice?brd_md=${brd_md}'" class="btn-danger btn-xxs">
					</div>		
					<hr class="custom-hr">				
				</div>
			</div>
		</form>
	</div>	

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>