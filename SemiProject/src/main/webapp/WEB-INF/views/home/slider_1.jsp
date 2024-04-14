<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
	<link rel="stylesheet" href="${resourceurl }/css/home/slider_1.css">
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>


</head>
<body id="slider_1_body">
	<div class="course_title1">
		<span><b>추천 여행지</b></span>
	</div>
	<div class="body-wrapper">
		<div class="swiper mySwiper swiper1">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img src="https://picsum.photos/400/300" alt=""> 
					<a href="#">여행지이름</a>

				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/600/450" alt=""> 
					<a href="#">여행지이름</a>

				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/200/150" alt="">
					<a href="#">여행지이름</a>
					<span>여행지 설명?</span>

				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/201/151" alt="">
					<a href="#">여행지이름</a>
					<span>여행지 설명?</span>

				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/199/149" alt="">
					<a href="#">여행지이름</a>


				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/200/150" alt="">
					<a href="#">여행지이름</a>

				</div>
			</div>
			<!-- swiper-wrapper -->
			<div class="swiper-pagination"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
		<!-- swiper1 -->
	</div>
	<!-- body-wrapper -->
	<script>
		var swiper = new Swiper(".swiper1", {
			slidesPerView : 3,
			spaceBetween : 50,
			loop : true,
			autoplay : {
				delay : 4000,
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