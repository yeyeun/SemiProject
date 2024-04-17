<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<c:set value="${pageContext.request.contextPath}" var="contextPath" />
<link href="${resourceurl}/css/board/common.css" rel="stylesheet">
<link href="${resourceurl}/css/board/list.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</head>

<body>
<script>
</script>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
<div class="board-wrapper">
<form>
<table class="table-top">
	<tr>
		<td align="center">
			<select name="searchField" class="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord">&nbsp;<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>
<table class="table table-hover">
    <thead>
    <tr>
        <th>번호</th>
        <th>분류</th>
        <th>제목</th>
        <th>작성자</th>
        <th>날짜</th>
        <th>조회수</th>

    </tr>
    </thead>
    <tbody>
    <c:choose>
			<c:when test="${empty bList}">
				<tr>
					<td colspan="6" align="center">등록된 게시물이 없습니다</td>
				</tr>
			</c:when>
		<c:otherwise>
			<c:forEach items="${bList}" var="board">
				<tr align="center">
					<td>${board.bno}</td>
					<td>${board.btype}</td>
					<td align="left"><a href="${contextPath}/board/read?bno=${board.bno}">${board.title}</a></td>
					<td align="center">${board.writer}</td>
					<td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/></td>
					<td align="center">${board.hit}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
    </tbody>
</table>

<div class="pagination-wrapper">
	<div class="pagination">
		<!-- 이전 페이지 버튼 -->
		<c:if test="${pagingDTO.prev}">
			<a href="${pagingDTO.start-1}" tabindex="-1">&laquo;</a>
		</c:if>
		<!-- 각 번호 페이지 버튼 -->
		<c:forEach var="num" begin="${pagingDTO.start}" end="${pagingDTO.end}">
			<c:choose>
			 <c:when test="${pagingDTO.cri.pageNum==num}">
			 	<a href="${num}" class="active">${num}</a>
			 </c:when>
			 <c:otherwise>
			 	<a href="${num}">${num}</a>
			 </c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- 다음 페이지 버튼 -->
		<c:if test="${pagingDTO.next}">
			<a href="${pagingDTO.end+1}">&raquo;</a>
		</c:if>
		
		
		
	</div>
</div>

<table class="table-bottom">
	<tr>
		<td align="right"><button type="button" id="regBtn">글쓰기</button></td>
	</tr>
</table>

<form id="actionFrm" method="get">
	<input type="hidden" name='pageNum' value='${pagingDTO.cri.pageNum}'>
	<input type="hidden" name='amount' value='${pagingDTO.cri.amount}'>
	<input type="hidden" name='searchField' value='${pagingDTO.cri.searchField}'>
	<input type="hidden" name='searchWord' value='${pagingDTO.cri.searchWord}'>

</form>

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




</div>
<script>
	var actionFrm = $("#actionFrm");
	$(".pagination a").on("click",function(e){
		e.preventDefault();
		//console.log('click');
		actionFrm.find("input[name='pageNum']").val($(this).attr("href"));
		actionFrm.attr("action","/board/list")
		actionFrm.submit();
	});
	


	$(document).ready(function(){
		let loginId = '<%=(String)session.getAttribute("loginId")%>';
		
		$("#regBtn").on("click",function(){
			if(loginId=="null"){
				alert("로그인 후 사용해주세요");
				return;
			}
			else{
				self.location = "/board/write";
			}
		});
		
		//체크
		let result = '<c:out value="${result}"/>';
		console.log('result :', result);
		checkModal(result);
		function checkModal(result) {
			if (result === '') { return; }
			if(parseInt(result)>0){
				$('.modal-body > p').text("게시글이 등록되었습니다");
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
</body>
</html>
