<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 조회</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<script type="text/javascript">
	// 유저 탈퇴 함수
	function fn_delCheck(user_num, delete_yn, pageNum, keyword){
		location.href = "/delUserByAdmin?user_num="+user_num+"&delete_yn="+delete_yn+"&pageNum="+pageNum+"&keyword="+keyword
	}
</script>
</head>
<body>
<section class="pt-7 pb-12">
 	<div class="container section-mt">
	 	
	 	<!-- TITLE  -->
	 	<div class="col-12 text-center">
				<h3 class="mb-10">회원 관리</h3>
	    </div>
	    
		<div class="row">
		<%@ include file="../jh/adminSidebar.jsp" %>
			<div class="col-10">
				<table class="table table-bordered table-sm mb-0">
				    <tr>
				      <th scope="row" class="table-secondary">레벨 / 경험치</th>
				      <td>LV.${user1.user_level } / ${user1.user_exp } point</td>
				      <th rowspan="3" class="table-secondary">사진</th>
					  <td rowspan="3">
			  			  <c:if test="${user1.img != null}">
		                  	<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${user1.img}" alt="userImg" style="width: 80%; height: 150px; border-radius: 10px;" >
		                  </c:if>
		                  <c:if test="${user1.img == null}">
		                  	<img class="card-img-top" src="${pageContext.request.contextPath}/upload/뤂다방.png" alt="userDfault" style="width: 80%; height: 150px; border-radius: 10px;">
		                  </c:if>
					  </td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">아이디</th>
				      <td>${user1.user_id }</td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">이름</th>
				      <td>${user1.user_name }</td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">닉네임</th>
				      <td>${user1.nick }</td>
				      <th class="table-secondary">회원상태</th>
				      <c:if test='${user1.status_md == 100 }'><td>일반 회원</td></c:if>
				      <c:if test='${user1.status_md == 101 }'><td>멤버쉽 회원</td></c:if>
				      <c:if test='${user1.status_md == 102 }'><td>관리자</td></c:if>
				      <c:if test='${user1.status_md == 103 }'><td>블랙리스트</td></c:if>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">이메일</th>
				      <td colspan="3">${user1.email }</td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">생년월일</th>
				      <td><fmt:formatDate value="${user1.birth }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
				      <th class="table-secondary">성별</th>
				      <c:if test="${user1.gender == 'F' }"><td>여자</td></c:if>
				      <c:if test='${user1.gender == "M" }'><td>남자</td></c:if>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">주소</th>
				      <td colspan="3">${user1.addr }</td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">전화번호</th>
				      <td colspan="3">${user1.tel }</td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">가입일자</th>
				      <td><fmt:formatDate value="${user1.reg_date }" pattern="yyyy년 MM월 dd일, HH시 mm분 ss초"></fmt:formatDate></td>
				      <th class="table-secondary">마지막 로그인</th>
				      <td><fmt:formatDate value="${user1.last_lgn_date }" pattern="yyyy년 MM월 dd일, HH시 mm분 ss초"></fmt:formatDate></td>
				    </tr>
				    <tr>
				      <th scope="row" class="table-secondary">탈퇴여부</th>
				      <td>${user1.delete_yn }</td>
				      <th class="table-secondary">탈퇴일자</th>
				      <td><c:if test="${user1.delete_yn == 'Y' }"><fmt:formatDate value="${user1.end_date }" pattern="yyyy년 MM월 dd일, HH시 mm분 ss초"></fmt:formatDate></c:if></td>
				    </tr>			    
				</table>
				<!-- 버튼  -->
				<div class="d-flex justify-content-start mt-5">
					<button class="btn btn-sm btn-dark mx-1" onclick="location.href='listUserAdmin?currentPage=${pageNum}&keyword=${keyword }'">목록</button>
					<button class="btn btn-sm btn-dark mx-1" onclick="location.href='updateUserFormAdmin?user_num=${user1.user_num }&pageNum=${pageNum}&keyword=${keyword }'">수정</button>
					<!-- 탈퇴여부에따라 보이는 버튼이 탈퇴 / 활성화로 바뀜  -->
					<c:if test="${user1.delete_yn == 'N' }">			      
						<button class="btn btn-sm btn-dark mx-1" id="delBtn" onclick="fn_delCheck(${user1.user_num},'${user1.delete_yn }', '${pageNum }', '${keyword }')">탈퇴</button>
					</c:if>
					<c:if test="${user1.delete_yn == 'Y' }">
						<button class="btn btn-sm btn-info mx-1" id="actBtn" onclick="fn_delCheck(${user1.user_num},'${user1.delete_yn }', '${pageNum }', '${keyword }')">활성화</button>
					</c:if>
				</div>	
				
			</div>
		</div>
		
			<div class="py-10"></div>
	</div>		
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>