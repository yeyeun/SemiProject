<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<title>Document</title>
<style>
.bodyContainer {
/*background-image: linear-gradient(91.4259523917508deg, rgba(255, 255, 255,1) 19.90234375%,rgba(254, 254, 255,1) 19.90234375%,rgba(224, 249, 255,1) 80.57942708333333%)*/
background: white;
}
</style>
</head>
<body>
	<c:set var="contextPath" value='${pageContext.request.contextPath}' />
	<div class="bodyContainer">

		<div>
			<jsp:include page="${contextPath }/WEB-INF/views/home/content.jsp"></jsp:include>
		</div>
		<div id="slider2Container" style="margin-top: 100px; padding-top: 65px; background: rgb(228, 233, 247);">
<%-- 			<jsp:include page="${contextPath }/front/allCourse.course"></jsp:include> --%>
		</div>
		<div style="height: 900px; margin-top: 100px; background: antiquewhite;">
			<jsp:include page="${contextPath }/tour/slider1"></jsp:include>
		</div>
		<div id="eventContainer" style="height: 800px">
			<jsp:include page="${contextPath }/event/listhome"></jsp:include>
		</div>
		<div>
		<jsp:include page="${contextPath }/WEB-INF/views/include/footer.jsp"></jsp:include>
		</div>
		
	</div>
	<script>
    $(document).ready(function(){
        $.ajax({
            url: "/course/list",
            success: function(response){
                $("#slider2Container").html(response); // 서블릿에서 받은 데이터를 slider2Container에 넣음
            }
        });
//         $.ajax({
//             url: "/event/listhome",
//             success: function(response){
//                 $("#eventContainer").html(response); // 서블릿에서 받은 데이터를 slider2Container에 넣음
//             }
//         });
    });
</script>

</body>
</html>