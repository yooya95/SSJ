<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>

<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- PRODUCT -->
<c:set var="usernum" value="${sessionScope.user_num}" />
<section>
     <div class="container section-mt">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <div class="col-12 col-md-6">
                        <!-- Images detailSharing과 똑같이 일치시킴! (이페이지에선 에러남) -->
                        <div class="row gx-5 mb-10 mb-md-0">
                            <div class="col-2">
                                <!-- Slider -->
                                <div class="flickity-nav flickity-vertical" data-flickity='{"asNavFor": "#productSlider", "draggable": false}'>
                                    <!-- Item -->
                                    <div class="ratio ratio-1x1 bg-cover mb-4" style="background-image: url(${pageContext.request.contextPath}/upload/${board.img});"></div>
                                </div>
                            </div>
                            <div class="col-10">
                                <!-- Card -->
                                <div class="card">
                                    <!-- Badge -->
                                  
                                    <!-- Slider -->
                                    <div data-flickity='{"draggable": false, "fade": true}' id="productSlider">
                                        <!-- Item -->
                                        <a href="${pageContext.request.contextPath}/upload/${board.img}">
                                            <img src="${pageContext.request.contextPath}/upload/${board.img}" alt="..." class="card-img-top">
                                        </a>
                                        <!-- Other Items -->
                                        <!-- ... -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 ps-lg-10" style="margin-top: 40px;">
                        <!-- Header -->
                        <div class="row mb-1">
                            <div class="col">
                                <!-- Preheading -->
                                <a class="text-muted" href="../sharing">쉐어링 게시판</a>
                            </div>
                            <div class="col-auto">
                                <a class="fs-sm text-reset ms-2" href="#reviews">
                                   Reviews (${board.replyCount})
                                </a>	
                            </div>
                        </div>
                        <!-- Heading, Price, Form -->
                        <h3 class="mb-1">${board.title}</h3>
                        <div class="mb-3 text-gray-400">
                             <span class="ms-1 fs-5 fw-bold"><fmt:formatNumber value="${board.price}" pattern="#,###"/>원</span>
                        </div>
                        <hr class="my-3">
                        
                        <!--  신청내용 -->
                        <p class="mb-4 fs-sm fw-bold">
                        <a class="text-body" href="product.html">작성자</a> <br>
	                      <span class="text-muted">${board.nick}</span>
	                    </p>
	                    <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">작성일</a> <br>
	                      <span class="text-muted">
						    <fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd"/>
						</span>
	                    </p>
	                    
	                    <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">모집인원</a> <br>
	                      <span class="text-muted">${board.applicants}명</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">참여인원</a> <br>
	                      <span class="text-muted">${board.participants}명</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">거래지역</a> <br>
	                      <span class="text-muted">${board.addr}</span>
	                    </p>
                        
                        <p class="mb-4 fs-sm fw-bold">
	                      <a class="text-body" href="product.html">내용</a> <br>
	                      <span class="text-muted">${board.conts}</span>
	                    </p>
                        <form>
                            <div class="form-group">
                                <!-- Labels for Applicants, Participants, and Content -->
                                <!-- ... -->
                                <!-- Submit Buttons -->
                                <div class="row">
                                    <div class="col-lg-3">
										    <a class="btn btn-sm btn-dark " href="/updateSharing1?brd_num=${board.brd_num}">
										        수정하기
										    </a>
										</div>

                                    <div class="col-lg-3">
                                        <%-- <a class="btn btn-outline-dark w-100" href="/deleteSharing?brd_num=${board.brd_num}"> --%>
                                        <a class="btn btn-sm btn-outline-dark" href="#" onclick="confirmDelete(${board.brd_num}, ${board.participants})">
											    삭제하기
										</a>
										<!--ya참가자 존재시 게시글 삭제 불가능 알람창 ------------------------------------>
										<script>
										function confirmDelete(brd_num, participants) {
										    if (participants > 0) {
										        alert("참가자가 존재하여 삭제가 불가능합니다.");
										    } else {
										        var confirmDelete = confirm("정말로 삭제하시겠습니까?");
										        if (confirmDelete) {
										            window.location.href = "/deleteSharing?brd_num=" + brd_num;
										        }
										    }
										}
										</script>     										
									</div>	
                                    <div class="col-lg-3">
                                        <%-- <a class="btn btn-outline-dark w-100" href="/deleteSharing?brd_num=${board.brd_num}"> --%>
                                        <a class="btn btn-sm btn-outline-dark" href="/mySharing">
											   목록이동
										</a>										
    
                                </div>
                                </div>
                               
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
                       

    
</section>

</body>
<%@ include file="commentSharing.jsp" %>
<%@ include file="../footer.jsp" %>
</html>
