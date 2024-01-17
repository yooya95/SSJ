<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/level.css">
</head>
<body>

       	<button id="modalOpenBtn">경험치 정보</button>
		<div id="modal">
			<div class="hidden" id="modalContainer">
				<div id="modalContent">
					<button id="modalCloseBtn">X</button>
					<div class="user_info">
						<div class="userInfoBox1">
							<img id="user_icon" alt="user_icon" src="images/level/${user1.user_level }.gif">
							<span id="user_level">
								<label>${user1.nick }님</label>
								<label>현재 레벨 : ${user1.user_level }</label> 
							</span>
						</div>

						<div class="progress" style="height: 50px">
							<div class="progress-bar" role="progressbar" style="width: ${user1.percentage}%;">${user1.percentage}%</div>
						</div>
						<div class="userInfoBox2">
							<span class="user_exp">
								<label>현재 경험치 ${user1.user_exp }</label>
							</span>
							<span class="remain_exp">
								<label>남은 경험치 ${user1.remain_exp }</label>
							</span>
						</div>

					</div>
					<button id="levelInfoBtn">레벨표 보기</button>
					<div class="hidden" id="level_info_container">
						<table border="1" style="width:500px;">
							<thead>
								<tr>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">레벨</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">아이콘</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">경험치</span></span></td>
									<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">설명</span></span></td>
								</tr>
							</thead>	
							<c:forEach var="level" items="${level1List }">
								<tbody>
									<tr>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.user_level }</span></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><img alt="${level.user_level }" src="/images/level/${level.lv_name }.gif"></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.tot_exp }.Exp</span></span></td>
										<td style="text-align: center;"><span style="font-family:굴림,Gulim,sans-serif;"><span style="font-size:16px;">${level.lv_name }레벨</span></span></td>
									</tr>
								</tbody>
							</c:forEach>
						</table>			
					</div>
				</div>
			</div>
		</div>

	
	
	
	
	
<script type="text/javascript">
	const modalOpenBtn = document.getElementById('modalOpenBtn');
	const modalCloseBtn = document.getElementById('modalCloseBtn');
	const modal = document.getElementById('modalContainer');
	const levelInfoContainer = document.getElementById('level_info_container');
	
	modalOpenBtn.addEventListener('click', () => {
	    modal.classList.remove('hidden');
	});
	
	modalCloseBtn.addEventListener('click', () => {
	    modal.classList.add('hidden');
	    levelInfoContainer.classList.add('hidden'); // 모달이 닫힐 때 level_info도 숨김
	});
	
	const levelInfoBtn = document.getElementById('levelInfoBtn');
	
	levelInfoBtn.addEventListener('click', () => {
	    levelInfoContainer.classList.toggle('hidden'); // 보이기/숨기기 전환
	});

</script>
</body>
</html>