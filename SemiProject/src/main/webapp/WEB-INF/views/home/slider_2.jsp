<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application" />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="${resourceurl }/css/home/slider_2.css">

</head>

<body>
	<div class="swiper mySwiper swiper2">
		<div class="course_title">
			<span><b>추천 여행코스</b></span>
		</div>
		<div class="swiper-wrapper">
			<!--제목, 소제목 위치 조정 필요-->
			<c:forEach items="${courseList}" var="course">
				<div class="swiper-slide">
					<img src="${course.getFirstimage()}" onerror="this.src='../../resources/images/nocourseimg.png';">
					<p class="tour_slide_name">${course.getTitle()}</p>
					<p class="tour_slide_subname">${course.getOverview()}</p>
					<div class="course_detail">
						<ul class="timeline">

						</ul>
					</div>
				</div>
			</c:forEach>

		</div>
		<!-- wrapper -->
		<div class="swiper-pagination"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>

	</div>
	<!-- swiper -->
	<script type="text/javascript">


		// titleList 문자열을 배열로 변환
		var titleListStr = "${titleList}";
		var titleList = titleListStr.substring(1, titleListStr.length - 1)
				.split(', ');
		console.log(titleList);

		// titleLength 문자열을 배열로 변환
		var titleLengthStr = "${titleLength}";
		var titleLength = titleLengthStr
				.substring(1, titleLengthStr.length - 1).split(', ');
		console.log(titleLength);

		// 받아온 데이터를 이용하여 각 course에 대해 timeline에 li 요소를 동적으로 생성하여 추가
		for (var i = 0; i < titleLength.length; i++) {
			var length = parseInt(titleLength[i]); // titleLength를 정수형으로 변환
			var slide = $(".timeline").eq(i);
			for (var j = 0; j < length; j++) {
				var title = titleList.shift(); // titleList에서 하나의 요소를 가져옴
				var li = $("<li>").attr({
					"data-year" : j + 1,
					"data-text" : title
				});
				// 생성한 li 요소를 timeline에 추가
				slide.append(li);
			}
		}
	</script>
	<script>
		var swiper = new Swiper(".swiper2", {
			speed : 5000,
			slidesPerView : 1,
			spaceBetween : 30,
			loop : true,
			autoplay : {
				delay : 700000,
			},
			pagination : {
				el : ".swiper-pagination",
				clickable : true,
			},
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});
	</script>

</body>

</html>