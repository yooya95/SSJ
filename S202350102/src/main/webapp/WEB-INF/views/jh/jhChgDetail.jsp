<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    .list-group-horizontal-sm .list-group-item {
        border: none /* 테두리 없애기 */
    }
</style>
<title>챌린지 상세 페이지</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<script type="text/javascript">
/* 	//jh 작성 -> 보류(챌린지 후기 10개 이상 쓰고 다시 해보기)
 * 일단 리뷰에만 적용되게 하고 추후에 변경하기 1페이지 누르면 아래 적용 안됨
 */
 	$(document).ready(function() {
 			//jh작성
	        var tap = $("#reviewCurrentPage").val();
	        //alert("tap -> " + tap);
	        if (tap == 3) {
					var targetElement = $('.nav-link');
					if(targetElement.length > 0) {
						 $('html, body').animate({
			                    scrollTop: targetElement.offset().top +1000
			                }, 500);
					}

					// 현재 active 클래스가 있는 요소를 찾아서 제거
					document.getElementById('descriptionNav')?.classList.remove('active');
					document.getElementById('descriptionTab')?.classList.remove('active', 'show');
/* 					document.querySelector('.nav-link.active')?.classList.remove('active');
					document.querySelector('.tab-pane.fade.show.active')?.classList.remove('active', 'show'); */

					// 새로운 active 클래스를 추가할 요소들을 찾아서 추가
					document.getElementById('reviewNav')?.classList.add('active');
					document.getElementById('reviewTab')?.classList.add('active', 'show');
	        } 
	            
	        
	}); 

	// yr 작성	
	// 챌린지 신청
	function cJoin() {
		var sendData = $('#cJoinForm').serialize();	// user_num=?&chg_id=?
		// alert("sendData -> " + sendData);
		
		$.ajax({
			url: "/chgJoinPro",
			type : "POST",
			data : sendData,
			dataType : 'json',
			success : function(joinResult) {
				if(joinResult.chgJoin > 0) {
					$('#inputParti').text(joinResult.nowChgParti);
					$('#joinBtn').text("참여완료").removeClass("btn-danger").addClass("btn-secondary");
					// 참여 완료 modal
					document.getElementById('chgResultModalClick').click();
				}
			},
			error : function() {
				alert("참여 오류");
			} 		
		});
	}

	// 유저 닉네임 클릭 시 modal 창 띄우기
	function userInfoModal(tap, index) {
		// 모달창에 넘겨줄 값을 저장 
		var user_num, user_nick, user_img, user_level, user_exp, percentage, icon;

		if(tap == '인증') {
			user_num 	= $("#user_num" 	+ index).val();
			user_nick 	= $("#nick" 		+ index).val();
			user_img 	= $("#user_img" 	+ index).val();
			user_level 	= $("#user_level" 	+ index).val();
			user_exp 	= $("#user_exp" 	+ index).val();
			percentage 	= $("#percentage" 	+ index).val();
			icon 		= $("#icon" 		+ index).val();
		} else if(tap == '소세지들') { 
			user_num 	= $("#ssjUserNum" 	+ index).val();
			user_nick 	= $("#ssjNick" 		+ index).val();
			user_img 	= $("#ssjImg" 		+ index).val();
			user_level 	= $("#ssjUserLevel" + index).val();
			user_exp 	= $("#ssjUserExp" 	+ index).val();
			percentage 	= $("#ssjPercentage"+ index).val();
			icon 		= $("#ssjIcon" 		+ index).val();
		} else {	// tap == '후기'
			user_num 	= $("#reviewUserNum" 	+ index).val();
			user_nick 	= $("#reviewNick" 		+ index).val();
			user_img 	= $("#reviewImg" 		+ index).val();
			user_level 	= $("#reviewUserLevel"  + index).val();
			user_exp 	= $("#reviewUserExp" 	+ index).val();
			percentage 	= $("#reviewPercentage" + index).val();
			icon 		= $("#reviewIcon" 		+ index).val();
		}
		
		// DB에 있는지 존재 유무 체크
		$.ajax({
			url : "/followingCheck",
			type : "POST",
			data:{following_id : user_num},
			dataType : 'json',
			success : function(followingCheck) {
				if(followingCheck.fStatus > 0) {
					$("#follow").removeClass("btn-danger");
					$("#follow").addClass("btn-light");
 					$("#follow").text("팔로잉");
				} else {
					$("#follow").removeClass("btn-light");
					$("#follow").addClass("btn-danger");
					$("#follow").text("팔로우");
				}
			},
			error : function() {
				alert("팔로우 오류");
			}

		});

		// userShowModal 모달 안의 태그 -> 화면 출력용  <span> <p> -> text
		$('#displayUserNick').text(user_nick);
		$('#displayUserImg').attr('src', '${pageContext.request.contextPath}/upload/' + user_img);
		$('#displayUserLevel').attr('title', 'Lv.' + user_level + ' | exp.' + user_exp + '(' + percentage + '%)').attr('src', '/images/level/' + icon + '.gif');
		
		// userShowModal 모달 안의 태그 input Tag -> Form 전달용		<input> -> <val>
		$('#inputUserNum1').val(user_num);	// following()
		$('#inputUserNum2').val(user_num);	// sendMessage()

		// 모달 창 표시
		$('#userShowModal').modal('show');
	}

	// 팔로우 하기 버튼
	function following() {
		var sendData = $('#followingForm').serialize();	// user_num=?

		$.ajax({
			url : "/followingPro",
			type : "POST",
			data : sendData,
			dataType : 'json',
			success : function(followResult) {

				if(followResult.following > 0) {
					$("#follow").removeClass("btn-danger");
					$("#follow").addClass("btn-light");
					$("#follow").text("팔로잉");
				} else if(followResult.following == 0) {
					$("#follow").removeClass("btn-light");
					$("#follow").addClass("btn-danger");
					$("#follow").text("팔로우");
				} else {
					alert("자신의 계정은 팔로우 할 수 없습니다");
				}
			},
			error : function() {
				alert("팔로우 오류");
			}

		});
		
	}

	// 챌린지 찜하기
	function chgPick(p_index) {
		// var chg_id = p_chg_id;
		// alert("chg_id -> " + chg_id);

		$.ajax({
			url : "/chgPickPro",
			type : "POST",
			data : {chg_id : p_index},
			dataType : 'json',
			success : function(chgPickResult) {
				if(chgPickResult.chgPick > 0) {
					$("#chgPick").removeClass("btn-outline-dark").addClass("btn-dark");
					alert("찜 성공");
				} else {
					$("#chgPick").removeClass("btn-dark").addClass("btn-outline-dark");
					alert("찜 취소");
				}
				$("#inputPickCnt").text(chgPickResult.chgPickCnt);

			},
			error : function() {
				alert("찜하기 오류");
			}
		});
	}
	
	// 좋아요 버튼
	function likePro(p_index) {
		var brd_num = $('#brd_num' + p_index).val();

		$.ajax({
            url: "/likePro",
            type: "POST",
            data: { brd_num: brd_num },
            dataType: 'json',
            success: function (likeResult) {
            	if (likeResult.likeProResult > 0) {
					// 좋아요 insert
					$('#likeBtn' + p_index).attr('src', '/images/yr/heart-fill.png');

				} else {
					// 좋아요 delete
					$('#likeBtn' + p_index).attr('src', '/images/yr/heart.png');
				}
            	// 좋아요 수 실시간 반영
            	$('#inputLikeCnt' + p_index).text(likeResult.brdLikeCnt);
            },
            error: function () {
                alert("좋아요 에러");
            }
        });
	}


	// 쪽지보내기 버튼
	function sendMessage() {
		var sendData = $('#sendMessageForm').serialize();	// user_num=?
		alert("sendDate -> " + sendData);
	}
  
  
	// bg 작성
	function writeCertBrd() {
		
		//alert("writeCertBrd Start");
		
		// EL값을 JavaScript 변수에 저장
		var user_num = ${user.user_num};
		// chg_id 챌린지 페이지 아직 없어서 임시용으로 변수에 저장함
		//var chg_id = 1;
		var chg_id = ${chg.chg_id};
		
		// 이미지 파일 선택
		var screenshot = $("#screenshot")[0].files[0];
		
		
		// 이미지 파일, 제목, 내용을 FormData 에 추가
		var formData = new FormData();
		formData.append("title", $('#title').val());
		formData.append("conts", $('#conts').val());
		formData.append("chg_id", chg_id);
		formData.append("user_num", user_num);
		formData.append("screenshot", screenshot);
		
		
		// 사용자가 입력한 내용 가져오기 -> ver.1:  이미지도 전달해야 해서 보류
		//var paramData = {
		//					"title"	:	$('#title').val(),
		//					"conts"	:	$('#conts').val(),
		//					"chg_id":	chg_id,
		//					"user_num":	user_num
		//};
		
		// alert("paramData $('#title').val() ->"+$('#title').val());
		// alert("paramData $('#conts').val() ->"+$('#conts').val());
		// alert("paramData chg_id ->"+chg_id);
		// alert("paramData user_num ->"+user_num); 
		
		// 서버로 데이터 전송
		$.ajax({
			url	:	"/writeCertBrd",
			type:	"POST",
			data:	formData,
			dataType:'text',
			processData: false,		// 이미지 파일 처리를 위해 false로 설정
			contentType: false,		// 이미지 파일 처리를 위해 false로 설정
			success:function(data){
				// alert(".ajax writeCertBrd->"+data); 
				if (data == '1') {
					// 성공하면 아래라인 수행 
					alert("입력성공");
				}
			},
			error: function() {
				// Ajax 요청 자체가 실패한 경우
				alert("error: 글 등록에 실패했습니다");
			}
		});
	}
	
	
	
	//  '수정', '더보기' 버튼 클릭 시    ->   글 수정용, 더보기용 모달 창 열기
	function updateModalCall(type, index) {
		
		// alert("updateModalCall Start...");
		
		// 모달창에 넘겨줄 값을 저장 
		var brd_num		=	$("#brd_num"+index).val();  		
		var nick		=	$("#nick"+index).val();  		
		var reg_date	=	$("#reg_date"+index).val();  
		var title		=	$("#title"+index).val();  
		var conts		=	$("#conts"+index).val();  
		var img			=	$("#img"+index).val();  
		var brd_step	=	$("#brd_step"+index).val();
		var user_img	=	$("#user_img"+index).val();

		// alert("img -> " + img);
		// alert("${pageContext.request.contextPath}/upload/"+img);
		
		/*
			 alert("updateModalCall nick -> "+nick);
		 alert("updateModalCall reg_date -> "+reg_date);
		 alert("updateModalCall title -> "+title);
		 alert("updateModalCall conts -> "+conts); 
		 */
		 
		// 이미지 설정
		$('#updateImage').attr('src', '${pageContext.request.contextPath}/upload/'+img);
		$('#moreImage').attr('src', '${pageContext.request.contextPath}/upload/'+img);
		$('#moerUserImg').attr('src', '${pageContext.request.contextPath}/upload/'+user_img);
		 
		//  글 수정 모달 창 안의 태그 -> 화면 출력용  <span> <p> -> text
		$('#displayNick').text(nick);     
		$('#moreNick').text(nick);
		
		$('#displayReg_date').text(reg_date); 
		$('#moreReg_date').text(reg_date);
		
		// 필요한 코드인지 재확인 필요
		$('#editImage').text(img);
		
		$('#moreTitle').text(title);
		$('#moreConts').text(conts);
		
		//   글 수정 모달 창 안의 태그 input Tag -> Form 전달용		<input> -> <val>
		$('#editBrd_num').val(brd_num);     
		$('#editNick').val(nick);     
		$('#editTitle').val(title);     
		$('#editConts').val(conts);    
		$('#editUserImg').attr('src', '${pageContext.request.contextPath}/upload/' + user_img); 
		
		
		if (type == 'edit') {
			$('#modalUpdateCertBrdForm').modal('show');
		}
		else $('#modalMoreCertBrdForm').modal('show');
		// 모달 창 표시
	}
	
	
	
	// 수정 시, 업로드 사진 변경할 수 있게
	function fileUpdate() {
		var fileInput = document.getElementById('fileInput');
		if(fileInput.style.display == "none") {
			fileInput.style.display = "block";
			fileInput.removeAttribute('disabled');
			$("#imgOroot").hide();
		} else {
			fileInput.style.display = "none";
			fileInput.setAttribute('disabled', 'true');
			$('#imgOroot').show();
		}
	}
	
	
	
	// '삭제' 버튼 클릭 시 -> 글과, 업로드 삭제
	function deleteCertBrd(type, index) {
		
		// 확인 및 취소 다이얼로그 표시
		var confirmed = confirm("정말 삭제하시겠습니까?");
		
		if(!confirmed) {
			// 사용자가 확인을 선택하지 않은 경우
			return;
		}
		
		// alert("type -> " + type);
		// Group 번호 가져오기

 	
	    var arr = new Array();
		var item;
		var idx = 0;
		
	 	<c:forEach items="${certBoard }" var="item" >	
	 		//alert("arr.title1->"+  ${list.title});
	    	// arr.push("${item.title}");
	    	
	    	arr.push({brd_num:"${item.brd_num }"
	    		     ,brd_group:"${item.brd_group}"
	    		     ,idx: idx
	    	});
	    	idx ++ ;
		</c:forEach>
		

		// var brd_num = $("#" + type + "brd_num"+index).val();
		// var img		= $("#" + type + "img"+index).val();
		
		var brd_num 	= $("#brd_num"+index).val();
		var img			= $("#img"+index).val();
		var brd_group	= $("#brd_group"+index).val();
		// alert("brd_num -> " + brd_num);
		// alert("img -> " + img);

		// alert("JSON.stringify(arr)->"+JSON.stringify(arr));

		$.ajax({
			url:"/brdNumDelete",
			data:{
					 brd_num	:	brd_num
				  	,img		:	img
				  	,brd_group	:	brd_group
			  	},
			dataType:'text',
			
			success:function(data){
				// alert(".ajax deleteCertBrd data -> "+data);
				
				if (data > '0') {
					// id 가 review +index 성공하면 아래 라인 수행
					if (type == 'review') {
						//$('#review'+index).remove();		/* Delete Tag */
						// 해당 brd_group 을 remove
						
						// 원글의 brd_group 가져오기
						var brd_group = arr[index].brd_group;
						// alert("삭제 대상 brd_num -> "+brd_num);
						
						// 댓글 그룹이 동일한 모든 댓글 삭제
						// 'comment'로 시작하는 모든 div 엘리먼트에 대해 아래의 코드를 실행
						for (var i=0; i<arr.length;i++){
							// 같은 댓글 그룹일 때 화면에서 삭제
							if (brd_num == arr[i].brd_group ) {
								//alert("arr.title2.brd_num->"+ i + " :  "+ arr[i].brd_num);
								/// alert("arr.title2.brd_group->"+ i + " :  "+ arr[i].brd_group);
								// alert("arr.title2.idx->"+ i + " :  "+ arr[i].idx);
								// 원글인지 댓글인지 판단하여 삭제
								if (arr[i].brd_num ==  arr[i].brd_group) {
									$('#review'+arr[i].idx).remove();
								} else {
									$('#comment'+arr[i].idx).remove();
								}
							}
									
						}
					} else $('#comment'+index).remove();	/* Delete Tag */
					//$("#" + type +index).remove();		
//					$('#review'+index).remove();		/* Delete Tag */
				}
			}
		});
	}
	
	
	// 찌르기 모달창 띄우기 
	// 		forkModalCall(${status.index}) 에서 올 때 index 입력 잊지 말기~! 
	function forkModalCall(index) { 
		 
		// 모달 창에 넘겨줄 값을 저장 
		var ssjUserNum = $("#ssjUserNum"+index).val(); 
		 
		// 찌르기 모달 창 안의 태그 
		$('#ssjUserNum').val(ssjUserNum); 
		 
		// 모달 창 표시 
		$('#modalfork').modal('show'); 
		document.getElementById('cheerUpMsg').placeholder = "안녕하세요!\n얼마 동안 활동이 뜸한 것 같아 걱정이 되네요\n함께 더 활발한 모습으로 돌아오기를 기대하고 있어요\n응원합니다!"; 
		 
	} 
	 
	 
	 
	// 찌르기 메일 보내기 
	function sendMail() { 
		
		 
		// EL값을 JavaScript 변수에 저장 
		// 실패:  
		var sendMailUser_num	= ${user.user_num}; 
		// alert("sendMailUser_num -> "+sendMailUser_num); 
		 
		// 넘겨줄 값을 저장 
		var ssjUserNum	= $("#ssjUserNum").val(); 
		var cheerUpMsg	= $("#cheerUpMsg").val(); 
		 
		 
		$.ajax({ 
			type:	"POST", 
			url:	"sendMail", 
			data:	{ 
				sendMailUser_num:	sendMailUser_num, 
				ssjUserNum:	ssjUserNum, 
				cheerUpMsg:	cheerUpMsg 
			},
			dataType:'text',
			success:	function (result) { 
				// 성공했을 때의 동작 
				alert("메일이 발송되었습니다");
				if(result == "1") {
				window.location.href = 'chgDetail?chg_id='+${chg.chg_id}; 
					
				}
			}, 
			error:		function () { 
				// 실패했을 때의 동작 
				alert("메일이 발송되지 않았습니다");
			} 
		}); 
		 
		
	} 
	
	
	
	function toggleCommentForm(index) {
		alert("toggleCommentForm Start...")
		var commentForm = document.getElementById("commentForm"+index);
		if (commentForm) {
			commentForm.classList.toggle("show");
		}
	}
	
	
	
	// 댓글 공백 체크
	function commentInsertchk(form) {
		form.conts.value = form.conts.value.trim();
		
		// 댓글 미입력시 체크
		if(form.conts.value.length == 0) {
			alert("댓글을 입력해주세요");
			form.conts.focus();
			return false;
		}
		// 댓글 입력시 실행
		return true;
	}
	
	
	document.addEventListener('DOMContentLoaded', function() {
		// 페이지 로드 시에 ${sortBy} 값에 따라 선택된 링크에 selected 클래스 추가
		var sortBy = "${sortBy}";
		var selectedLink = document.querySelector('#sortForm .sort-option[href*="${sortBy}"]');
		if (selectedLink) {
			selectedLink.classList.add('selected');
		}
	});
	
	
	
	// 인증 게시판 > 정렬
	function fn_sortBy() {
		var sortBy		= $('#sortBy').val();
		var chg_id		= ${chg.chg_id};
		
		// searchType 과 keyword 값이 존재하는 경우에만 추가
		var searchType	= '${searchType != null ? searchType : ''}';
		var keyword		= '${keyword != null ? keyword : ''}';
		
		location.href	= 'chgDetail?chg_id=' + chg_id
						+	(searchType ? '&searchType=' + searchType : '')
						+	(keyword ? '&keyword=' + keyword : '')
						+	'&sortBy=' + sortBy;
	}
	
	
	// 이전 블럭 이동
	function movePrevBlock() {
		var sortBy 	= 	$('#sortBy').val()
		var chg_id		= ${chg.chg_id}
		
		// searchType 과 keyword 값이 존재하는 경우에만 추가
		var searchType	= '${searchType != null ? searchType : ''}';
		var keyword		= '${keyword != null ? keyword : ''}';
		var pageNum		=	${certBrdPage.startPage - certBrdPage.pageBlock }

		location.href	= 'chgDetail?chg_id=' + chg_id
						+	(searchType ? '&searchType=' + searchType : '')
						+	(keyword ? '&keyword=' + keyword : '')
						+	'&sortBy=' + sortBy
						+	'&currentPage=' + pageNum;
	}
	
	// 다음 블럭 이동
	function moveNextBlock() {
		var sortBy 	= 	$('#sortBy').val()
		var chg_id		= ${chg.chg_id}
		
 		// searchType 과 keyword 값이 존재하는 경우에만 추가
		var searchType	= '${searchType != null ? searchType : ''}';
		var keyword		= '${keyword != null ? keyword : ''}';
		var pageNum		=	${certBrdPage.startPage + certBrdPage.pageBlock }

		location.href	= 'chgDetail?chg_id=' + chg_id
						+	(searchType ? '&searchType=' + searchType : '')
						+	(keyword ? '&keyword=' + keyword : '')
						+	'&sortBy=' + sortBy
						+	'&currentPage=' + pageNum;
	}
	
	
	// 인증 게시판 > 태우기 버튼 -> 로그인을 해야 (로그인 안했을 때 해라고 alert 창 또는 로그인 창 뜨게 할 지)
	function Burning(p_index) {
		
		
		var report_cnt	= $('#report_cnt' + p_index).val();
		var brd_num		= $('#brd_num' + p_index).val();
		var myBurning	= $('#myBurning' + p_index).val();
		
		// alert("report_cnt -> " + report_cnt);
		// alert("myBurning -> " + myBurning);
		
		var confirmationMsg = "이 글을 신고하시겠습니까? (+10°C)\n\n현재 신고 온도: " + report_cnt + "°C";
		var cancelBurningMsg = "신고를 취소하시겠습니까? (-10°C)\n\n현재 신고 온도: " + report_cnt + "°C";
		
		var isConfirmed;
		
		if (myBurning == 10) {
			isConfirmed = window.confirm(cancelBurningMsg);
		} else {
			isConfirmed = window.confirm(confirmationMsg);
			
		}
		
		if(isConfirmed) {
			
	         
	         $.ajax({
	             url:   "/Burning"
	            ,type:   "POST"
	            ,data:   { brd_num : brd_num}
	            ,dataType:   'json'
	            // dataType 이란, 서버로부터 받아올 응답 데이터의 타입
	            // -> 서버로 데이터를 전송할 때는 영향을 받지 X
	            ,success:   function (burningResult) {
	               // alert("태우기 성공"); -> 추후 취소 여부에 따라 다르게 alert 가 뜨도록 수정
	               location.reload();
	               
	            },
	            error:   function() {
	               alert("태우기 실패하였습니다");
	            }
	         });
			
		} else {
			return;
		}
		
	}
	
	
	
	
	

	
	
