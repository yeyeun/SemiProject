<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application" />
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link href="${resourceurl }/css/home/boardBanner.css" rel="stylesheet">
<title>Document</title>
</head>


<body>

	<div class="tab">
		<button class="tablinks active" onclick="openTab(event, 'Tab1')">
			<b>축제/행사</b>
		</button>
		<button class="tablinks" onclick="openTab(event, 'Tab2')">
			<b>게시판</b>
		</button>
	</div>

	<div id="Tab1" class="tabcontent">
		<div id="tab1_img1"></div>
		<div class="boardList">
			<ul id="ul1">
				<c:forEach items="${selectedEvents }" var="item">
					<li id="festivalTitle">
							<a href="${pageContext.request.contextPath}/event/detail?contentId=${item.contentid}&title=${item.title}&eventstartdate=${item.eventstartdate}&eventenddate=${item.eventenddate}" onmouseover="changeImage('${item.firstimage}')"><mark id="mark2">${item.title}</mark></a>
						</li>
					<li id="festivalDate">&nbsp;&nbsp;&nbsp;&nbsp;${item.eventstartdate}~${item.eventenddate}</li>
					<hr class="myhr">
				</c:forEach>
			</ul>
		</div>
	</div>

	<div id="Tab2" class="tabcontent tabcontent2">
		<div class="boardList2">
			<ul class="board-list">
				<h3>최근 등록 글</h3>
<%-- 				<c:forEach items="${selectedBoards}" var="recentBoard"> --%>
<%-- 					<li class="board-item"><a href="#" class="board-title">${recentBoard.title}</a> --%>
<%-- 						<p class="board-writer">작성자: ${recentBoard.writer}</p> --%>
<!-- 						<p class="board-date"> -->
<%-- 							<fmt:formatDate pattern="yyyy/MM/dd" value="${recentBoard.regDate}" /> --%>
<!-- 						</p></li> -->
<%-- 				</c:forEach> --%>
			</ul>
			<c:forEach items="${selectedBoards}" var="recentBoard">
			<div class="col-md-4 col-sm-6 content-card">
				<div class="card-big-shadow">
				<a href="${pageContext.request.contextPath}/board/read?bno=${recentBoard.bno}">
					<div class="card card-just-text" data-background="color" data-color="yellow" data-radius="none">
						<div class="content content2">
							<h6 class="category">[${recentBoard.btype }]</h6>
							<h4 class="title">
								${recentBoard.title }
							</h4>
							<p class="description">작성자: ${recentBoard.writer}</p>
						</div>
					</div>
				</a>
					<!-- end card -->
				</div>
			</div>
			</c:forEach>
		</div>
	</div>



	<script>
		function openTab2(evt, tabName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			document.getElementById(tabName).style.display = "block";
			evt.currentTarget.className += " active";
		}

		function openTab(evt, tabName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}
			document.getElementById(tabName).style.display = "block";
			evt.currentTarget.className += " active";
		}

		// 페이지 로드될 때 Tab1을 활성화하도록 설정
		window.onload = function() {
			openTab2(event, 'Tab1');
		};

		function changeImage(imageSrc) {
			$("#tab1_img1").fadeOut(
					'fast',
					function() {
						$(this).css("background-image", `url('\${imageSrc}')`)
								.fadeIn('fast');
					});
		}
		// 날짜 형식 변경
	</script>

</body>

</html>