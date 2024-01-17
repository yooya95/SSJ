<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%> 
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

/*댓글 조회 아작스-- 게시글 부모글의 정보로 조회됨 */
var brd_num = ${board.brd_num}; 
var sessionUserNum = ${sessionScope.user_num};
var user_num =  ${board.user_num};

console.log("brd_num: " + brd_num);
console.log("user_num: " +  user_num);

$(document).ready(function(){
    listComment(brd_num);
});

function listComment() {
    var brd_num = ${board.brd_num}
    var user_num =  ${board.user_num};
    
    $.ajax({
        url: "listComment?brd_num=" + brd_num,
        type: "GET",
        data: {  
            user_num: user_num,
            brd_num: brd_num,
        },
        dataType: "json",
        success: function (result) {
        	console.log(result)
            var commentList = $("#commentList");
            
            commentList.empty();
            console.log("listcomment brd_num: " + brd_num);
            console.log("listcomment user_num: " + user_num);
            console.log("listcomment sessionUserNum :" + sessionUserNum)

            $.each(result, function (index, board) {
            	
            	var fullImageUrl = "${pageContext.request.contextPath}/upload/" + board.img;
                var listItem = $("<li class='list-group-item'></li>");
                var reviewContainer = $("<div class='review' style='padding-bottom:20px'></div>");
                var reviewBody = $("<div class='review-body style='padding-bottom:0px' style='padding-bottom :0px;'></div>");
                var row = $("<div class='row'></div>");
                var colMdAuto = $("<div class='col-12 col-md-auto'></div>");
                var avatar = $("<div class='avatar avatar-xxl mb-6 mb-md-0'></div>");
                avatar.append("<span class='avatar-title rounded-circle'> <img class='img-fluid' src='" + fullImageUrl + "' alt='Image' style='width: 150%; height: 100%; object-fit: cover;'> </span>");
                colMdAuto.append(avatar);
                var colMd = $("<div class='col-12 col-md'></div>");
                var headerRow = $("<div class='row mb-6'></div>");
                var headerCol = $("<div class='col-12'></div>");
                
                var regDate = new Date(board.reg_date);
                var formattedDateTime = regDate.toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });

                headerCol.append("<span class='fs-xs text-muted'>" + board.nick + " " + formattedDateTime + "</span>");
                headerRow.append(headerCol);
                
                var text = $("<p class='text-gray-500'>" + board.conts + "</p>");
                var footerRow = $("<div class='row align-items-center'></div>");
                
                reviewBody.append(row.append(colMdAuto).append(colMd.append(headerRow).append(text).append(footerRow)));
                reviewContainer.append(reviewBody);
                
                listItem.append(reviewContainer);

                if (${sessionScope.user_num} === board.user_num) {
                    // 댓글 수정 버튼
                    var commentUpdateButton = $("<button type='button' class='btn btn-xs btn-outline-border comment-update-btn ms-2'' data-user-num='" + board.user_num +
                        "'data-brd-num=" + board.brd_num + ">댓글 수정</button>");

                    // 댓글 삭제 버튼
                    var commentDeleteButton = $("<button type='button' class='btn btn-xs btn-outline-border comment-delete-btn ms-2'' data-user-num='" + board.user_num +
                        "'data-brd-num=" + board.brd_num + ">댓글 삭제</button>");

                    // 버튼을 가로로 나란히 놓기 위해 d-flex 클래스를 적용
                    var buttonsContainer = $("<div class='d-flex justify-content-end'></div>");
                    buttonsContainer.append(commentUpdateButton).append(commentDeleteButton);
                    
                    // 댓글 컨테이너에 버튼 컨테이너 추가
                    reviewContainer.append(buttonsContainer);
                }

                commentList.append(listItem);
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Ajax 요청 실패: " + errorThrown);
        }
    });
}





