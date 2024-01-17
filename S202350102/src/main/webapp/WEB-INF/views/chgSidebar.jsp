<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        
          <div class="col-12 col-md-4 col-lg-3">

            <!-- Filters -->
            <form class="mb-10 mb-md-0">
              <ul class="nav nav-vertical" id="filterNav">
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="#ingChallenge" id="ingDropDown">
                    	진행중 챌린지
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="ingChallenge">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="chgCtNav">
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/thChgList?state_md=102">
                            	전체
                          </a>
                        </li>
                        <c:forEach var="comm" items="${chgCategoryList }">
	                        <li class="list-styled-item" >
	                          <a class="list-styled-link" href="/thChgList?state_md=102&chg_lg=${comm.lg }&chg_md=${comm.md}">${comm.ctn }</a>
	                        </li>
                        </c:forEach>
                      </ul>
                    </div>
    			  </div>
    			  
    			</li>
    
    
    
     			<li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="#endChallenge">
                    	종료된 챌린지
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="endChallenge">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="productsNav">
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/thChgList?state_md=103">전체</a>
                        </li>
                        <c:forEach var="comm" items="${chgCategoryList }">
	                        <li class="list-styled-item">
	                          <a class="list-styled-link" href="/thChgList?state_md=103&chg_lg=${comm.lg }&chg_md=${comm.md}">${comm.ctn }</a>
	                        </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
		
                
              </ul>
            </form>
            
          <div style="text-align: center;">
	            <button class="btn w-100 btn-primary mb-2" onclick="location.href='/chgApplicationForm'" style="margin-top: 26px;">
	 				챌린지 개설 신청하기 <i class="fe fe-arrow-right ms-2"></i>
				</button>
		  </div>
			
<!-- 			<a class="btn w-100 btn-dark mb-2" href="sharingUserDetail" style=" margin-top: 50px;">게시글 작성하기 -->
<!--                </a> -->
         </div>
          
</body>
</html>