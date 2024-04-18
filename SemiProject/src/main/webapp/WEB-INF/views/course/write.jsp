<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}'/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/course/course_write.css">

</head>
<body>
	<%
	String loginId = (String) session.getAttribute("loginId");
	
	
	%>
	<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
	<div id="course_write_wrapper">
		<div class="left_box">
			<div class="side_tab">
				<a href="${contextPath}/course/allList"><span class="spread-underline">여행코스 검색</span></a><br>
				<a href="${contextPath}/course/write"><span class="spread-underline checked">여행코스 만들기</span></a>
			</div>
		</div>
		<div class="right_box">
			<!-- 여행코스 만들기 페이지 -->
			<div class="container">
				<span class="form-title">여행지 만들기</span>
				<hr style="border: none; height: 3px; background: #0D689C; opacity: 1;">
				
				<form action="${contextPath}/course/list.course">
					<div class="form-row">
						<span>제목</span><input name="title" type="text"
							placeholder="제목을 입력하세요" />
					</div>

					<div class="form-row">
						<button type="button" class="btn" data-bs-toggle="modal"
						data-bs-target="#exampleModal" data-whatever="<%=loginId%>">여행지 불러오기</button>	
							
						<span class="loadTour">여행지가 없습니다</span>
					</div>

					<div class="form-row">
						<span>내용</span><br>
						<textarea name="message" placeholder="내용을 입력하세요"></textarea>
						<br>
					</div>

					<button type="submit" id="submit" class="btn">글 작성</button>
				</form>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg">
					<div class="modal-content" style="width: 700px;">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">모달 타이틀</h1>
						</div>
						<div class="modal-body" style="height: 465px; overflow-y: auto;">
							<ul>
							<c:forEach items="${mytourList }" var = "tour">
								<li class="cartItem" onclick="saveContentId('${tour.contentid}')">
									<span class="cartcontentid">${tour.contentid }</span>
									<img src="${tour.firstimage}" alt="Tour Image" class="cartimage">
            						<span class="carttitle">${tour.title}</span>
								</li>
							</c:forEach>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary">가져오기</button>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal"onclick="clearSelectedItems()">닫기</button>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
var selectedContentIds = [];

function saveContentId(contentId) {
    selectedContentIds.push(contentId);
    console.log(selectedContentIds); // 선택한 contentId 배열을 콘솔에 출력
}
function clearSelectedItems() { //닫기 버튼 누르면 배열 초기화
    // 배열 초기화
    selectedContentIds = [];
}

$(document).ready(function() {
	// show.bs.modal : 모달 팝업 시 발생하는 이벤트
	$('#exampleModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget); // 클릭시 눌려진 버튼을 참조하고 싶을때 event.relatedTarget 사용
		var recipient = button.data('whatever'); // data-whatever의 값 가져오기
		var modal = $(this);
		modal.find('.modal-title').text('[' + recipient + ']님의 장바구니 목록');
		modal.find('.modal-body').val(recipient);
		});
});
</script>
</body>
</html>
