<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" 
    crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="${resourceurl }/css/home/slider_2.css">

</head>

<body>
	<div class="swiper mySwiper swiper2">
		<div class="course_title">
	<span><b>추천 여행코스</b></span>
	</div>
		<div class="swiper-wrapper" >
				<!--제목, 소제목 위치 조정 필요-->
				 <c:forEach items="${selectedCourses}" var="course">
                <div class="swiper-slide">
                    <img src="${course.getFirstimage()}" onerror="this.src='../images/nocourseimg.png'">
                    <p class="tour_slide_name">${course.getTitle()}</p>
                    <p class="tour_slide_subname">${course.getOverview()}</p>
                    <div class="course_detail">
                    <ul class="timeline">

                    </ul>                   
                    </div>
                </div>
            </c:forEach>

        </div> <!-- wrapper -->
			<div class="swiper-pagination"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		
	</div> <!-- swiper -->
<script type="text/javascript">

//     var selectedTour = ${selectedTour};
    

//     // JavaScript 변수로부터 데이터 사용하기
//     for (var i = 0; i < selectedTour.length; i++) {
//       var courseDetail = $(".timeline")[i];
//         var subcontentid = selectedTour[i];
        
//         console.log("Subcontent ID:", subcontentid);
//         for(var j = 0; j < subcontentid.length; j++){
        	
//         	console.log("@@@@"+subcontentid[j]);
//             $.ajax({ //여행지 세부정보 조회
//                 url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=ETC&contentId="+ subcontentid[j] +"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA%3D%3D&_type=json",
//                 async:false,
//                 success: function(data){
//                     let detailInfos = data.response.body.items.item[0];
//                     let str="";                    
//                     str = `              
//                     	<li data-year=\${j+1} data-text=\${detailInfos.title}></li>                    
//                     `;                 
                    
//                     $(courseDetail).append(str);
//                 }
//             });
//         }
//     }



    // titleList 문자열을 배열로 변환
    var titleListStr = "${titleList}";
    var titleList = titleListStr.substring(1, titleListStr.length - 1).split(', ');
    console.log(titleList);

    // titleLength 문자열을 배열로 변환
    var titleLengthStr = "${titleLength}";
    var titleLength = titleLengthStr.substring(1, titleLengthStr.length - 1).split(', ');
    console.log(titleLength);

    // 받아온 데이터를 이용하여 각 course에 대해 timeline에 li 요소를 동적으로 생성하여 추가
    for (var i = 0; i < titleLength.length; i++) {
        var length = parseInt(titleLength[i]); // titleLength를 정수형으로 변환
        var slide = $(".timeline").eq(i);
        for (var j = 0; j < length; j++) {
            var title = titleList.shift(); // titleList에서 하나의 요소를 가져옴
            var li = $("<li>").attr({
                "data-year": j + 1,
                "data-text": title
            });
            // 생성한 li 요소를 timeline에 추가
            slide.append(li);
        }
    }


            
            
            
            
            

            // course 정보를 활용하여 slide에 필요한 내용을 추가
//             slide.find(".tour_slide_name").text(course.title);
//             slide.find(".tour_slide_subname").text(course.overview);

//             // li 요소를 생성하여 timeline에 추가
//             var timeline = slide.find(".timeline");
//             for (var j = 0; j < length; j++) {
//                 var listItem = $("<li>").text(titles[j]);
//                 timeline.append(listItem);
//             }

   
   
   
   
   
   
   
   
   
   
   // 해당 subcontentid 값을 가지고 있는 course_detail 영역에 추가
//    var courseDetail = document.getElementsByClassName("course_detail")[i];
//    courseDetail.innerHTML = "Subcontent ID: " + subcontentid;

   // 여기에 원하는 작업을 수행합니다.
   
   
   
   




// subcontentid를 사용하기 위한 JavaScript 코드
// 여기서는 예시로 콘솔에 출력하는 것으로 대체합니다.
//for (var i = 0; i < selectedCourses.length; i++) {
//    var course = selectedCourses[i];
//    var subcontentidArray = course.subcontentid.split(","); // 콤마(,)로 구분된 문자열을 배열로 분할
//    console.log("Course: " + course.title);
//    console.log("subcontentid Array: ", subcontentidArray);
   
