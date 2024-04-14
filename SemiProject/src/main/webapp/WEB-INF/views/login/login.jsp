<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	 
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script> 
<style>
:root {
  /* COLORS */
  --white: #e9e9e9;
  --gray: #333;
  --blue: #0367a6;
  --lightblue: #008997;

  /* RADII */
  --button-radius: 0.7rem;

  /* SIZES */
  --max-width: 758px;
  --max-height: 480px;

  font-size: 16px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

body {
  align-items: center;
  background-color: var(--white);
  background: url("../images/login_back.jpg");
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  display: grid;
  height: 100vh;
  place-items: center;
}

.form__title {
  font-weight: 300;
  margin: 0;
  margin-bottom: 1.25rem;
}

.link {
  color: var(--gray);
  font-size: 0.9rem;
  margin: 1.5rem 0;
  text-decoration: none;
}

.container {
  background-color: var(--white);
  border-radius: var(--button-radius);
  box-shadow: 0 0.9rem 1.7rem rgba(0, 0, 0, 0.25),
    0 0.7rem 0.7rem rgba(0, 0, 0, 0.22);
  height: var(--max-height);
  max-width: var(--max-width);
  overflow: hidden;
  position: relative;
  width: 100%;
}

.container__form {
  height: 100%;
  position: absolute;
  top: 0;
  transition: all 0.6s ease-in-out;
}

.container--signin {
  left: 0;
  width: 50%;
  z-index: 2;
}

.container.right-panel-active .container--signin {
  transform: translateX(100%);
}

.container--signup {
  left: 0;
  opacity: 0;
  width: 50%;
  z-index: 1;
}

.container.right-panel-active .container--signup {
  animation: show 0.6s;
  opacity: 1;
  transform: translateX(100%);
  z-index: 5;
}

.container__overlay {
  height: 100%;
  left: 50%;
  overflow: hidden;
  position: absolute;
  top: 0;
  transition: transform 0.6s ease-in-out;
  width: 50%;
  z-index: 100;
}

.container.right-panel-active .container__overlay {
  transform: translateX(-100%);
}

.overlay {
  background-color: var(--lightblue);
  background: url("../images/login_back.jpg");
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 100%;
  left: -100%;
  position: relative;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 200%;
  opacity: 0.85;
}

.container.right-panel-active .overlay {
  transform: translateX(50%);
}

.overlay__panel {
  align-items: center;
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  position: absolute;
  text-align: center;
  top: 0;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 50%;
}

.overlay--left {
  transform: translateX(-20%);
}

.container.right-panel-active .overlay--left {
  transform: translateX(0);
}

.overlay--right {
  right: 0;
  transform: translateX(0);
}

.container.right-panel-active .overlay--right {
  transform: translateX(20%);
}

.btn {
  background-color: var(--blue);
  background-image: linear-gradient(90deg, var(--blue) 0%, var(--lightblue) 74%);
  border-radius: 20px;
  border: 1px solid var(--blue);
  color: var(--white);
  cursor: pointer;
  font-size: 0.8rem;
  font-weight: bold;
  letter-spacing: 0.1rem;
  padding: 0.9rem 4rem;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
}

.form > .btn {
  margin-top: 0.8rem;
}

.btn:active {
  transform: scale(0.95);
}

.btn:focus {
  outline: none;
}

.form {
  background-color: var(--white);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 3rem;
  height: 100%;
  text-align: center;
}

.input {
  background-color: #fff;
  border: none;
  padding: 0.9rem 0.9rem;
  margin: 0.5rem 0;
  width: 100%;
}

@keyframes show {
  0%,
  49.99% {
    opacity: 0;
    z-index: 1;
  }

  50%,
  100% {
    opacity: 1;
    z-index: 5;
  }
}
.input_id{
background-color: #fff;
  border: none;
  padding: 0.9rem 0.9rem;
  margin: 0.5rem 0;
  width: 100%;
	border: 1px solid var(--blue);
}
.input_name{
background-color: #fff;
  border: none;
  padding: 0.9rem 0.9rem;
  margin: 0.5rem 0;
  width: 100%;
	border: 1px solid var(--blue);
}
</style>

</head>
<body>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<jsp:include page="../front/header.jsp"/>
<div class="container">
  <!-- Sign Up -->
  <div class="container__form container--signup">
    <form action="${contextPath}/login/signUp.action" method="Post"class="form" id="form1">
      <h2 class="form__title">Sign Up</h2>
      <input type="text" name="id" placeholder="UserId" class="input" />
      <input type="text" name="name" placeholder="Name" class="input" />
      <input type="email" name="email" placeholder="Email" class="input" />
      <input type="password" name="pwd" placeholder="Password" class="input" />
      <input type="text" name="phoneNo" placeholder="Phone" class="input" />
      <button type="submit" class="btn">Sign Up</button>
    </form>
  </div>

  <!-- Sign In -->
  <div class="container__form container--signin">
    <form action="${contextPath}/login/login.action" method="Post" class="form" id="form2">
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
</script>
</body>
</html>