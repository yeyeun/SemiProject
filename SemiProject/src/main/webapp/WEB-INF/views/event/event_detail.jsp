<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<link rel="stylesheet" href="${contextPath }/resources/css/event/event_detail.css">
</head>
<body>
	<%
	String title = request.getParameter("title");
	String eventstartdate = request.getParameter("eventstartdate");
	String eventenddate = request.getParameter("eventenddate");
	%>

	<div class="headerContainer">
		<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
	</div>

	<div class="all_container">
		<hr style="border: none; height: 6px; background: black; opacity: 1;">
		<div class="title">
			<p id="title1"><%=title%></p>
			<p id="title2"><%=eventstartdate%>~<%=eventenddate%></p>
		</div>
		<div class="poster">
			<!-- 포스터 추가 -->
			<c:if test="${empty posterImageList}">
				<!-- 만약 posterImageList가 비어 있다면 기본 이미지를 표시합니다 -->
				<a href="#"> <img src="../../resources/images/noposterimg.png" class="posterImg">
				</a>
				<p id="posterClick">
					<b>이미지 클릭해서 크게 보기</b>
				</p>
			</c:if>
			<c:forEach items="${posterImageList}" var="poster">
				<a href="${poster}" target="_blank"> <img src="${poster}" class="posterImg" onerror="this.src='../../resources/images/noposterimg.png'">
				</a>
				<p id="posterClick">
					<b>이미지 클릭해서 크게 보기</b>
				</p>
			</c:forEach>
		</div>
		<!-- 상세정보영역 -->
		<div class="basicInfo">
			<p style="font-size: 30px">
				<b>상세정보</b>
			</p>
			<hr style="border: none; height: 6px; background: black; opacity: 1;">
			<c:if test="${empty infotextList}">
				<!-- 만약 infotextList가 비어 있다면 -->
					<p id="infotext">행사 정보가 없습니다.</p>
			</c:if>
			<c:forEach items="${infotextList}" var="infotext">
				<p id="infotext">${infotext}</p>
			</c:forEach>
		</div>
		<!-- 상세정보영역 -->
		<div class="carousel_container">
			<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel" data-bs-interval="0">

				<div class="carousel-inner">
					<!-- Carousel 아이템 영역 -->
					<c:if test="${empty eventImageList}">
						<!-- 만약 posterImageList가 비어 있다면 기본 이미지를 표시합니다 -->
						<a href="#"> <img src="../../resources/images/noeventimg.png" class="posterImg">
						</a>
						<p id="posterClick">
							<b>이미지 클릭해서 크게 보기</b>
						</p>
					</c:if>
					<c:forEach items="${eventImageList}" var="event">
						<div class="carousel-item">
							<img src="${event}" class="d-block w-100 custom-carousel-img" onerror="this.src='../../resources/images/noeventimg.png">
						</div>
					</c:forEach>
				</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true">&lt;</span> <span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true">&gt;</span> <span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
		<div class="detailInfo">
			<ul class="detailInfoList">
				<!-- 	상세정보 동적 추가 영역 -->
<%-- 				<c:if test="${empty detailIntroList}"> --%>
<!-- 						<p>상세정보가 존재하지 않습니다.</p> -->
<%-- 				</c:if> --%>
				<c:forEach items="${detailIntroList}" var="intro">
				<li><p class="ttext" id="eventPlace"><b>행사 장소: </b>${intro.eventplace}</p></li>
				<li><p class="ttext"><b>행사 시간: </b>${intro.playtime}</p></li>
				<li><p class="ttext"><b>이용 요금: </b>${intro.usetimefestival}</p></li>
				<li><p class="ttext"><b>행사 지원: </b>${intro.sponsor1}&nbsp;&nbsp;&nbsp;${intro.sponsor2}</p></li>
				</c:forEach>
<%-- 				<c:if test="${empty detailCommonList}"> --%>
<!-- 						<p>상세정보가 존재하지 않습니다.</p> -->
<%-- 				</c:if> --%>
				<c:forEach items="${detailCommonList}" var="common">
					<p id="mapx" style="display: none;">${common.mapx }<p>
					<p id="mapy" style="display: none;">${common.mapy }<p>
					<p id="mlevel" style="display: none;">${common.mlevel }<p>
					<li><p class="ttext"><b>홈페이지: </b>${common.homepage}</p></li>
                	<li><p class="ttext"><b>주최: </b>${common.telname}</p></li>
                	<li><p class="ttext"><b>문의 전화: </b>${common.tel}</p></li>
                </c:forEach>
			</ul>
		</div>
		<div class="mapInfo" style="margin-top: 50px;">
			<p style="font-size: 30px">
				<b>위치</b>
			</p>
			<hr style="border: none; height: 6px; background: black; opacity: 1;">
			<div id="map" style="width: 100%; height: 450px; border: 1px solid black;"></div>
		</div>
	</div>
	<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=247193dfa28ad4e983e0bea6bc9fd614"></script>
	<script>
	$(document).ready(function(){
        let carouselInner = $(".carousel-inner");
		let poster = $(".poster");
        let basicInfo = $(".basicInfo");
        let detailInfo =$(".detailInfo ul");

        
        $('.carousel-item:first').addClass('active');
        var locationName = document.getElementById("eventPlace").innerText;
        var mappx = document.getElementById("mapx").innerText;
        var mappy = document.getElementById("mapy").innerText;
        var mlevel = document.getElementById("mlevel").innerText;

	    
// 	    지도 추가

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(mappy, mappx), // 지도의 중심좌표
		        level: mlevel // 지도의 확대 레벨
		    };    

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = message;
		    
		});
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(mappy, mappx); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		
		var content = '<div class="event-map" style="padding:5px;">위치<br><a href="https://map.kakao.com/link/map/'+locationName+','+mappy+','+mappx+'" style="color:white; text-decoration-line:none;" target="_blank">'+locationName+'</a> <a href="https://map.kakao.com/link/to/'+locationName+','+mappy+','+mappx+'" style="color:white;" target="_blank">길찾기</a></div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var customOverlay = new kakao.maps.CustomOverlay({
		    position: markerPosition,
		    content: content,
		    yAnchor: 2
		});

		// 커스텀 오버레이를 지도에 표시합니다
		customOverlay.setMap(map);

	    
// 		var iwContent = '<div style="padding:5px;">행사 위치<br><a href="https://map.kakao.com/link/map/'+locationName+','+mappy+','+mappx+'" style="color:blue" target="_blank">'+locationName+'</a> <a href="https://map.kakao.com/link/to/'+locationName+','+mappy+','+mappx+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwPosition = new kakao.maps.LatLng(mappy, mappx); //인포윈도우 표시 위치입니다

// 		// 인포윈도우를 생성합니다
// 		var infowindow = new kakao.maps.InfoWindow({
// 		    position : iwPosition, 
// 		    content : iwContent 
// 		});
		  
// 		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
// 		infowindow.open(map, marker);
	}); //document.ready

 
</script>
</body>
</html>