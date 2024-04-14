<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${contextPath}/mypage/CSS/mywrite.css">
</head>
<body>
	<!-- Begin Page Content -->
	<div class="container-fluid scrollable">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800"
			style="text-align: center; font-size: 45px;">작성 목록</h1>
		<p class="mb-4"></p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<span class="title_write" id="title_board"
					onclick="toggleCategory('board')" style="cursor: pointer;">게시판</span>
				&nbsp;&nbsp;&nbsp; <span class="title_write" id="title_course"
					onclick="toggleCategory('course')" style="cursor: pointer;">여행코스</span>
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
							<%-- 							<c:forEach items="${bList}" var="board"> --%>
							<!-- 								<tr> -->
							<%-- 									<td>${board.bno}</td> --%>
							<%-- 									<td>${board.title}</td> --%>
							<%-- 									<td>${board.writer}</td> --%>
							<%-- 									<td>${board.regDate}</td> --%>
							<!-- 								</tr> -->
							<%-- 							</c:forEach> --%>

							<%--예시 데이터 수동 삽입 --%>
							<tr>
								<td>1</td>
								<td>정보공유</td>
								<td>Lorem Ipsum</td>
								<td>2024-04-11</td>
								<td>256</td>
							</tr>
							<tr>
								<td>2</td>
								<td>분실물</td>
								<td>Dolor Sit Amet</td>
								<td>2024-04-10</td>
								<td>187</td>
							</tr>
							<tr>
								<td>3</td>
								<td>자유주제</td>
								<td>Consectetur Adipiscing Elit</td>
								<td>2024-04-09</td>
								<td>354</td>
							</tr>
							<tr>
								<td>4</td>
								<td>정보공유</td>
								<td>Sed Do Eiusmod Tempor</td>
								<td>2024-04-08</td>
								<td>421</td>
							</tr>




						</tbody>
					</table>
					<!-- 					<button id='regBtn' type="button" class="btn btn-sm btn-info">글쓰기</button> -->
				</div>
				<!-- 				게시판 테이블 -->
				<!-- 여행코스 -->


				<div class="blog-wrapper category-course">
				<!-- 카드 아이템 -->
					<div class="blog-card">
						<div class="card-img">
							<img
								src="http://tong.visitkorea.or.kr/cms/resource/97/600097_image2_1.jpg">
							<h1>몸과 마음을 치유하는 에코 테라피</h1>
						</div>
						<div class="card-details">
							<span><i class="fa fa-calendar"></i>2024-04-01</span> <span><i
								class="fa fa-comment"></i>15</span>
						</div>
						<div class="card-text">
							<p>회색빛 도시의 일상에 지친 이들에게 제주의 숲과 바다는 천연 치유제가 된다. 천년의 숲 비자림에 들어서면
								영혼까지 맑아지는 기분이다. 평화로움 가득한 중산간 도로, 잘 가꿔진 허브동산, 망망대해가 펼쳐진 해안 절벽까지
								천천히 쉬어가는 동안 스트레스로 찌들었던 몸과 마음이 한결 가벼워진다. 비워진 공간엔 맑고 따스한 기운이 가득
								찬다.</p>
						</div>
						<div class="read-more"><a href="${contextPath}/course/detail.course?contentid=1855198">상세 보기</a></div>
					</div>
					<div class="blog-card">
						<div class="card-img">
							<img
								src="http://tong.visitkorea.or.kr/cms/resource/27/3023727_image2_1.jpg">
							<h1>한라산 품 안에서 보내는 하룻밤</h1>
						</div>
						<div class="card-details">
							<span><i class="fa fa-calendar"></i>2024-04-15</span> <span><i
								class="fa fa-comment"></i>85</span>
						</div>
						<div class="card-text">
							<p>한라산 기슭 1100도로 변에 자리한 서귀포자연휴양림은 삼림욕과 생태탐방은 물론 여름철 물놀이와 캠핑을
								위한 야영장까지 고루 갖추고 있다. 편백나무 숲 속에 펼친 텐트에 모여 앉아 밤하늘 총총히 뜬 별빛을 바라보며
								보내는 하룻밤은 평생 간직할 추억으로 남는다. 휴양림에서 멀지 않은 거리에 한라수목원과 어승생악 탐방로가 있어
								반나절 코스로 잡으면 좋다.</p>
						</div>
						<div class="read-more"><a href="${contextPath}/course/detail.course?contentid=1855218">상세 보기</a></div>
					</div>

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