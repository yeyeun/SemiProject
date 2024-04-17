<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath }/resources/css/event/event_main.css">
</head>
<body>
	<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
	<div id="event_main_wrapper">
		<div class="event_container2">
			<div class="content">
				<div class="filter-wrapper">
					<p class="filter-header">지역별</p>
					<ul id="arealist">
						<li id="0"><button class="active" type="button" onclick="changeItem('0')">
								<span>전체</span>
							</button></li>
						<li id="1"><button type="button" onclick="changeItem('1')">
								<span>제주시</span>
							</button></li>
						<li id="2"><button type="button" onclick="changeItem('2')">
								<span>서귀포시</span>
							</button></li>
					</ul>
				</div>
				<hr>
				<div class="row-wrapper">

					<div class="row row-cols-2 row-cols-md-3 g-4">
						<!-- 						카드 추가 부분 -->
						<c:forEach items="${eventList}" var="event">
							<div class="col">
								<div class="card h-100">
									<a href="event_detail.jsp?contentid=\${event.contentid}&title=\${event.title}&eventstartdate=\${startDate}&eventenddate=\${endDate}"><img src=${event.firstimage} class="img-fluid rounded-start" alt="..." onerror="this.src='../../resources/images/image_none.png'"></a>
									<div class="card-body">
										<h5 class="card-title">
											<a href="event_detail.jsp?contentid=\${event.contentid}&title=\${event.title}&eventstartdate=\${startDate}&eventenddate=\${endDate}" class="item-title"><h5 class="card-title">${event.title}</h5></a>
										</h5>
										<p class="card-text">${event.addr1}</p>

									</div>
									<div class="card-footer">
										<small class="card-text">${event.eventstartdate}~${event.eventenddate}</small></small>
									</div>
								</div>
							</div>
							<!-- 						카드 추가 부분 -->
							</c:forEach>
					</div>
					<br>
					<!-- 					<div class="pagination"> -->
					<!-- 						<a href="#">&laquo;</a> <a href="#" class="active">1</a> <a -->
					<!-- 							href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> -->
					<!-- 						<a href="#">6</a> <a href="#">&raquo;</a> -->
					<!-- 					</div> -->
				</div>

			</div>

		</div>

	</div>
	<script>
// 	$(document).ready(function(){ 
//   		let result = $(".row.row-cols-2.row-cols-md-3.g-4");
// 		let str="";
		
// 		let currentDate = new Date();
//         let year = currentDate.getFullYear();
//         let month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
//         let day = ('0' + currentDate.getDate()).slice(-2);

//         let currentDateStr = year + month + day;
		
        

//         $.ajax({
//             url: `https://apis.data.go.kr/B551011/KorService1/searchFestival1?MobileOS=etc&MobileApp=a&_type=json&arrange=Q&eventStartDate=\${currentDateStr}&areaCode=39&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D`,
//             success: function(data) {
//                 console.log('items', data.response.body.items);
//                 let items = data.response.body.items.item;
//                 $.each(items, (index, item) => {
                    
//                     let startDate = formatDate(item.eventstartdate);
//                     let endDate = formatDate(item.eventenddate);
//                     let firstItemInfotext;
//                     str += `
//                         <div class="col">
//                         <div class="card h-100">
//                         <a href="event_detail.jsp?contentid=\${item.contentid}&title=\${item.title}&eventstartdate=\${startDate}&eventenddate=\${endDate}"><img src="\${item.firstimage}" class="img-fluid rounded-start" alt="..." onerror="this.src='../images/image_none.png'"></a>
//                             <div class="card-body">
//                                 <h5 class="card-title"><a href="event_detail.jsp?contentid=\${item.contentid}&title=\${item.title}&eventstartdate=\${startDate}&eventenddate=\${endDate}" class="item-title"><h5 class="card-title">\${item.title}</h5></a></h5>
//                                 <p class="card-text">\${item.addr1}</p>

//                             </div>
//                             <div class="card-footer">
//                                 <small class="card-text">\${startDate}~\${endDate}</small></small>
//                             </div>
//                         </div>
//                     </div>
//                     `;
//                 });
//                 result.append(str);
//                 $('body').append(data);
//             }
//         });
		   
// 	});
// 	//날짜 형식 변환
// 	function formatDate(dateString) {
// 	    let year = dateString.substring(0, 4);
// 	    let month = dateString.substring(4, 6);
// 	    let day = dateString.substring(6, 8);
// 	    return `\${year}.\${month}.\${day}`;
// 	}
	function changeItem(buttonId){
// 		클릭된 버튼 표시
	    $("ul#arealist li button").removeClass("active");
	    $("#" + buttonId + " button").addClass("active");
	    
	    let areatext = document.getElementById(buttonId).textContent.trim();
	    let items = $(".row.row-cols-2.row-cols-md-3.g-4").find(".col");

	    // "전체" 버튼 클릭 시 모든 아이템 표시
	    if(areatext === "전체") {
	        items.show();
	    } else {
	        // 그 외 버튼 클릭 시 해당 지역 아이템만 표시
	        items.each(function() {
	            let itemAddress = $(this).find(".card-text").text();
	            if(areatext === "서귀포시" && itemAddress.includes("서귀포시")) {
	                $(this).show();
	            } else if(areatext === "제주시" && itemAddress.includes("제주시")) {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    }
	}

	</script>
</body>
</html>