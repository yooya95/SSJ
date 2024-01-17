<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<style type="text/css">
	.container {
	    max-width: 1200px;
	    margin: 0 auto;
	    padding: 20px;
	   
	}
	.page-title h3 {
	  font-size: 28px;
	  color: #333333;
	  font-weight: 400;
	  text-align: center;
	}
	.boardtable {
	  font-size: 15px;
	  height: 300px;
	  width: 100%;
	  border-top: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	}
	
	.boardtable a {
	  color: #333;
	  display: inline-block;
	  line-height: 1.4;
	  word-break: break-all;
	  vertical-align: middle;
	}
	.boardtable a:hover {
	  text-decoration: underline;
	}
	.boardtable th {
	  text-align: center;
	}
	
	.boardtable .th-num {
	  width: 100px;
	  text-align: center;
	}
	
	.boardtable .th-date {
	  width: 200px;
	}
	
	.boardtable .th-view_cnt {
	  width: 200px;
	}
	
	.boardtable .th-replyCount{
	  width: 200px;
	}
	
	.boardtable th, .board-table td {
	  padding: 14px 0;
	}
	
	.boardtable tbody td {
	  border-top: 1px solid #e7e7e7;
	  text-align: center;
	}
	
	.boardtable tbody th {
	  padding-left: 28px;
	  padding-right: 14px;
	  border-top: 1px solid #e7e7e7;
	  text-align: left;
	}

</style>
<title>Insert title here</title>
<script src="./js/jquery.js"></script>
<script type="text/javascript">
	function pageMove(brd_md, currentPage){
		/* alert(brd_md);
		alert(currentPage); */
		var brdMd = brd_md;
		var currentP = currentPage;
		var data = 
		$.ajax({
			url : "pageAjax",
			data: {brd_md : brdMd, currentPage : currentP},
			dataType: "json",
			success: function(result){				
				var text = "";
				text = brdText(result);
				$("#body"+result.page.brd_md).html(text);
				$("#body"+result.page.brd_md).css()
			}
		})
	}
	
	function brdText(result){
		var text ="";
		switch(result.page.brd_md){
		/**********************인증***************/
		case 100:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='reviewContent?brd_num="+result.listBdRe[i].brd_num+"&chg_id="+result.listBdRe[i].chg_id+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td>삭제"+"</td></tr>";
         		num = num - 1;            
			}
			return text;
			break;
		/**********************후기***************/
		case 101:						
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='reviewContent?brd_num="+result.listBdRe[i].brd_num+"&chg_id="+result.listBdRe[i].chg_id+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td></tr>";
         		num = num - 1;            
			}
			return text;
			
			break;
			/**********************쉐어링***************/
		case 102:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='detailSharing?brd_num="+result.listBdRe[i].user_num+"&brd_num="+result.listBdRe[i].brd_num+"'>"+result.listBdRe[i].title+"</a></td>"                	
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td><a href='/deleteCommunity?brd_num="+result.listBdRe[i].brd_num+"'>삭제</a></td></tr>";
         		num = num - 1;            
			}
			return text;
			break;
			/**********************자유***************/
		case 103:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='detailCommunity?brd_num="+result.listBdRe[i].user_num+"&brd_num="+result.listBdRe[i].brd_num+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td></tr>";
         			
         		num = num - 1;            
			}
			return text;
			break;
		}
		
		
		
	}
