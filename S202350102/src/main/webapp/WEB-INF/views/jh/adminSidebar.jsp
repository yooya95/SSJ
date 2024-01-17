<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<div class="col-12 col-md-2">

            <!-- Filters -->
            <form class="mb-10 mb-md-0">
              <ul class="nav nav-vertical" id="filterNav">
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6"   href="/listUserAdmin" id="listUserDropDown">
                    	회원 관리
                  </a>

    		    </li>
    
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="#challengeAdmin" id="listChgDropDown">
                    	챌린지 관리
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="challengeAdmin">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="listChg">
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_md=100">
                            	신청 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_md=104">
                            	반려된 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_md=102">
                            	진행중 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_md=103">
                            	종료된 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgCommManagement">
                            	챌린지 카테고리
                          </a>
                        </li>
                      </ul>
                    </div>
    			  </div>
    			  
    			</li>
    
                <li class="nav-item">

   	 		 <!-- Toggle -->
    	             <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="#listComAdmin"  id="listComDropDown">
                    	커뮤니티 관리
                  </a>

                   <!-- Collapse -->
                  <div class="collapse" id="listComAdmin">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="listCom">
                         <li class="list-styled-item">
                          <a class="list-styled-link"  href="/sharAdminList">
                            	쉐어링
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/communityAdminList">
                            	자유게시판
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/reportListAdmin">
                            	인증게시판
                          </a>
                        </li>
                      </ul>
                    </div>
    			    </div>    
    			</li>
			</ul>
		</form>
	</div>
</body>
</html>