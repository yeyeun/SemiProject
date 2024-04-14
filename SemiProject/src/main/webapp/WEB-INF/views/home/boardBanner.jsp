<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../CSS/boardBanner.css" rel="stylesheet">
        <title>Document</title>
    </head>

    <body>

	<div class="tab">
            <button class="tablinks active" onclick="openTab(event, 'Tab1')"><b>축제/행사</b></button>
            <button class="tablinks" onclick="openTab(event, 'Tab2')"><b>게시판</b></button>
        </div>

        <div id="Tab1" class="tabcontent">
            <div id="tab1_img1"></div>
            <div class="boardList">
                <ul id="ul1">
                    <!-- <li><a href="#">축제행사1</a></li>
                <li><a href="#">축제행사2</a></li> -->
                </ul>
            </div>
        </div>

        <div id="Tab2" class="tabcontent tabcontent2">
            <div class="boardList2">
                <ul>
                    <h3>게시판</h3>
                    <li><a href="#">aa</a></li>
                    <li><a href="#">bb</a></li>
                </ul>
            </div>
        </div>
        

        <script>
            function openTab2(evt, tabName) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }

            function openTab(evt, tabName) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }

            // 페이지 로드될 때 Tab1을 활성화하도록 설정
            window.onload = function () {
                openTab2(event, 'Tab1');
            };

            $(document).ready(function () {
                let result = $("#ul1");
                let str = "";

				let temp = 0;
                let currentDate = new Date();
                let year = currentDate.getFullYear();
                let month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
                let day = ('0' + currentDate.getDate()).slice(-2);

                let currentDateStr = year + month + day;



                $.ajax({
                    url: `https://apis.data.go.kr/B551011/KorService1/searchFestival1?MobileOS=etc&MobileApp=a&_type=json&arrange=Q&eventStartDate=\${currentDateStr}&areaCode=39&serviceKey=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D`,
                    success: function (data) {
                        console.log('items', data.response.body.items);
                        let items = data.response.body.items.item;
                        // 배열을 섞고
                        items.sort(() => Math.random() - 0.5);
                        // 핸덤 5개 추출
                        let selectedItems = items.slice(0, 5);
                        $.each(selectedItems, (index, item) => {
                        	
                            
                            // 날짜 형식 변경
                            let startDate = formatDate(item.eventstartdate);
                            let endDate = formatDate(item.eventenddate);
                            str += `                            	
                            <li id="festivalTitle"><a href="#" onmouseover="changeImage('\${item.firstimage}')"><b>\${item.title}</b></a></li>
                            <li id="festivalDate">&nbsp;&nbsp;&nbsp;&nbsp;\${startDate}~\${endDate}</li>                     
                        `;
                        //마지막 항목이 아니면 <hr>추가
                         if (index < selectedItems.length - 1) {
     						   str += `<hr>`;
    }
                        });
                        //console.log(str);
                        result.append(str);
                    }
                });
            });
            function changeImage(imageSrc) {
                $("#tab1_img1").fadeOut('fast', function() {
                    $(this).css("background-image", `url('\${imageSrc}')`).fadeIn('fast');
                });
            }
         // 날짜 형식 변경 
            function formatDate(dateString) {
                // 문자열에서 연, 월, 일 추출
                let year = dateString.substring(0, 4);
                let month = dateString.slice(4, 6);
                let day = dateString.slice(6, 8);
                // 변경된 형식으로 반환
                return `\${month}월 \${day}일`;
            }

        </script>

    </body>

    </html>