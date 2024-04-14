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
<link rel="stylesheet" href="${contextPath}/mypage/CSS/mytour.css">
</head>
<body>
	<!-- Begin Page Content -->
	<div class="container-fluid scrollable">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800"
			style="text-align: center; font-size: 45px;">즐겨찾기 여행지</h1>
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
							<%-- 							<c:forEach items="${bList}" var="board"> --%>
							<!-- 								<tr> -->
							<%-- 									<td>${board.bno}</td> --%>
							<%-- 									<td>${board.title}</td> --%>
							<%-- 									<td>${board.writer}</td> --%>
							<%-- 									<td>${board.regDate}</td> --%>
							<!-- 								</tr> -->
							<%-- 							</c:forEach> --%>

							<%--예시 데이터 수동 삽입 --%>
							<tr style="cursor:pointer;" onClick="location.href='${contextPath}/front/tour_detail.jsp?contentid=126460&title=관덕정(제주)&mapy=33.5132954930&mapx=126.5219701925'">
								<td><img class="favorite_tour_img" src="http://tong.visitkorea.or.kr/cms/resource/78/2513578_image2_1.jpg"></td>
								<td>126460</td>
								<td>관덕정(제주)</td>
								<td><p class="favorite_tour_overview">제주도내에서 가장 오래된 건축물 중의 하나인 보물 관덕정은 조선 시대 세종 30년(1448)에 목사 신숙청이 사졸들을 훈련시키고 상무 정신을 함양할 목적으로 이 건물을 세웠다. 관덕정이란 이름은 [사이관덕]이란 문구에서 나온 것으로 활을 쏘는 것은 평화시에는 심신을 연마하고 유사시에는 나라를 지키는 까닭에 이를 보는 것은 덕행으로 태어난 곳이다. 대들보에는 십장생도, 적벽대첩도, 대수렵도 등의 격조 높은 벽화가 그려져 있고, 편액은 안평대군의 친필로 전해오고 있다.</p></td>
								<td>제주특별자치도 제주시 관덕로 19 (삼도이동)</td>
							</tr>
							<tr style="cursor:pointer;" onClick="location.href='${contextPath}/front/tour_detail.jsp?contentid=2027184&title=금룡사(제주)&mapy=33.5539724801&mapx=126.7536019143'">
								<td><img class="favorite_tour_img" src="http://tong.visitkorea.or.kr/cms/resource/77/2027877_image2_1.jpg"></td>
								<td>2027184</td>
								<td>금룡사(제주)</td>
								<td><p class="favorite_tour_overview">제주 금룡사의 템플스테이는 체험형과 휴식형 두가지이다. [체험형 템플스테이]는 주말에 운영되는 정기 체험형 프로그램으로 사찰예절, 사찰안내, 범종체험, 예불, 나 긍정 명상, 108배 자비명상, 파도소리 명상, 스님과의 대화, 칭찬샤워 등의 프로그램을 진행하고 있다. [휴식형 템플스테이]는 바쁜 일상에서 잠시 벗어나 나만의 시간, 나와의 대화를 통해 마음을 쉬어가기 위한 프로그램이다. 예불, 공양, 운력 외에 올레길 걷기, 지질트레일, 바닷가 해맞이, 독서, 기도 등 개인이 자율적으로 자아성찰의 시간을 가지면 된다.원할 경우 108배하며 108염주 꿰기 체험, 스님과의 차담, 명상을 할 수 있다.</p></td>
								<td>제주특별자치도 제주시 구좌읍 김녕로 148-11 (구좌읍)</td>
							</tr>
							<tr style="cursor:pointer;" onClick="location.href='${contextPath}/front/tour_detail.jsp?contentid=600584&title=금호리조트%20제주아쿠아나&mapy=33.2737526275&mapx=126.7028238197'">
								<td><img class="favorite_tour_img" src="http://tong.visitkorea.or.kr/cms/resource/64/3024964_image2_1.jpg"></td>
								<td>600584</td>
								<td>금호리조트 제주아쿠아나</td>
								<td><p  class="favorite_tour_overview">금호리조트 제주 아쿠아나는 남원관광지 인근에 위치한 금호리조트제주 내 물놀이 시설이다. 초원과 제주바다의 아름다운 해안절벽을 낀 수영장에서 바라보는 탁 트인 오션뷰가 제주아쿠아나의 자랑거리이다. 실내 수영장, 노천이벤트탕, 실외 수영장, 실외 슬라이드, 사우나 등 디양한 시설을 갖추고 있다. 리조트와 연결된 산책로를 따라 내려가면 남원큰엉해변이 있어 기암절벽과 맑은 바다 풍경을 감상할 수 있다. 주변 해안가는 제주 올레 5코스에 속한다.</p></td>
								<td>제주특별자치도 서귀포시 남원읍 태위로 522-12</td>
							</tr>





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