<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tour_detail</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	 
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<link rel="stylesheet" href="${contextPath }/resources/css/tour/tour_detail.css">

<script src="https://kit.fontawesome.com/3a115195d8.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b179d98657949b7bb8bb0c0d1b9f2844"></script>   
</head>
<body>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<%
	String id = (String)session.getAttribute("loginId");
	String contentid = request.getParameter("contentid");
	String title = request.getParameter("title");
	String firstimage = request.getParameter("firstimage");
%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" scope="application"></c:set>
<div class="menu">
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
</div>
	 <div class="container">
	  	<div class="tour_title" style="display:inline; white-space:nowrap;">
	  	<form name="addForm" action="${pageContext.request.contextPath}/mypage/write">
	  		<blockquote><h2><%=title %><button type="button" class="like" onclick="click()">
	  		
	  		<i id="heartzone" class="fa-regular fa-heart" style="color: #7E57C2; margin-left:10px;"></i>
	  		
	  		</button></h2></blockquote>
	  				<input id="contentidInput" name="contentid" type="text" value="<%=contentid %>" style="display: none;" /> 
					<input id="firstimageInput" name="firstimage" type="text" value="<%=firstimage %>" style="display: none;" />
					<input id="titleInput" name="title" type="text" value="<%=title %>" style="display: none;" />
					<input id="idInput" name="id" type="text" value="<%=id %>" style="display: none;" />
	  	</form>
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
			 <c:forEach items="${detailList}" var="item">
			<div class="col">
			
				<div class="description">
					
						<p id="explain">상세 설명</p>
						<hr style="border: none; width: 40%; height: 3px; background: black; opacity: 1;">
					<ul>
						<li><p>${item.overview}</p></li>
						<li><p><b>홈페이지: </b>${item.homepage}</p></li>
						<li><p><b>전화번호: </b>${item.tel }</p></li>
					</ul>
					
				</div> 
			
			</div>
			</c:forEach>
			<br/>
			<c:forEach items="${detailList}" var="common">
					<p id="title" style="display: none;">${common.title }<p>
					<p id="mapx" style="display: none;">${common.mapx }<p>
					<p id="mapy" style="display: none;">${common.mapy }<p>
					<p id="mlevel" style="display: none;">${common.mlevel }<p>
			</c:forEach>
			<div class="map_info">
				<p id="explain">위치</p>
				<hr style="border: none; width: 100%; height: 3px; background: black; opacity: 1;">
				<div id="map" style="width: 49%; height: 450px; border: 1px solid black;">
				</div>
				<div id="bustable">
				<table class="bustable">
					<thead>
							<tr>
								<th>도착 정보</th>
							</tr>
						</thead>
					<tbody id="busbody">
						<tr>
							<td style="font-size: 30px; color: blue;">"routetp"</td>
							<td>"routeno"</td>
							<td>"arrtime"<span style="color: gray;">"arrprevstationcnt"</span></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div style="position: relative; width: 300px; right: 225px;">
			<p style="color:gray;">[여행지 주변 500m이내 정류장]</p>
			</div>
			
        </div>
        

        </div>
  
<script>
var i = 0;
var contentids = '<%= request.getParameter("contentid") %>';
var ids = '<%=id %>'
var firstimages = '<%=firstimage %>';
var titles = '<%= title %>';
//지도에 띄울 마커
var xList = new Array();
var yList = new Array();
var titleList = new Array();
var buslist1  = new Array();
var buslist2 = new Array();

