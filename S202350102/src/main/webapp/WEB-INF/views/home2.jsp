<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
	.flickity-cell {
	  width: 50%; /* half-width */
	  height: 400px;
	  margin-right: 10px;
	}
	
	 #recomSlider .flickity-slider{
		width: 100% !important; /* half-width */
	}
	
	#srch_btn{
		background-color: transparent;
	}
	
	#searchVar{
		width: 30%
	}
	.flickity-viewport {  
	  height: 400px !important;
	  padding: 10px
	}
	.section-mt {
		margin-top: 150px;
	}
	
	#shList{
		z-index: 999;
		position: absolute;
		max-height: 200px;
		min-width: 550px;
		overflow-y: scroll;
		overflow-x: hidden;	
	}
</style>
<title>맛있게! 즐겁게! 건강한 습관 커뮤니티 + Life is the best game.</title>
	<script type="text/javascript">
		// 팔로우 하기 버튼
		function following(p_index) {
			$.ajax({
				url: "/followingPro",
				type: "POST",
				data: { user_num: p_index },
				dataType: 'json',
				success: function (followResult) {

					if (followResult.following > 0) {
						$(".follow" + p_index).removeClass("btn-danger");
						$(".follow" + p_index).addClass("btn-light");
						$(".follow" + p_index).text("팔로잉");
					} else if (followResult.following == 0) {
						$(".follow" + p_index).removeClass("btn-light");
						$(".follow" + p_index).addClass("btn-danger");
						$(".follow" + p_index).text("팔로우");
					} else {
						alert("자신의 계정은 팔로우 할 수 없습니다");
					}
				},
				error: function () {
					alert("팔로우 오류");
				}

			});

		}

		// 좋아요 버튼
		function likePro(type, p_index) {
			var brd_num = '';

			if (type == '인증') {
				brd_num = $('#brd_num' + p_index).val();
			} else if (type == 'modal') {
				brd_num = p_index;
			} else {	// modal안에 있는 댓글
				brd_num = $('#brd_num_cmt' + p_index).val();
			}
			
			$.ajax({
				url: "/likePro",
				type: "POST",
				data: { brd_num: brd_num },
				dataType: 'json',
				success: function (likeResult) {
					// likeProResult에 좋아요 수 담아서 넘어오는거 구현할까 생각 중

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
	
		// 댓글 버튼
		function comment(p_index) {
			var user_img 	= $('#user_img' 	+ p_index).val();
			var user_level 	= $('#user_level' 	+ p_index).val();
			var nick 		= $('#nick' 		+ p_index).val();
			var title 		= $('#title' 		+ p_index).val();
			var conts 		= $('#conts' 		+ p_index).val();
			var like_cnt 	= $('#like_cnt' 	+ p_index).val();
			var chg_id 		= $('#chg_id' 		+ p_index).val();

			var brd_num 	= $('#brd_num' 		+ p_index).val();
			var user_num 	= $('#user_num' 	+ p_index).val();
			var brd_group 	= $('#brd_group' 	+ p_index).val();
			var user_exp 	= $('#user_exp' 	+ p_index).val();
			var percentage 	= $('#percentage' 	+ p_index).val();
			var icon		= $('#icon' 		+ p_index).val();
			var likeyn 		= $('#likeyn' 		+ p_index).val();

			// alert("brd_num -> " + brd_num
			// 	+ "/ user_num -> " + user_num
			// 	+ "/ nick -> " + nick
			// 	+ "/ user_img -> " + user_img
			// 	+ "/ title -> " + title
			// 	+ "/ conts -> " + conts
			// 	+ "/ brd_group -> " + brd_group
			// 	+ "/ user_level -> " + user_level
			// 	+ "/ user_exp -> " + user_exp
			// 	+ "/ percentage -> " + percentage
			// 	+ "/ icon -> " + icon
			// 	+ "/ likeyn -> " + likeyn
			// 	+ "/ like_cnt -> " + like_cnt
			// );

			$('#inputUserImg' + p_index).attr('src', '${pageContext.request.contextPath}/upload/' + user_img);
			$('#inputUserLevel' + p_index).attr('title', 'Lv.' + user_level + ' | exp.' + user_exp + '(' + percentage + '%)')
								.attr('src', '/images/level/' + icon + '.gif');
			$('#inputNick' + p_index).text(nick);
			$('#inputTitle' + p_index).text(title);
			$('#inputConts' + p_index).text(conts);
			$('#inputLikeCnt' + p_index).text(like_cnt);
		}
		
		// 댓글 공백 체크
		// bg 작성. 인증게시판에서 가져옴
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
						$("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
						alert("찜 성공");
					} else {
						$("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
						alert("찜 취소");
					}

				},
				error : function() {
					alert("찜하기 오류");
				}
			});
		}
		
		function sharingPick(p_index) {
	        // alert("sharingPick" + p_index);

	        $.ajax({
	            url: "/likePro",
	            type: "POST",
	            data: { brd_num: p_index },
	            dataType: 'json',
	            success: function (likeResult) {
	                if (likeResult.likeProResult > 0) {
	                    $("#sharingPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
	                    alert("찜 성공");
	                } else {
	                    $("#sharingPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
	                    alert("찜 취소");
	                }
	                $('#likeCnt' + p_index).text(likeResult.brdLikeCnt);
	            },
	            error: function () {
	                alert("찜하기 오류");
	            }
	        });
	    }
		
		function sh(){
			if($("#shList").css("display") == "none" || $("#shList").css("display") == ""){
			    $("#shList").show();
			} else {
			    $("#shList").hide();
			    
			}
		}
		
		
		
		function clickLoad(index) {				
			// Flickity 인스턴스 제거
		    /* var flkty = $('#mySlider').data('flickity');
		    if (flkty) {
		        flkty.destroy();				       
		    }	 */
				    
					
					if(index == 1) {
						
						// 참여 챌린지
						$.ajax(
								{
									
									url: "popChgList",
									dataType:"html",
									success:function(data){
										
										$("#Commu").html(data);
										/* $("#mySlider").html(data); */						
											
									    initFlickity();
										
										
									}
								}		
							);
						
					} else if(index == 2) {						
						// 신청한 챌린지
						$.ajax(
								{
									
									url: "popShareList",
									dataType:"html",
									success:function(data){
										
										$("#Commu").html(data);
										/* $("#mySlider").html(data);																	    
										 */
								        //Flickity 초기화
									    initFlickity();
									}
								}		
							);			
					
					} else {
						$.ajax(
								{
									
									url: "popCommuList",
									dataType:"html",
									success:function(data){
										
										$("#Commu").html(data);			    
										
								       
									}
								}		
							);
					}
				
				
		}
		
		function initFlickity() {

		    // Flickity 초기화 초기화 위해 객체 생성
		    var flkty = new Flickity('#mySlider', {
		        prevNextButtons: true, // 이전 및 다음 버튼 활성화
		        draggable: true, // 드래깅 활성화
		        // 필요한 경우 더 많은 옵션을 추가할 수 있습니다.
		         contain: true ,// 부모 요소에 캐러셀을 포함시킵니다.
		         cellAlign: 'left',
		         pageDots: false
		    });
		    
		    //리턴값을 줘서 사용(없어도 됨)
		    return flkty;
		}
		
		//하단 더보기 클릭시 발동(인증글 더 불러오기)
		function moreList() {
			var sendData = $('#more').serialize();
			location.href = "/?" + sendData;
		}
		
		function deleteHis(srch_word, index){
			/* alert(srch_word+index); */
			$.ajax(
					{
						url: "deleteHis",
						type: "POST",
						data:{srch_word : srch_word},
						dataType:"text",
						success:function(data){							
							if(data > 0){
								$("#row-"+index).remove();
							} else{
								alert("잘못된 접근입니다.");
							}
						}
					}		
				);
		}
		
	</script>
</head>
<body>
<section class="section-mt">
	<div id="searchVar" class="container">
		<form action="searching">
			<div class="input-group">				
				<input type="search" name="srch_word" id="srch_word" class="form-control form-control-underline form-control-sm border-dark" onclick="sh()" >
				<button type="submit" class="btn-underline btn-sm border-dark" id="srch_btn">
					<i class="fe fe-search"></i>
				</button>
			
			</div>			
		</form>
		<div class="card review px-0" id="shList" style="display: none;">
			<c:if test="${user_num != 0 }">
				<div class="card-body">
					<table>
						<c:forEach items="${shList }" var="shList" varStatus="status">
							<tr id="row-${status.index }">
								<td class="col-6 text-start">
									<a href="searching?srch_word=${shList.srch_word }">${shList.srch_word }</a>
								</td>
								<td class="col-6 text-end">
									<a href="javascript:void(0);" onclick="deleteHis('${shList.srch_word }',${status.index })">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
										  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
										</svg>
									</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>
	</div>

    <section class="py-12">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h2 class="mb-4 text-center text-primary">HOT</h2>

            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#popChg" data-bs-toggle="tab" onclick="clickLoad(1)">인기 챌린지</a>
              <a class="nav-link" href="#popChg" data-bs-toggle="tab" onclick="clickLoad(2)">인기 쉐어링</a>              
              <a class="nav-link" href="#popChg" data-bs-toggle="tab" onclick="clickLoad(0)">인기 자유글</a>              
            </div>

            <!-- Content -->
            <div class="tab-content">

              <!-- Pane -->
              <div class="tab-pane fade show active" id="popChg">
				<div id="Commu">
                <div id="mySlider" class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>

                  <!-- Item2 -->
                  <c:forEach var="chg" items="${popchgList }">
                  <div class="col px-4" style="max-width: 250px;">
                    <div class="card">

                      <!-- Image -->
                      <c:choose>
						<c:when test="${sessionScope.user_num != null}">
							<!-- 로그인 한 상태 -->
							<c:choose>
								<c:when test="${chg.pickyn > 0}">
									<!-- 찜하기 있음 -->
									<button type="button" class="btn btn-xs btn-circle btn-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
										<i class="fe fe-heart"></i>
									</button>
								</c:when>
					
								<c:otherwise>
									<!-- 찜하기 없음 -->
									<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
										<i class="fe fe-heart"></i>
									</button>
								</c:otherwise>
							</c:choose>
						</c:when>
					
						<c:otherwise>
							<!-- 로그인 안 한 상태 -->
							<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button"
								onclick="location.href='/loginForm'">
								<i class="fe fe-heart"></i>
							</button>
						</c:otherwise>
					</c:choose>

	                  <!-- Button -->
	                  <button class="btn btn-xs w-100 btn-dark card-btn">
	                    <i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
	                  </button>
	
	                  
	                  <a class="text-body" href="chgDetail?chg_id=${chg.chg_id }">
	                  <c:if test="${chg.thumb != null}">
	                  <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
	                  </c:if>
	                  <c:if test="${chg.thumb == null}">
	                  <img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
	                  </c:if>
					  </a>

                      <!-- Body -->
                      <div class="card-body py-4 px-0 text-center">

		                <a class="text-body fw-bolder text-muted fs-6" href="chgDetail?chg_id=${chg.chg_id }">${chg.title }</a>
		                <div class="text-muted"> 
		                 <fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
		                  ~ 
		                 <fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
		                 </div>
		                <div class="text-muted">참여인원: ${chg.chlgerCnt}
		            	</div>
			            	
                      </div>

                    </div>
                  </div>
                  </c:forEach>

                </div>
                 <!-- Slider -->
                 </div>
				
              </div>
              <!-- Pane -->              
              
          </div>
          <!-- Content -->
            
          </div>
        </div>
        <!-- row -->
      </div>
      <!-- container -->
    </section>
</section>


	
	<!-- yr 작성 -->
	<!-- 최신 인증글 -->
	<section>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center">
					<!-- Heading -->
					<h2 class="mb-10">소세지들 인증타임</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
		
					<!-- 인증글 시작 -->
					<c:forEach var="certList" items="${chgCertList }" varStatus="status">
						<!-- 인증글 원글 -->
						<input type="hidden" id="brd_num${status.index}" value="${certList.brd_num}">
						<input type="hidden" id="like_cnt${status.index }" value="${certList.like_cnt }">
						<input type="hidden" id="user_num${status.index}" value="${certList.user_num}">
						<input type="hidden" id="nick${status.index}" value="${certList.nick }">
						<input type="hidden" id="user_img${status.index}" value="${certList.user_img}">
						<input type="hidden" id="title${status.index}" value="${certList.title }">
						<input type="hidden" id="conts${status.index}" value="${certList.conts }">
						<input type="hidden" id="brd_group${status.index}" value="${certList.brd_group }">
						<input type="hidden" id="user_level${status.index }" value="${certList.user_level }">
						<input type="hidden" id="user_exp${status.index }" value="${certList.user_exp }">
						<input type="hidden" id="percentage${status.index }" value="${certList.percentage }">
						<input type="hidden" id="icon${status.index }" value="${certList.icon }">
						<input type="hidden" id="likeyn${status.index }" value="${certList.likeyn }">
						<input type="hidden" id="chg_id${status.index}" value="${certList.chg_id}">
					
						<c:if test="${certList.brd_step == 0 }">
							<div class="mt-3 d-flex justify-content-center">
					
								<!-- Card -->
								<div class="card-lg card border col-10">
									<div class="card-body">
					
										<!-- Header -->
										<div class="row align-items-center">
					
											<!-- 인증 사진 -->
											<div class="col-4 text-center">
					
												<a href="/chgDetail?chg_id=${certList.chg_id }">
													<img src="${pageContext.request.contextPath}/upload/${certList.img}" alt="certImg"
														class="img-fluid" style="width: 200px; height: 100%;">
												</a>
					
											</div>
					
											<div class="col-8 ms-n2">
					
					
												<!-- Nick & Date & follow -->
												<div class="row mb-6">
													<div class="col-12">
														<span class="fs-xs text-muted d-flex justify-content-between">
					
															<span>
																<!-- 유저 프로필 사진 -->
																<div class="avatar avatar-lg">
																	<img src="${pageContext.request.contextPath}/upload/${certList.user_img}"
																		alt="profile" class="avatar-img rounded-circle">
																</div>
					
																<!-- Nick -->
																<img class="mx-1"
																	title="Lv.${certList.user_level } | exp.${certList.user_exp}(${certList.percentage }%)"
																	src="/images/level/${certList.icon}.gif">
					
																<span>
																	${certList.nick}
																</span>
															</span>
					
					
					
															<!-- follow -->
															<span>
																<c:choose>
																	<c:when test="${sessionScope.user_num != null }">
																		<!-- 로그인 한 상태 -->
																		<c:choose>
																			<c:when test="${certList.followyn == 1}">
																				<!-- 팔로잉 -->
																				<button type="button"
																					class="btn btn-light btn-xxs follow${certList.user_num}"
																					onclick="following(${certList.user_num})">
																					팔로잉
																				</button>
																			</c:when>
					
																			<c:otherwise>
																				<!-- 팔로우 -->
																				<button type="button"
																					class="btn btn-danger btn-xxs follow${certList.user_num}"
																					onclick="following(${certList.user_num})">
																					팔로우
																				</button>
																			</c:otherwise>
					
																		</c:choose>
					
																	</c:when>
					
																	<c:otherwise>
																		<!-- 로그인 안 한 상태 -->
																		<button type="button" class="btn btn-danger btn-xxs"
																			onclick="location.href='/loginForm'">
																			팔로우
																		</button>
																	</c:otherwise>
					
																</c:choose>
					
															</span>
														</span>
													</div>
												</div>
					
												<!-- Title & conts -->
												<div class="d-flex justify-content-between col-12">
													<a href="/chgDetail?chg_id=${certList.chg_id }" class="col-9">
														<!-- Title -->
														<p class="mb-2 fs-lg fw-bold" style="color: black;">
															${certList.title}
														</p>
					
														<!-- conts -->
														<p class="text-gray-500">
															${certList.conts }
														</p>
													</a>
					
													<!-- Date -->
													<!-- 오늘 날짜 -->
													<jsp:useBean id="javaDate" class="java.util.Date" />
													<fmt:formatDate var="nowDateFd" value="${javaDate }" pattern="yyyy-MM-dd" />
													<fmt:parseDate var="nowDatePd" value="${nowDateFd }" pattern="yyyy-MM-dd" />
													<fmt:parseNumber var="nowDatePn" value="${nowDatePd.time/(1000*60*60*24) }"
														integerOnly="true" />
					
													<!-- 마지막 작성일자 -->
													<fmt:formatDate var="lastRegDateFd" value="${certList.reg_date }"
														pattern="yyyy-MM-dd" />
													<fmt:parseDate var="lastRegDatePd" value="${lastRegDateFd }" pattern="yyyy-MM-dd" />
													<fmt:parseNumber var="lastRegDatePn" value="${lastRegDatePd.time/(1000*60*60*24) }"
														integerOnly="true" />
					
													<c:set var="dDay" value="${nowDatePn - lastRegDatePn}" />
					
													<span class="text-gray-500 col-3 text-end">${dDay }일 전</span>
					
					
												</div>
					
												<!-- 좋아요 & 댓글 -->
												<footer class="fs-xs text-muted">
					
													<c:choose>
														<c:when test="${sessionScope.user_num != null }">
															<!-- 로그인 한 상태 -->
					
															<a class="rate-item" data-toggle="vote" role="button"
																onclick="likePro('인증', ${status.index})">
																좋아요
																<c:choose>
																	<c:when test="${certList.likeyn > 0}">
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
																<span id="inputLikeCnt${status.index}">${certList.like_cnt}</span>
															</a>
														</c:when>
					
														<c:otherwise>
															<!-- 로그인 안 한 상태 -->
															<a class="rate-item" data-toggle="vote" data-count="${certList.like_cnt}"
																href="/loginForm" role="button">
																좋아요
																<img alt="heart" src="./images/yr/heart.png">
															</a>
														</c:otherwise>
					
													</c:choose>
					
													<!-- 댓글 -->
													<a class="rate-item" data-count="${certList.replyCount}" role="button"
														onclick="comment(${status.index})" data-bs-toggle="modal"
														data-bs-target="#showModal${status.index}">
														댓글
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
															class="bi bi-chat-dots" viewBox="0 0 16 16">
															<path
																d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
															<path
																d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2" />
														</svg>
													</a>
					
												</footer>
											</div>
										</div>
									</div>
								</div>
					
							</div>
						</c:if>
					
						<!-- 댓글 클릭 시 modal -->
						<div class="modal fade" id="showModal${status.index}" tabindex="-1" role="dialog" aria-hidden="true">
							<div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
								<div class="modal-content" style="max-height: calc(100vh - 200px); overflow-x: hidden; overflow-y: auto;">
									<!-- Body -->
									<div class="modal-body text-center">
										<!-- 인증글 원글 in modal -->
										<div class="review p-5">
											<div class="row d-flex justify-content-between">
												<div class="col-4 text-start">
													<!-- 유저 프로필 사진 -->
													<div class="avatar avatar-lg">
														<img src="" alt="profile" class="avatar-img rounded-circle"
															id="inputUserImg${status.index}">
													</div>
					
													<!-- Nick -->
													<div class="row mb-6">
														<div class="col-12">
															<span class="fs-xs text-muted d-flex justify-content-between">
					
																<span>
																	<!-- Nick -->
																	<img title="" src="" id="inputUserLevel${status.index}">
					
																	<span id="inputNick${status.index}">
																	</span>
																</span>
															</span>
														</div>
													</div>
												</div>
					
												<div class="col-6 text-start">
													<div>
														<!-- Title -->
														<p class="mb-2 fw-bold" id="inputTitle${status.index}">
														</p>
					
														<!-- Text -->
														<p class="text-gray-500 m-0" id="inputConts${status.index}">
														</p>
													</div>
												</div>
					
												<!-- Footer -->
												<div class="col-md-auto row align-items-center">
					
													<!-- Rate -->
													<c:choose>
														<c:when test="${sessionScope.user_num != null }">
															<!-- 로그인 한 상태 -->
					
															<a class="rate-item" data-toggle="vote" role="button"
																onclick="likePro('modal', ${certList.brd_num})">
																<c:choose>
																	<c:when test="${certList.likeyn > 0}">
																		<!-- 좋아요 눌렀을 때 -->
																		<img alt="heart-fill" src="./images/yr/heart-fill.png"
																			id="likeBtn${certList.brd_num }">
																	</c:when>
					
																	<c:otherwise>
																		<!-- 좋아요 안 눌렀을 때 -->
																		<img alt="heart" src="./images/yr/heart.png"
																			id="likeBtn${certList.brd_num }">
																	</c:otherwise>
					
																</c:choose>
																<span id="inputLikeCnt${certList.brd_num}">${certList.like_cnt}</span>
															</a>
														</c:when>
					
														<c:otherwise>
															<!-- 로그인 안 한 상태 -->
															<a class="rate-item" data-toggle="vote" data-count="${certList.like_cnt}"
																href="/loginForm" role="button">
																<img alt="heart" src="./images/yr/heart.png">
															</a>
														</c:otherwise>
					
													</c:choose>
					
					
												</div>
					
											</div>
										</div>
										<hr>
					
										<!-- 인증글 댓글 -->
										<c:forEach var="comment" items="${chgCertList }" varStatus="cmtSts">
											<c:choose>
												<c:when test="${comment.brd_step > 0 && comment.brd_group == certList.brd_num}">
													<input type="hidden" id="brd_num_cmt${cmtSts.index }" value="${comment.brd_num }">
													<div class="review p-5">
														<div class="row d-flex justify-content-between">
															<div class="col-4 text-start">
																<!-- 유저 프로필 사진 -->
																<div class="avatar avatar-lg">
																	<img src="${pageContext.request.contextPath}/upload/${comment.user_img}"
																		alt="profile" class="avatar-img rounded-circle">
																</div>
					
																<!-- Nick -->
																<div class="row mb-6">
																	<div class="col-12">
																		<span class="fs-xs text-muted d-flex justify-content-between">
					
																			<span>
																				<!-- Nick -->
																				<img title="Lv.${comment.user_level } | exp.${comment.user_exp}(${comment.percentage }%)"
																					src="/images/level/${comment.icon}.gif">
					
																				<span>
																					${comment.nick}
																				</span>
																			</span>
																		</span>
																	</div>
																</div>
															</div>
					
															<div class="col-6 text-start">
																<div>
																	<!-- Title -->
																	<p class="mb-2 fw-bold">
																		${comment.title}
																	</p>
					
																	<!-- conts -->
																	<p class="text-gray-500 m-0">
																		${comment.conts }
																	</p>
																</div>
															</div>
					
															<!-- Footer -->
															<div class="col-md-auto row align-items-center">
					
																<c:choose>
																	<c:when test="${sessionScope.user_num != null }">
																		<!-- 로그인 한 상태 -->
					
																		<a class="rate-item" data-toggle="vote" role="button"
																			onclick="likePro('댓글', ${cmtSts.index})">
																			<c:choose>
																				<c:when test="${comment.likeyn > 0}">
																					<!-- 좋아요 눌렀을 때 -->
																					<img alt="heart-fill" src="./images/yr/heart-fill.png"
																						id="likeBtn${cmtSts.index}">
																				</c:when>
					
																				<c:otherwise>
																					<!-- 좋아요 안 눌렀을 때 -->
																					<img alt="heart" src="./images/yr/heart.png"
																						id="likeBtn${cmtSts.index}">
																				</c:otherwise>
					
																			</c:choose>
																			<span
																				id="inputLikeCnt${cmtSts.index}">${comment.like_cnt}</span>
																		</a>
																	</c:when>
					
																	<c:otherwise>
																		<!-- 로그인 안 한 상태 -->
																		<a class="rate-item" data-toggle="vote"
																			data-count="${comment.like_cnt}" href="/loginForm"
																			role="button">
																			<img alt="heart" src="./images/yr/heart.png">
																		</a>
																	</c:otherwise>
					
																</c:choose>
					
					
															</div>
					
														</div>
													</div>
					
												</c:when>
					
												<c:otherwise>
					
												</c:otherwise>
											</c:choose>
										</c:forEach>
					
										<!-- 인증 댓글 쓰기 Form -->
										<div class="row mt-5">
											<form id="certCommentForm" action="/commentInsert" method="post"
												onsubmit="return commentInsertchk(this)">
					
												<c:choose>
													<c:when test="${sessionScope.user_num != null }">
														<!-- 로그인을 한 경우 -->
														<c:choose>
															<c:when test="${certList.chgryn == 1 }">
																<!-- 1. 참가자일 경우 -->
																<div class="col-12 col-md-6">
																	<input type="hidden" name="chg_id" value="${certList.chg_id }">
																	<input type="hidden" name="user_num" value="${user.user_num }">
																	<input type="hidden" name="brd_num" value="${certList.brd_num }">
																</div>
					
																<div class="col-12">
																	<!-- 제목 입력란  Name -->
																	<div class="form-group">
																		<label class="visually-hidden" for="reviewTitle">CertBrd
																			Title:</label>
																		<input class="form-control form-control-sm" id="commentTitle"
																			name="title" type="text" placeholder="제목을 작성해주세요 *">
																	</div>
																</div>
					
																<div class="col-12">
																	<!-- 댓글 입력란 Name -->
																	<div class="form-group">
																		<label class="visually-hidden" for="reviewText">CertBrd:</label>
																		<textarea class="form-control form-control-sm" id="commentConts"
																			name="conts" rows="5" placeholder="댓글을 작성해주세요 *"></textarea>
																	</div>
																</div>
															</c:when>
					
															<c:otherwise>
																<!-- 3. 참여자가 아닌 회원 -->
																<div class="col-12">
																	<!-- 제목 입력란  Name -->
																	<div class="form-group">
																		<label class="visually-hidden" for="reviewTitle">Review
																			Title:</label>
																		<input class="form-control form-control-sm" type="text" name="title"
																			placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
																	</div>
																</div>
					
																<div class="col-12">
																	<!-- 댓글 입력란 Name -->
																	<div class="form-group">
																		<label class="visually-hidden" for="reviewText">Review:</label>
																		<textarea class="form-control form-control-sm" rows="5" name="conts"
																			placeholder="챌린지 참여자만 글을 쓸 수 있습니다"
																			disabled="disabled"></textarea>
																	</div>
																</div>
															</c:otherwise>
														</c:choose>
													</c:when>
					
													<c:otherwise>
														<!-- 로그인을 안 한 경우 -->
														<div class="col-12">
															<!-- 제목 입력란  Name -->
															<div class="form-group">
																<label class="visually-hidden" for="reviewTitle">Review Title:</label>
																<input class="form-control form-control-sm" type="text" name="title"
																	placeholder="로그인 해주세요" disabled="disabled">
															</div>
														</div>
					
														<div class="col-12">
															<!-- 댓글 입력란 Name -->
															<div class="form-group">
																<label class="visually-hidden" for="reviewText">Review:</label>
																<textarea class="form-control form-control-sm" rows="5" name="conts"
																	placeholder="로그인 해주세요" disabled="disabled"></textarea>
															</div>
														</div>
													</c:otherwise>
												</c:choose>
					
												<div class="col-12 text-center">
													<!-- 등록 Button -->
													<button class="btn btn-dark btn-sm mx-1" type="submit">
														등록
													</button>
					
													<!-- 닫기 -->
													<button class="btn btn-light btn-sm mx-1" data-bs-dismiss="modal" type="button">
														닫기
													</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					
				</div>
				
				<div class="col-12 text-center mt-10">
					<form id="more">
						<input type="hidden" name="start" value="1">
						<input type="hidden" name="end" value="${board.end + 10}">
						<button type="button" onclick="moreList()" class="btn btn-sm btn-outline-dark">더보기</button>
					</form>
				</div>
			</div>
		</div>
	</section>	
	
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>