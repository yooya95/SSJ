<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
      .map_wrap,
      .map_wrap * {
        margin: 0;
        padding: 0;
        font-size: 12px;
      }
      .map_wrap a,
      .map_wrap a:hover,
      .map_wrap a:active {
        color: #000;
        text-decoration: none;
      }
      .map_wrap {
        position: relative;
        width: 100%;
        height: 500px;
      }

      #menu_wrap {
        top: 0;
        left: 0;
        bottom: 0;
        width: 80%;
        display: inline-block;
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        overflow-y: auto;
        background: rgba(255, 255, 255, 0.7);
        z-index: 1;
        font-size: 12px;
        border-radius: 10px;
      }
      .bg_white {
        background: #fff;
      }
      #menu_wrap hr {
        display: block;
        height: 1px;
        border: 0;
        border-top: 2px solid #5f5f5f;
        margin: 3px 0;
      }
      #menu_wrap .option {
        text-align: center;
      }
      #menu_wrap .option p {
        margin: 10px 0;
      }
      #menu_wrap .option button {
        margin-left: 5px;
      }
      #placesList {
        padding-left: 0px;
      }
      #placesList li {
        list-style: none;
      }
      #placesList .item {
        position: relative;
        border-bottom: 1px solid #888;
        overflow: hidden;
        cursor: pointer;
        min-height: 65px;
      }
      #placesList .item span {
        display: block;
        margin-top: 4px;
      }
      #placesList .item h5,
      #placesList .item .info {
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
      }
      #placesList .item .info {
        padding: 10px 0 10px 55px;
      }
      #placesList .info .gray {
        color: #8a8a8a;
      }
	      #placesList .info .jibun {
        padding-left: 26px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
          no-repeat;
      }
      #placesList .info .tel {
        color: #009900;
      }
      #placesList .item .markerbg {
        float: left;
        width: 36px;
        height: 37px;
        margin: 10px 0 0 10px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
          no-repeat;
      }
      #placesList .item .marker_1 {
        background-position: 0 -10px;
      }
      #placesList .item .marker_2 {
        background-position: 0 -56px;
      }
      #placesList .item .marker_3 {
        background-position: 0 -102px;
      }
      #placesList .item .marker_4 {
        background-position: 0 -148px;
      }
      #placesList .item .marker_5 {
        background-position: 0 -194px;
      }
      #placesList .item .marker_6 {
        background-position: 0 -240px;
      }
      #placesList .item .marker_7 {
        background-position: 0 -286px;
      }
      #placesList .item .marker_8 {
        background-position: 0 -332px;
      }
      #placesList .item .marker_9 {
        background-position: 0 -378px;
      }
      #placesList .item .marker_10 {
        background-position: 0 -423px;
      }
      #placesList .item .marker_11 {
        background-position: 0 -470px;
      }
      #placesList .item .marker_12 {
        background-position: 0 -516px;
      }
      #placesList .item .marker_13 {
        background-position: 0 -562px;
      }
      #placesList .item .marker_14 {
        background-position: 0 -608px;
      }
      #placesList .item .marker_15 {
        background-position: 0 -654px;
      }
      #pagination {
        margin: 10px auto;
        text-align: center;
      }
      #pagination a {
        display: inline-block;
        margin-right: 10px;
      }
      #pagination .on {
        font-weight: bold;
        cursor: default;
        color: #777;
      }
      #keyword {
        padding: 12px;
        border-radius: 16px;
        border: none;
      }
      .button{
        padding: 12px;
        border-radius: 16px;
        border: none;
        background: linear-gradient(to bottom right, blue, pink);
        color: #ffffff;
      }
    </style>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9fb99f45a47c1c87ebbcfc532e1f831f&libraries=services"></script>
