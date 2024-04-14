<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<c:set value="${pageContext.request.contextPath}" var="contextPath" />
<link href="${resourceurl}/css/board/common.css" rel="stylesheet">
<link href="${resourceurl}/css/board/modify.css" rel="stylesheet">
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp"/>
<div class="board-wrapper">
	<table class="table-top">
		<tr>
			<td align="left">
				<h2>수정하기</h2>
			</td>
		</tr>
	</table>
	<form action="${contextPath}/board/modifyProc.bo" method="POST">
		<table class="table-middle" width="80%">
			<tr hidden>
				<td>게시번호</td>
				<td><input type="text" name="bno" value="${board.bno}"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${board.title}" style="width:90%;"/></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" style="width:90%; height:100px">${board.content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">수정 완료</button>
					<button type="reset">다시 입력</button>
					<button type="button" onclick="location.href='${contextPath}/board/board.bo';">목록 보기</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>