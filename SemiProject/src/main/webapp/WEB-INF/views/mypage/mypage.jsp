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
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
	    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="${contextPath}/mypage/CSS/mypage.css">
</head>
<body>
<div class="mypage_header_container" style="position:relative; height: 100px; width: 100%;">
	<jsp:include page="${application.contextPath}/front/header.jsp"/>
</div>
<div class="body_container" style="position: relative;">
    <nav id="mypage_nav" class="sidebar">
        <header>
            <div class="image-text">
                <span class="image">
                    <img id="logo_icon" alt="" src="../images/logo_icon.PNG">
                </span>

                <div class="text logo-text">                	
                    <span class="name">MyPage</span>
                    <span class="profession" style="text-decoration: underline;">${sessionScope.loginId}님</span>
                </div>
            </div>

            <i class='bx bx-chevron-right toggle'></i>
        </header>

        <div class="menu-bar">
            <div class="menu">
                <ul class="menu-links">
                    <li class="nav-link active">
                        <a href="#" onclick="loadContent('myprofile.jsp')">
                            <i class='bx bx-home-alt icon'></i>
                            <span class="text nav-text">내 정보 조회</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#" onclick="loadContent('mywrite.jsp')">
                            <i class='bx bx-bar-chart-alt-2 icon'></i>
                            <span class="text nav-text">내가 작성한 글</span>
                        </a>
                    </li>
                    <li class="nav-link">
                        <a href="#" onclick="loadContent('mytour.jsp')">
                            <i class='bx bx-heart icon'></i>
                            <span class="text nav-text">관심 여행지</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="bottom-content">
                <li class="">
                    <a href="#">
                        <i class='bx bx-log-out icon'></i>
                        <span class="text nav-text">Logout</span>
                    </a>
                </li>
            </div>
        </div>
    </nav>

    <section class="home" style="background: white; overflow: hidden;">
        <div class="text" id="content">Loading..</div>
    </section>
</div>

	<script>
    $(document).ready(function() {
        loadContent('myprofile.jsp');
    });
        const body = document.querySelector('body'),
            sidebar = body.querySelector('#mypage_nav'),
            toggle = body.querySelector(".toggle"),
            modeSwitch = body.querySelector(".toggle-switch"),
            modeText = body.querySelector(".mode-text");

        toggle.addEventListener("click", () => {
            sidebar.classList.toggle("close");
        })
        $(".menu-links").on("click", ".nav-link", function() {
        $(".nav-link").removeClass("active");
        $(this).addClass("active");
    });
		

        function loadContent(page) {
            $.ajax({
                url: page,
                success: function(response) {
                    $(".home").html(response);
                }
            });
        }
    </script>

</body>
</html>