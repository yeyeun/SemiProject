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
					<td align="center">${board.regDate}</td>
					<td align="center">${board.hit}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
    </tbody>
</table>

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

<table class="table-bottom">
	<tr>
		<td align="right"><button type="button" id="regBtn">글쓰기</button></td>
	</tr>
</table>

<form action="${pageContext.request.contextPath}/board/board.bo" id="actionFrm">
	<input type="hidden" name='pageNum' value='${pagingDTO.cri.pageNum}'>
	<input type="hidden" name='amount' value='${pagingDTO.cri.amount}'>
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
	
	$(document).ready(function(){
		$("#regBtn").on("click",function(){
			self.location = "/board/write";
		})
		
		//체크
		let result = '<c:out value="${result}"/>';
		console.log('result:',result);
		checkChange(result);
		function checkChange(result){
			if(result === '')
				{return;}
			if(parseInt(result)>0){
				alert("게시글 " + parseInt(result) + "번이 등록되었습니다");
			}
			if(result==="modify"){
				alert("수정이 완료되었습니다");
			}
			if(result==="remove"){
				alert("삭제가 완료되었습니다");
			}
		}
	});

</script>
</body>
</html>