</script> 
</head>
<body>

    <!-- BREADCRUMB -->
    <nav class="py-5">
      <div class="container section-mt">
        <div class="row">
          <div class="col-12">

            <!-- Breadcrumb -->
            <ol class="breadcrumb mb-0 fs-xs text-gray-400">
              <li class="breadcrumb-item">
                <a class="text-gray-400" href="/thChgList?state_md=${chg.state_md }">챌린지</a>
              </li>
              <li class="breadcrumb-item">
                <a class="text-gray-400" href="/thChgList?state_md=${chg.state_md }&chg_lg=200&chg_md=${chg.chg_md }">${chg.ctn }</a>
              </li>
              <li class="breadcrumb-item active">${chg.title }
                	
              </li>
            </ol>

          </div>
        </div>
      </div>
    </nav>

<!-- PRODUCT -->
    <section>
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="row">
              <div class="col-12 col-md-6">

                <!-- Card -->
                <div class="card">

					
                  <!-- 인기 뱃지-->
                 <c:if test="${chg.pick_cnt >= 10 }">
			     	<div class="badge bg-primary card-badge text-uppercase">인기</div>
				 </c:if>
                                    <!-- 찜수  -->

                  <!-- Slider -->
                  <div class="mb-4">


                    <!-- Item -->
           		    <c:choose>
					    <c:when test="${chg.thumb == 'assets/img/chgDfaultImg.png'}">
							<img src="assets/img/chgDfaultImg.png" alt="챌린지 썸네일" class="card-img-top" >
					    </c:when>
					    <c:otherwise>
							 <img src="${pageContext.request.contextPath}/upload/${chg.thumb}" class="card-img-top" alt="챌린지 썸네일" >
					    </c:otherwise>
					</c:choose>
             <!--썸네일 처리 해야 함 파일 위치랑 null일 때 뜨게 할 것  -->
                  </div>
                </div>


              </div>
              <div class="col-12 col-md-6 ps-lg-10">

                <!-- Heading -->
                <h3 class="mb-2">${chg.title }</h3>
                
                
                <div class="col-12 col-md-6">


                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">개설자</li>
                    <li class="list-group-item">${chg.nick }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                      <li class="list-group-item">참여 인원</li>
                    <li class="list-group-item"><span id="inputParti">${chgrParti }</span> / ${chg.chg_capacity }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">진행 기간</li>
                    <li class="list-group-item"><fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"/> </li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">진행 상태</li>
                    <li class="list-group-item">${chg.stateCtn }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">인증 빈도</li>
                    <li class="list-group-item">${chg.freq }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">챌린지 찜</li>
                    <li class="list-group-item" id="inputPickCnt">${chg.pick_cnt }</li>
                  </ul> 
               </div>
               
				<div class="mb-7 d-flex justify-content-start">
					<!-- 참여하기 -->
					<!-- YR 작성 -->
					<div class="mx-1">
						<c:choose>
							<c:when test="${chg.stateCtn == '진행중'}">
					
								<c:choose>
									<c:when test="${sessionScope.user_num != null}">
									<!-- 로그인 한 상태 -->
										
										<c:choose>
											<c:when test="${chgrYN == 1 }">
												<!-- 이미 챌린지 참여함 -->
												<button type="button" class=" btn btn-secondary mb-2 btn-sm">
													참여완료
												</button>
												
											</c:when>
											
											<c:when test="${chg.chg_capacity == chgrParti }">
												<!-- 참여 정원 = 참가 인원 -->
												<button type="button" class=" btn btn-secondary mb-2 btn-sm">
													참여마감
												</button>
											
											</c:when>
											
											<c:otherwise>
												<button type="button" class=" btn btn-danger mb-2 btn-sm" data-bs-toggle="modal" data-bs-target="#chgJoin" id="joinBtn">
													참여하기
												</button>
											
												<div class="modal fade" id="chgJoin" tabindex="-1" aria-labelledby="exampleModalLabel"
													aria-hidden="true">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-body">
																<p>현재 참여 인원 : ${chgrParti } / 참여 정원 : ${chg.chg_capacity}</p>
																<p>${user.nick }님 챌린지에 참여하시겠습니까?</p>
																<div class="text-end">
																	<button type="button" class="btn btn-danger btn-xs"
																		onclick="cJoin()">참여하기</button>
																	<button type="button" class="btn btn-secondary btn-xs"
																		data-bs-dismiss="modal" aria-label="Close">취소하기</button>
																	<form id="cJoinForm">
																		<input type="hidden" name="user_num" value="${user.user_num}">
																		<input type="hidden" name="chg_id" value="${chg.chg_id}">
																	</form>
																</div>
															</div>
														</div>
													</div>
												</div>
												
											</c:otherwise>
										
										</c:choose>
					
					
									</c:when>
					
									<c:when test="${sessionScope.user_num == null}">
										<!-- 로그인 안 한 상태 -->
										<button type="button" class=" btn btn-danger mb-2 btn-sm" onclick="location.href='/loginForm'">
											참여하기
										</button>
									</c:when>
					
								</c:choose>
					
							</c:when>
					
							<c:otherwise>
								<button type="button" class="btn btn-secondary mb-2 btn-sm">
									챌린지 종료
								</button>
							</c:otherwise>
						</c:choose>
						
						<!-- 참여완료 YN -->
						<!-- 실제로 나타나는 버튼은 아님
							 modal 띄우기 위해 존재하는 버튼
							 hidden처리 되어있음 
						-->
						<button type="button" class="btn btn-danger mb-2" id="chgResultModalClick" data-bs-toggle="modal" data-bs-target="#chgResultModal" hidden>
							참여완료
						</button>
						
						<!-- 챌린지 참여 성공 -->
						<div class="modal fade" tabindex="-1" id="chgResultModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body">
										<p>챌린지 참여가 완료되었습니다</p>
										<div class="text-end">
											<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal" aria-label="Close">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					

					<!-- 찜하기 -->
					<!-- YR 작성 -->
					<div>

						<c:choose>
							<c:when test="${sessionScope.user_num != null}">
								<!-- 로그인 한 상태 -->
								<c:choose>
								
									<c:when test="${chgPickYN == 1}">
										<!-- 찜 기록 있을 때 -->
										<button class=" btn btn-dark mb-2 btn-sm" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick">
											챌린지 찜 <i class="fe fe-heart ms-2"></i>
										</button>	
									</c:when>

									<c:otherwise>
										<!-- 찜 기록 없을 때 -->
										<button class=" btn btn-outline-dark mb-2 btn-sm" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick">
											챌린지 찜 <i class="fe fe-heart ms-2"></i>
										</button>
									</c:otherwise>
								</c:choose>

							</c:when>
							
							<c:otherwise>
								<!-- 로그인 안 한 상태 -> 로그인 페이지로 이동 -->
								<button class=" btn btn-outline-dark mb-2 btn-sm" data-toggle="button" onclick="location.href='/loginForm'">
									챌린지 찜 <i class="fe fe-heart ms-2"></i>
								</button>
							</c:otherwise>

						</c:choose>

					</div>
				</div>
              
            </div>
          </div>
        </div>
      </div>
      </div>
    </section>



 <!-- DESCRIPTION -->
    <section class="pt-11">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Nav -->
            <div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
              <a class="nav-link active" id="descriptionNav" data-bs-toggle="tab" href="#descriptionTab">
               	 챌린지 정보
              </a>
              <a class="nav-link" id="certNav" data-bs-toggle="tab" href="#certBoardTab" >
                             인증 게시판
              </a>
              <a class="nav-link" id="ssgNav" data-bs-toggle="tab" href="#ssjFriendsTab">
                             소세지들
              </a>
              
              <!-- 일단 기본 활성화 상태로 두었다가 시간 남으면 챌린지 종료되면 활성화 되게 하기  -->
              <a class="nav-link" id="reviewNav" data-bs-toggle="tab" href="#reviewTab">
                             후기 게시판
              </a>
            </div>
			
            <!-- Content -->
            <div class="tab-content">
              <div class="tab-pane fade show active" id="descriptionTab">
                <div class="row justify-content-center py-9">
                <div class="col-12 col-lg-10 col-xl-8">
                <!-- 챌린지 소개 수정 -->
                 <div class="card mb-7">

	            
	
	                <!-- Heading -->
	                <div class="mt-1 mb-4">
	                	<h5>챌린지 소개</h5>
	                </div>
	                
	                <div>
		                <!-- Text -->
		                <p class="mb-8 text-gray-500">
		                 		${chg.chg_conts }
		                </p>
	                </div>
	                
		              <!-- Image -->
		              <img class="card-img-top mb-7" src="${pageContext.request.contextPath}/upload/${chg.sample_img }" alt="인증예시">
		
		              <!-- Body -->
		              <div class="card-body px-0">
		
	
	                <!-- Text -->
			        <div class="mt-1 mb-4">
	                	<h5>인증방법</h5>
	                </div>
              		 
	                <p class="mb-0 text-gray-500">
	                 		 ${chg.upload }
	                </p>
	
	                
					</div>
	              </div>
	
	            </div>
                
                 
                </div>
              </div>
              
            

            <!-- BG 인증 게시판 -->
            <div class="tab-pane fade" id="certBoardTab">
                <div class="row justify-content-center py-9">
                  <div class="col-12 col-lg-10 col-xl-8">
    			        <!-- Heading -->
		            <h4 class="mb-10 text-center">인증 게시판</h4>
		            
	            	<!-- 인증게시판 C -->
		            <c:choose>
		            	<c:when test="${certTotal == 0 }">
		            	<!-- 1. 인증글이 없을 때 -->
		            		<div class="text-center">
		            			<div class="mb-6 fs-1">🙁</div>
		            			<p>
		            				인증글이 없습니다. 첫 인증글을 올려주세요!
		            			</p>
		            			<c:choose>
				              		<c:when test="${chgrYN == 1 }">
				              			<!-- 1. 참여자일 경우 -->
						              	<!-- Button -->
						                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
					                		인증하기
					                	</a>
				              		</c:when>
				              		<c:when test="${user == null }">
				              			<!-- 2. 비로그인 -->
						              	<!-- Button -->
						                <a class="btn btn-sm btn-dark" href="/loginForm">
					                		인증하기
					                	</a>
				              		</c:when>
				              		<c:otherwise>
				              			<!-- 3. 로그인 했지만 참여자가 아닌 경우 -->
				              			<!-- Button -->
				              			<a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
					                		인증하기
					                	</a>
				              		</c:otherwise>
				              	</c:choose>
		            		</div>
		            		<!-- 새 인증글 -->
				            <div class="collapse" id="writeForm">
				              <!-- Divider -->
				              <hr class="my-8">
				              <!-- 인증 글쓰기 Form -->
				              <form id="certForm">
				              	<input type="hidden" id="chg_id" name="chg_id" value="${chg.chg_id }">
				                <div class="row">
					              <c:choose>
					              	<c:when test="${chgrYN == 1 }">
					              	<!-- 1. 참여자일 경우 -->
					                  <div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	
					              	<c:when test="${user == null }">
					              	<!-- 2. 비로그인 인터셉터 ing -->
										<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" >
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" ></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	<c:otherwise>
					              	<!-- 3. 참여자가 아닌 회원 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
					                      	등록
					                    </button>
					                  </div>
					              	</c:otherwise>
					                  
					              </c:choose>
				                </div>
				              </form>
				
				            </div>
		            	</c:when>
		            	<c:otherwise>
		            	<!-- 2. 인증글이 있을 때 -->
				            <!-- Header -->
				            <div class="row align-items-center">
				            
				            <c:if test="${user != null }">
				              <div class="col-12 col-md-auto">
						        <!-- 필터 조회 -->
				                <select class="form-select form-select-xs" id="sortBy" onchange="fn_sortBy()"> 
				                  <option value="newest"	<c:if test="${sortBy eq 'newest' }">	selected="selected"</c:if>>최신 순</option>
				                  <option value="oldest"	<c:if test="${sortBy eq 'oldest' }">	selected="selected"</c:if>>오래된 순</option>
				                  <%-- 보류 중 <option value="like"		<c:if test="${sortBy eq 'like' }">		selected="selected"</c:if>>좋아요 순</option> --%>
				                </select>
				              </div>
				              </c:if>
				              
				              <div class="col-12 col-md text-md-center">
				                <!-- Count 총 인증 수 -->
				                <strong class="fs-sm ms-2">Total ${certTotal }</strong>
				              </div>
				              
				              
				              <div class="col-12 col-md-auto">
				              	<c:choose>
				              	
				              		<c:when test="${chgrYN == 1 }">
				              			<!-- 1. 참여자일 경우 -->
						              	<!-- Button -->
						                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
					                		인증하기
					                	</a>
				              		</c:when>
				              		<c:when test="${user == null }">
				              			<!-- 2. 비로그인 -->
						              	<!-- Button -->
						                <a class="btn btn-sm btn-dark" href="/loginForm">
					                		인증하기
					                	</a>
				              		</c:when>
				              		<c:otherwise>
				              			<!-- 3. 로그인 했지만 참여자가 아닌 경우 -->
				              			<!-- Button -->
				              			<a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
					                		인증하기
					                	</a>
				              			
				              		</c:otherwise>
				              		
				              	</c:choose>
				              </div>
				              
				              
				            </div>
				            <!-- 새 인증글 -->
				            <div class="collapse" id="writeForm">
				
				              <!-- Divider -->
				              <hr class="my-8">
				
				              <!-- 인증 글쓰기 Form -->
				              <form id="certForm">
				              	<input type="hidden" id="chg_id" name="chg_id" value="${chg.chg_id }">
				                <div class="row">
				                  
					              <c:choose>
					              	<c:when test="${chgrYN == 1 }">
					              	<!-- 1. 참여자일 경우 -->
					                  <div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	
					              	<c:when test="${user == null }">
					              	<!-- 2. 비로그인 인터셉터 ing -->
										<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" >
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" ></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	
					              	<c:otherwise>
					              	<!-- 3. 참여자가 아닌 회원 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" id="title" type="text"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 인증글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
					                  <div class="mb-3">
					                  	<!-- 인증샷 -->
									  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
										<input class="form-control" type="file" id="screenshot" name="screenshot">
									  </div>
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
					                      	등록
					                    </button>
					                  </div>
					              	</c:otherwise>
					                  
					              </c:choose>
				                </div>
				              </form>
				
				            </div>
			            </c:otherwise>
		            </c:choose>
		
		
		            <!-- 인증글 게시판 R -->
		            <div class="mt-8">
		
		              <!--  여기부터 첫번째 인증글 -->
						<c:forEach var="certBoard" items="${certBoard }" varStatus="status">
			              	<c:choose>
			              		<c:when test="${certBoard.brd_step == 0 }">
			              		<!-- 1. 원글 -->
					              <div class="review" id="review${status.index}"><!--  -->
					              	<div class="review-body"><!--  -->
					              		<div class="row" id="certBoard${status.index}"><!--  -->
							              	<c:choose>
							              		<c:when test="${certBoard.report_cnt >= 100 }">
				                                   <div class="text-center">
				                                       <div class="mb-6 fs-1">🔥</div>
				                                       <p>
				                                           	다수의 사용자에 의해 다 탄 소시지의 글입니다
				                                       </p>
				                                   </div>
				                                </c:when>
				                                <c:otherwise>
				                                	<input type="hidden" id="brd_num${status.index}"		value="${certBoard.brd_num }">
								                  	<input type="hidden" id="nick${status.index}"			value="${certBoard.nick }">
								                  	<input type="hidden" id="reg_date${status.index}"		value="${certBoard.reg_date }">
								                  	<input type="hidden" id="title${status.index}"			value="${certBoard.title }">
								                  	<input type="hidden" id="conts${status.index}"			value="${certBoard.conts }">
								                  	<input type="hidden" id="img${status.index}"			value="${certBoard.img }">
								                  	<input type="hidden" id="brd_step${status.index}"		value="${certBoard.brd_step }">
			                                        <input type="hidden" id="brd_group${status.index}"  	value="${certBoard.brd_group }">
			                                        <input type="hidden" id="user_img${status.index}"		value="${certBoard.user_img}">
													<input type="hidden" id="user_num${status.index}"		value="${certBoard.user_num}">
			                                        <input type="hidden" id="like_cnt${status.index}"		value="${certBoard.like_cnt}">
			                                        <input type="hidden" id="report_cnt${status.index}"		value="${certBoard.report_cnt}">
			                                        <input type="hidden" id="myBurning${status.index}"		value="${certBoard.myBurning}">
			                                        <input type="hidden" id="user_level${status.index}"		value="${certBoard.user_level}">
			                                        <input type="hidden" id="user_exp${status.index}"		value="${certBoard.user_exp}">
			                                        <input type="hidden" id="percentage${status.index}"		value="${certBoard.percentage}">
			                                        <input type="hidden" id="icon${status.index}"			value="${certBoard.icon}">
							   						                  	
								                  	
								                  	<div class="col-5 col-md-3 col-xl-2">
														<!-- 인증샷 Image -->
								                    	<img src="${pageContext.request.contextPath}/upload/${certBoard.img }" alt="인증샷" class="img-fluid">
								                    </div>
								                    
								                    
								                    <div class="col-12 col-md">
								                    
														<!-- Avatar -->
														<a href="#" data-bs-toggle="modal" onclick="userInfoModal('인증', ${status.index})">
									                    	<div class="avatar avatar-lg">
															  <img src="${pageContext.request.contextPath}/upload/${certBoard.user_img}" alt="profile" class="avatar-img rounded-circle">
															</div>
														</a>
								                    
								                      <!-- Header -->
								                      <div class="row mb-6">
								                        <div class="col-12">
								                         	<!-- Time -->
								                         	<span class="fs-xs text-muted">
																<a href="#" data-bs-toggle="modal" onclick="userInfoModal('인증', ${status.index})">
																	<img title="Lv.${certBoard.user_level } | exp.${certBoard.user_exp}(${certBoard.percentage }%)" src="/images/level/${certBoard.icon}.gif">
																	<span style="color: black;">${certBoard.nick}</span>
																</a>
																<time datetime="2019-07-25">${certBoard.reg_date }</time>
															</span>
								                        </div>
								                      </div>
								                      
								
								                      <!-- Title -->
								                      <p class="mb-2 fs-lg fw-bold">
								                        ${certBoard.title }
								                      </p>
								
								                      <!-- Text -->
								                      <p class="text-gray-500">
								                      	${certBoard.conts }
								                      </p>
								                      
								
								                      <!-- Footer -->
								                      <div class="row align-items-center">
								                      
								                        <!-- Text -->
								                        <div class="col-auto me-auto">
								                        
									                        <!-- Rate -->
									                        <div class="rate">
																<c:choose>
																	<c:when test="${sessionScope.user_num != null }">
																		<!-- 로그인 한 상태 -->
																		<a class="rate-item" data-toggle="vote" role="button" onclick="likePro(${status.index})">
																			좋아요 
																			<c:choose>
																				<c:when test="${certBoard.likeyn > 0}">
																					<!-- 좋아요 눌렀을 때 -->
																					<img alt="heart-fill" src="./images/yr/heart-fill.png"
																						id="likeBtn${status.index }">
																				</c:when>
																		
																				<c:otherwise>
																					<!-- 좋아요 안 눌렀을 때 -->
																					<img alt="heart" src="./images/yr/heart.png"
																						id="likeBtn${status.index }">
																				</c:otherwise>
																			</c:choose>
																			<span id="inputLikeCnt${status.index}">${certBoard.like_cnt}</span>
																		</a>
																	</c:when>
																	<c:otherwise>
																		<!-- 로그인 안 한 상태 -->
																		<a class="rate-item" data-toggle="vote" data-count="${certBoard.like_cnt}" role="button">
																			좋아요 
																			<img alt="heart" src="./images/yr/heart.png">
																		</a>
																	</c:otherwise>
																</c:choose>
			
																<a class="rate-item" data-toggle="vote" data-count="(${certBoard.report_cnt }°C)" href="#" role="button" onclick="Burning(${status.index})">
																	태워요<i class="fa-solid fa-fire ms-2"></i>
																</a>
															</div>
									                        
								                        </div>
								                        
								                        <div class="col-auto d-none d-lg-block">
								                          <!-- Text -->
								                          <p class="mb-0 fs-sm">댓글<i class="fa-regular fa-comments ms-2"></i> (${certBoard.replyCount })</p>
								                        </div>
								                        
								                        <c:choose>
								                        	<c:when test="${user.user_num == certBoard.user_num }">
								                        	<!-- 작성자 본인일 경우 -->
										                        <div class="col-auto">
										                        
										                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
										                          <a class="btn btn-xs btn-outline-border" 
										                          	 href="#!" 
										                          	 id="showModalButton"
										                          	 onclick="updateModalCall('edit', ${status.index})"
										                          >
																	수정
										                          </a>
										                          
										                          <a class="btn btn-xs btn-outline-border" href="#!" onclick="deleteCertBrd('review', ${status.index})">
																	삭제
										                          </a>
										                          
										                        </div>
								                        	</c:when>
								                        	
								                        	<c:otherwise>
							                        			<div class="col-auto">
																	<!-- Button -->	
																	<a class="btn btn-xs btn-outline-border" href="#!" onclick="updateModalCall('more', ${status.index})">
																		더보기
																	</a>
																	<!-- Button -->
																	<button class="btn btn-xs btn-outline-border" data-bs-toggle="collapse" data-bs-target="#commentForm${status.index }" aria-expanded="false" aria-controls="commentForm${status.index }">
																		댓글
																	</button>
																</div>
								                        	</c:otherwise>
								                        </c:choose>
								                        
								                        
								                      </div>
								                    </div>
				                                </c:otherwise>
							              	</c:choose>
					              	
					                  	</div> <!-- <div class="row" id="certBoard${status.index}"> -->
													
					                </div><!-- <div class="review-body"> -->
					                
					              </div><!-- <div class="review" id="review${status.index}"> -->
					             
				              	</c:when>
			            		<c:otherwise>
			            		<!-- 2. 댓글 Child review -->
									<div class="review" id="comment${status.index }">
										<c:choose>
											<c:when test="${certBoard.report_cnt >= 100 }">
			                                   <div class="text-center">
			                                       <div class="mb-6 fs-1">🔥</div>
			                                       <p>
			                                           	다수의 사용자에 의해 다 탄 소시지의 댓글입니다
			                                       </p>
			                                   </div>
			                                </c:when>
			                                <c:otherwise>
			                                <div class="review review-child">
						                  <div class="review-body">
							                  <div class="row" id="certBoard${status.index}">
							                  	<input type="hidden" id="brd_num${status.index}"	value="${certBoard.brd_num }">
							                  	<input type="hidden" id="nick${status.index}"		value="${certBoard.nick }">
							                  	<input type="hidden" id="reg_date${status.index}"	value="${certBoard.reg_date }">
							                  	<input type="hidden" id="title${status.index}"		value="${certBoard.title }">
							                  	<input type="hidden" id="conts${status.index}"		value="${certBoard.conts }">
							                  	<input type="hidden" id="img${status.index}"		value="${certBoard.img }">
	                                            <input type="hidden" id="brd_group${status.index}"  value="${certBoard.brd_group }">
	                                            <input type="hidden" id="user_img${status.index}"	value="${certBoard.user_img}">
												<input type="hidden" id="user_num${status.index}"	value="${certBoard.user_num}">
												<input type="hidden" id="report_cnt${status.index}"		value="${certBoard.report_cnt}">
												<input type="hidden" id="myBurning${status.index}"	value="${certBoard.myBurning}">
							                  	
							                  	
												<div class="col-12 col-md-auto">
							                        <!-- Avatar -->
							                        <a href="#" data-bs-toggle="modal" onclick="userInfoModal('인증', ${status.index})">
								                        <div class="avatar avatar-xxl mb-6 mb-md-0">
								                          <span class="avatar-title rounded-circle">
								                            <img src="${pageContext.request.contextPath}/upload/${certBoard.user_img}" alt="profile" class="avatar-img rounded-circle">
								                          </span>
								                        </div>
							                        </a>
												</div>
							                    
							                    
							                    <div class="col-12 col-md">
							                    
							                    
							                      <!-- Header -->
							                      <div class="row mb-6">
							                        <div class="col-12">
							                          <!-- Time -->
							                          <span class="fs-xs text-muted">
															
														<a href="#" data-bs-toggle="modal" onclick="userInfoModal('인증', ${status.index})">
															<span style="color: black;">
																<img title="Lv.${certBoard.user_level } | exp.${certBoard.user_exp}(${certBoard.percentage }%)" src="/images/level/${certBoard.icon}.gif">
																${certBoard.nick}
															</span>
														</a>

														<time datetime="2019-07-25">${certBoard.reg_date }</time>
							                          </span>
							                        </div>
							                      </div>
							                      
							
							                      <!-- Title -->
							                      <p class="mb-2 fs-lg fw-bold">
							                        ${certBoard.title }
							                      </p>
							
							                      <!-- Text -->
							                      <p class="text-gray-500">
							                      	${certBoard.conts }
							                      </p>
							                      
							
							                      <!-- Footer -->
							                      <div class="row align-items-center">
							                      
							                      	<div class="col-auto me-auto">
							                      		<!-- Rate -->
								                        <div class="rate">
								                        
															<c:choose>
																<c:when test="${sessionScope.user_num != null }">
																	<!-- 로그인 한 상태 -->
																	<a class="rate-item" data-toggle="vote" role="button" onclick="likePro(${status.index})">
																		좋아요 
																		<c:choose>
																			<c:when test="${certBoard.likeyn > 0}">
																				<!-- 좋아요 눌렀을 때 -->
																				<img alt="heart-fill" src="./images/yr/heart-fill.png"
																					id="likeBtn${status.index }">
																			</c:when>
																
																			<c:otherwise>
																				<!-- 좋아요 안 눌렀을 때 -->
																				<img alt="heart" src="./images/yr/heart.png"
																					id="likeBtn${status.index }">
																			</c:otherwise>
																		</c:choose>
																		<span id="inputLikeCnt${status.index}">${certBoard.like_cnt}</span>
																	</a>
																</c:when>
															
																<c:otherwise>
																	<!-- 로그인 안 한 상태 -->
																	<a class="rate-item" data-toggle="vote" data-count="${certBoard.like_cnt}" role="button">
																		좋아요 
																		<img alt="heart" src="./images/yr/heart.png">
																	</a>
																</c:otherwise>
													
															</c:choose>

															<a class="rate-item" data-toggle="vote" data-count="(${certBoard.report_cnt }°C)" href="#" role="button" onclick="Burning(${status.index})">
																태워요<i class="fa-solid fa-fire ms-2"></i>
															</a>
								                        </div>
							                      	</div>
							                      
							                        <c:choose>
							                        	<c:when test="${user.user_num == certBoard.user_num }">
							                        	<!-- 작성자 본인일 경우 -->
									                        <div class="col-auto">
									                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
									                          <a class="btn btn-xs btn-outline-border" href="#!" onclick="deleteCertBrd('comment', ${status.index})">
																삭제
									                          </a>
									                        </div>
							                        	</c:when>
							                        </c:choose>
							                        
							                        
							                      </div>
							                    </div>
							                  </div>
							                </div>
										</div>	
			                                
			                                
			                                
			                                
			                                </c:otherwise>
										</c:choose>
									
									
									
									
		            					
									</div>
				                </c:otherwise>
			            	</c:choose>		
				               	
			              
			              <!-- 새 댓글 -->
				            <div class="collapse" id="commentForm${status.index }">
				
				              <!-- Divider -->
				              <hr class="my-8">
				
				
				
				              <!-- 인증 댓글 쓰기 Form -->
				              <form id="certCommentForm" action="/commentInsert" method="post" onsubmit="return commentInsertchk(this)">
				              	<input type="hidden" id="chg_id" name="chg_id" value="${chg.chg_id }">
				                <div class="row">
				                  
					              <c:choose>
					              	<c:when test="${chgrYN == 1 }">
					              	<!-- 1. 참가자일 경우 -->
					                  <div class="col-12 col-md-6">
					                  	<input type="hidden" name="chg_id"		value="${chg.chg_id }">
					                  	<input type="hidden" name="user_num"	value="${user.user_num }">
					                  	<input type="hidden" name="brd_num"		value="${certBoard.brd_num }">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="commentTitle" name="title" type="text" placeholder="제목을 작성해주세요 *" >
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="commentConts" name="conts" rows="5" placeholder="댓글을 작성해주세요 *" ></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="commentCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	<c:when test="${user == null }">
					              	<!-- 2. 비로그인 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" type="text" name="title"  placeholder="로그인 해주세요" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" rows="5" name="conts" placeholder="로그인 해주세요" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="commentCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	<c:otherwise>
					              	<!-- 3. 참여자가 아닌 회원 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" type="text" name="title"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" rows="5" name="conts" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
					                      	등록
					                    </button>
					                  </div>
					              	</c:otherwise>
					                  
					              </c:choose>
				                </div>
				              </form>
				
				            </div>
			            
						</c:forEach>
		            </div>
		            
		            
		            <!-- 인증글 게시판 U: 수정하기 모달 창 Product -->
				    <div class="modal fade" id="modalUpdateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"><!--  -->
				      <div class="modal-dialog modal-dialog-centered modal-xl" role="document"><!--  -->
				        <div class="modal-content"><!--  -->
				    
				          <!-- Close -->
				          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				            <i class="fe fe-x" aria-hidden="true"></i>
				          </button>
				    
				          <!-- Content -->
				          <div class="container-fluid px-xl-0">
				            <div class="row align-items-center mx-xl-0">
			            	
								<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
				                <!-- Image 수정 모달창 인증샷 -->
					                <img class="img-fluid" alt="수정 모달창 인증샷" id="updateImage">
				             	</div>
				              
				              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
				                <!-- 수정 Form -->
					            <form action="updateCertBrd" method="post" enctype="multipart/form-data">
					              <input type="hidden" name="brd_num"	id="editBrd_num">
					              <input type="hidden" name="nick" 		id="editNick">
					              <input type="hidden" name="chg_id" 	value="${chg.chg_id }">
					              <input type="hidden" name="currentPage" 	value="${certBrdPage.currentPage }">
					                
									<div class="avatar avatar-xl">
									  <img src="" alt="profile" class="avatar-img rounded-circle" id="editUserImg">
									</div>
				                      
				                      
					                <div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold" id="displayNick">
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
					                      <input class="form-control form-control-sm" id="editTitle" name="title" type="text" placeholder="제목을 작성해주세요 *" required>
					                  </div>
					                </div>
	
					                <div class="col-12">
					                  <!-- Email -->
					                  <div class="form-group">
					                    <label class="form-label" for="accountEmail">
					                     	 인증글 *
					                    </label>
					                      <textarea class="form-control form-control-sm" id="editConts" name="conts" rows="4" placeholder="인증글을 작성해주세요 *" required></textarea>
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
				    
				        </div><!-- <div class="modal-content"> -->
				      </div><!-- <div class="modal-dialog modal-dialog-centered modal-xl" role="document"> -->
				    </div><!-- <div class="modal fade" id="modalUpdateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"> -->
				    
				    
				    <!-- 더보기 모달 창 Product -->
				    <div class="modal fade" id="modalMoreCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"><!--  -->
				      <div class="modal-dialog modal-dialog-centered modal-xl" role="document"><!--  -->
				        <div class="modal-content"><!--  -->
				    
				          <!-- Close -->
				          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				            <i class="fe fe-x" aria-hidden="true"></i>
				          </button>
				    
				          <!-- Content -->
				          <div class="container-fluid px-xl-0">
				            <div class="row align-items-center mx-xl-0">
			            	
								<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
				                <!-- Image 더보기 모달창 인증샷 -->
					                <img class="img-fluid" alt="더보기 모달창 인증샷" id="moreImage">
				             	</div>
				              
				              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
				                <!-- 더보기 Form -->
					            <form action="moreCertBrd" method="post" enctype="multipart/form-data">
					              <input type="hidden" name="brd_num" id="editBrd_num">
					              <input type="hidden" name="nick" id="editNick">
					                
									<div class="avatar avatar-xl">
									  <img src="" alt="profile" class="avatar-img rounded-circle" id="moerUserImg">
									</div>
				                      
				                      
					                <div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold" id="moreNick">
					                      </p>
				                    </div>
					                </div>
		                    
			                      <!-- Header -->
				                      <div class="row mb-6"><!--  -->
				                        <div class="col-12"><!--  -->
				                          <!-- Time -->
				                          <span class="fs-xs text-muted">
				                            <time datetime="2019-07-25" id="moreReg_date"></time>
				                          </span>
				                        </div>
				                      </div>
					                

		        					<div class="col-12"><!--  -->
					                  <!-- 제목 -->
					                  <div class="form-group"><!--  -->
					                  	<h5 class="modal-title" id="moreTitle"></h5>
					                  	<!-- <h4 id="moreTitle"></h4> -->
					                  	<!-- <strong class="mx-auto" id="moreTitle"></strong> -->
					                    <!-- <h5 class="mb-3" id="moreTitle"></h5> -->
					                  </div>
					                </div>
	
					                <div class="col-12">
					                  <!-- 인증글 -->
					                  <div class="form-group">
					                  	<div class="modal-body" id="moreConts"></div>
					                  	<!-- <p class="mb-7 fs-lg" id="moreConts"></p> -->
					                    	<!-- <h4 class="mb-3" id="moreConts"></h4> -->
					                  </div>
					                </div>
					                
					                
					                
					            </form>
							
							
				    
				              </div><!-- <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"> -->
				              
				            </div><!-- <div class="row align-items-center mx-xl-0"> -->
				          </div><!-- <div class="container-fluid px-xl-0"> -->
				    
				        </div><!-- <div class="modal-content"> -->
				      </div><!-- <div class="modal-dialog modal-dialog-centered modal-xl" role="document"> -->
				    </div>
				    
		            
				    <div id="searchResultContainer">
			            <!-- BG Pagination		임시로 chg_id 넣어둠 -->
			            <nav class="d-flex justify-content-center justify-content-md-center">
		      	   		 <ul class="pagination pagination-sm text-gray-400">
						  	<c:if test="${certBrdPage.startPage > certBrdPage.pageBlock }">
						  		<li class="page-item">
									<a class="page-link page-link-arrow" href="#" onclick="movePrevBlock()">
									<i class="fa fa-caret-left">이전</i></a>
								</li>
							</c:if>
							
						    <c:forEach var="i" begin="${certBrdPage.startPage }" end="${certBrdPage.endPage }">
								<li class="page-item">
									<c:if test="${i == certBrdPage.currentPage }">
										<a class="page-link" onclick="moveCurrentPage()" href="chgDetail?chg_id=${chg.chg_id}&searchType=${searchType }&keyword=${keyword }&sortBy=${sortBy }&currentPage=${i }" id="moveCurrentPage"><b class="text-primary">${i}</b></a>
									</c:if>
									<c:if test="${i != certBrdPage.currentPage }">
										<a class="page-link" onclick="movePage()" href="chgDetail?chg_id=${chg.chg_id}&searchType=${searchType }&keyword=${keyword }&sortBy=${sortBy }&currentPage=${i }" id="movePage">${i}</a>
									</c:if>
								</li>
							</c:forEach>
						    <c:if test="${certBrdPage.endPage < certBrdPage.totalPage }">
						    	<li class="page-item">
									<a class="page-link page-link-arrow" href="#" onclick="moveNextBlock()">
									<i class="fa fa-caret-right">다음</i></a>
								</li>
							</c:if>
						 </ul>
				  		</nav>
			            
			            <c:if test="${certTotal != 0 }">
							<div class="offcanvas-body">
				            <!-- 검색 Search Body: Form -->
						        <form id="searchForm">
						         	<div class="form-group">
						            	<label class="visually-hidden" for="modalSearchCategories">Categories:</label>
						            	<select class="form-select" id="modalSearchCategories" name="searchType">
							              	<option selected>All Categories</option>
							              	<option value="title" <c:if test="${searchType eq 'title' }">selected="selected"</c:if>>제목</option>
							              	<option value="conts" <c:if test="${searchType eq 'conts' }">selected="selected"</c:if>>내용</option>
							              	<option value="nick" <c:if test="${searchType eq 'nick' }">selected="selected"</c:if>>닉네임</option>
						            	</select>
						          	</div>
						          	<div class="input-group input-group-merge">
						            	<input class="form-control" type="search" placeholder="Search" name="keyword" value="${keyword }">
									  	<input type="hidden" name="chg_id" value="${chg.chg_id }">
							            <div class="input-group-append">
							              <button class="btn btn-outline-border" type="submit">
							                <i class="fe fe-search"></i>
							              </button>
							            </div>
						          </div>
						        </form>
							</div>
			            </c:if>
		            </div>
					
		            </div>
	            </div>
            </div>
            
            
				<!-- 소세지들 -->
				<!-- 스크롤 내릴 때 내용이 나중에 나타나는 모션? 추가할 예정 -->
				<div class="tab-pane fade" id="ssjFriendsTab">
					<div class="row justify-content-center py-9">
						<div class="col-12 col-lg-10 col-xl-8">
							<div class="row">
								<div class="col-12">
				
									<!-- content -->
									<div class="review">
										<!-- Body -->
										<c:forEach var="ssj" items="${listSsj}" varStatus="status">
											<div class="review-body row d-flex justify-content-between align-items-center" id="ssj${status.index}">
													<input type="hidden" id="ssjImg${status.index}" 		value="${ssj.img}">
													<input type="hidden" id="ssjNick${status.index}" 		value="${ssj.nick}">
													<input type="hidden" id="ssjUserNum${status.index}" 	value="${ssj.user_num}">
													<input type="hidden" id="ssjUserLevel${status.index}" 	value="${ssj.user_level}">
													<input type="hidden" id="ssjUserExp${status.index}" 	value="${ssj.user_exp}">
													<input type="hidden" id="ssjPercentage${status.index}" 	value="${ssj.percentage}">
													<input type="hidden" id="ssjIcon${status.index}" 		value="${ssj.icon}">
													
													<!-- profile & nick -->
															<!-- profile -->
															<a href="#" data-bs-toggle="modal" onclick="userInfoModal('소세지들', ${status.index})" class="col-2">
																<div class="avatar avatar-xxl mb-6 mb-md-0">
																		<span class="avatar-title rounded-circle">
																			<img src="${pageContext.request.contextPath}/upload/${ssj.img}"
																				alt="profile" class="avatar-title rounded-circle">
																		</span>
																</div>
															</a>
															
															<!-- nick -->
															<a href="#" data-bs-toggle="modal" onclick="userInfoModal('소세지들', ${status.index})" class="col-5">
																<img title="Lv.${ssj.user_level } | exp.${ssj.user_exp}(${ssj.percentage }%)" src="/images/level/${ssj.icon}.gif">
																<span style="color: black;">${ssj.nick}</span>
															</a>
				
													<!-- reg_date & fork -->
													<div class="col-5 text-end">
														<!-- reg_date -->
				
																<!-- 오늘 날짜 -->
																<jsp:useBean id="javaDate" class="java.util.Date" />
																<fmt:formatDate var="nowDateFd" value="${javaDate }"
																	pattern="yyyy-MM-dd" />
				
																<!-- 마지막 인증 게시판 작성일자 -->
																<fmt:formatDate var="lastRegDateFd" value="${ssj.brd_reg_date }"
																	pattern="yyyy-MM-dd" />
				
																<c:choose>
																	<c:when test="${ssj.brd_reg_date != null }">
																		<!-- 인증한 날짜 있음 -->
																		<fmt:parseDate var="nowDatePd" value="${nowDateFd }"
																			pattern="yyyy-MM-dd" />
																		<fmt:parseDate var="lastRegDatePd" value="${lastRegDateFd }"
																			pattern="yyyy-MM-dd" />
					
																		<fmt:parseNumber var="nowDatePn"
																			value="${nowDatePd.time/(1000*60*60*24) }" integerOnly="true" />
																		<fmt:parseNumber var="lastRegDatePn"
																			value="${lastRegDatePd.time/(1000*60*60*24) }"
																			integerOnly="true" />
					
																		<c:set var="dDay" value="${nowDatePn - lastRegDatePn}" />
					
																		<span class="mx-5">
																			${dDay }일 전
																		</span>
																	
																	</c:when>
																	
																	<c:otherwise>
																		<!-- 인증한 날짜 없음 -->
																		<span class="mx-5">
																			인증 전
																		</span>
																	
																	</c:otherwise>
																</c:choose>
				
				
															<c:choose>
																<c:when test="${sessionScope.user_num != null}">
																	<!-- 로그인 한 상태 -->
																	<!-- fork -->
																	<!-- Button -->
																	<a class="btn btn-xs btn-outline-border" href="#!"
																		onclick="forkModalCall(${status.index})">찌르기</a>
																</c:when>
					
																<c:when test="${sessionScope.user_num == null}">
																	<!-- 로그인 안 한 상태 -->
																	<!-- loginForm으로 이동 -->
																	<!-- Button -->
																	<a class="btn btn-xs btn-outline-border"
																		href="/loginForm">찌르기</a>
																</c:when>
					
															</c:choose>
													</div>
				
				
											</div>
				
										</c:forEach>

										<!-- BG 찌르기 fork 기능 모달창	 Wait List 를 참고함 -->
										<div class="modal fade" id="modalfork" tabindex="-1" role="dialog" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered" role="document">
												<div class="modal-content">
													<input type="hidden" name="ssjUserNum" id="ssjUserNum">
													<input type="hidden" name="sendMailUser_num" id="sendMailUser_num">
										
													<!-- Close -->
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
														<i class="fe fe-x" aria-hidden="true"></i>
													</button>
										
													<!-- Header-->
													<div class="modal-header lh-fixed fs-lg">
														<strong class="mx-auto">찌르기</strong>
													</div>
										
													<!-- Body -->
													<div class="modal-body">
										
														<!-- <div class="row mb-6"> -->
														<!-- <div class="col-12 col-md-3"> -->
														<!-- 아바타 부분 보류 Image -->
														<!-- <a href="./product.html">
																<img class="img-fluid mb-7 mb-md-0" src="./assets/img/products/product-6.jpg" alt="...">
															</a>
														</div> -->
										
														<!-- 보류 칸 <div class="col-12 col-md-9"> -->
														<!-- Label -->
														<!-- <p>
																<a class="fw-bold text-body" href="./product.html">Cotton floral print Dress</a>
															</p>
														</div> -->
														<!-- </div> -->
										
										
														<div class="row">
															<div class="col-12">
																<!-- Text -->
																<p class="fs-sm text-center text-charcol-400">
																	인증 활동이 뜸한 참가자들에게 격려 메일을 보내보세요!
																</p>
															</div>
														</div>
										
										
														<div class="row gx-5 mb-2">
															<!-- Form group -->
															<div class="form-group">
																<textarea class="form-control form-control-sm" id="cheerUpMsg" name="conts" rows="4"
																	required></textarea>
															</div>
														</div>
										
										
														<div class="row">
															<div class="col-12 text-center">
																<!-- Button -->
																<button class="btn btn-dark mb-1" type="submit" onclick="sendMail()">메일 보내기<i class="fe fe-send ms-2"></i></button>
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
					</div>
				
				
				</div>

            <!-- jh 후기글   -->
            <input type="hidden" name="reviewCurrentPage" id="reviewCurrentPage" value="${tap}">  
            <!-- stateCtn 대신 그냥 공통 코드 103으로 해도 될듯 -->
            <c:choose>
            	<c:when test="${chg.state_md == 103}">
   	              <div class="tab-pane fade" id="reviewTab">
	                <div class="row justify-content-center py-9">
	                  <div class="col-12 col-lg-10 col-xl-8">
	                  	 <!-- Heading -->
				            <h4 class="mb-10 text-center">후기 게시판</h4>
				            
				            
				              	<c:choose>
					              	<c:when test="${chgrYN == 1 }">
						              	<!-- 참가자인 경우 -->
							            <!-- Header -->
							            <div class="row align-items-center">
							              
							              <div class="col-12 col-md text-md">
							
							                <!-- Count -->
							                <strong class="fs-sm ms-2">총 리뷰수 : ${reviewTotal }</strong>
							
							              </div>
							              
			   				              <div class="col-12 col-md-auto mb-1">
							
							                <!-- Button -->
							                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
							                  	후기 등록하기
							                </a>
							
							              </div>
							            </div>
						            
	
					              		<!-- New Review -->
							            <div class="collapse" id="reviewForm">
							
							              <!-- Divider -->
							              <hr class="my-8">
							              
							              <div class="col-12 col-md-auto">
							
							                <strong class="fs-sm ms-2">${user.nick }님 후기를 입력해 주세요!</strong><p>
							               		
							              </div>
							
							              <!-- Form -->
							              <form action="/reviewPost" method="post"  enctype="multipart/form-data">
							              	<input type="hidden" 	name="chg_id" 		value="${chg.chg_id}" >
							              	<input type="hidden" 	name="user_num" 	value="${user.user_num}" >
							                <div class="row">
							 
							                  <div class="col-12">
							
							                    <!-- Name -->
							                    <div class="form-group">
							                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
							                      <input class="form-control form-control-sm" id="reviewTitle" type="text" name="title" placeholder="Review Title *" required>
							                    </div>
							
							                  </div>
							                  <div class="col-12">
							
							                    <!-- Name -->
							                    <div class="form-group">
							                      <label class="visually-hidden" for="reviewText">Review:</label>
							                      <textarea class="form-control form-control-sm" id="reviewText" rows="5" name="conts" placeholder="Review *" required></textarea>
							                    </div>
							
							                  </div>
							                  
							                  <div class="input-group mb-3">
												  <input type="file" class="form-control" name="file" id="inputGroupFile">
												  <label class="input-group-text" for="inputGroupFile">이미지 업로드</label>
											  </div>
							                  
							                  <div class="col-12 text-center mb-5">
							
							                    <!-- Button -->
							                    <button class="btn btn-outline-dark" type="submit">
							                      	등록
							                    </button>
							                    <button class="btn btn-outline-secondary" type="reset">
							                      	다시쓰기
							                    </button>
							
							                  </div>
							                </div>
							              </form>
							
							            </div>
					              	</c:when>
					              	
					              	<c:when test="${user == null  }">
						              	<!-- 로그인 전인 경우 -->
						              	<!-- Header -->
								            <div class="row align-items-center">
								              
								              <div class="col-12 col-md text-md">
								
								                <!-- Count -->
								                <strong class="fs-sm ms-2">총 리뷰수 : ${reviewTotal }</strong>
								
								              </div>
								              
				   				              <div class="col-12 col-md-auto">
								
								                <!-- Button -->
								                <a class="btn btn-sm btn-dark"  href="/reviewPost">
								                  Write Review
								                </a>
								
								              </div>
								            </div>
					              	
					              	</c:when>
					              	
					              	<c:otherwise>
						              	<!-- 로그인 했지만 참가자 아닌 경우 -->
						              	<div class="row align-items-center">
						              
							              <div class="col-12 col-md text-md">
							
							                <!-- Count -->
							                <strong class="fs-sm ms-2">총 리뷰수 : ${reviewTotal }</strong>
							
							              </div>
							              
			   				              <div class="col-12 col-md-auto">
							
							                <!-- Button -->
							                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
							                  Write Review
							                </a>
							
							              </div>
						            	</div>
					            
	
					              		<!-- New Review -->
							            <div class="collapse" id="reviewForm">
							
							              <!-- Divider -->
							              <hr class="my-8">
							              
							              <div class="col-12 col-md-auto">
							
							                <strong class="fs-sm ms-2">${user.nick }님 챌린지 참가자만 후기를 남길 수 있습니다! 다음엔 꼭 참가해 주세요!</strong><p>
							               		
							              </div>
							
							              <!-- Form -->
							              <form action="/reviewInsert">
							              	<input type="hidden" 	name="chg_id" 		value="${chg.chg_id}" >
							              	<input type="hidden" 	name="user_num" 	value="${user.user_num}" >
							                <div class="row">
							 
							                  <div class="col-12">
							
							                    <!-- Name -->
							                    <div class="form-group">
							                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
							                      <input class="form-control form-control-sm" id="reviewTitle" type="text" name="title" placeholder="챌린지 참가자만 후기를 남길 수 있습니다!" disabled>
							                    </div>
							
							                  </div>
							                  <div class="col-12">
							
							                    <!-- Name -->
							                    <div class="form-group">
							                      <label class="visually-hidden" for="reviewText">Review:</label>
							                      <textarea class="form-control form-control-sm" id="reviewText" rows="5" name="conts" placeholder="챌린지 참가자만 후기를 남길 수 있습니다!" disabled></textarea>
							                    </div>
							
							                  </div>
							                  
							                  <div class="input-group mb-3">
												  <input type="file" class="form-control" name="file" id="inputGroupFile02" disabled>
												  <label class="input-group-text" for="inputGroupFile02">Upload</label>
											  </div>
							                  
							                  <div class="col-12 text-center">
							
							                    <!-- Button -->
							                    <button class="btn btn-outline-dark" type="submit" disabled>
							                      	등록
							                    </button>
							
							                  </div>
							                </div>
							              </form>
							
							            </div>
					              	</c:otherwise>
					              </c:choose>
	                  	
			                    <!-- Table -->
			                    <div class="table-responsive">     
	                    			<c:set var="num" value="${reviewPage.total-reviewPage.start+1 }"></c:set>
									<table class="table table-bordered table-sm table-hover" id="reviewTable" border="1">
									       <thead>
									         <tr>
									           <th>글번호</th>
									           <th>제목</th>
									           <th>작성자</th>
									           <th>조회수</th>
									           <th>작성일</th>
									         </tr>
									       </thead>
									       <tbody>
									         <c:forEach var="review" items="${chgReviewList}" varStatus="status">
									         <input type="hidden" id="reviewImg${status.index}" 		value="${review.user_img}">
											 <input type="hidden" id="reviewNick${status.index}" 		value="${review.nick}">
											 <input type="hidden" id="reviewUserNum${status.index}" 	value="${review.user_num}">
									         <input type="hidden" id="reviewUserLevel${status.index}" 	value="${review.user_level}">
											 <input type="hidden" id="reviewUserExp${status.index}" 	value="${review.user_exp}">
											 <input type="hidden" id="reviewPercentage${status.index}" 	value="${review.percentage}">
											 <input type="hidden" id="reviewIcon${status.index}" 		value="${review.icon}">
									          <tr>
									            <td>${num }</td>
									            <td><a href="/reviewContent?brd_num=${review.brd_num}&chg_id=${chg.chg_id}">${review.title } [${review.replyCount }]</a></td>
									            <td>
									            	<a href="#" data-bs-toggle="modal" onclick="userInfoModal('후기', ${status.index})" class="col-2">
										            	<img title="Lv.${review.user_level } | exp.${review.user_exp}(${review.percentage }%)" src="/images/level/${review.icon}.gif">
										            	<span style="color: black;">${review.nick }</span>
													</a>
												</td>
									            <td>${review.view_cnt }</td>
									            <td><fmt:formatDate value="${review.reg_date }" pattern="yyyy-MM-dd"/></td>
									          </tr>
				          					<c:set var="num" value="${num -1 }"></c:set>
									        </c:forEach>
									       </tbody>
								     </table>
		                    	</div>
		                    	
	   		            		<!-- Pagination -->
								<nav class="d-flex justify-content-center mt-3">
								  <ul class="pagination pagination-sm text-gray-400">
								  <c:if test="${reviewPage.startPage > reviewPage.pageBlock}">
								    <li class="page-item">
								      <a class="page-link page-link-arrow" href="chgDetail?currentPage=${reviewPage.startPage-reviewPage.pageBlock }&chg_id=${chg.chg_id}&tap=3">
								        <i class="fa fa-caret-left"></i>
								      </a>
								    </li>
					              </c:if>
						          <c:forEach var="i" begin="${reviewPage.startPage }" end="${reviewPage.endPage }">
								    <li class="page-item">
								    	<c:if test="${i == reviewPage.currentPage}">
								      		<a class="page-link" href="chgDetail?currentPage=${i}&chg_id=${chg.chg_id}&tap=3"><b class="text-primary">${i}</b></a>
								    	</c:if>
								    	<c:if test="${i != reviewPage.currentPage}"> 
								     		<a class="page-link" href="chgDetail?currentPage=${i}&chg_id=${chg.chg_id}&tap=3">${i}</a>
								    	</c:if>
								    </li>
						          </c:forEach>
						          <c:if test="${reviewPage.endPage < reviewPage.totalPage }">
								    <li class="page-item">
								      <a class="page-link page-link-arrow" href="chgDetail?currentPage=${reviewPage.startPage+reviewPage.pageBlock }&chg_id=${chg.chg_id}&tap=3">
								        <i class="fa fa-caret-right"></i>
								      </a>
								    </li>
						          </c:if>
								  </ul>
								</nav>

                  			</div>
               			</div>
              		</div>
           		</c:when>
            
            	<c:otherwise>
            	<div class="tab-pane fade" id="reviewTab">
	                <section class="py-12">
				      <div class="container">
				        <div class="row justify-content-center">
				          <div class="col-12 col-md-10 col-lg-10 col-xl-10 text-center">
				
				            <!-- Icon -->
				            <div class="mb-7 fs-1">🙁</div>
				
				            <!-- Heading -->
				            <h2 class="mb-5">챌린지가 종료 된 후에 후기를 남겨주세요!</h2>
				
				            <!-- Text -->
				            <p class="mb-7 text-gray-500">
						              아직 챌린지가 종료되지 않았습니다.<br>
						              후기 게시판은 챌린지가 종료된 이후에 글을 남길 수 있습니다!<br>
						              챌린지가 종료되기 전까지 최선을 다 해주세요~!
				            </p>
				          </div>
				        </div>
				      </div>
				    </section>
            	  </div>
            	</c:otherwise>
            </c:choose>
            
            <!-- yr 작성 -->
            <!-- nick 클릭 시 나타나는 modal -->
			<!-- 인증게시판, 소세지들, 후기게시판 사용 -->
			<div class="modal fade" id="userShowModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-body">
							<div class="col-12 col-md-auto">
								<div class="avatar avatar-xxl mb-6 mb-md-0">
									<span class="avatar-title rounded-circle">
										<img src="" alt="profile" class="avatar-title rounded-circle" id="displayUserImg">
									</span>
								</div>
							</div>
							
							<div class="col-12">
								<img title="" src="" id="displayUserLevel">
								<span id="displayUserNick"></span>
							</div>
							
							<div class="text-end">
									<button type="button" class="btn btn-danger btn-xs" name="user_num" onclick="following(${status.index})"
										id="follow">팔로우</button>
									
									<!-- 
										<button type="button" class="btn btn-info" onclick="sendMessage(${status.index})">쪽지보내기</button>
										<form id="sendMessageForm">
											<input type="hidden" id="inputUserNum2" name="user_num">
										</form>
									 -->
									 
									<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal" aria-label="Close">닫기</button>
									
									<form id="followingForm">
										<input type="hidden" id="inputUserNum1" name="user_num">
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
    </section>

</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>