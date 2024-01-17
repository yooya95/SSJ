<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		
				<!-- Close -->
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				<i class="fe fe-x" aria-hidden="true"></i>
				</button>
				
				<!-- Content -->
				<div class="container-fluid px-xl-0">
					<div class="row align-items-center mx-xl-0">
						       	
						<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
						            <!-- Image 수정 모달창 인증샷 -->
							<c:if test="${not empty board.img }">
								<img class="img-fluid" alt="수정 모달창 인증샷" id="updateImage" src="${pageContext.request.contextPath}/upload/${board.img}">
							</c:if>
						</div>
						
						<div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
							<!-- 수정 Form -->
							<form action="chCertBoardUpdate" method="post" enctype="multipart/form-data">
								<input type="hidden" name="brd_num"	 value="${board.brd_num }">
								<input type="hidden" name="nick" 		id="editNick">
								<input type="hidden" name="chg_id" 	value="${board.chg_id }">
								            
								
								                 
								                 
								<div class="col-12 col-md-6">
								               <!-- 유저 닉네임 표시하는 란 Name -->
									<div class="form-group">
										<p class="mb-2 fs-lg fw-bold" id="displayNick">${board.nick }
										</p>
									</div>
								</div>
								 
								<!-- Header -->
								<div class="row mb-6"><!--  -->
									<div class="col-12"><!--  -->
										<!-- Time -->
										<span class="fs-xs text-muted">
										<time datetime="2019-07-25" id="displayReg_date"></time>
									</span>
									</div>
								</div>
								      
								
								<div class="col-12"><!--  -->
									<!-- Email -->
									<div class="form-group"><!--  -->
										<label class="form-label" for="accountEmail">
											제목 *
										</label>
										<input class="form-control form-control-sm" id="editTitle" name="title" type="text" value="${board.title }" required>
									</div>
								</div>
								
								<div class="col-12">
									<!-- Email -->
									<div class="form-group">
										<label class="form-label" for="accountEmail">
										인증글 *
										</label>
										<textarea class="form-control form-control-sm" id="editConts" name="conts" rows="4"required>
											 ${board.conts }
										</textarea>
									</div>
								</div>
								
								<div class="row">
									<div class="col-12 text-center">
										<!-- 파일 변경 -->
										<div class="input-group mb-3">
											<label class="input-group-text" for="inputGroupFile01">파일 변경</label>
											<input type="file" name="editFile" class="form-control" id="inputGroupFile01">
										</div>
										<!-- 인증 글쓰기에서 가져온 글 수정 Form 등록 Button -->
										<!-- onclick(보류) 대신 form으로 작동시킴 --> 
										<button class="btn btn-outline-dark" type="submit" onclick="updateCertBoard()">
										수정하기
										</button>
									</div>
								</div>
								    
							</form>
						
						
						
						</div><!-- <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"> -->
					  
					</div><!-- <div class="row align-items-center mx-xl-0"> -->
				</div><!-- <div class="container-fluid px-xl-0"> -->
			
	
</body>
</html>