<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<title>header</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<link href="${resourceurl}/css/include/header.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body>
<div class="header-container">
  <header>
   <c:choose>
  	<c:when test="${sessionScope.loginId!=null}">
  	<div class="login-user">
      <span>${sessionScope.loginId}님이 로그인 중입니다</span><img src="${resourceurl }/images/user-icon.png">
      <div class="login-user-menu" style="display:none;">
      	<ul>
    		<li><a href="${contextPath}/mypage">마이페이지</a></li>
    		<li><a href="${contextPath}/login/logout.action">로그아웃</a></li>
    	</ul>
    	</div>
    </div>

	</c:when>
	<c:otherwise>
  		<div class="login-signup">
        <a href="${contextPath}/login/login"><b>로그인/회원가입</b></a>
      </div>
     </c:otherwise>
   </c:choose>
  </header>
  <nav class="header_nav">
    <div class="logo_container">
      <img src="${resourceurl}/images/logo.png" width=200px>
    </div>

    <div class="header-right">
      <a href="${contextPath}/home/" class="nav-item nav-active">홈</a>
      <a href="${contextPath}/tour/list" class="nav-item">여행지</a>
       <a href="${contextPath}/course/allList" class="nav-item">여행코스</a>
      <a href="${contextPath}/event/list" class="nav-item">축제/행사</a>
      <a href="${contextPath}/board/list" class="nav-item">게시판</a>
    </div>
  </nav>
</div>

  <script>
  $(document).ready(function() {
      // 페이지 로드 시 active 클래스 설정
      setActiveClass();

      // 네비게이션 클릭 시 active 클래스 설정
      $('.nav-item').click(function(event) {
          var href = $(this).attr('href');
          $('.nav-item').removeClass('nav-active');
          $(this).addClass('nav-active');
          setActiveClass(); // active 클래스 설정
      });

      // 브라우저의 상태(뒤로/앞으로) 변경 시 active 클래스 설정
      $(window).on('popstate', function() {
          setActiveClass();
      });

      // 현재 페이지에 해당하는 링크에 active 클래스 설정하는 함수
      function setActiveClass() {
          var currentPage = location.pathname;
          $('.nav-item').removeClass('nav-active');

          // 각 탭의 URL 경로와 현재 페이지의 경로 비교하여 active 클래스 부여
          if (currentPage.startsWith("${contextPath}/event")) {
              $('.nav-item[href="${contextPath}/event/list"]').addClass('nav-active');
          } else if (currentPage.startsWith("${contextPath}/tour")) {
              $('.nav-item[href="${contextPath}/tour/list"]').addClass('nav-active');
          } else if (currentPage.startsWith("${contextPath}/course")) {
              $('.nav-item[href="${contextPath}/course/allList"]').addClass('nav-active');
          } 
          else if (currentPage.startsWith("${contextPath}/board")) {
              $('.nav-item[href="${contextPath}/board/list"]').addClass('nav-active');
          } else if (currentPage.startsWith("${contextPath}/home")) {
              $('.nav-item[href="${contextPath}/home/"]').addClass('nav-active');
          }
          // 추가 탭 있으면 아래에 같은 방식으로 추가, 여행지 여행코스 링크 추후 수정
      }
  });
	 // 스크롤 이벤트 감지
	    $(window).scroll(function() {
	        // 헤더 요소 선택
	        var nav = $('.header_nav');
	        // 스크롤 위치
	        var scroll = $(window).scrollTop();

	        // 스크롤 위치에 따라 헤더의 배경색 변경
	        if (scroll > 0) {
	            nav.addClass('scrolled'); // 스크롤이 발생하면 scrolled 클래스 추가
	        } else {
	            nav.removeClass('scrolled'); // 스크롤이 없으면 scrolled 클래스 제거
	        }
	    });
	 
	    let subToggle=true;
	    $(".login-user").click(()=>{
	      if(subToggle){
	        $(".login-user-menu").slideDown(500);
	      }else{
	        $(".login-user-menu").slideUp(500);
	      }
	      subToggle=!subToggle;
	    });
  </script>
</body>
</html>