<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}'/>
<script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/course/course_main.css">
</head>
<body>
<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
<div id="course_main_wrapper">
	<div class="left_box">
		<div class="side_tab">
				<a href="${contextPath}/course/allList"><span class="spread-underline checked">여행코스 검색</span></a><br>
				<a href="${contextPath}/course/write"><span class="spread-underline">여행코스 만들기</span></a>
		</div>
	</div>
		<div class="right_box">
			<!-- 여행코스 검색 페이지 -->
			<div class="content">
				<div class="filter-wrapper">
				<form> <!-- action값이 없을경우 현재 페이지 반환 -->
				<select name="searchField" class="searchField">
					<option value="title">&nbsp;제목</option>
					<option value="overview">&nbsp;내용</option>
				</select>
				<input type="text" name="searchWord">&nbsp;<input type="submit" value="검색하기">	
				</form>
				</div>
				<hr>
				<div class="row-wrapper">
					<div class="row justify-content-center">
						<c:choose>
							<c:when test="${empty allList}">
								<p>등록된 여행코스가 없습니다</p>
							</c:when>
							<c:otherwise>
								<c:forEach items="${allList}" var="course">
									<div class="col-4 cards">
										<img class="images" src="${course.firstimage}" alt="..."
											onerror="this.src='../../resources/images/nocourseimg.png'" />
											
										<!-- 	onerror="onErrorFn(this);" -->
										<p class="title">${course.title}</p>
										<div class="overlay"></div>
										<div class="buttons">
											<a href="${contextPath}/course/detail?contentid=${course.contentid}"> 상세보기 </a>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<br>

					<div class="pagination-wrapper">
						<div class="pagination">
							<c:if test="${pagingDTO.prev}">
								<a href="${pagingDTO.start-1}" tabindex="-1">&laquo;</a>
							</c:if>
							<c:forEach var="num" begin="${pagingDTO.start}" end="${pagingDTO.end}">
								<c:choose>
									<c:when test="${pageNum==num}">
										<a href="${num}" class="active">${num}</a>
									</c:when>
									<c:otherwise>
										<a href="${num}">${num}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${pagingDTO.next}">
								<a href="${pagingDTO.end+1}">&raquo;</a>
							</c:if>
						</div>
					</div>

				</div>
			</div>
			
		<div class="modal fade" tabindex="-1" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">알림</h5>	
					</div>
					<div class="modal-body">
						<p>처리가 완료됐습니다</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<form id="actionFrm" method="get">
			<input type="hidden" name='pageNum' value='${pagingDTO.cri.pageNum}'>
			<input type="hidden" name='amount' value='${pagingDTO.cri.amount}'>
			<input type="hidden" name='searchField' value='${pagingDTO.cri.searchField}'>
			<input type="hidden" name='searchWord' value='${pagingDTO.cri.searchWord}'>
		</form>
		</div>

<script>
var actionFrm = $("#actionFrm");
$(".pagination a").on("click",function(e){
	e.preventDefault();
	//console.log('click');
	actionFrm.find("input[name='pageNum']").val($(this).attr("href"));
	actionFrm.submit();
});

function setEmptyImage(img){
	img.src='../../resources/images/image_none.png';
}

$(document).ready(function(){
	//체크
	let result = '<c:out value="${result}"/>';
	console.log('result :', result);
	checkModal(result);
	function checkModal(result) {
		if (result === '') { return; }
		if(result === "write"){
			$('.modal-body > p').text("여행코스가 등록되었습니다");
		}
   		if (result === "modify") {
       		$('.modal-body > p').text('수정되었습니다');
   		}
   		if (result === "remove") {
       		$('.modal-body > p').text('삭제되었습니다');
       	} 
   		$("#myModal").modal("show");
   	}
	
});
</script>
</div>
</body>
</html>
