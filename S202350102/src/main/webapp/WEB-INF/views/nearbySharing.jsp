<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header4.jsp" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9fb99f45a47c1c87ebbcfc532e1f831f&libraries=services"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>

#searchResults {
  max-height: 800px;
  overflow-y: auto;
  border: 1px solid #ddd; /* 테두리 선 추가 */
  border-radius: 8px; /* 테두리 선 둥글게 */
  padding: 10px; /* 내부 여백 추가 */
  background-color: #fff; /* 배경색 추가 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
}

#searchResults h6 {
  font-size: 18px; /* 헤딩의 글꼴 크기 변경 */
  margin-bottom: 15px; /* 아래 여백 추가 */
}

#searchResults .card {
  margin-bottom: 20px; /* 카드 사이의 간격 조정 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 각 카드에 그림자 효과 추가 */
}

#searchResults .card img {
  border-radius: 8px; /* 이미지를 둥글게 */
}

#searchResults .card a {
  text-decoration: none; /* 링크 밑줄 제거 */
  color: #333; /* 링크 색상 변경 */
}

#searchResults .card a:hover {
  color: #FFCCE5; /* 호버 시 링크 색상 변경 */
}

#searchResults p {
  margin-top: 8px; /* 문단 위 여백 추가 */
  font-size: 14px; /* 문단 글꼴 크기 변경 */
}

#searchResults .btn-outline-dark {
  transition: background-color 0.3s, color 0.3s; /* 버튼 호버 시 색상 전환 효과 추가 */
}

#searchResults .btn-outline-dark:hover {
  background-color: #E56D90; /* 버튼 호버 시 배경색 변경 */
  color: #fff; /* 버튼 호버 시 글자색 변경 */
}


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
            if (index < 100) { // 최대 5개까지만 표시
                var fullImageUrl = "${pageContext.request.contextPath}/upload/" + shrResultList.img;
                html +=
                    "<div class='card card-lg mb-5 border' style='padding: 10px; overflow: hidden;'>" +
                        "<div class='row'>" +
                            "<div class='col-3 col-md-3'>" +
                                "<img class='img-fluid' src='" + fullImageUrl + "' alt='Image' style='width: 150%; height: 100%; object-fit: cover;'>" +
                            "</div>" +
                            "<div class='col-9 col-md-9 simplebar' style='max-height: 400px;'> <!-- simplebar 클래스 추가 및 최대 높이 설정 -->" +
                                "<div class='d-flex flex-column justify-content-between h-100'>" +
                                    "<div class='text-left'>" +
                                        "<a href='detailSharing?user_num=" + shrResultList.user_num + "&brd_num=" + shrResultList.brd_num + "' class='text-body fw-bold' style='font-size: 16px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;'>" +
                                            shrResultList.title + "<p class='fs-xs' style='margin-bottom: 10px;'>" + "모집인원 : " + shrResultList.applicants +  " / 참여인원 : " + shrResultList.participants + " / 가격 : " + shrResultList.price + "원" + "</p>" + 
                                        "</a>" + "<p class='fs-xs' style='margin-bottom: 10px;'>" + shrResultList.addr + "</p>" +

                                    "</div>" +
                                    "<div class='d-flex justify-content-between' style='margin-top: 10px; overflow: hidden;'>" +
                                        "<p class='mb-0 text-muted' style='font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;'>" + new Date(shrResultList.reg_date).toLocaleDateString() +" 판매자:  "+ shrResultList.nick + "</p>" +
                                        "<a class='btn btn-sm btn-outline-dark' href='detailSharing?user_num=" + shrResultList.user_num + "&brd_num=" + shrResultList.brd_num + "'>자세히 보기</a>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
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
      <div class="container section-mt">
        <div class="row justify-content-center">
          <div class="col-12 col-md-10 col-lg-8 col-xl-8">

            <!-- Heading -->
            <h3 class="mb-5 text-center">내주변 쉐어</h3>
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
                  <i class="fe fe-search"></i></button>
                  </div>
                <button class="btn btn-outline-border"  onclick="getLocation()" style="margin-left: 0px;">   
                  <i class="fa-solid fa-location-crosshairs" onclick="getLocation()"></i>
                </button>
              </div>
            </form>
            </div>
           
          </div>
        </div>
        <!-- 여기리스트 -->
        <div id="searchResults" style="margin-right: 30px;margin-left: 30px;">
   
        <!-- Heading -->

    
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

			
        
        <div id="pagination"></div>
      </div>
 

    <div
      class="map_wrap"
      id="map"
      style="width: 65%; height: 100%; position: relative; overflow: hidden; margin-bottom: 100px;"></div>


<script>

//지도 옵션 설정
 var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
            center: new kakao.maps.LatLng(37.5605672, 126.9433486), // 지도의 중심좌표
            level: 9 // 지도의 확대 레벨
          };

