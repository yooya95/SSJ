<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 리스트</title>
<script type="text/javascript">
  // yr 작성
  // follow 버튼
  function follow(type, p_index) {
	var user_num;
	if(type == 'following') {
		user_num = $('#following_user_num' + p_index).val();	// 상대방 user_num = following_id
	} else {
		user_num = $('#follower_user_num' + p_index).val();		// 내 user_num = user_num
	}
    // alert("user_num -> " + user_num);

    $.ajax({
      url: "/followingPro",
      type: "POST",
      data: { user_num : user_num },
      dataType: 'json',
      success: function (followResult) {
        
        if (followResult.following > 0) {
        	// 팔로우 성공
        	if(type == 'following') {
				$("#following" + p_index).text("팔로잉").removeClass("btn-danger").addClass("btn-light");
        	} else {
				$("#follower" + p_index).text("팔로잉").removeClass("btn-danger").addClass("btn-light");        		
        	}
        } else {
        	// 팔로우 취소
        	if(type == 'following') {
				$("#following" + p_index).text("팔로우").removeClass("btn-light").addClass("btn-danger");
        	} else {
				$("#follower" + p_index).text("팔로우").removeClass("btn-light").addClass("btn-danger");
        	}
        }
      },
      error: function () {
        alert("팔로우 오류");
      }

    });

  }

  //쪽지보내기 버튼 - following
//  function sendMessage(type, p_index) {
//	  var user_num = $('#user_num' + p_index).val();
//  }

</script>
</head>
<body>
  <div class="container section-mt">
    <div class="row profile">
      
      <div class="col-md-3">
        <%@ include file="/WEB-INF/views/mypageMenu.jsp" %>
      </div>

      <div class="col-md-9 profile-form">
        <!-- Nav -->
        <div class="container text-center" style="margin-top: 20px;">
	    	<h3>My Page</h3>
	    </div>
	    
	    
        <div class="container mt-7">
	        <div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
	          <a class="nav-link active" data-bs-toggle="tab" href="#followingList">
	            팔로잉
	          </a>
	          <a class="nav-link" data-bs-toggle="tab" href="#followerList">
	            팔로워
	          </a>
	        </div>
  
        <div class="tab-content">
          <!-- followingList -->
          <div class="tab-pane fade show active" id="followingList">
            <div class="row justify-content-center py-9">
              <div class="col-12 col-lg-10 col-xl-8">
                <div class="row">
                  <div class="col-12">
  
                    <!-- content -->
                    <div class="review">
                      <!-- Body -->
                      <c:forEach var="following" items="${followingList }" varStatus="status">
						<input type="hidden" id="following_user_num${status.index }" value="${following.following_id }">
                        <div class="review-body">
                          <div class="row d-flex justify-content-between align-items-center">
                            <!-- img -->
                            <div class="col-3">
                              <div class="avatar avatar-xxl mb-6 mb-md-0">
                                <span class="avatar-title rounded-circle">
                                  <img src="${pageContext.request.contextPath}/upload/${following.img}" alt="profile"
                                    class="avatar-title rounded-circle">
                                </span>
                              </div>
                            </div>
  
                            <!-- nick -->
                            	<div class="col-5">
                                  	<img title="Lv.${following.user_level } | exp.${following.user_exp}(${following.percentage }%)" src="/images/level/${following.icon}.gif">&ensp;
                                  	<span>${following.nick}</span>
                                 </div>
                                  
  
                              <!-- following & sendMessage -->
                                    <div class="col-4 text-end">
  
                                      <!-- following -->
                                      <button type="button" class="btn btn-light btn-xxs mb-1" onclick="follow('following', ${status.index})" id="following${status.index}">팔로잉</button>
  
                                      <!-- sendMessage --> 
                                      <!-- 
	                                  <button type="button" class="btn btn-info btn-xxs" onclick="sendMessage('following', ${status.index})">쪽지보내기</button>
	                                  -->
                                    </div>
                          </div>
                        </div>
                      </c:forEach>
                    </div>
  
                  </div>
                </div>
              </div>
            </div>
          </div>
  
  
  
          <!-- followerList -->
          <div class="tab-pane fade" id="followerList">
            <div class="row justify-content-center py-9">
              <div class="col-12 col-lg-10 col-xl-8">
                <div class="row">
                  <div class="col-12">
  
                    <!-- content -->
                    <div class="review">
                      <!-- Body -->
                      <c:forEach var="follower" items="${followerList }" varStatus="status">
                      	<input type="hidden" id="follower_user_num${status.index }" value="${follower.user_num }">
                        <div class="review-body">
                          <div class="row d-flex justify-content-between align-items-center">
                          
                            <!-- img -->
                            <div class="col-3">
                              <div class="avatar avatar-xxl mb-6 mb-md-0">
                                <span class="avatar-title rounded-circle">
                                  <img src="${pageContext.request.contextPath}/upload/${follower.img}" alt="profile"
                                    class="avatar-title rounded-circle">
                                </span>
                              </div>
                            </div>
  
                            <!-- nick -->
                                  <div class="col-5">
                                  	<img title="Lv.${follower.user_level } | exp.${follower.user_exp}(${follower.percentage }%)" src="/images/level/${follower.icon}.gif">&ensp;
                                  	<span>${follower.nick}</span>
                                 </div>
                                  
                            <div class="col-4 text-end">
  
                              <!-- follower & sendMessage -->
                              <!-- follower -->
                             
                              <c:choose>
                                  <c:when test="${follower.matpal == 1 }">
                                    <!-- 맞팔인 경우 -->
                                    <button type="button" class="btn btn-light btn-xxs mb-1" onclick="follow('follower', ${status.index})" id="follower${status.index}">팔로잉</button>
                                  </c:when>

                                  <c:otherwise>
                                    <!-- 맞팔이 아닌 경우 -->
                                    <button type="button" class="btn btn-danger btn-xxs mb-1" onclick="follow('follower', ${status.index})" id="follower${status.index}">팔로우</button>
                                  </c:otherwise>
                                </c:choose>

                                <!-- sendMessage -->
                                <!-- 
                                <button type="button" class="btn btn-info btn-xxs" onclick="sendMessage('follower', ${status.index})">쪽지보내기</button>
                                 -->
                                    
                            </div>
                          </div>
                        </div>
                      </c:forEach>
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
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>