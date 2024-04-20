<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/mypage/mywrite.css">
</head>
<body>
	<!-- Begin Page Content -->
	<div class="container-fluid scrollable">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800" style="text-align: center; font-size: 45px;">작성 목록</h1>
		<p class="mb-4"></p>

		<!-- DataTalesㄴ Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<span class="title_write" id="title_board" onclick="toggleCategory('board')" style="cursor: pointer;">게시판</span> &nbsp;&nbsp;&nbsp; <span class="title_write" id="title_course" onclick="toggleCategory('course')" style="cursor: pointer;">여행코스</span>
			</div>
			<div class="card-body">
				<!-- 			게시판 테이블 -->
				<div class="table-responsive category-board">
					<table class="table table-hover" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>게시판 번호</th>
								<th>분류</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>


						<tbody>
							<c:forEach items="${bList}" var="board">
								<tr onclick="location.href='${contextpath}/board/read?bno=${board.bno}'">
									<td>${board.bno}</td>
									<td>${board.btype}</td>
									<td>${board.title}</td>
									<td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}" /></td>
									<td>${board.hit}</td>
								</tr>
							</c:forEach>


						</tbody>
					</table>
					<!-- 					<button id='regBtn' type="button" class="btn btn-sm btn-info">글쓰기</button> -->
				</div>
				<!-- 				게시판 테이블 -->
				<!-- 여행코스 -->


				<div class="blog-wrapper category-course">
					<!-- 카드 아이템 -->
					<c:forEach items="${cList}" var="course">
						<div class="blog-card">
							<div class="card-img">
								<img src="${course.firstimage}">
								<h1>${course.title }</h1>
							</div>
							<div class="card-details">
								<span><i class="fa fa-calendar"></i>${course.regDate}</span>
								<span><i class="fa fa-comment"></i>${course.count }</span>
							</div>
							<div class="card-text">
								<p>${course.overview }</p>
							</div>
							<div class="read-more">
								<a href="${contextPath}/course/detail.course?contentid=${course.contentid}">상세 보기</a>
							</div>
						</div>
					</c:forEach>
					<!-- 카드 아이템 -->
				</div>




				<!-- 여행코스 -->
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