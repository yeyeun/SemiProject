<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tourlist</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
    rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
    crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
    crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath }/resources/css/tour/tour.css?after">

<style>

</style>
</head>
<body>
<c:set var="contextPath" value="<%=request.getContextPath()%>" scope="application"></c:set>
<header>
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
</header>

<div id="tour_wrapper">
    <div class="left-box">
        <div class="side_tab">
            <div class="page_tag">
                <div class="tour_category"><h1>여행지</h1></div>
                <form action="${contextPath }/tour/search" method="Get">
                <div class="hstack gap-3">
                    <input class="form-control me-auto" type="text" name="keyword" placeholder="검색" aria-label="검색">
                    <input type="submit" class="btn btn-secondary" value="검색">
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="right-box">
        <div class="container">
            <h1>검색 결과가 없습니다.</h1>
        </div>
        <div class="pagination">
           
        </div>
    </div>
</div>
<%-- <jsp:include page="footer.jsp"/> --%>

<script>
	
</script>
</body>
</html>