<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/qBoardDetail.css"><c:param name="dt" value="${nowDate}"/></c:url>"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="js/jquery.js"></script>
<body>

<c:import url="/WEB-INF/views/header4.jsp"/>
	<i class="fa-sharp fa-light fa-image"></i>
	<div id="qbd-main" class="container section-mt">
		<div class="qbd-mainbody">
			<div id="qbd-title" class="qbd-title">
				<div class="qbd-title-content">
					<span class="title-text">${board.title }</span>
				</div>
				<div class="qbd-object text-end">
						<a href="qBoardUpdateForm?brd_num=${board.brd_num }">수정</a>
						<a href="javascript:void(0);" onclick="confirmDelete(${board.brd_num}, '${board.img}');">삭제</a>
						<a href="qBoardList?board=${board }">목록</a></p>
				</div>	
			</div>
				<div class="qbd-line-box">
					<span class="qbd-line-box-text">작성자: ${board.nick }</span>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qbd-line-box-text">작성일: <fmt:formatDate value="${board.reg_date }" pattern="yyyy-MM-dd"/></span>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qbd-line-box-text">카테고리: ${board.category }</span>
				</div>
			<div class="qbd-line">
				<div class="qbd-line-li"></div>
			</div>
				<!-- <div class="qbd-line-li"></div> -->
			</div>
			
			<div class="qbd-content">
				<div class="qbd-content text">
					<span><c:if test="${board.img != null }"><img alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/qBoard/${board.img}"><p></c:if>${board.conts }</span>
				</div>

			</div>
			<div class="qbd-line">
				<div class="qbd-line-li"></div>
			</div>
			<div class="qbd-rp">
				<div class="qbd-rp-write">
					<form  name="boardTrans"   id="boardTrans">
					    <input type="hidden"  id="brd_num"  name="brd_num" value="${board.brd_num }">
					    <input type="hidden"  id="img"  name="img" value="${board.img }">
					    <input type="hidden"  id="brd_md" 	 name="brd_md" value="${board.brd_md }">
					    <input type="hidden"  id="brd_group"  name="brd_group" value="${board.brd_num }">
					    <textarea rows="3" cols="50" maxlength="200" name="conts" id="conts" placeholder="댓글을 입력하세요." wrap="on" required="required"></textarea><p>
						<input type="button" value="입력" onclick="commentWriteBtn()">
					</form>
				</div>
				<div class="qbd-rp-list">
					<ul class="qbd-rp-group" id="qBoardCommentList">
					</ul>
				</div>
			</div>			
		</div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		qBoardCommentList();
	})
	
	function qBoardCommentList() {
	    var brd_group = ${board.brd_group};
	    $.ajax({
	        url: "qBoardCommentList",
	        type: "GET",
	        data: {
	            brd_group: brd_group
	        },
	        dataType: "json",
	        success: function (data) {
	            var qBoardCommentList = $('#qBoardCommentList');
	            qBoardCommentList.empty();
	            console.log(data);

	            for (var i = 0; i < data.length; i++) {
	                var commentList = data[i];
	                var isEditable = ${sessionScope.user_num} === commentList.user_num || ${user1.status_md} == 102;
	                var commentItem = $("<li>", { class: "comment_item", id: `comment${i}` });
	                var span = $("<span>", { id: "data-conts", text: commentList.conts, class: "comment_item-text" });
	                var commentInfo = $("<div>", { class: "comment_info" });
	                var img = $("<img>", {
	                    title: `Lv.`+commentList.user_level+` | exp.`+commentList.user_exp+`(`+commentList.percentage+`%)`,
	                    src: `/images/level/`+commentList.icon+`.gif`
	                });
	                
					var formatDate = new Date(commentList.reg_date);
					var day = formatDate.getDate();
					var month = formatDate.getMonth()+1;
					var hours = formatDate.getHours()+9;
					var minutes = formatDate.getMinutes();
					day = (day < 10) ? '0'+day : day;
					month = (month<10) ? '0'+month : month;
					hours = (hours < 10) ? '0' + hours : hours;
					minutes = (minutes < 10) ? '0' + minutes : minutes;
					var commentDate = month+"-"+day+" "+hours+":"+minutes;
	                
	                commentInfo.append(img, commentList.nick, "&nbsp;&nbsp;"+commentDate);

	                if (isEditable) {
	                    var btnUpdate = $("<button>", {
	                        id: "commentUpdate",
	                        "data-user-num": commentList.user_num,
	                        "data-brd-num": commentList.brd_num,
	                        text: "수정"
	                    });

	                    var btnDelete = $("<button>", {
	                        id: "commentDelete",
	                        "data-user-num": commentList.user_num,
	                        "data-brd-num": commentList.brd_num,
	                        text: "삭제"
	                    });

	                    commentInfo.append(btnUpdate, btnDelete);
	                }

	                commentItem.append(span, commentInfo);
	                qBoardCommentList.append(commentItem);
	            }
	        }
	    });
	}

	
	
