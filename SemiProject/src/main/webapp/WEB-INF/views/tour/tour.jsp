<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tourlist</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	 
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script> 
<link rel="stylesheet" href="${contextPath }/resources/css/tour/tour.css">

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
    			<div class="hstack gap-3">
  					<input class="form-control me-auto" type="text" placeholder="검색" aria-label="검색">
  					<input type="button" class="btn btn-secondary" value="검색">
				</div>
			</div>
		</div>
	</div>
	<div class="right-box">
		<div class="container">
			<div class="row row-3" align="center">
			<c:forEach items="${tList}" var="item">
				<div class="col-4">
						
								<div class="m-1">
									<div class="card" style="width:24rem;" align="center">
				        				<img src="${item.firstimage}" class="card-img-top" alt="1" onerror="this.src='../../resources/images/tour_none_image.png'" style="height: 300px">
				        				<div class="card-body">
				        					<p class="card-title">${item.title}</p><br/>
				            				<p class="card-text" style="font-size: 14px">${item.addr1} ${item.addr2}</p>
				            				<p class="text-body-secondary"><a href="${contextPaht }/tour/detail?contentid=${item.contentid}&title=${item.title}&mapy=${item.mapy}&mapx=${item.mapx}&firstimage=${item.firstimage}" class="btn">세부 정보</a></p>
				            			</div>

				    				</div>
				    			</div>
				 </div>
			</c:forEach>
			</div> 
		</div>
<div class="pagination">
    <hr style="margin-bottom: 10px">
    <!-- 이전 페이지로 이동하는 버튼 -->
    <c:if test="${page > 10}">
        <a href="${contextPath}/tour/list?page=${page - 10}" data-page="${page - 10}" class="page-link">&laquo; Prev</a>
    </c:if>
    <!-- 페이지 링크를 동적으로 생성 -->
    <!-- totalPages가 1 이상일 때만 페이지 링크를 생성합니다. -->
    <c:if test="${totalPages > 0}">
        <c:forEach var="i" begin="${page}" end="${page + 9}" varStatus="loop">
            <!-- 페이지 번호가 totalPages보다 작거나 같을 때만 페이지 번호를 표시합니다. -->
            <c:if test="${i <= totalPages}">
                <a href="${contextPath}/tour/list?page=${i}" data-page="${i}" class="page-link">${i}</a>
            </c:if>
        </c:forEach>
    </c:if>
    <!-- 다음 페이지로 이동하는 버튼 -->
    <c:if test="${page + 10 <= totalPages}">
        <a href="${contextPath}/tour/list?page=${page + 10}" data-page="${page + 10}" class="page-link">Next &raquo;</a>
    </c:if>
</div>
	</div>
</div>
<%-- <jsp:include page="footer.jsp"/> --%>

<script>
	$(document).ready(function(){
		
		$('.pagenation a').click(function(event) {
	        event.preventDefault(); // 기본 링크 동작 방지
	        var page = $(this).data('page'); // 클릭된 페이지 번호 가져오기
	        fetchTourList(page); // 해당 페이지의 관광 정보 가져오기
	    });
		
	   
	}); 

	function fetchTourList(page) {
	    $.ajax({
	        url: '/list', // 서버의 해당 엔드포인트로 설정
	        type: 'GET',
	        data: {
	            page: page // 페이지 번호를 GET 파라미터로 전송
	        },
	        success: function(response) {
	            // 관광 정보를 받아와서 동적으로 추가
	            $('#tour-wrapper').html(response);
	        },
	        error: function(xhr, status, error) {
	            console.error('Error fetching tour list:', error);
	        }
	    });
	}
</script>
</body>
</html>