<script>
$(document).ready(function () {
    $("#srchSharing").submit(function (e) {
        e.preventDefault();

        var formData = $(this).serialize();

        $.ajax({
            type: "GET",
            url: "/srchSharing",
            data: formData,
            success: function (data) {
                // 서버에서 받은 JSON 데이터를 이용하여 동적으로 HTML 생성
                generateHtml(data);
            },
            error: function (error) {
                console.error(error);
            }
        });
    });

    function generateHtml(data) {
        // 검색 결과를 표시할 곳의 DOM 요소를 선택
        var searchResultsContainer = $("#searchResults");

        // 검색 결과가 없는 경우
        if (data.srch_shareResult.length === 0) {
            searchResultsContainer.html("<h6>검색결과가 없습니다.</h6>");
            return;
        }

        // 검색 결과가 있는 경우
        var html = "<table>";
        var num = 1;


        $.each(data.srch_shareResult, function (index, shrResultList) {
        	console.log(shrResultList);
            if (index < 5) { // 최대 5개까지만 표시
                var fullImageUrl = "${pageContext.request.contextPath}/upload/" + shrResultList.img;
                html += "<div class='row align-items-center position-relative mb-4' style='padding: 10px; height: 150px;'>" +
                    "<div class='col-3 col-md-3'>" +
                    "<img class='img-fluid' src='" + fullImageUrl + "' alt='Image' style='width: 100px; max-width: 150px; max-height: 150px;'>" +
                    "</div>" +
                    "<div class='col-9 col-md-9'>" +
                    "<p class='mb-0 fw-bold' style='font-size: 16px;'>" +
                    "<a class='stretched-link text-body' href='detailSharing?user_num=" + shrResultList.user_num + "&brd_num=" + shrResultList.brd_num + "'>" +
                    shrResultList.title + shrResultList.zipCode +
                    "</a>" +
                    "</p>" +
                    "<p class='mb-0 text-muted' style='font-size: 16px;'>" + new Date(shrResultList.reg_date).toLocaleDateString() + " | " + shrResultList.nick + "</p>" +
                    "</div>" +
                    "<div class='col-12'>" +
                    "<button class='btn btn-primary float-end'>위치 검색</button>" +
                    "</div>" +
                    "</div>";
            }
        });

        searchResultsContainer.html(html);

    }
    
    
});

</script>
</head>
<body>


    <!-- HEADER -->
    <section class=" pb-8">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-12 col-md-10 col-lg-8 col-xl-8">

            <!-- Heading -->
            <h3 class="mb-5 text-center">내주변 쉐어링</h3>
			<p class="mb-0 text-muted text-center" >검색어를 입력하면 지도 상에서 해당 지역에 등록된 물품이 마커로 표시됩니다.</p>
            <!-- Search -->
            
          </div>
        </div>
      </div>
    </section>
<body style="width: 100%; height: 100%; margin: 0 0 0 0">
    <div
      class="side_bar"
      style="
        width: 30%;
        height: 100%;
        background-color: white;
        float: left;
        text-align: center;
      "
    >


	
      <div id="menu_wrap" class="bg_white">
        <div class="option">
          <div>
            <form id="srchSharing">
              <div class="input-group input-group-merge">
              <input class="form-control" type="search" id="srch_sharing" name="srch_sharing" placeholder="검색어를 입력해주세요.">
              <div class="input-group-append">
                <button class="btn btn-outline-border" type="submit" style="margin-left: 0px;">
                  <i class="fe fe-search"></i></div> 
                <button class="btn btn-outline-border"  onclick="getLocation()" style="margin-left: 0px;">   
                  <i class="fa-solid fa-location-crosshairs" onclick="getLocation()"></i>
                </button>
              </div>
            </div>
            </form>
          </div>
        </div>
        <!-- 여기리스트 -->
        <div id="searchResults">
        <div class="offcanvas-body border-top fs-sm">
        <!-- Heading -->
        <p>에 대한 검색결과 입니다.</p>
    
    <div class="container">
			<c:if test="${empty srch_shareResult }">
				<h6>검색결과가 없습니다.</h6>
			</c:if>
			<table>
				<c:set var="num" value="1"/>
				<c:forEach items="${srch_shareResult }" var="shrResultList" varStatus="status">
					<c:if test="${num < 3 }">
						<tr>
							<td>
								<a href="detailSharing?user_num=${shrResultList.user_num}&brd_num=${shrResultList.brd_num}">${shrResultList.img} ${shrResultList.title }</a>
							</td>
							<td><fmt:formatDate value="${shrResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
							<td>${shrResultList.nick }</td>
						</tr>
						<c:set var="num" value="${num+1 }"/>
					</c:if>
				</c:forEach>
			</table>
		</div>
</div>    
    
    
       
      </div>

			
        
        <div id="pagination"></div>
      </div>
    </div>

    <div
      class="map_wrap"
      id="map"
      style="width: 65%; height: 100%; position: relative; overflow: hidden"
    ></div>


<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.5605672, 126.9433486), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 마커생성
var markerPosition  = new kakao.maps.LatLng(37.5605672, 126.9433486); 

var marker = new kakao.maps.Marker({
    position: markerPosition
});

//마커 지도에 추가


// 마커 배열에 추가
markers.push(marker);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});


</script>	



<script>
var x = document.getElementById("pos");
var map = null;

function getLocation() {
    navigator.geolocation.getCurrentPosition(showPosition);
}

function showPosition(position) {
   

    // 지도에 마커 표시
    if (!map) {
        // 지도를 생성할 때 한 번만 실행
        map = new kakao.maps.Map(document.getElementById('map'), {
            center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude),
            level: 3 // 지도의 확대 레벨
        });
    }

    var markerPosition = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);

    // 기존 마커 제거
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.BICYCLE);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.HYBRID);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.USE_DISTRICT);

    // 새로운 마커 추가
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커 지도에 추가
    marker.setMap(map);
}
</script>

	
	


</body>
<%@ include file="footer.jsp" %>
</html>