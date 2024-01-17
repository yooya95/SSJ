<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/header4.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의</title>
	<script type="text/javascript" src="js/jquery.js"></script>
	<link rel="stylesheet" href="/css/qBoardList.css?after">
</head>
<body>
	<div class="mainBody section-mt">
	  <div class="qe_body">
	    <div class="qe_box">
	      <div class="qe_text_box">
	        <h2>문의게시판</h2>
	      </div>
	      <div class="qe_extra_box">
	      	<div class="qe_select_box">
	      		<c:if test="${user1.status_md == 102 }">
			      	<select name="brd_md" id="brd_md" onchange="categoryList()">
			      		<option value="all" <c:if test="${searchInfo.category eq 'all' }"> selected="selected" </c:if> >전체</option>
			      		<option value="user" <c:if test="${searchInfo.category eq 'user' }"> selected="selected" </c:if> >회원관련</option>
			      		<option value="buggy" <c:if test="${searchInfo.category eq 'buggy' }"> selected="selected" </c:if> >버그</option>
			      		<option value="challenge" <c:if test="${searchInfo.category eq 'challenge' }"> selected="selected" </c:if> >챌린지</option>
			      		<option value="sharing" <c:if test="${searchInfo.category eq 'sharing' }"> selected="selected" </c:if> >쉐어링</option>
			      		<option value="follow" <c:if test="${searchInfo.category eq 'follow' }"> selected="selected" </c:if> >팔로워</option>
			      		<option value="suggest" <c:if test="${searchInfo.category eq 'suggest' }"> selected="selected" </c:if> >기타/건의</option>
			      	</select>
		      	</c:if>
	      	</div>
	      	<div class="qe_write_box">
		        <c:if test="${user1.user_id != null }">
					<a href="qBoardWriteForm"><span>문의하기</span></a>
				</c:if>	      	
	      	</div>

	      </div>
	      <div class="tb_body">
	      <c:set var="num" value="${page.total-page.start+1 }"></c:set>
	        <table class="tb_main">
	          <thead class="tb_thead">
	              <tr>
	                <td>번호</td>
	                <td>제목</td>
	                <td>작성자</td>
	                <td>카테고리</td>
	                <td>작성일자</td>
	                <td>조회수</td>
	              </tr>
	          </thead>
	          <tbody id="search-list">
				<c:forEach var="board" items="${qBoardList}">
					<c:if test="${board.user_num == user1.user_num || user1.status_md == 102 }">	
						<tr>
							<td>${num}</td>
							<td><a href="qBoardDetail?brd_num=${board.brd_num}">${board.title}</a></td>
							<td>
								<img title="Lv.${board.user_level } | exp.${board.user_exp}(${board.percentage }%)" src="/images/level/${board.icon}.gif">${board.nick}
							</td>
							<td>${board.category }</td>
							<td>
								<jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
								  <fmt:parseNumber value="${today.time / (1000 * 60 * 60 * 24)}" var="nowDays" integerOnly="true" />
								  <fmt:parseNumber value="${(board.reg_date.time + (9 * 60 * 60 * 1000)) / (1000 * 60 * 60 * 24)}" var="regDays" integerOnly="true" />
								  <c:set value="${nowDays - regDays }" var="dayDiff" />
								  <c:choose>
								    <c:when test="${dayDiff == 0 }">
								    	<fmt:formatDate value="${board.reg_date }" pattern="HH:mm"/>
								    </c:when>
								    <c:otherwise>
								        <fmt:formatDate value="${board.reg_date }" pattern="yy.MM.dd"/>
								    </c:otherwise>
								  </c:choose>
							</td>
							<td>${board.view_cnt}</td>
							<c:set var="num" value="${num-1 }"></c:set>
						</tr>
					</c:if>
				</c:forEach>
	          </tbody>
	        </table>
	        <c:if test="${searchInfo.keyword == null }">
		        <div class="page" id="page">
		        	<c:if test="${page.startPage > page.pageBlock }">
						<a href="qBoardList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<a href="qBoardList?currentPage=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage }">
						<a href="qBoardList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
					</c:if>
				</div>
			</c:if>
			<c:if test="${searchInfo.keyword != null }">
		        <div class="page" id="page">
		        	<c:if test="${page.startPage > page.pageBlock }">
						<a href="qBoardList?currentPage=${page.startPage-page.pageBlock}&keyword=${searchInfo.keyword }&searchType=${searchInfo.searchType}&category=${searchInfo.category}">[이전]</a>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<a href="qBoardList?currentPage=${i}&keyword=${searchInfo.keyword }&searchType=${searchInfo.searchType}&category=${searchInfo.category}">[${i}]</a>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage }">
						<a href="qBoardList?currentPage=${page.startPage+page.pageBlock}&keyword=${searchInfo.keyword }&searchType=${searchInfo.searchType}&category=${searchInfo.category}">[다음]</a>
					</c:if>
				</div>
			</c:if>
			<c:if test="${user1.status_md == 102 }">
			<div class="search">
				<div class="select">
					<select id="search-select">
						<option value="title" <c:if test="${searchInfo.searchType eq 'title' }"> selected="selected" </c:if>>제목</option>
						<option value="conts" <c:if test="${searchInfo.searchType eq 'conts' }"> selected="selected" </c:if>>내용</option>
						<option value="nick" <c:if test="${searchInfo.searchType eq 'nick' }"> selected="selected" </c:if>>작성자</option>
					</select>
					<input class="search-box" id="searchValue" type="text" size="20" <c:if test="${searchInfo.keyword != 'null' }"> value="${searchInfo.keyword }" </c:if>>
				</div>
				<div class="search-btn">
					<button class="search-btn-form" type="button">검색</button>
				</div>
			</div>
			</c:if>	
	      </div>
	    </div>
	  </div>
	</div>
	
