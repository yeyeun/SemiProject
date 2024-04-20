<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
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
				<a href="${contextPath}/course/allList"><span class="spread-underline">여행코스 검색</span></a><br> <a href="${contextPath}/course/write"><span class="spread-underline checked">여행코스 만들기</span></a>
			</div>
		</div>
		<div class="right_box">
			<!-- 여행코스 만들기 페이지 -->
			<div class="container">
				<span class="form-title">여행코스 만들기</span>
				<hr style="border: none; height: 3px; background: #0D689C; opacity: 1;">

				<form name="form1" action="${contextPath}/course/add">
					<input id="contentidInput" name="contentid" type="text" value="" style="display: none;" /> 
					<input id="firstimageInput" name="firstimage" type="text" value="" style="display: none;" />
					<input id="subcontentidInput" name="subcontentid" type="text" value="" style="display: none;" />
					<input id="idInput" name="id" type="text" value="<%=loginId %>" style="display: none;" />
					<div class="form-row">
						<span>제목</span><input name="title" type="text" id="title" maxlength="20" placeholder="제목을 입력하세요" />
					</div>

					<div class="form-row">
						<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal" data-whatever="<%=loginId%>">여행지 불러오기</button>

						<span id="loadTour">여행지가 없습니다</span>
					</div>

					<div class="form-row">
						<span>내용</span><br>
						<textarea name="overview" id="overview" maxlength="400" placeholder="내용을 입력하세요"></textarea>
						<br>
					</div>

					<button type="submit" id="submit" class="btn btn-primary" onclick="sendData()">글 작성</button>
				</form>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg">
					<div class="modal-content" style="width: 700px;">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">모달 타이틀</h1>
						</div>
						<div class="modal-body" style="width: 483px; height: 465px; overflow-y: auto;">
							<ul style="list-style-type: none;">
								<c:forEach items="${mytourList }" var="tour">
									<li class="cartItem"><input type="checkbox" class="cartCheckbox" value="${tour.title}" onclick="toggleCheckbox(this)"> <img src="${tour.firstimage}" alt="Tour Image" class="cartimage" onerror="this.src='../../resources/images/nocourseimg.png'"> <span class="carttitle">${tour.title}</span>
										<p id="checkcontentid" style="display: none;">${tour.contentid }</p></li>
								</c:forEach>
							</ul>
						</div>
						<p style="margin-top: 20px;">
							여행 순서: <span id="selectedIdsDisplay"></span>
						</p>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" onclick="showTourList()" data-bs-dismiss="modal">가져오기</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="clearCheckboxes()">초기화</button>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		var selectedTitles = [];
		var selectedIds = [];
		var selectedIdsDisplay = document.getElementById("selectedIdsDisplay");
		var tourList = document.getElementById("loadTour");
		var selectedIdsValue = document.getElementById("checkcontentid");
		var firstImage;

		function toggleCheckbox(checkbox) {
			var contentTitle = checkbox.value;
			var contentId = checkbox.parentElement
					.querySelector("#checkcontentid").textContent;
			var li = checkbox.parentElement;
			if (checkbox.checked) {
				selectedTitles.push(contentTitle);
				selectedIds.push(contentId);
				li.style.backgroundColor = "rgb(180,180,180)"; // 체크되면 배경색 변경
			} else {
				var index = selectedTitles.indexOf(contentTitle);
				if (index !== -1) {
					selectedTitles.splice(index, 1);
					selectedIds.splice(index, 1);
				}
				li.style.backgroundColor = "";
			}
			selectedIdsDisplay.innerHTML = selectedTitles.join(' → ');
			console.log(selectedIds);
		}

		function clearCheckboxes() { //닫기버튼
			// 모든 체크박스와 연관된 데이터를 초기화합니다.
			var checkboxes = document.querySelectorAll('.cartCheckbox');
			checkboxes.forEach(function(checkbox) {
				checkbox.checked = false;
				var contentId = checkbox.parentElement
						.querySelector("#checkcontentid").textContent;
				var index = selectedIds.indexOf(contentId);
				if (index !== -1) {
					selectedTitles.splice(index, 1);
					selectedIds.splice(index, 1);
				}
				checkbox.parentElement.style.backgroundColor = "";
			});
			//     selectedTitles = [];
			// 선택된 제목을 표시를 초기화합니다.
			selectedIdsDisplay.innerHTML = '';
			tourList.innerHTML = '여행지가 없습니다';
		}

		function showTourList() {
			tourList.innerHTML = selectedTitles.join(' → ');
		}
		function sendData() {
			var titleValue = document.getElementById("title").value;
			var overviewValue = document.getElementById("overview").value;
			
		    // 선택된 아이템이 없을 때 서브밋 막기
		    if (selectedIds.length === 0) {
		        alert("최소한 하나의 여행지를 선택해야 합니다.");
		        event.preventDefault();
		    }
		    // 제목,내용이 없을때 서브밋 막기
		    else if(titleValue === '' || overviewValue === ''){
		    	alert("제목과 내용은 최소 한 글자 이상 입력해주세요");
		    	event.preventDefault();
		    }
		    

		   
		    // 폼에 랜덤 id 값 삽입
		    var randomId = Math.floor(100000 + Math.random() * 900000);
		    document.getElementById("contentidInput").value = randomId;
		    document.getElementById("subcontentidInput").value = selectedIds;
		    document.getElementById("firstimageInput").value = firstImage;

		}

		$(document).ready(
				function() {
					//선택된 첫번째 아이템의 이미지 링크
					$('#exampleModal').on(
							'click',
							'.btn-primary',
							function() {
								// selectedIds 배열의 첫 번째 값
								var firstId = selectedIds[0];

								// 해당 id를 가지고 있는 li 요소의 이미지 src 가져오기
								firstImage = $('p:contains(' + firstId + ')')
										.siblings('img').attr('src');
								console.log(firstImage);
							});
					// show.bs.modal : 모달 팝업 시 발생하는 이벤트
					$('#exampleModal').on(
							'show.bs.modal',
							function(event) {
								var button = $(event.relatedTarget); // 클릭시 눌려진 버튼을 참조하고 싶을때 event.relatedTarget 사용
								var recipient = button.data('whatever'); // data-whatever의 값 가져오기
								var modal = $(this);
								modal.find('.modal-title').text(
										'[' + recipient + ']님의 관심 여행지');
								modal.find('.modal-body').val(recipient);
							});
				});
	</script>
</body>
</html>
