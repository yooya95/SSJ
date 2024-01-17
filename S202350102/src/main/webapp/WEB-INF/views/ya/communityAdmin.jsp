<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 자유게시판 게시글 조회</title>
</head>
<body>
<section class="pt-7 pb-12">
 <div class="container section-mt"><!--  style=" margin-left: 300px;" -->            
        <div class="row">
          <div class="col-12 text-center">			
            <!-- Heading -->        
            	<h3 class="mb-10">자유게시판 관리</h3>       
          </div>
        </div>        
               
        <div class="row">
        <!--사이드바   -->
         <%@ include file="../jh//adminSidebar.jsp" %>
		<div class="col-10 ">	
		<div class="row mb-5">
        </div>
        <!-- 게시판리스트    user_id에 회원정보 상세보기 링크 걸어두기 -->
            <div class="col-12">	
             <c:set var="num" value="${boardPage.total - boardPage.start+1 }"></c:set> 
                <table class="table table-bordered table-sm mb-0" > <!-- style="width:1200px" -->
                    <thead class="table-dark">
                        <tr class="p-2 text-center">
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>         
                            <th scope="col" class="th-user_id">아이디</th>
                            <th scope="col" class="th-nick">닉네임</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col" class="th-view_cnt">조회수</th>
                            <th scope="col"  class="text-center">삭제처리</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${listCommunity}" varStatus="status">
                        	<input type="hidden" value="${board.brd_num }">
                            <tr>
                                <td>${num}</td>                             
                                <td><a href="detailCommunity?user_num=${board.user_num}&brd_num=${board.brd_num}">${board.title}</a></td>
                                <td><a href="detailUserByAdmin?user_num=${board.user_num}">${board.user_id}</a></td>
                                <td>${board.nick}</td>
                                <td><fmt:formatDate value="${board.reg_date}" pattern="yy-MM-dd"/></td>
                                <td>${board.view_cnt}</td>
				         		<td class="justify-content-center">
									<button type="button" class="btn btn-secondary btn-xs" onclick="confirmDelete(${board.brd_num})">삭제</button>
									<%-- <button type="button" class="btn btn-secondary btn-xs"  onclick="location.href='/deleteCommunityAdmin?brd_num=${board.brd_num}'">삭제</button> --%>
								</td>
				         		<c:set var="num" value="${num-1}"></c:set> 			       
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
               </div>
 			
				<nav class="d-flex justify-content-center justify-content-md-center mt-3">
			     <ul class="pagination pagination-lg text-gray-400">
			        <c:if test="${boardPage.startPage > boardPage.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="communityAdminList?currentPage=${boardPage.startPage-boardPage.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${boardPage.startPage}" end="${boardPage.endPage}">
			            <li class="page-item <c:if test='${boardPage.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="communityAdminList?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${boardPage.endPage < boardPage.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="communityAdminList?currentPage=${boardPage.startPage+boardPage.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			   </nav>	
		</div>
	</div>		
</div>

<script>
    function confirmDelete(brd_num) {
        if (confirm("게시글을 삭제하시겠습니까?")) {
            location.href = '/deleteCommunityAdmin?brd_num=' + brd_num;
        } else {     
        }
    }
</script>


<div class="py-10"></div>
</section>			
<%@ include file="/WEB-INF/views/footer.jsp" %>		 			
</body>
</html>