</body>
<script type="text/javascript">
    $(function() {
        // 검색 버튼 클릭 이벤트 핸들러
        function search() {
            var searchType = $('#search-select').val();
            var category = $('#brd_md').val();
            var keyword = $('.search-box').val();
/*             if (keyword == "") {
                window.location.href = "/qBoardList";
                return;
            }
 */
            $.ajax({
                url: "qboardListSearch",
                type: "GET",
                data: {
                    keyword: keyword,
                    searchType: searchType,
                    category: category
                },
                dataType: "json",
                success: function(data) {
                    $('#page').empty();
                    $('#search-list').empty();
                    var list = data.list;
                    var page = data.page;

                    if (list && list.length > 0) {
                        for (var i = 0; i < list.length; i++) {
                            var result = list[i];
                            var img = "<img title='Lv."+result.user_level+" | exp."+result.user_exp+"("+result.percentage+"%)', src='/images/level/"+result.icon+".gif' >";
                            var str = '<tr>';
                            console.log(result);
                            str += "<td>" + (page.total - i) + "</td>";
                            str += "<td><a href='qBoardDetail?brd_num=" + result.brd_num + "'>" + result.title + "</a></td>";
                            str += "<td>" +img+result.nick + "</td>";
                            str += "<td>"+result.category+"</td>";
                            var formatDate = new Date(result.reg_date);
                            var day = formatDate.getDate();
                            var month = formatDate.getMonth() + 1;
                            var year = formatDate.getFullYear() % 100;
        					var hours = formatDate.getHours();
        					var minutes = formatDate.getMinutes();
        					
                            day = (day < 10) ? '0' + day : day;
                            month = (month < 10) ? '0' + month : month;
                            year = (year < 10) ? '0' + year : year;
        					hours = (hours < 10) ? '0' + hours : hours;
        					minutes = (minutes < 10) ? '0' + minutes : minutes;
        					var sysdate = new Date();
        					if (sysdate.getDate() === formatDate.getDate()) {
        					    // 날짜가 sysdate와 다르면 시간을 표시
        					    str += "<td>" + hours + ":" + minutes + "</td>";
        					} else {
        					    // 날짜가 sysdate와 같으면 날짜를 표시
        					    str += "<td>" + year + '.' + month + '.' + day + "</td>";
        					}
                            str += "<td>" + result.view_cnt + "</td>";
                            str += "</tr>";
                            $('#search-list').append(str);
                        }

                        // 페이지 링크 추가
                        if (page.startPage > page.pageBlock) {
                            var prevPage = page.startPage - page.pageBlock;
                            $('#page').append('<a href="#" id="page-link" data-page="' + prevPage + '">[이전]</a>');
                        }

                        for (var i = page.startPage; i <= page.endPage; i++) {
                            $('#page').append('<a href="#" id="page-link" data-page="' + i + '">[' + i + ']</a>');
                        }

                        if (page.endPage < page.totalPage) {
                            var nextPage = page.startPage + page.pageBlock;
                            $('#page').append('<a href="#" id="page-link" data-page="' + nextPage + '" >[다음]</a>');
                        }
                    } else {
                        $('#search-list').append('<tr><td colspan="30">검색 결과가 없습니다.</td></tr>');
                    }
                },
                error: function(error) {
                    console.log("에러발생: " + error);
                }
            });
        }

        // 검색 버튼 클릭 이벤트 핸들러 등록
        $(document).off('click', '.search-btn-form');
        $(document).on('click', '.search-btn-form', search);

        // Enter 키 눌렀을 때 검색 실행
        $('.search-box').off('keypress')
        $('.search-box').on('keypress', function(event) {
            if (event.keyCode == 13) {
                search();
            }
        });

        // 페이지 링크를 클릭했을 때의 이벤트 처리
        $(document).off('click', '#page-link');
        $(document).on('click', '#page-link', function searchPage() {
            var searchType = $('#search-select').val();
            var keyword = $('.search-box').val();
            var category = $('#brd_md').val();

            // 클릭한 페이지의 번호를 가져와서 해당 페이지로 이동
            var targetPage = $(this).data('page');
            window.location.href = 'qBoardList?currentPage=' + targetPage + '&keyword=' + keyword+'&searchType='+searchType+'&category='+category;
        });
    });
    
    function categoryList() {
		var category = $('#brd_md').val();
		$.ajax({
			url: "qboardListSearch",
			type: "GET",
			data: { category: category },
			dataType: "json",
			success: function(result) {
                $('#page').empty();
                $('#search-list').empty();
                var list = result.list;
                var page = result.page;
                console.log(page);
                console.log(list);

                if (list && list.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        var result = list[i];
                        var str = '<tr>';
                        console.log(result);
                        var img = "<img title='Lv."+result.user_level+" | exp."+result.user_exp+"("+result.percentage+"%)', src='/images/level/"+result.icon+".gif' >";
                        
                        str += "<td>" + (page.total - i) + "</td>";
                        str += "<td><a href='qBoardDetail?brd_num=" + result.brd_num + "'>" + result.title + "</a></td>";
                        str += "<td>" +img+result.nick + "</td>";
                        str += "<td>"+result.category+"</td>";
                        var formatDate = new Date(result.reg_date);
                        var day = formatDate.getDate();
                        var month = formatDate.getMonth() + 1;
                        var year = formatDate.getFullYear() % 100;
    					var hours = formatDate.getHours();
    					var minutes = formatDate.getMinutes();
    					
                        day = (day < 10) ? '0' + day : day;
                        month = (month < 10) ? '0' + month : month;
                        year = (year < 10) ? '0' + year : year;
    					hours = (hours < 10) ? '0' + hours : hours;
    					minutes = (minutes < 10) ? '0' + minutes : minutes;
    					var sysdate = new Date();
    					if (sysdate.getDate() === formatDate.getDate()) {
    					    // 날짜가 sysdate와 다르면 시간을 표시
    					    str += "<td>" + hours + ":" + minutes + "</td>";
    					} else {
    					    // 날짜가 sysdate와 같으면 날짜를 표시
    					    str += "<td>" + year + '.' + month + '.' + day + "</td>";
    					}
                        str += "<td>" + result.view_cnt + "</td>";
                        str += "</tr>";
                        $('#search-list').append(str);
                    }

                    // 페이지 링크 추가
					if (page.startPage > page.pageBlock) {
					    var prevPage = page.startPage - page.pageBlock;
					    $('#page').append('<a href="#" id="page-link" data-page="' + prevPage + '" data-category="' + category + '">[이전]</a>');
					}
					
					for (var i = page.startPage; i <= page.endPage; i++) {
					    $('#page').append('<a href="#" id="page-link" data-page="' + i + '" data-category="' + category + '">[' + i + ']</a>');
					}
					
					if (page.endPage < page.totalPage) {
					    var nextPage = page.startPage + page.pageBlock;
					    $('#page').append('<a href="#" id="page-link" data-page="' + nextPage + '" data-category="' + category + '">[다음]</a>');
					}
			  }
			}
		});
    	
    }
    
    
    
    
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>