//마커
let businfo = $(".businfo");
function showAllBus(nodeid, nodenm){
	var nodeids = nodeid;
	var nodenms = nodenm;
	var endnodenmlist = [];
	var startnodenmlist = [];
		
	 $.ajax({
            type: "GET",
            url: "/tour/buslist", // 컨트롤러의 엔드포인트 URL
            async: false,
            data: { 
            	nodeid: nodeids }, // 요청 파라미터 설정
            dataType : 'json', 
            success: function(data) {
            	buslist1 = data;
            	console.log(nodenm+"정류장에 오는 모든 버스는");
                $.each(data, function(idx, val) {
                	endnodenmlist.push(val.endnodenm);
                	startnodenmlist.push(val.startnodenm);
                });


            },
            error: function(xhr, status, error) {
                // 요청이 실패하면 실행될 코드
                console.error("AJAX request failed:", status, error);
            }
        });
	 //버스 도착//
	 	 $.ajax({
            type: "GET",
            url: "/tour/arrivelist", // 컨트롤러의 엔드포인트 URL
            async: false,
            data: { 
            	nodeid: nodeids,
            	nodenm: nodenms
            	}, // 요청 파라미터 설정
            dataType : 'json', 
            success: function(data) {
                buslist2 = data;
                console.log(nodenm + "정류장에");
                var tableBody = $('#bustable tbody');
                tableBody.empty();
                
                $.each(data, function(idx, val) {
                    // 새로운 행(tr) 생성
                    var newRow = $('<tr></tr>');
                    
                    // 버스 종류 표시
                    var routeTypeCell = $('<td></td>').text(val.routetp);
                    newRow.append(routeTypeCell);
                    
                    // 버스 번호 표시
                    var routeNumberCell = $('<td></td>').text(val.routeno);
                    newRow.append(routeNumberCell);
                    
                    // 도착 시간 및 정류소 표시
                     var arrivalInfoCell;
    					if (val.arrtime >= 0) {
        				arrivalInfoCell = $('<td></td>').text(val.arrtime / 60 + "분 뒤 도착");
        				arrivalInfoCell.append('<span style="color: gray;">[' + val.arrprevstationcnt + '번째 전]</span>');
    					} else {
        				arrivalInfoCell = $('<td></td>').text("도착 정보 없음");
    				}
                    newRow.append(arrivalInfoCell);
                    
                    var endnodenmCell = $('<td></td>').text(startnodenmlist[idx]+"->"+endnodenmlist[idx]);
                    newRow.append(endnodenmCell);                    

                    if (val.arrtime >= 0) {
                        // 도착 정보가 있는 경우 해당 행을 그대로 추가
                        newRow.append(arrivalInfoCell);
                        tableBody.prepend(newRow);
                    } else {
                        // 도착 정보가 없는 경우 따로 모아서 마지막에 추가
                        newRow.append(arrivalInfoCell);
                        tableBody.append(newRow);
                    }
                });
//             	buslist2 = data;
//             	console.log(nodenm+"정류장에");
//                 $.each(data, function(idx, val) {
//                     console.log(val.routetp+"종류의"+val.routeno+"번 버스가 "+val.arrprevstationcnt+"개 정류장 남았고 "+val.arrtime/60+"분 뒤 도착");
//                 });
//                 // alert 창에 출력
                


            },
            error: function(xhr, status, error) {
                // 요청이 실패하면 실행될 코드
                console.error("AJAX request failed:", status, error);
            }
        });
	 console.log("@@"+buslist1+"@@@"+buslist2);
	 //버스 도착//
	 
}
$(document).ready(function(){
	//지도 마커
		<c:forEach items="${BusStationList}" var="station">
			xList.push("${station.gpslong}");
			yList.push("${station.gpslati}");
			titleList.push("${station.nodenm}");
		</c:forEach>

		var contentid = '<%= request.getParameter("contentid") %>';
		var firstimage = '<%= request.getParameter("firstimage") %>';
		var id = '<%=id %>'
		let description = $(".description"); //bootstrap 추가
		let carouselInner = $(".carousel-inner");
		let carouselIndicators = $(".carousel-indicators");
		let str="";
		let items=[];
		var mtitle = document.getElementById("title").innerText;
		var mappx = document.getElementById("mapx").innerText;
        var mappy = document.getElementById("mapy").innerText;
        var mlevel = document.getElementById("mlevel").innerText;

        console.log(mapx, mapy);
		
	       $.ajax({
	            type: "GET",
	            url: "/mypage/checkCartItem", // 컨트롤러의 엔드포인트 URL
	            data: { id: id, contentid: contentid }, // 요청 파라미터 설정
	            success: function(response) {

	            	if(response == "1"){
	            		i = 1;
	            		$('#heartzone').attr('class','fa-solid fa-heart');
	            		
	            		; 
	            	}else{
	            		i = 0 ;
	            		$('#heartzone').attr('class','fa-regular fa-heart');
	            	}
	            	
	            	
	            	
	                // 요청이 성공하면 실행될 코드
	                // 서버에서 보내온 응답(response)을 처리
	                // 예를 들어, 장바구니에 여행지가 있는지 여부에 따라 화면 표시를 변경하는 등의 작업 수행
	            },
	            error: function(xhr, status, error) {
	                // 요청이 실패하면 실행될 코드
	                console.error("AJAX request failed:", status, error);
	            }
	        });

		$.ajax({
			url: "https://apis.data.go.kr/B551011/KorService1/detailImage1?MobileOS=ETC&MobileApp=raon&contentId="+contentid+"&imageYN=Y&subImageYN=Y&serviceKey=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D&_type=json",
			success: function(data){
				console.log('items',data.response.body.items);
				let first= true;
				items = data.response.body.items.item;
				if(items!=null){
					items.forEach(function(item, index) {
						var active = first?"active":"";//첫번쨰 이미지에 active 부여
						let idx=index;
						first= false;
						if(item.originimgurl == null){
							if(firstimage.equals("")){
								carouselInner.append(`
										<img src=<%=request.getParameter("firstimage")%> class="d-block w-100" alt="this.src= '../../resources/images/tour_none_image.png'">			
								`);
							}
							
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
									<img src="\${item.originimgurl}" class="d-block w-100" alt="1" onerror="this.src='../../resources/images/tour_none_image.png'"   style="max-height: 450px;">	
			    				</div>
						`);
						}
						
					});
				}
				else{
					carouselInner.append(`
							<img src= <%=request.getParameter("firstimage")%> class="d-block w-100" style="height: 450px;" alt="1" onerror="this.src='../../resources/images/tour_none_image.png'" >			
					`);
				}
				
			}
		});
		

		
        
// 	    지도 추가

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(mappy, mappx), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };    

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				//버스 추가//
	var positions = [
    <c:forEach items="${BusStationList}" var="station" varStatus="loop">
        {
            title: "${station.nodenm}",
            latlng: new kakao.maps.LatLng("${station.gpslati}", "${station.gpslong}"),
            nodeid: "${station.nodeid}",
            nodenm: "${station.nodenm}"
        }<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];


	//버스 추가//
		var imageSrc = "../../resources/images/bus-stop2.png";
		console.log("&&&&"+positions);
		
		for(var i=0; i<positions.length; i++){
			
			// 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(47, 47); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		    
		    
		    (function(nodeid, nodenm) {
		        // 마커 클릭 이벤트 리스너 등록
		        kakao.maps.event.addListener(marker, 'click', function() {
		            console.log(nodeid + " " + nodenm); // nodeid와 nodenm 출력
		            // 해당 정류장의 정보를 가져오는 함수 호출
		            showAllBus(nodeid, nodenm);
		        });

		        // 마커 호버 이벤트 등록
		        kakao.maps.event.addListener(marker, 'mouseover', function() {
		            var infowindow = new kakao.maps.InfoWindow({
		                content: "<div style='padding:5px;'>정류장 ID: " + nodeid + "<br>정류장 이름: " + nodenm + "</div>",
		                removable: true
		            });
		            infowindow.open(map, marker);
		        });

		        // 마커에서 마우스를 떼었을 때 인포윈도우 닫기
		        kakao.maps.event.addListener(marker, 'mouseout', function() {
		            infowindow.close();
		        });
		    })(positions[i].nodeid, positions[i].nodenm); // 즉시 실행 함수를 이용하여 현재의 nodeid와 nodenm 값을 넘겨줌
		    
		    
		
		}//마커 삽입 for문
		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(mappy, mappx); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		var iwContent = '<div class="map_loc" style="padding:5px;"><a href="https://map.kakao.com/link/map/'+mtitle+','+mappy+','+mappx+'" style="color:blue" target="_blank">'+mtitle+'</a><br> <a href="https://map.kakao.com/link/to/'+mtitle+','+mappy+','+mappx+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(mappy, mappx); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker);

	});

$('i').on('click',function(){
    if(i==0){
        $(this).attr('class','fa-solid fa-heart');
        i++;
        addToCart();
    }else if(i==1){
        $(this).attr('class','fa-regular fa-heart');
        i--;
        deleteFromCart();
    }

});
function addToCart(){
    // 세션에 저장된 "loginId" 확인
    var loginId = "<%= session.getAttribute("loginId") %>";

    
    // 만약 "loginId"가 없다면 알림창을 띄우고 함수를 호출하지 않음
    if(loginId == "null"){
        alert("로그인 후 이용해주세요.");
        $('i').attr('class','fa-regular fa-heart');
        i = 0; // 'i' 변수 초기화
        return;
    }
    
    if(confirm("여행지를 관심 여행지에 추가하시겠습니까?")){
    	$.ajax({
            type: "GET",
            url: "/mypage/write", // 컨트롤러의 엔드포인트 URL
            data: { id: ids, contentid: contentids, firstimage: firstimages, title: titles }, // 요청 파라미터 설정
            success: function(response) {
            	console.log("add cart success");	
//	            	console.log(response);
//	            	if(response == "1"){
//	            		i = 1;
//	            		$('#heartzone').attr('class','fa-solid fa-heart');
            		
//	            		; 
//	            	}else{
//	            		i = 0 ;
//	            		$('#heartzone').attr('class','fa-regular fa-heart');
//	            	}
            	
            	
            	
                // 요청이 성공하면 실행될 코드
                // 서버에서 보내온 응답(response)을 처리
                // 예를 들어, 장바구니에 여행지가 있는지 여부에 따라 화면 표시를 변경하는 등의 작업 수행
            },
            error: function(xhr, status, error) {
                // 요청이 실패하면 실행될 코드
                console.error("AJAX request failed:", status, error);
            }
        });
   	 $('i').attr('class','fa-solid fa-heart');
     i = 1; // 'i' 변수 초기화
    } else {
         // 알림창에서 '취소'를 눌렀을 때 아이콘 클래스 변경
        $('i').attr('class','fa-regular fa-heart');
        i = 0; // 'i' 변수 초기화
        document.addForm.reset();
    }
}
function deleteFromCart(){
    // 세션에 저장된 "loginId" 확인
    var loginId = "<%= session.getAttribute("loginId") %>";

    
    // 만약 "loginId"가 없다면 알림창을 띄우고 함수를 호출하지 않음
    if(loginId == "null"){
        alert("로그인 후 이용해주세요.");
        $('i').attr('class','fa-regular fa-heart');
        i = 0; // 'i' 변수 초기화
        return;
    }
    
    if(confirm("여행지를 관심 여행지에서 제거하시겠습니까?")){
    	console.log("delete");
    	  $.ajax({
	            type: "GET",
	            url: "/mypage/deleteCartItem", // 컨트롤러의 엔드포인트 URL
	            data: { id: ids, contentid: contentids }, // 요청 파라미터 설정
	            success: function(response) {
	            	console.log("delete cart success");	            	 
// 	            	console.log(response);
// 	            	if(response == "1"){
// 	            		i = 1;
// 	            		$('#heartzone').attr('class','fa-solid fa-heart');
	            		
// 	            		; 
// 	            	}else{
// 	            		i = 0 ;
// 	            		$('#heartzone').attr('class','fa-regular fa-heart');
// 	            	}
	            	
	            	
	            	
	                // 요청이 성공하면 실행될 코드
	                // 서버에서 보내온 응답(response)을 처리
	                // 예를 들어, 장바구니에 여행지가 있는지 여부에 따라 화면 표시를 변경하는 등의 작업 수행
	            },
	            error: function(xhr, status, error) {
	                // 요청이 실패하면 실행될 코드
	                console.error("AJAX request failed:", status, error);
	            }
	        });
    } else {
         // 알림창에서 '취소'를 눌렀을 때 아이콘 클래스 변경
         console.log(contentids+"@@"+ids);
         
        $('i').attr('class','fa-solid fa-heart');
        i = 1;
    }

}

    </script>
</body>
</html>