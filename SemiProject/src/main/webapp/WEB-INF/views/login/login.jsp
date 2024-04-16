<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />	 
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${contextPath }/resources/css/login/login.css">
</head>
<body>

<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
<div class="container">
  <!-- Sign Up -->
  <div class="container__form container--signup">
    <form action="${contextPath}/login/signUp" method="Post"class="form" id="form1">
      <h2 class="form__title">Sign Up</h2>
      <input type="text" id="id" name="id" placeholder="UserId" class="input" />
      <input type="text" id="name" name="name" placeholder="Name" class="input" />
      <input type="email" id="email"name="email" placeholder="Email" class="input" />
      <input type="password" id="pwd"name="pwd" placeholder="Password" class="input" />
      <input type="text" id="phoneNo"name="phoneNo" placeholder="Phone" class="input" />
      <button type="submit" class="btn" onclick="checkSignUp()">Sign Up</button>
    </form>
  </div>

  <!-- Sign In -->
  <div class="container__form container--signin">
    <form action="${contextPath}/login/login" method="Post" class="form" id="form2">
      <h2 class="form__title">Sign In</h2>
      <input type="text" name="id" placeholder="UserId" class="input" />
      <input type="password" name="pwd" placeholder="Password" class="input" />
      <a href="#exampleModal" id="findPwd" data-bs-toggle="modal">Forgot your password?</a>
      <button type="submit" class="btn">Sign In</button>
    </form>
  </div>

  <!-- Overlay -->
  <div class="container__overlay">
    <div class="overlay">
      <div class="overlay__panel overlay--left">
        <button class="btn" id="signIn">Sign In</button>
      </div>
      <div class="overlay__panel overlay--right">
        <button class="btn" id="signUp">Sign Up</button>
      </div>
    </div>
  </div>
  <form  action="${contextPath}/login/rePwd.action" method="Post">
  <div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">아이디를 입력하세요</h1>
						</div>
						<div class="modal-body">
							<input type="text" name="id" placeholder="아이디 입력" class="input_id"/>
							<input type="text" name="name" placeholder="이름 입력" class="input_name"/>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">확인</button>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
	</div>
	</form>
</div>




<script>

const signInBtn = document.getElementById("signIn");
const signUpBtn = document.getElementById("signUp");
const firstForm = document.getElementById("form1");
const secondForm = document.getElementById("form2");
const container = document.querySelector(".container");

signInBtn.addEventListener("click", () => {
  container.classList.remove("right-panel-active");
});

signUpBtn.addEventListener("click", () => {
  container.classList.add("right-panel-active");
});

/* firstForm.addEventListener("submit", (e) => e.preventDefault());
secondForm.addEventListener("submit", (e) => e.preventDefault());
 */
 $(document).ready(function() {
		// show.bs.modal : 모달 팝업 시 발생하는 이벤트
		$('#exampleModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget); // 클릭시 눌려진 버튼을 참조하고 싶을때 event.relatedTarget 사용
			var modal = $(this);

			});
	});
 function checkSignUp(){
		var id= document.getElementById("id");
		var name=document.getElementById("name");
		var email=document.getElementById("email");
		var password=document.getElementById("pwd");
		var phoneNo=document.getElementById("phoneNo");
		if(id==null|| name==null || email==null || password==null || phoneNo.value.length==0||isNaN(phoneNo.value)){
			alert("정보를 입력하세요.");
			return false;
		}else{
			document.form1.submit();
		}
		
	}
	function check(regExp, e, msg){
		if(regExp, test(e.value)){
			return true;
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
</script>
</body>
</html>