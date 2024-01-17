<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="myChgPickList" style="width: 1000px; height: 400px">
   <!-- 게시판리스트  -->
      <div class="container" >
        <div class="col-12">
         <c:set var="num" value="${myUploadSharingPaging.total - myUploadSharingPaging.start+1 }"></c:set> 
                <table class="table table-bordered table-sm mb-0" >
                     <thead class="table-dark">
                        <tr class="p-2 text-center">
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">챌린지명</th>
                            <th scope="col" class="th-applicants" >참여인원</th>
                            <th scope="col" class="th-bank_duedate">진행기간</th>
                            <th scope="col" class="th-check">진행상태</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${myUploadSharingList}" varStatus="status">
                        <input type = "hidden" value="${board.brd_num }">
                             <tr>
                                <td>${num}</td>
                                <td><a href="/chgDetail?chg_id=${chg.chg_id }">${board.title}</a></td>
                                <td>${board.applicants}명</td>            
                                <td>${board.participants}명</td>      
                                <td>${board.bank_duedate}</td>
				         		<c:set var="num" value="${num-1}"></c:set> 	 	        
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>   
         </div>             
        </div>
        
			<nav class="d-flex justify-content-center justify-content-md-center mt-3">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${myUploadSharingPaging.startPage >myUploadSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage-myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${myUploadSharingPaging.startPage}" end="${myUploadSharingPaging.endPage}">
			            <li class="page-item <c:if test='${myUploadSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${myUploadSharingPaging.endPage <myUploadSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage+myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			 </nav>        
    </section>