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
    			 <a href="${contextPath }/tour/list?page=${pageNumber}" data-page="1" class="page-link">&laquo;</a>
    <!-- 페이지 링크를 동적으로 생성 -->
    <!-- totalPages가 1 이상일 때만 페이지 링크를 생성합니다. -->
    <c:if test="${totalPages > 0}">
    <c:forEach var="pageNumber" begin="1" end="${totalPages}">
        <!-- 페이지 번호가 10개를 초과하는 경우, 1, 2, ..., 현재페이지-2, 현재페이지-1, 현재페이지, 현재페이지+1, 현재페이지+2, ..., totalPages 형식으로 표시 -->
        <c:choose>
            <c:when test="${pageNumber == page}">
                <a href="${contextPath }/tour/list?page=${pageNumber}" data-page="${pageNumber}" class="page-link active">${pageNumber}</a>
            </c:when>
            <c:otherwise>
              
                <c:choose>
                    <c:when test="${page <= 5 || totalPages < 10}">
                        <a href="#" data-page="${pageNumber}" class="page-link">${pageNumber}</a>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${pageNumber == 1 || pageNumber == totalPages || (pageNumber >= page - 2 && pageNumber <= page + 2)}">
                                <a href="${contextPath }/tour/list?page=${pageNumber}" data-page="${pageNumber}" class="page-link">${pageNumber}</a>
                            </c:when>
                            <c:otherwise>
                                <span>...</span>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</c:if>
    <a href="${contextPath }/tour/list?page=${pageNumber}" data-page="${totalPages}" class="page-link">&raquo;</a>
		</div>
	</div>
</div>
<%-- <jsp:include page="footer.jsp"/> --%>

<script>
	$(document).ready(function(){
		
		$('.page-link').click(function(event) {
	        event.preventDefault(); // 기본 링크 동작 방지
	        var page = $(this).data('page'); // 클릭된 페이지 번호 가져오기
	        fetchTourList(page); // 해당 페이지의 관광 정보 가져오기
	    });
		
	   
	}); 
	var actionFrm = $("#actionFrm");
	$(".pagination a").on("click",function(e){
		e.preventDefault();
		//console.log('click');
		actionFrm.find("input[name='pageNum']").val($(this).attr("href"));
		actionFrm.submit();
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