</script>
</head>
<body>
	<h4>인증 게시판</h4>
	<div id="board-list">
            <div class="container">
            <c:choose>
            	<c:when test="${not empty myCertiList }">
            		<c:set var="num" value="${myCertiPage.total - myCertiPage.start+1 }"></c:set> 
	                <table class="boardtable">
	                    <thead>
	                        <tr>
	                            <th scope="col" class="th-num">번호</th>
	                            <th scope="col" class="th-title">제목</th>
	                            <th scope="col" class="th-nick">작성자</th>
	                            <th scope="col" class="th-date">등록일</th>
	                            <th scope="col" class="th-view_cnt">조회수</th>
	                            <th  scope="col" class="th-replyCount">댓글수</th>
	                            <th  scope="col" ></th>
	                            <th></th>
	                        </tr>
	                    </thead>                 
	                    <tbody id="body${Certi_md }">
	                        <c:forEach items="${myCertiList }" var="myCertiList">
	                            <tr id="row${myCertiList.brd_num}">
	                                <td>${num}</td>
	                                <td><a href="detailCommunity?user_num=${myCertiList.user_num}&brd_num=${myCertiList.brd_num}">${myCertiList.title}</a></td>
	                                <td>${myCertiList.nick}</td>
	                                <td><fmt:formatDate value="${myCertiList.reg_date}" pattern="yyyy-MM-dd"/></td>
	                                <td>${myCertiList.view_cnt}</td>
					         		<td>${myCertiList.replyCount}</td>
					         		<td>삭제</td>
					         		<c:set var="num" value="${num-1}"></c:set> 			       
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                
					   <div class="page">
					    <c:if test="${myCertiPage.startPage >myCertiPage.pageBlock}">
					        <a href="listCommunity?currentPage=${myCertiPage.startPage-myCertiPage.pageBlock}">[이전]</a>
					    </c:if>
					    <c:forEach var="i" begin="${myCertiPage.startPage}" end="${myCertiPage.endPage}">					        
					        <a href="javascript:void(0);" onclick="pageMove(${Certi_md}, ${i }); return false;" >[${i}]</a>
					    </c:forEach>
					    <c:if test="${myCertiPage.endPage < myCertiPage.totalPage}">
					        <a href="listCommunity?currentPage=${myCertiPage.startPage+myCommuPage.pageBlock}">[다음]</a>
					    </c:if>
					</div>            	
            	</c:when> 
            	
            	<c:otherwise>
            		<h3>작성한 글이 없습니다.</h3>
            	</c:otherwise>
            	
			</c:choose>
				
            </div>
        </div>
	
	
	<hr>
	
	<h4>후기 게시판</h4>
	<div id="board-list">
            <div class="container">
            <c:choose>
            	<c:when test="${not empty myReviewList }">
            		<c:set var="num" value="${myReviewPage.total - myReviewPage.start+1 }"></c:set> 
	                <table class="boardtable">
	                    <thead>
	                        <tr>
	                            <th scope="col" class="th-num">번호</th>
	                            <th scope="col" class="th-title">제목</th>
	                            <th scope="col" class="th-nick">작성자</th>
	                            <th scope="col" class="th-date">등록일</th>
	                            <th scope="col" class="th-view_cnt">조회수</th>
	                            <th  scope="col" class="th-replyCount">댓글수</th>
	                        </tr>
	                    </thead>                 
	                    <tbody id="body${Review_md}">
	                        <c:forEach items="${myReviewList }" var="myReviewList">
	                            <tr id="row${myReviewList.brd_num }">
	                                <td>${num}</td>
	                                <td><a href="reviewContent?brd_num=${myReviewList.brd_num }&chg_id=${myReviewList.chg_id }">${myReviewList.title}</a></td>
	                                <td>${myReviewList.nick}</td>
	                                <td><fmt:formatDate value="${myReviewList.reg_date}" pattern="yyyy-MM-dd"/></td>
	                                <td>${myReviewList.view_cnt}</td>
					         		<td>${myReviewList.replyCount}</td>
					         		<c:set var="num" value="${num-1}"></c:set> 			       
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                
					<div class="page">
					    <c:if test="${myReviewPage.startPage >myReviewPage.pageBlock}">					        
					        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage-myReviewPage.pageBlock}); return false;" >[이전]</a>
					    </c:if>
					    <c:forEach var="i" begin="${myReviewPage.startPage}" end="${myReviewPage.endPage}">					    	
					        <a href="javascript:void(0);" onclick="pageMove(${Review_md}, ${i }); return false;" >[${i}]</a>
					    </c:forEach>
					    <c:if test="${myReviewPage.endPage < myReviewPage.totalPage}">					        
					        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>
					    </c:if>
					</div>            	
            	</c:when> 
            	
            	<c:otherwise>
            		<h3>작성한 글이 없습니다.</h3>
            	</c:otherwise>
            	
			</c:choose>
				
            </div>
        </div>
        
	
	<hr>
	
	<h4>자유 게시판</h4>
	<div id="board-list">
            <div class="container">
	            <c:choose>
	            	<c:when test="${not empty myCommuList }">
	            		<c:set var="num" value="${myCommuPage.total - myCommuPages.start+1 }"></c:set> 
		                <table class="boardtable">
		                    <thead>
		                        <tr>
		                            <th scope="col" class="th-num">번호</th>
		                            <th scope="col" class="th-title">제목</th>
		                            <th scope="col" class="th-nick">작성자</th>
		                            <th scope="col" class="th-date">등록일</th>
		                            <th scope="col" class="th-view_cnt">조회수</th>
		                            <th  scope="col" class="th-replyCount">댓글수</th>
		                            <th></th>
		                        </tr>
		                    </thead>                 
		                    <tbody>
		                        <c:forEach items="${myCommuList }" var="myCommuList">
		                            <tr>
		                                <td>${num}</td>
		                                <td><a href="detailCommunity?user_num=${myCommuList.user_num}&brd_num=${myCommuList.brd_num}">${myCommuList.title}</a></td>
		                                <td>${myCommuList.nick}</td>
		                                <td><fmt:formatDate value="${myCommuList.reg_date}" pattern="yyyy-MM-dd"/></td>
		                                <td>${myCommuList.view_cnt}</td>
						         		<td>${myCommuList.replyCount}</td>
						         		<td><a href="/deleteCommunity?brd_num=${myCommuList.brd_num}">삭제</a></td>
						         		<c:set var="num" value="${num-1}"></c:set> 			       
		                            </tr>
		                        </c:forEach>
		                    </tbody>
		                </table>
		                
						   <div class="page">
						    <c:if test="${myCommuPage.startPage >myCommuPage.pageBlock}">					        
						        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage-myCommuPage.pageBlock}); return false;" >[이전]</a>
						    </c:if>
						    <c:forEach var="i" begin="${myCommuPage.startPage}" end="${myCommuPage.endPage}">					        
						        <a href="javascript:void(0);" onclick="pageMove(${commu_bd}, ${i }); return false;" >[${i}]</a>
						    </c:forEach>
						    <c:if test="${myCommuPage.endPage < myCommuPage.totalPage}">					        
						        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>					        
						    </c:if>
						</div>            	
	            	</c:when> 
	            	
	            	<c:otherwise>
	            		<h3>작성한 글이 없습니다.</h3>
	            	</c:otherwise>
	            	
				</c:choose>
				
            </div>
        </div>
	
	
	<hr>
	
	<h4>쉐어링 게시판</h4>
	<div id="board-list">
            <div class="container">
            <c:choose>
            	<c:when test="${not empty myShareList }">
            		<c:set var="num" value="${mySharePage.total - mySharePage.start+1 }"></c:set> 
	                <table class="boardtable">
	                    <thead>
	                        <tr>
	                            <th scope="col" class="th-num">번호</th>
	                            <th scope="col" class="th-title">제목</th>
	                            <th scope="col" class="th-nick">작성자</th>
	                            <th scope="col" class="th-date">등록일</th>
	                            <th scope="col" class="th-view_cnt">조회수</th>
	                            <th  scope="col" class="th-replyCount">댓글수</th>
	                            <th  scope="col" ></th>
	                        </tr>
	                    </thead>                 
	                    <tbody id="body${Share_md }">
	                        <c:forEach items="${myShareList }" var="myShareList">
	                            <tr id="row${myShareList.brd_num }">
	                                <td>${num}</td>
	                                <td><a href="detailSharing?user_num=${myShareList.user_num}&brd_num=${myShareList.brd_num}">${myShareList.title}</a></td>
	                                <td>${myShareList.nick}</td>
	                                <td><fmt:formatDate value="${myShareList.reg_date}" pattern="yyyy-MM-dd"/></td>
	                                <td>${myShareList.view_cnt}</td>
					         		<td>${myShareList.replyCount}</td>
					         		<td><a href="/deleteCommunity?brd_num=${myShareList.brd_num}">삭제</a></td>
					         		<c:set var="num" value="${num-1}"></c:set> 			       
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                
					   <div class="page">
					    <c:if test="${mySharePage.startPage >mySharePage.pageBlock}">
					        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage-mySharePage.pageBlock}); return false;" >[이전]</a>
					    </c:if>
					    <c:forEach var="i" begin="${mySharePage.startPage}" end="${mySharePage.endPage}">
					        <a href="javascript:void(0);" onclick="pageMove(${Share_md}, ${i }); return false;" >[${i}]</a>
					    </c:forEach>
					    <c:if test="${mySharePage.endPage < mySharePage.totalPage}">
					        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage+mySharePage.pageBlock}); return false;" >[다음]</a>
					    </c:if>
					</div>            	
            	</c:when> 
            	
            	<c:otherwise>
            		<h3>작성한 글이 없습니다.</h3>
            	</c:otherwise>
            	
			</c:choose>
				
            </div>
        </div>
	
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>