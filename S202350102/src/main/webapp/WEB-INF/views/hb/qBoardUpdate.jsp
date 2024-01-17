<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/qBoardWrite.css?after">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/header4.jsp"/>
	<div class="container section-mt">
		<div class="row">
			<div class="col-12 text-center">
				<h3 class="mb-10"> 문의글 수정</h3>
			</div>
		</div>
		<form class="brd" action="qBoardUpdate" method="post" enctype="multipart/form-data">
			<input type="hidden" value="${board.brd_num  }" name="brd_num">
			<input type="hidden" value="${board.brd_md  }" name="brd_md">
			<input type="hidden" value="${board.img  }" name="img">
			<input type="hidden" value="${board.user_num }" name="user_num">
			<input type="hidden" name="brd_lg" value="400">
			<table class="brd-tb">
				<tr class="brd-title" style="background: #ccc;">
					<td>제목</td>
					<td><input type="text" maxlength="25" name="title" value="${board.title }" name="title" required="required"></td>
				</tr>
				<tr class="brd-line"></tr>
				<tr class="brd-option">
					<td style="background: #ccc;">파일</td>
					<td>
						<c:if test="${not empty board.img }">
				  			<img alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/qBoard/${board.img}" 
				      	   			 style="max-width: 100%; height: auto;">
						</c:if>
						<%@ include file="/WEB-INF/views/hb/test.jsp" %>
					</td>
					<td style="background: #ccc;">카테고리</td>
					<td style="background: #ccc;">
					    <select name="brd_md">
					        <option value="100" ${board.brd_md == 100 ? 'selected' : ''}>회원관련</option>
					        <option value="101" ${board.brd_md == 101 ? 'selected' : ''}>버그</option>
					        <option value="102" ${board.brd_md == 102 ? 'selected' : ''}>챌린지</option>
					        <option value="103" ${board.brd_md == 103 ? 'selected' : ''}>쉐어링</option>
					        <option value="104" ${board.brd_md == 104 ? 'selected' : ''}>팔로워</option>
					        <option value="105" ${board.brd_md == 105 ? 'selected' : ''}>기타/건의</option>
					    </select>
					</td>
				</tr>
				<tr class="brd-line"></tr>
				<tr class="brd-conts">
					<td>내용</td>
					<td><textarea style="background: #ccc;" id="conts" name="conts" required="required">${board.conts }</textarea></td>
				</tr>
				<tr class="brd-line"></tr>
				<tr class="brd-btn">
					<td colspan="2">
						<input type="submit" value="확인" id="submit">
						<input type="button" value="취소" onclick="location.href='qBoardDetail?brd_num=${board.brd_num}'">
					</td>
				</tr>
			</table>
		</form>
	</div>
<c:import url="/WEB-INF/views/footer.jsp"/>
</body>
</html>