//    // subcontentidArray를 사용하여 필요한 작업을 수행할 수 있습니다.
//}
//});
//	 subcontentids.forEach(function(subcontentid) {
//		 console.log(subcontentids)
//	        $.ajax({
//	            url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=WIN&MobileApp=raon&contentId="+subcontentid+"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D&_type=json",
//	            success: function(data){
//	                let items = data.response.body.items.item;
//	                let str = `
//	                        <p id="explain">상세 설명</p>
//	                        <hr style="border: none; width: 40%; height: 3px; background: black; opacity: 1;">
//	                        <p>\${items[0].title}</p>
//	                `;
//	                // div에 결과 추가
//	                $(".course_detail").append(str);
//	            }
//	        });
//	    });
</script> 


	<script>
    var swiper = new Swiper(".swiper2", {
        speed: 5000,
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        autoplay: {
            delay: 700000,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
    });
// $(document).ready(function(){
//     let result = $(".swiper2 .swiper-wrapper");
//     $.ajax({
//         url: "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=10&MobileOS=etc&MobileApp=etc&contentTypeId=25&areaCode=39&serviceKey=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA%3D%3D&_type=json",
//         success: function(data){
//             let items = data.response.body.items.item;
//             $.each(items, (index, item) => {
//                 result.append(`
//                     <div class="swiper-slide">
//                         <img src="\${item.firstimage}" alt="">
//                         <p class="tour_slide_name">\${item.title}</p>
//                         <p class="tour_slide_subname">\${item.firstimage2}</p>
//                     </div>
//                 `);
//             });
            
//             // 캐러셀 초기화
//             var swiper = new Swiper(".swiper2", {
//                 speed: 4000,
//                 slidesPerView: 1,
//                 spaceBetween: 30,
//                 loop: true,
//                 autoplay: {
//                     delay: 700000,
//                 },
//                 pagination: {
//                     el: ".swiper-pagination",
//                     clickable: true,
//                 },
//                 navigation: {
//                     nextEl: ".swiper-button-next",
//                     prevEl: ".swiper-button-prev",
//                 },
//             });
//         }
//     });
// });
// $(document).ready(function(){
//         let result = $(".swiper2 .swiper-wrapper");
//         let contentids = []; //contentid만 담을 배열 선언
//         $.ajax({ //첫번째 ajax 실행
//             url: "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=10&MobileOS=etc&MobileApp=etc&contentTypeId=25&areaCode=39&serviceKey=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA%3D%3D&_type=json",
//             success: function(data) {
//                 console.log('items',data.response.body.items);
//                 let items = data.response.body.items.item;
//                 for(var i=0; i<items.length; i++){
//                     contentids[i] = items[i].contentid;
//                 }
//                 // 두번째 ajax 실행
//                 // Shuffle contentids array to get random 5 contentids
//                 let shuffledContentIds = contentids.sort(() => Math.random() - 0.5).slice(0, 5);
//                 let promises = [];
//                 shuffledContentIds.forEach(contentid => {
//                     promises.push($.ajax({
//                         url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=etc&MobileApp=etc&contentId="+contentid+"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&overviewYN=Y&serviceKey=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA%3D%3D&_type=json",
//                         success: function(data){
//                             let item = data.response.body.items.item[0];
//                             let str = `
//                                  <div class="swiper-slide">
//                                     <img src="\${item.firstimage}" alt="">
//                                     <p class="tour_slide_name">\${item.title}</p>
//                                     <p class="tour_slide_subname">\${item.overview}</p>
//                                 </div>
//                             `;
//                             result.append(str);
//                         }
//                     }));
//                 });
//                 // 모든 ajax 요청이 완료되면 슬라이드 초기화
//                 $.when.apply($, promises).then(function() {
//                     var swiper = new Swiper(".swiper2", {
//                         speed: 4000,
//                         slidesPerView: 1,
//                         spaceBetween: 30,
//                         loop: true,
//                         autoplay: {
//                             delay: 300000,
//                         },
//                         pagination: {
//                             el: ".swiper-pagination",
//                             clickable: true,
//                         },
//                         navigation: {
//                             nextEl: ".swiper-button-next",
//                             prevEl: ".swiper-button-prev",
//                         },
//                     });
//                 });
//             }
//         });
//     });
</script>

</body>

</html>