// 댓글작성
	function commentWriteBtn() {
		  // 댓글 내용 가져오기
		  var commentContent = $('#conts').val();

		  // 댓글 내용이 비어 있는지 확인
		  if (commentContent.trim() === '') {
		    alert('댓글 내용을 입력하세요.');
		    return; // 댓글 내용이 비어있다면 함수 종료
		  }
	
		var brd_group = ${board.brd_group};
		var sendData =  $('#boardTrans').serialize();
		$.ajax({
			url: 'qBoardCommentWrite',
			type: 'POST',
			data: sendData,
			dataType: 'json',
			success: function(response) {
				if( response.result > 0) {
					console.log("response: ", response);
					qBoardCommentList();
					$('#conts').val('');
				}
			}
			
		})		
	}
	
	// 엔터 키 입력 시 댓글 작성 함수 호출
	$('#conts').keyup(function (e) {
	  if (e.which === 13 && !e.shiftKey) { // 엔터 키 코드이면서 쉬프트 키가 눌리지 않았을 때
	    e.preventDefault(); // 기본 엔터 동작 제거
	    commentWriteBtn(); // 댓글 작성 함수 호출
	  }
	});

	// 댓글삭제
	$(document).ready(function () {
	    $(document).off('click', '#commentDelete');
	    $(document).on('click', '#commentDelete', function () {
	        var commentList = $(this).closest('li');
	        var brd_num = $(this).data('brd-num');
			
	        var confirmDelete = confirm("이 댓글을 정말 삭제하시겠습니까?");
	        
	        if (confirmDelete) {
		        $.ajax({
		            url: 'qBoardCommentDelete',
		            type: 'DELETE',
		            data: {brd_num:brd_num},
		            dataType: 'json',
		            success: function (result) {
		            	qBoardCommentList();
		                if (result.result == "success") {
		                    console.log("삭제성공");
		                } else {
		                	console.log("삭제실패");
		                }
		            }
		        });
	        }
	    });

		// 댓글수정
	    $(document).off('click', '#commentUpdate');
	    $(document).on('click', '#commentUpdate', function () {
	        var commentList = $(this).closest('li');
	        var user_num = $(this).data('user-num');
	        var brd_num = $(this).data('brd-num');

	        var originalContent = commentList.find('span').text(); // input hidden하고 textarea 밸류 받자
	        var inputField = $('<textarea wrap="on" rows="5" cols="50" maxlength="200" class="updateArea">' +originalContent+ '</textarea>' /* { type: 'text', value: originalContent } */);
	        commentList.find('span').replaceWith(inputField);

	        var saveButton = $('<button type="button" class="saveBtn" data-user-num="' + user_num + '" data-brd-num="' + brd_num + '">저장</button>');
	        var cancelButton = $('<button type="button" class="cancelBtn" data-user-num="' + user_num + '">취소</button>');
	        commentList.append(saveButton, cancelButton);

	        commentList.find('#commentUpdate, #commentDelete').hide().prop('disabled', true);

	        $(document).off('click', '.saveBtn');
	        $(document).on('click', '.saveBtn', function () {
	            var updateContent = commentList.find('textarea').val();
	            $.ajax({
	                url: 'qBoardCommentUpdate',
	                type: 'POST',
	                data: {
	                    brd_num: brd_num,
	                    conts: updateContent
	                },
	                dataType: 'json',
	                success: function (result) {
	                    if (result.result == "success") {
	                        qBoardCommentList();
	                    } else {
	                        alert("수정실패..");
	                        qBoardCommentList();
	                    }
	                }
	            });
	        });

	        $(document).off('click', '.cancelBtn');
	        $(document).on('click', '.cancelBtn', function () {
	            qBoardCommentList();
	        });
	    });
	});

	function confirmDelete(brd_num, img) {
	    var result = confirm("게시글을 삭제하시겠습니까?");
	    if (result) {
	        window.location.href = "qBoardDelete?brd_num=" + brd_num+"&img="+img;
	    } else {
	    }
	}
	
	// textarea 줄바꿈 제한
	$(document).on('keydown', 'textarea', function() {
	    var rows = $(this).val().split('\n').length;
	    var maxRows = 6;
	    if (rows > maxRows) {
	        var modifiedText = $(this).val().split("\n").slice(0, maxRows);
	        $(this).val(modifiedText.join("\n"));
	    }
	});

</script>
</body>
<c:import url="/WEB-INF/views/footer.jsp"/>
</html>