<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application" />
<link rel="stylesheet" href="${resourceurl }/css/include/footer.css">
<title>Insert title here</title>
</head>
<body>
	<footer class="new_footer_area bg_color">
		<div class="new_footer_top">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-md-6">
						<div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.6s" style="visibility: visible; animation-delay: 0.6s; animation-name: fadeInLeft;">
							<h3 class="f-title f_600 t_color f_size_18">Resource</h3>
							<ul class="list-unstyled f_list">
								<li><a href="https://knto.or.kr/index">한국 관광 공사</a></li>
								<li><a href="https://api.visitkorea.or.kr/#/">Tour API 4.0</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.6s" style="visibility: visible; animation-delay: 0.6s; animation-name: fadeInLeft;">
							<h3 class="f-title f_600 t_color f_size_18">Team(요기5때)</h3>
							<ul class="list-unstyled f_list">
								<li><a href="https://github.com/chk0527">Choi Hyeon Kyu</a></li>
								<li><a href="https://github.com/yeyeun">Choi Young Eun</a></li>
								<li><a href="https://github.com/YoungWoo0">Son Young Woo</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="footer_bg">
				<div class="footer_bg_one"></div>
				<div class="footer_bg_two"></div>
			</div>
		</div>
		<div class="footer_bottom">
			<div class="container">
				<div class="row align-items-center">
					<div class="col-lg-6 col-sm-7">
						<p class="mb-0 f_400">© cakecounter Inc.. 2019 All rights reserved.</p>
					</div>
					<div class="col-lg-6 col-sm-5 text-right">
						<p>
							Made with <i class="icon_heart"></i> in <a href="http://cakecounter.com" target="_blank">CakeCounter</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>