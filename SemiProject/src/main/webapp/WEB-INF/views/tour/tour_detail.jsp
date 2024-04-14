<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tour_detail</title>
<c:set var="contextPath" value="<%=request.getContextPath()%>" scope="application"></c:set>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>	 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<link rel="stylesheet" href="${contextPath }/resources/css/tour/tour_detail.css"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c21d4e024682dd160eb186f02ced1e1"></script>
<script src="https://kit.fontawesome.com/3a115195d8.js" crossorigin="anonymous"></script>
</head>
<body>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<%
	String contentid = request.getParameter("contentid");
	String title = request.getParameter("title");
%>

<div class="menu">
	<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
</div>
	 <div class="container">
	  	<div class="tour_title" style="display:inline; white-space:nowrap;">
	  		<blockquote><h2><%=title %><button type="button" class="like" onclick="click()"><i class="fa-regular fa-heart" style="color: #7E57C2; margin-left:10px;"></i></button></h2>
	  		
	  		</blockquote>
        </div>
        <div class="row">
        	<div class="col">
				<div class="detail-image">
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="height:500px;">
						 <div class="carousel-indicators">
						 </div>
						 <div class="carousel-inner"></div>
						 <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Previous</span>
						  </button>
						  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						   	<span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Next</span>
						  </button>
					</div>
				</div>
			</div>
			<div class="col">
			<c:forEach items="${detailList}" var="item">
				<div class="description"><p id="explain">상세 설명</p>
						            <hr style="border: none; width: 40%; height: 3px; background: black; opacity: 1;">
						            <p>${item.overview}</p><br/>
						            <p><b>홈페이지: </b>${item.homepage}</p>
				</div>
			</c:forEach>
			</div>
			<br/>
			<div class="map_info">
				<p id="explain">위치</p>
				<hr style="border: none; width: 30%; height: 3px; background: black; opacity: 1;">
				<div id="map" style="width: 60%; height: 450px; border: 1px solid black;"></div>
			</div>
			
        </div>
        <div id="block" style="width:100%; height: 200px;"></div>       
     </div>
    <script>
$(document).ready(function(){
		var contentid = '<%= request.getParameter("contentid") %>';
		let description = $(".description"); //bootstrap 추가
		let carouselInner = $(".carousel-inner");
		let carouselIndicators = $(".carousel-indicators");
		let str="";
		$.ajax({
			url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=WIN&MobileApp=raon&contentId="+contentid+"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D&_type=json",
			success: function(data){
				console.log('items',data.response.body.items);
				let items = data.response.body.items.item;
				$.each(items,(index,item) => {
					console.log('item',item,index);
					str += `
				`;
					
				});
				description.append(str);
				$('body').append(data);
			}
			
		});
		$.ajax({
			url: "https://apis.data.go.kr/B551011/KorService1/detailImage1?MobileOS=ETC&MobileApp=raon&contentId="+contentid+"&imageYN=Y&subImageYN=Y&serviceKey=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D&_type=json",
			success: function(data){
				console.log('items',data.response.body.items);
				let first= true;
				let items = data.response.body.items.item;
				items.forEach(function(item, index) {
					var active = first?"active":"";//첫번쨰 이미지에 active 부여
					let idx=index;
					first= false;
					console.log(index+"!@#!@#"+item.originimgurl);
					if(item.originimgurl == null){
						carouselInner.append(`
								<img src="../images/tour_none_image.png" class="d-block w-100" alt="../images/tour_none_image.png">			
						`);
					}else{
						if(index ==0){
							carouselIndicators.append(`
				                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="\${index}" class="\${active}" aria-current="true" aria-label="Slide \${index+1}"></button>
				                `);
						}else{
							carouselIndicators.append(`
									<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="\${index}" aria-label="Slide \${index}"></button>
				                `);
							
						}
						
						carouselInner.append(`
							<div class="carousel-item \${active}">
								<img src="\${item.originimgurl}" class="d-block w-100"alt="1" onerror="this.src='../images/tour_none_image.png'" >	
		    				</div>
					`);
					}
					
				});
			}
		});
		
		var i = 0;
        $('i').on('click',function(){
            if(i==0){
                $(this).attr('class','fa-solid fa-heart');
                i++;
            }else if(i==1){
                $(this).attr('class','fa-regular fa-heart');
                i--;
            }

        });

	});
var container = document.getElementById('map');

let mapX='${param.mapx}';
let mapY = '${param.mapy}';
let title = '${param.title}';

var mapContainer = document.getElementById('map'),
mapOption={
	center: new kakao.maps.LatLng(mapY, mapX),
	level: 5
};
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다



// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
// 지도 중심좌표에 마커를 생성합니다 
	position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);
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

var iwContent = '<div style="padding:5px;"><a href="https://map.kakao.com/link/map/Hello World!,\${mapy},\${mapx}" style="color:blue" target="_blank">'+title+'</a> <a href="https://map.kakao.com/link/to/Hello World!,\${mapy},\${mapx}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
iwPosition = new kakao.maps.LatLng(mapY, mapX); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
position : iwPosition, 
content : iwContent 
});

// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
    </script>
</body>
</html>