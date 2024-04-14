<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextPath }/resources/css/home/content.css">
</head>
<body>

   <div class="headerContainer">
	<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
  </div>
	<div id="carouselExampleCaptions" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="6000" data-bs-pause="false"> <!-- 간격을 6초로 설정 -->
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="3" aria-label="Slide 4"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="4" aria-label="Slide 5"></button>
  </div>
  <span id="arrow-title">둘러보기</span>
  <div class="arrow-container">
    <div class="chevron"></div>
    <div class="chevron"></div>
    <div class="chevron"></div>
  </div>
  <div class="carousel-inner">
			<div class="carousel-caption d-none d-md-block">
				<div class="content">
					<h2><b>Jeju Island</b></h2>
					<h2><b>Jeju Island</b></h2>
				</div>
				<p>당신만의 여행코스를 만들어보세요</p>
			</div>
			<div class="carousel-item active">
      <img src="${contextPath }/resources/images/jeju_back1.jpg" class="d-block w-100" alt="...">

    </div>
    <div class="carousel-item">
      <img src="${contextPath }/resources/images/jeju_back2.jpg" class="d-block w-100" alt="...">

    </div>
     <div class="carousel-item">
      <img src="${contextPath }/resources/images/jeju_back3.jpg" class="d-block w-100" alt="...">

    </div>
     <div class="carousel-item">
      <img src="${contextPath }/resources/images/jeju_back4.jpg" class="d-block w-100" alt="...">

    </div>
     <div class="carousel-item">
      <img src="${contextPath }/resources/images/jeju_back5.jpg" class="d-block w-100" alt="...">

    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<script>

</script>
</body>
</html>
