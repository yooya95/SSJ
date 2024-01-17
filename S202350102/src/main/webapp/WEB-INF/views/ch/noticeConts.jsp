<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/qBoardDetail.css">
<style>
  .custom-hr {
    border: 1px solid #000; /* 기본 테두리 스타일 */
    border-width: 0 0 2px 0; /* 아래쪽 테두리만 두껍게 설정 */
  }
  
  #test{  
    min-height: 200px; /* 최소 높이를 200px로 설정 */    
    
  }
</style>

</head>
<body>	
	<div class="container section-mt">
			<div class="col-12 text-center">
				<c:if test="${noticeConts.brd_md == 105 }"><h3 class="mb-10">공지사항</h3></c:if>
				<c:if test="${noticeConts.brd_md == 106 }"><h3 class="mb-10">이벤트</h3></c:if>								
			</div>
			<div class="row">
				
				<div class="col-3">
				
					<nav class="mb-10 mb-md-0">
						<div class="list-group list-group-sm list-group-strong list-group-flush-x">
							<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=105">공지사항</a>
							<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=106">이벤트</a>							
						</div>
					</nav>			
					
				</div>
				<div class="col-9">
						<span class="title-text">${noticeConts.title }</span>
						<div class="row justify-content-center">
								<div class="col-3 text-center py-2">작성자: ${noticeConts.nick }</div>
								<div class="col-3 text-center py-2">작성일: <fmt:formatDate value="${noticeConts.reg_date }" pattern="yyyy-MM-dd"/></div>								
								<form action="noticeUpdateForm" onsubmit="return chk()" class="col-6 text-end">
									<input type="hidden" value="${noticeConts.brd_num  }" name="brd_num">
									<input type="hidden" value="${noticeConts.user_num  }" name="user_num">					
									<c:if test="${status_md==102 }">
										<input type="submit" value="수정" class="btn-danger btn-xxs">
										<input type="button" value="삭제" onclick="location.href='deleteNoticeForm?brd_num=${noticeConts.brd_num}'" class="btn-danger btn-xxs">											
									</c:if>
										<input type="button" value="목록" onclick="location.href='notice?brd_md=${noticeConts.brd_md}'" class="btn-danger btn-xxs">								
								</form>
						</div>
						<hr class="custom-hr">
						<div class="container">
			    			<div class="row border" id="test">
			    				<div class="col-12" >
									<c:if test="${not empty noticeConts.img }">
											<div class="col-12">
												<img alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/${noticeConts.img}" style="max-width: 400px">
											</div>
										</c:if>				
										<div>${noticeConts.conts }</div>
								</div>   			
							</div>
						</div>
						<hr class="custom-hr">				
				</div>
			</div>
	</div>
	
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>