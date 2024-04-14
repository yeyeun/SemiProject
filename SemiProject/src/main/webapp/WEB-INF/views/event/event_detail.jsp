<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="../CSS/event_detail.css">
</head>
<body>
	<%
	String contentid = request.getParameter("contentid");
	String title = request.getParameter("title");
	String eventstartdate = request.getParameter("eventstartdate");
	String eventenddate = request.getParameter("eventenddate");
	String posterurl = "";
	%>

	<div class="headerContainer">
		<jsp:include page="header.jsp" />
	</div>

	<div class="all_container">
		<hr style="border: none; height: 6px; background: black; opacity: 1;">
		<div class="title">
			<p id="title1"><%=title%></p>
			<p id="title2"><%=eventstartdate%>~<%=eventenddate%></p>
		</div>
		<div class="poster">
			<!-- 포스터 추가 -->
		</div>
		<!-- 상세정보영역 -->
		<div class="basicInfo">
			<p style="font-size: 30px">
				<b>상세정보</b>
			</p>
			<hr style="border: none; height: 6px; background: black; opacity: 1;">
		</div>
		<!-- 상세정보영역 -->
		<div class="carousel_container">
			<div id="carouselExampleDark" class="carousel carousel-dark slide"
				data-bs-ride="carousel" data-bs-interval="0">

				<div class="carousel-inner">
					<!-- Carousel 아이템 영역 -->
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true">&lt;</span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true">&gt;</span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
		<div class="detailInfo">
			<ul class="detailInfoList">
				<!-- 	상세정보 동적 추가 영역 -->
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b179d98657949b7bb8bb0c0d1b9f2844"></script>
	<script>
	$(document).ready(function(){
        let carouselInner = $(".carousel-inner");
		let poster = $(".poster");
        let basicInfo = $(".basicInfo");
        let detailInfo =$(".detailInfo ul");
	    // detailImage1
	    $.ajax({
	        url: "https://apis.data.go.kr/B551011/KorService1/detailImage1?MobileOS=etc&MobileApp=test&_type=json&contentId="+<%=contentid%>+"&imageYN=Y&subImageYN=Y&numOfRows=999999&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D",
	        async: false,
	        success: function(data){
	            // Ajax 요청 성공시 실행되는 함수
	            var items = data.response.body.items.item;
	            var posterurl;
	            let isFirstImg = true; // 첫번째 이미지 처리
	            // 각 아이템을 돌면서 케러셀 아이템과 인디케이터를 추가합니다.
	            items.forEach(function(item, index) {
	                // 포스터인 경우 변수에만 저장
	                if (item.imgname.includes("포스터")) {  	
	                	posterurl = item.originimgurl;
	                    return; // 다음 아이템으로 넘어감
	                }
				
	                var activeClass = isFirstImg ? "active" : ""; // 첫 번째 아이템에는 active 클래스를 부여
	                isFirstImg = false; // 부여 되면 다음 아이템은 firstimg가 아님
	                console.log(index+"!@#!@#"+item.originimgurl);
	                if(item.originimgurl == null){
						carouselInner.append(`
								<img src="../images/noeventimg.png" class="d-block w-100 custom-carousel-img" alt="../images/noeventimg.png">
						`);
					} else{
	                // 케러셀 아이템을 추가합니다.
	                carouselInner.append(`
	                	    <div class="carousel-item \${activeClass}">
	                	        <img src="\${item.originimgurl}" class="d-block w-100 custom-carousel-img" alt="../images/noeventimg.png">
	                	    </div>
	                	`);
					}

	            });
	            if(posterurl == null){
	            	poster.append(`
		            		<img src="../images/noposterimg.png" class="posterImg" alt="../images/noposterimg.png">

		            		`);
	            }else{
	            poster.append(`
	            		<a href="\${posterurl}" target="_blank"><img src="\${posterurl}" class="posterImg" alt="../images/noposterimg.png"></a>
	            		<p id="posterClick"><b>이미지 클릭해서 크게 보기</b></p>
	            		`);
	            
	            }
	        }
	    });
	    
	    //detailInfo
	    $.ajax({
	        url: "https://apis.data.go.kr/B551011/KorService1/detailInfo1?MobileOS=etc&MobileApp=test&_type=json&contentId="+<%=contentid%>+"&contentTypeId=15&numOfRows=999999&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D",
	        async: false,
	        success: function(data){
	            // Ajax 요청 성공시 실행되는 함수
	            let items = data.response.body.items.item;
				

                $.each(items, (index, item) => {
	                basicInfo.append(`
	                		<p id="infotext">\${item.infotext}</p>
	                	`);
	            });
	        }
	    });
	    //detailCommon
	    $.ajax({
	        url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=etc&MobileApp=test&_type=json&contentId="+<%=contentid%>+"&contentTypeId=15&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&numOfRows=999999&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D",
	        async: false,
	        success: function(data){
	            // Ajax 요청 성공시 실행되는 함수
	            let items = data.response.body.items.item;

                $.each(items, (index, item) => {
                	mappx = item.mapx;
                	mappy = item.mapy; //좌표저장
                	

                	detailInfo.append(`
                			<li><p><b>홈페이지: </b>\${item.homepage}</p></li>
                			<li><p><b>주최: </b>\${item.telname}</p></li>
                			<li><p><b>문의 전화: </b>\${item.tel}</p></li>
	                	`);
	            });
	        }
	    });
	    //detailIntro
	    $.ajax({
	        url: "https://apis.data.go.kr/B551011/KorService1/detailIntro1?MobileOS=etc&MobileApp=test&_type=json&contentId="+<%=contentid%>+"&contentTypeId=15&numOfRows=99999&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D",
	        async: false,
	        success: function(data){
	            // Ajax 요청 성공시 실행되는 함수
	            let items = data.response.body.items.item;


                $.each(items, (index, item) => {
                	locationName = item.eventplace;
                	detailInfo.append(`
                			<li><p><b>행사 장소: </b>\${item.eventplace}</p></li>
                			<li><p><b>행사 시간: </b>\${item.playtime}</p></li>
                			<li><p><b>이용 요금: </b>\${item.usetimefestival}</p></li>
                			<li><p><b>행사 지원: </b>\${item.sponsor1}&nbsp;&nbsp;&nbsp;\${item.sponsor2}</p></li>
                			
                			
                			
	                	`);
	            });
	        }
	    });
	    console.log(mappx+"@@"+mappy);
// 	    지도 추가

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(mappy, mappx), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
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

		var iwContent = '<div style="padding:5px;">행사 위치<br><a href="https://map.kakao.com/link/map/'+locationName+','+mappy+','+mappx+'" style="color:blue" target="_blank">'+locationName+'</a> <a href="https://map.kakao.com/link/to/'+locationName+','+mappy+','+mappx+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(mappy, mappx); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker);
	}); //document.ready

 
</script>
	<jsp:include page="footer.jsp" />
</body>
</html>