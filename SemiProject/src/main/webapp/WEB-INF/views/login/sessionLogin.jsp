<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<%
	request.setCharacterEncoding("UTF-8");

	MemberDAO dao = new MemberDAO(application);
	String loginId = request.getParameter("id");
	String loginPwd = request.getParameter("pwd");
	int result = dao.isUser(loginId, loginPwd);
	dao.close();
	if(result==1){
		session.setAttribute("loginId", loginId);
		session.setAttribute("loginPwd", loginPwd);
		//세션 유지시간 설정
		session.setMaxInactiveInterval(3600); //1시간동안 아이디 유지
		response.sendRedirect("${contextPath}/front/main.jsp");
	}else{//로그인 실패한경우 알림창 팝업
		out.println("<script>alert('로그인 실패'); history.back();</script>");
	}
%>
</body>
</html>