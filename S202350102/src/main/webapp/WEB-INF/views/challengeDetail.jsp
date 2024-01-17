<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	
	    <!-- Title -->
	    <title>챌린지 상세</title>
		
		<!-- jQuery 라이브러리를 불러옵니다. -->
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
			
			function certBoard() {
				
				var Data = {};
				// alert("certBoard");
				$.ajax(
						{
							type:"POST",
							url:"certBoard",
							data: Data,
							dataType:"json",
							
							success:function(result) {
								// alert("success ajax Data ->" +result);
									
								if(result.status == "OK") {
									
									// 데이터를 화면에 표시할 HTML 요소를 선택
									var table = $('#boardCertTable');
									// alert("success ajax table ->" +table);
									
									// 결과에서 글 목록을 순회하면서 HTML을 생성
									var html = "";
									result.boardCert.forEach(function (item) {
										
										html += "<tr><td>" + item.user_num + "</td><td>" + item.conts + "</td></tr>";
									});
									
									// 생성한 HTML을 테이블에 추가	// text, value, html 세 가지 메소드
									table.html(html);
									
								} else {
									console.log("조회 실패");
								}
							}
						}
						);	
			}
			
			
			function writeCertBoard() {
				
				alert("writeCertBoard Start");
				
				// 사용자가 입력한 내용 가져오기
				var paramData = {
								"conts"		: $('#content').val(),
								"chg_Id"	: $('#chg_id').val(),
								"user_num"	: $('#user_num').val()
				};
				console.log("paramData -> ", paramData);
				//alert("paramData -> "+paramData);
				alert("paramData $('#content').val() -> "+$('#content').val());
				alert("paramData $('#chg_id').val() -> "+$('#chg_id').val());
				alert("paramData $('#user_num').val() -> "+$('#user_num').val());
				
					
				/* 아니면 content만 빠졌는지 확인할 지 고민
				if(paramData.content.trim() == "") {
					alert("내용을 입력하세요");
					return;
				}
				*/
				
				// 서버로 데이터 전송
				$.ajax({
					url		:"/writeCertBoard",
					type	:"POST",
					data	:paramData,
					dataType:"text",
					success	:function(rtnStr) {
						alert("success ajax Data ->" +rtnStr);
						// 서버 응답을 처리하는 코드
						},
					error: function() {
						// Ajax 요청 자체가 실패한 경우
						alert("error: 글 등록에 실패했습니다.");
					}
				});
			}
		
		</script>
	</head>
	<body>
	<c:import url="/WEB-INF/views/header3.jsp"/>
	<h1>챌린지 상세</h1>
		<div>
			<section data-role="챌린지-상세-게시판">
				<section data-role="챌린지-게시판-글쓰기">
				
				</section>
				<!-- Ajax로 가져온 데이터를 표시할 테이블 -->
				<input type="button" onclick="certBoard()" value="인증 게시판"><p>
				글 작성             :<input type="text" id="content" placeholder="글을 작성해주세요" required="required">
				챌린지 등록 번호:<input type="text" id="chg_id" placeholder="챌린지 등록 번호" required="required">
				회원 번호          :<input type="text" id="user_num" placeholder="회원 번호" required="required">
				<input type="button" onclick="writeCertBoard()" value="글쓰기 등록">
				<table id="boardCertTable">
					<tr>
						<th>제목</th>
						<th>내용</th>
					</tr>
				</table>
				
			</section>
		</div>
	<c:import url="/WEB-INF/views/footer.jsp"/>
	</body>
</html>