//지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 지도 생성
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new daum.maps.LatLng(37.5605672, 126.9433486),
    level: 8
};
var map = new daum.maps.Map(mapContainer, mapOption);

//주소-좌표로 변환
var data = JSON.parse('${addrJson}');
console.log("jsondata"+data);

var geocoder = new kakao.maps.services.Geocoder();

// 비동기 처리를 위해 Promise 사용
function geocodeData(dataItem) {
    return new Promise(function (resolve) {
        geocoder.addressSearch(dataItem.addr, function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
                // Resolve with the coordinates and title
                resolve({
                    coords: new kakao.maps.LatLng(result[0].y, result[0].x),
                    title: dataItem.title,
                    addr: dataItem.addr,
                    user_num: dataItem.user_num,
                    brd_num: dataItem.brd_num,
                    img:dataItem.img
                 
                });

                console.log("user_num: " + dataItem.user_num + ", brd_num: " + dataItem.brd_num);

            } else {
                // Resolve with null if geocoding fails
                resolve(null);
            }
        });
    });
}

//Promise 배열 생성
var geocodePromises = data.map(function (dataItem) {
    return geocodeData(dataItem);
});

//Promise.all을 사용하여 모든 데이터에 대한 좌표를 얻은 후 처리
	Promise.all(geocodePromises)
	    .then(function (dataWithCoords) {
	        // 모든 좌표를 얻은 후 처리
	        dataWithCoords.forEach(function (item) {
	            if (item) {
	                // 좌표가 유효하면 커스텀 오버레이 생성
	// 예제에서는 가로 길이의 최소 값을 200px로 설정하였습니다.
var minWidth = 3;
var fullImageUrl = "${pageContext.request.contextPath}/upload/" + item.img;

var customOverlay = new kakao.maps.CustomOverlay({
    position: item.coords,
    content: '<div class="customOverlay" style="background-color: white; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-shadow: 3px 3px 5px #888888; display: flex; min-width: ' + minWidth + '20px;">' +
        '<div style="flex: 0 0 40%; padding-right: 10px;">' +
            '<img src="' + fullImageUrl + '" alt="이미지" style="width: 100%; height: auto;">' +
        '</div>' +
        '<div style="flex: 1; max-width: 200px; overflow: hidden;">' +
            '<div style="font-weight: bold; margin-bottom: 5px;">' + item.title + '</div>' +
            '<div style="margin-bottom: 15px;">' + item.addr + '</div>' +
            '<div style="text-align: right;">' +
                '<button class="btn btn-dark btn-xxs" style="width: 120px;" onclick="location.href=\'detailSharing?user_num=' + item.user_num + '&brd_num=' + item.brd_num + '\'">자세히 보기</button>' +
            '</div>' +
        '</div>' +
    '</div>',
    yAnchor: -0.1

});

// CustomOverlay가 지도에 추가되기 전에 각 데이터의 가로 길이를 계산하고 minWidth를 조절하도록 하십시오.


                customOverlay.setMap(map);
             
             // 마커 이미지 변경
             	var imageUrl = "/images/jk/icon02.png";

				var markerImage = new kakao.maps.MarkerImage(
				    imageUrl,
				    new kakao.maps.Size(50, 50),
				    { offset: new kakao.maps.Point(25, 35) }
				);

                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: item.coords,
                    map: map,
                    image: markerImage // 변경된 마커 이미지 적용
                    
                });
				
				
                // 커스텀 오버레이를 클릭할 때의 이벤트 핸들러 함수
                function overlayClickHandler() {
                    console.log("Marker or Custom Overlay clicked! User_num: " + item.user_num + ", Brd_num: " + item.brd_num);
                    // 클릭한 마커 또는 오버레이의 정보를 사용하여 페이지 이동
                    location.href = 'detailSharing?user_num=' + item.user_num + '&brd_num=' + item.brd_num;
                }

                // 커스텀 오버레이를 클릭할 때의 이벤트 핸들러를 추가
                kakao.maps.event.addListener(customOverlay, 'click', overlayClickHandler);
            }
        });
    });

function getLocation() {
    navigator.geolocation.getCurrentPosition(showPosition);
}

function showPosition(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;  

    // 지도에 마커 표시
    if (!map) {
        // 지도를 생성할 때 한 번만 실행
  map.panTo(currentPos);
        map = new kakao.maps.Map(document.getElementById('map'), {
            center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude),
            level: 2 // 지도의 확대 레벨
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
    map.panTo(markerPosition);
	
	}

function moveToMarker(index) {
    var marker = markers[index].marker;
    var position = marker.getPosition();

    // 해당 마커의 위치로 지도 이동
    map.panTo(position);
}
</script>

	
	


</body>
<%@ include file="footer.jsp" %>
</html>