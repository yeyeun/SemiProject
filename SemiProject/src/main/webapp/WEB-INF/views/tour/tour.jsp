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
<link rel="stylesheet" href="../CSS/tour.css?after"/>

<style>

</style>
</head>
<body>
<c:set var="contextPath" value="<%=request.getContextPath()%>" scope="application"></c:set>
<header>
	<jsp:include page="header.jsp"/>
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
				        				<img src="${item.firstimage}" class="card-img-top" alt="1" onerror="this.src='../images/tour_none_image.png'" style="height: 300px">
				        				<div class="card-body">
				        					<p class="card-title">${item.title}</p><br/>
				            				<p class="card-text" style="font-size: 14px">${item.addr1} ${item.addr2}</p>
				            				<p class="text-body-secondary"><a href="/MLP_SemiProject/front/detail.api?contentid=${item.contentid}&title=${item.title}&mapy=${item.mapy}&mapx=${item.mapx}" class="btn">세부 정보</a></p>
				            			</div>

				    				</div>
				    			</div>
				 </div>
			</c:forEach>
			</div> 
		</div>
		<div class="pagination">
    			<hr style="margin-bottom: 10px">
    			<a href="#">&laquo;</a>
    			<a href="#" class="active">1</a>
    			<a href="#">2</a>
    			<a href="#">3</a>
    			<a href="#">4</a>
    			<a href="#">5</a>
    			<a href="#">6</a>
    			<a href="#">&raquo;</a>
		</div> 
	</div>
</div>
<%-- <jsp:include page="footer.jsp"/> --%>

<script>
	$(document).ready(function(){
		
		let result = $(".row"); //bootstrap 추가
		let str="";
		$.ajax({
			url: "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?numOfRows=12&MobileOS=WIN&MobileApp=raon&_type=json&keyword=%EC%A0%9C%EC%A3%BC&contentTypeId=12&areaCode=39&serviceKey=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D",
			success: function(data){
				console.log('items',data.response.body.items);
				let items = data.response.body.items.item;
				$.each(items,(index,item) => {
					console.log('item',item,index);
					str += `
						`;
					
				});
				result.append(str);
				$('body').append(data);
			}
			
		});
		
	   
	});
</script>
</body>
</html>
