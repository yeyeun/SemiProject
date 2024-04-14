<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<c:set value="${pageContext.request.contextPath}" var="contextPath" />
<link href="${resourceurl}/css/board/common.css" rel="stylesheet">
<link href="${resourceurl}/css/board/read.css" rel="stylesheet">
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp"/>
<div class="board-wrapper">
	<table class="table-top">
		<tr>
			<td align="left">
				<h2>상세보기</h2>
			</td>
		</tr>
	</table>
	
	<form>
		<table class="table-middle" width="80%">
			<tr>
				<td>번호</td><td>${board.bno}</td><td>작성자</td><td>${board.writer}</td>
			</tr>
			<tr>
				<td>작성일</td><td>${board.regDate}</td><td>조회수</td><td>${board.hit}</td>
			</tr>
			<tr>
				<td>제목</td><td colspan="3"><span style="font-weight:bold">[${board.btype}]</span>&nbsp;${board.title}</td>
			</tr>
			<tr>
				<td>내용</td><td colspan="3" height="100">${board.content}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
						<button type="button" onclick="location.href='${contextPath}/board/modify.bo?bno=${board.bno}';">수정하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/deleteProc.bo?bno=${board.bno}';">삭제하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/board.bo';">목록 보기</button>
				
				
				<!-- 로그인 세션 여부에 따라 보이는 버튼 다르게 하기 -->
<%-- 				<c:choose>
					<c:when test="${sessionScope.loginId == board.writer }">
						<button type="button" onclick="location.href='${contextPath}/board/modify.jsp?bno=${board.bno}';">수정하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/deleteProc.jsp?bno=${board.bno}';">삭제하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/board.jsp';">목록 보기</button>
					</c:when>
					<c:otherwise>
						<button type="button" onclick="location.href='${contextPath}/board/board.jsp';">목록 보기</button>
					</c:otherwise>
				</c:choose> --%>
				
				
				
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>