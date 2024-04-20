<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/mypage/mytour.css">
</head>
<body>
	<!-- Begin Page Content -->
	<div class="container-fluid scrollable">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800" style="text-align: center; font-size: 45px;">관심 여행지</h1>
		<p class="mb-4"></p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<!-- 			<div class="card-header py-3"> -->
			<!-- 				<span class="title_write" id="title_board" -->
			<!-- 					onclick="toggleCategory('board')" style="cursor: pointer;">게시판</span> -->
			<!-- 				&nbsp;&nbsp;&nbsp; <span class="title_write" id="title_course" -->
			<!-- 					onclick="toggleCategory('course')" style="cursor: pointer;">여행코스</span> -->
			<!-- 			</div> -->
			<div class="card-body">
				<!-- 			게시판 테이블 -->
				<div class="table-responsive category-board">
					<table class="table table-hover" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>대표 이미지</th>
								<th>ID</th>
								<th>여행지명</th>
								<th>소개</th>
								<th>주소</th>
							</tr>
						</thead>


						<tbody>
							<c:forEach items="${mytourList}" var="tour" varStatus="status">
								<tr style="cursor: pointer;" onClick="location.href='${contextPath}/tour/detail?contentid=${tour.contentid }&title=${tour.title }&mapy=${mytourList2[status.index].getMapy() }&mapx=${mytourList2[status.index].getMapx() }&firstimage=${tour.firstimage }'">
									<td><img class="favorite_tour_img" src="${tour.firstimage }" onerror="this.src='../../resources/images/nocourseimg.png'"></td>
									<td>${tour.contentid }</td>
									<td>${tour.title }</td>
									<td><p class="favorite_tour_overview">${mytourList2[status.index].getOverview() }</p></td>
									<td>${mytourList2[status.index].getAddr1() }</td>
								</tr>
							</c:forEach>

							




						</tbody>
					</table>
					<!-- 					<button id='regBtn' type="button" class="btn btn-sm btn-info">글쓰기</button> -->
				</div>
				<!-- 				게시판 테이블 -->
			</div>

		</div>

	</div>
	<!-- /.container-fluid -->

	<script>
		function toggleCategory(category) {
			if (category === 'board') {
				$('.category-board').show();
				$('.category-course').hide();
				$('#title_board').addClass('active');
				$('#title_course').removeClass('active');
			} else {
				$('.category-board').hide();
				$('.category-course').show();
				$('#title_board').removeClass('active');
				$('#title_course').addClass('active');
			}
		}
		$(document).ready(function() {
			toggleCategory('board');
			$("#regBtn").on("click", function() {
				self.location = "/board/write";
			}); //버튼 클릭시 등록창으로 이동
		});
	</script>
</body>
</html>