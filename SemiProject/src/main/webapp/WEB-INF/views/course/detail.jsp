<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}'/>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${contextPath}/resources/css/course/course_detail.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=247193dfa28ad4e983e0bea6bc9fd614"></script>
</head>
<body>
<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
<div id="course_detail_wrapper">
	<div class="left_box">
		<div class="side_tab">
				<a href="${contextPath}/course/allList"><span class="spread-underline checked">여행코스 검색</span></a><br>
				<a href="${contextPath}/course/write"><span class="spread-underline">여행코스 만들기</span></a>
		</div>
	</div>
	<div class="right_box">
		<!-- 여행코스 세부 페이지 -->
		<div class="title">
			<blockquote>
			 	<p>${course.title}</p>
			</blockquote>
		</div>
		<div class="container">
		<div class="overview-text">
			<blockquote>
				<p>${course.overview}</p>
			</blockquote>
		</div>
		<div class="row-wrapper">
			<section style="background-color: #F0F2F5;">
				<div class="container py-5">
					<div class="main-timeline-2">
					<c:choose>
						<c:when test="${empty contentdetailList}">
						여행지 목록이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach items="${contentdetailList}" var="contentdetail">
							<div class="timeline-2">
								<div class="card">
									<img src="${contentdetail.firstimage}" alt="..." onerror="this.src='../../../resources/images/nocourseimg.png'" class="card-img-top"/>
									<div class="card-body p-4">              
										<h4 class="fw-bold mb-4">
										<a href="${contextPath}/tour/tour_detail?contentid=${contentdetail.contentid}&title=${contentdetail.title}&mapy=${contentdetail.mapy}&mapx=${contentdetail.mapx}">${contentdetail.title}</a>
										</h4>
									</div>
								</div>
							</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</section>
  			
  		</div>
  		
  		<div id="map-wrapper">
  			<div id="map" style="width:500px;height:400px;"></div>
  		</div>
		</div>
	</div>




<script>

var mapInfos;
var mapxList = new Array();
var mapyList = new Array();
var titleList = new Array();
	
<c:forEach items="${contentdetailList}" var="contentdetail">
	mapxList.push("${contentdetail.mapx}");
	mapyList.push("${contentdetail.mapy}");
	titleList.push("${contentdetail.title}")
</c:forEach>
	
console.log(mapInfos);


var mapContainer = document.getElementById('map');
var options = {
		center: new kakao.maps.LatLng(33.3891248662, 126.8050373428),
		level: 10
	};

var map = new kakao.maps.Map(mapContainer, options);

var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

for(var i=0; i<mapxList.length; i++){
	console.log(mapxList[i]);
	console.log(mapyList[i]);
	console.log(titleList[i]);
	var imageSize = new kakao.maps.Size(24, 35); // 마커 이미지 크기
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지 생성
    var marker = new kakao.maps.Marker({ // 마커 생성
        map: map, // 마커를 표시할 지도
        position: new kakao.maps.LatLng(mapyList[i], mapxList[i]),
        title : titleList[i], // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
</div>
</body>
</html>
