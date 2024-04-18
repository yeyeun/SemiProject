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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${contextPath}/resources/css/course/course_detail.css">

</head>
<body>
<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
<div id="course_detail_wrapper">
	<div class="left_box">
		<div class="side_tab">
				<a href="${contextPath}/course/allList"><span class="spread-underline checked">여행코스 검색</span></a><br>
				<a href="${contextPath}/course/write"><span class="spread-underline">여행코스 만들기</span></a>
		</div>
	</div>
	<div class="right_box">
		<!-- 여행코스 세부 페이지 -->
		<div class="title">
			<blockquote>
			 	<p>${course.title}</p>
			</blockquote>
		</div>
		<div class="container">
		<div class="overview-text">
			<blockquote>
				<p>${course.overview}</p>
			</blockquote>
		</div>
		<div class="row-wrapper">
			<section style="background-color: #F0F2F5;">
				<div class="container py-5">
					<div class="main-timeline-2">
					
					<!-- ajax 반복문 -->
					</div>
				</div>
			</section>
  			
  		</div>
 
		</div>
	</div>

		<script>
 	$(document).ready(function(){
		let result = $(".main-timeline-2"); //bootstrap 추가
		let subcontentid = JSON.parse('${course.subcontentid}'); //subcontentid : 여행지 아이디가 담긴 배열
		let str="";
		let datas;
        for(var i=0; i<subcontentid.length; i++){
/*             (function(i){ */
                let str="";
                $.ajax({ //여행지 세부정보 조회
                    url: "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=ETC&contentId="+ subcontentid[i] +"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA%3D%3D&_type=json",
                    async:false,
                    success: function(data){
                        let detailInfos = data.response.body.items.item[0];
                        str = `
                        
 
              			<div class="timeline-2">
              	        <div class="card">
              	          <img src="\${detailInfos.firstimage}" alt="..." onerror="this.src='../images/nocourseimg.png'" class="card-img-top"/>
              	          <div class="card-body p-4">
              	            <h4 class="fw-bold mb-4">
              	          	<a href="${contextPath}/front/tour_detail.jsp?contentid=\${detailInfos.contentid}&title=\${detailInfos.title}&mapy=\${detailInfos.mapy}&mapx=\${detailInfos.mapx}">\${detailInfos.title}</a>
              	            </h4>
              	          </div>
              	        </div>
              	      </div>

                        `;
                        
                        
                        result.append(str);
                    }
                });
                
/*             })(i); */
            
        }//for문 끝
	});
	</script>
</div>
</body>
</html>