/*댓글 작성 아작스 */
    $(document).ready(function () {
        $("#submit-comment").click(function () {
            var user_num = $("#user_num").val();
            var brd_group = $("#brd_group").val();
            var conts = $("#conts").val();
            var brd_step = $("#brd_step").val();
            console.log("brd_num: " + brd_num);
            console.log("brd_group: " + brd_group);
         	console.log("conts" + conts);
            console.log("brd_step: " + brd_step);
            // 댓글 작성을 서버로 전송
            $.ajax({
                url: "commentWrite",
                type: "POST",
                data: {
                    user_num: user_num,
                    brd_num: brd_num,
                    brd_group: brd_group,
                    brd_step: brd_step,
                    conts: conts
                },
                dataType: "json",
                success: function (result) {
                    if (result.result === "success") {
                        // 댓글 작성이 성공한 경우, 댓글 목록 조회 아작스를 호출하여 댓글을 즉시 가져옴
                        listComment();
                        console.log("conts"+conts)
                    } else {
                        alert("댓글 작성에 실패했습니다.");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Ajax 요청 실패: " + errorThrown);
                    console.log("서버에서의 오류 메시지: " + jqXHR.responseText);
                }
            });
        });
    });
    
    
    /*댓글 수정 (게시글 본글 댓글 작성자 = 로그인 유저) */
    $(document).ready(function () {
       
    	// 댓글 수정 버튼을 클릭
        $(document).on('click', '.comment-update-btn', function () {       	
            // 클릭한 수정 버튼의 부모 엘리먼트 <li>
            var listItem = $(this).closest('li');
            //  li 요소에서 댓글 작성자의  user_num 가져오기  var user_num = $("#user_num").val(); 이러면 부모게시글꺼 가져옴
            var user_num = $(this).data('user-num');
            var brd_num = $(this).data('brd-num');
			var sessionUserNum = ${sessionScope.user_num};
			  console.log("user_num: " +user_num);
			  console.log("brd_num: " + brd_num);
		
			if (user_num == sessionUserNum) {
		    // 권한이 있는 경우 수정 버튼 활성화
			  console.log("수정 버튼 클릭 user_num: " +user_num);
			  console.log("수정 버튼 클릭 brd_num: " + brd_num);
			  console.log("수정 버튼 클릭 sessionUserNum: " +sessionUserNum );
            
			// 댓글 내용을 텍스트 필드로 교체           
            var originalContent = listItem.find('p').text();
            var inputField = $('<input type="text" class="form-control" value="' + originalContent + '">');
            listItem.find('p').replaceWith(inputField);

            // 수정 버튼 클릭 시, '저장' 버튼에 data-value를 추가하여 댓글 번호를 저장
         var saveButton = $('<button type="button" class="btn btn-xs btn-outline-border save-comment-btn" data-user-num="' + user_num + '" data-brd-num="' + brd_num + '">저장</button>');
            var cancelButton = $('<button type="button" class="btn btn-xs btn-outline-border cancel-comment-btn" data-user-num="' + user_num + '">취소</button>');
            var buttonContainer = $('<div style="position: relative; margin-top: 5px;"></div>').append(saveButton, cancelButton);
            listItem.append(buttonContainer);
            var user_num = listItem.find('.user_num').val();
  
            // 기존 수정 버튼을 비활성화
            $(this).prop('disabled', true);
		}   else {
			
            alert("게시글의 댓글 작성자와 다른 사용자는 수정할 수 없습니다.");
        }
    	
    	 // 취소 버튼 클릭 시
    	 $(document).on('click', '.cancel-comment-btn', function () {
    	        // 클릭한 취소 버튼의 부모 엘리먼트 <li>
    	        var listItem = $(this).closest('li');
    	        var user_num = $(this).data('user-num');
    	        // 수정된 내용을 원래 내용으로 되돌리기
    	        var originalContent = listItem.find('input').val();
    	        listItem.find('input').replaceWith('<span>' + originalContent + '</span>');
    	        
    	        // 수정 버튼 다시 활성화
    	        listItem.find('.comment-update-btn').prop('disabled', false);
    	        
    	        // 저장 버튼과 취소 버튼 제거
    	        listItem.find('.save-comment-btn, .cancel-comment-btn').remove();
    	 });   
    	       
    });

  });  	
        // 저장 버튼을 클릭
        $(document).on('click', '.save-comment-btn', function () {
            // 클릭한 저장 버튼의 부모 엘리먼트 <li>      
           var listItem = $(this).closest('li');

            // 수정된 내용을 가져와서 서버로 전송
            var newContent = listItem.find('input').val();
            var user_num = $(this).data('user-num');
            var brd_num = $(this).data('brd-num');
            
            // 댓글 번호와 사용자 번호를 data- 속성으로 추가
            $(this).data('user-num', user_num);
            $(this).data('brd-num', brd_num);
            
            
            console.log("저장  버튼 클릭 brd_num: " + brd_num);
            console.log("저장 버튼 클릭 user_num : " + user_num );
            
            // 댓글 작성자와 로그인 사용자가 같은지 확인
            if (${sessionScope.user_num}  === user_num) {
                $.ajax({
                    url: "commentUpdate",
                    type: "POST",
                    data: {
                        user_num: user_num, 
                        brd_num: brd_num,
                        conts: newContent
                    },
                    dataType: "json",
                    success: function (result) {
                        if (result.result === "success") {
                            // 수정이 성공하면 댓글 목록을 다시 불러오기
                            listComment();
                            
                            alert("댓글이 수정되었습니다.")
                        } else {
                            alert("댓글 수정에 실패했습니다.");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Ajax 요청 실패: " + errorThrown);
                    }
                });
            } else {
                alert("댓글 작성자와 다른 사용자는 수정할 수 없습니다.");
            }
        });
    /*삭제버튼 클릭 */
	$(document).on('click', '.comment-delete-btn', function () {
	    // 클릭한 삭제 버튼의 부모 엘리먼트 <li>
	    var listItem = $(this).closest('li');
	    var user_num = $(this).data('user-num');
	    var brd_num = $(this).data('brd-num');
	
	    // 댓글 번호와 사용자 번호를 data- 속성으로 추가
	    $(this).data('user-num', user_num);
	    $(this).data('brd-num', brd_num);
	
	    console.log("삭제 버튼 클릭 brd_num: " + brd_num);
	    console.log("삭제 버튼 클릭 user_num : " + user_num);
	
	    // 댓글 작성자와 로그인 사용자가 같은지 확인
	    if (${sessionScope.user_num} === user_num) {
	    	if (confirm("정말로 댓글을 삭제하시겠습니까?")) {
	    	    // 확인 버튼을 누른 경우 댓글 삭제를 서버로 전송
	    	    $.ajax({
	    	        url: "commentDelete",
	    	        type: "POST",
	    	        data: {
	    	            user_num: user_num,
	    	            brd_num: brd_num
	    	        },
	    	        dataType: "json",
	    	        success: function (result) {
	    	            // 삭제가 성공하면 삭제 후의 댓글 목록을 다시 불러오기
	    	            listComment();
	    	            if (result.result === "success") {
	    	                alert("댓글 삭제되었습니다.");
	    	                var deletedCommentElement = $('#commentList').find('li[data-brd-num="' + brd_num + '"]');
	    	                if (deletedCommentElement.length > 0) {
	    	                    deletedCommentElement.remove();
	    	                } else {
	    	                    console.log("삭제된 댓글을 찾을 수 없습니다.");
	    	                }
	    	            } else {
	    	                alert("댓글 삭제되었습니다.");
	    	            }
	    	        }
	    	    });
	        }
	    }
	    });
    </script>

 <!--댓글작성-->
<c:choose>
    <c:when test="${empty sessionScope.user_num}">
    <section class="pt-9 pb-8" id="reviews">
    <div class="container">
       <div class="row">
          <div class="col-12" align="center">
  			게시판 댓글을 확인하시려면 로그인을 해주세요!
  		  </div>
  	   </div>	  	
  	</div>	
  	</section>	
    </c:when>
    
    <c:otherwise> 
 <!-- REVIEWS -->

    <section class="pt-9 pb-8" id="reviews">
      <div class="container">
        <div class="row">
          <div class="col-12">
                <!-- Button -->
                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
                  	댓글 작성
                </a>
           </div>
        </div>
            <!-- New Review -->
            <div class="collapse" id="reviewForm">
              <!-- Divider -->
              <hr class="my-6">
              <!-- Form -->
	            <form name="commentWrite" action="/commentWrite" method="post" autocomplete="off">
                <input type="hidden" name="user_num"  id="user_num" value="${board.user_num}">
                <input type="hidden" name="brd_group" id="brd_group" value="${board.brd_group}">
                <input type="hidden" name="brd_step" id="brd_step" value="${board.brd_step}">
                <div class="row">
                   <div class="col-12">
                    <!-- Name -->
					<div class="form-group">
					  <label class="visually-hidden" for="reviewText"></label>
					  <textarea class="form-control form-control-sm full-width" id="conts" name="conts" rows="5" placeholder="댓글을 작성해주세요.*" required></textarea>
					</div>
                  </div>
                  <div class="col-12 text-center">

                    <!-- Button -->
                    <button class="btn btn-outline-dark" id="submit-comment" type="button">
                      	작성완료
                    </button>

                  </div>
                </div>
              </form>

            </div>
	</div>
	</section>
<!-- Reviews -->
  </c:otherwise> 
</c:choose> 
 <!-- 댓글 목록이 나타날 창  -->
		<div class="container">
		<ul class="list-group list-group-flush" id="commentList"> 
		</ul>
		</div>