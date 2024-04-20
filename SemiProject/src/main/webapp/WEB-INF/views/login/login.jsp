<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

</head>

<link rel="stylesheet" href="${contextPath }/resources/css/login/login.css?after">

<body>

	<jsp:include page="${contextPath }/WEB-INF/views/include/header.jsp"></jsp:include>
	<div class="container">
		<!-- Sign Up -->
		<div class="container__form container--signup">
			<form action="${contextPath}/login/signUp" method="Post" class="form" id="form1" name="form1">
				<h2 class="form__title">회원가입</h2>
				<input type="text" id="id" name="id" placeholder="아이디" class="input" />
				<label id="label1"></label> 
				<input type="text" id="name" name="name" placeholder="이름" class="input" />
				<label id="label2"></label> 
				<input type="email" id="email" name="email" placeholder="이메일" class="input" />
				<label id="label3"></label> 
				<input type="password" id="pwd" name="pwd" placeholder="비밀번호" class="input" />
				<label id="label5">비밀번호는 영문, 숫자, 특수문자 조합 8자리 이상을 입력해주세요.</label> 
				<input type="text" id="phoneNo" name="phoneNo" placeholder="핸드폰 번호" class="input" />
				<label id="label4"></label>
				<input type="button" class="btn" onclick="checkSignUp()" value="회원가입" />
				<!--       <button type="submit" class="btn" onclick="checkSignUp()">회원가입</button> -->
			</form>
		</div>

		<!-- Sign In -->
		<div class="container__form container--signin">
			<form action="${contextPath}/login/login" method="Post" class="form" id="form2">
				<h2 class="form__title">로그인</h2>
				<input type="text" id="id" name="id" placeholder="아이디" class="input" />
				<input type="password" id="pwd" name="pwd" placeholder="비밀번호" class="input" />
				<a href="#exampleModal" id="findPwd" data-bs-toggle="modal" onclick="setis()">비밀번호 찾기</a>
				<button type="submit" class="btn">로그인</button>
			</form>
		</div>

		<!-- Overlay -->
		<div class="container__overlay">
			<div class="overlay">
				<div class="overlay__panel overlay--left">
					<button class="btn" id="signIn">로그인</button>
				</div>
				<div class="overlay__panel overlay--right">
					<button class="btn" id="signUp">회원가입</button>
				</div>
			</div>
		</div>

		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호 찾기</h1>
					</div>

					<div class="modal-body">
						<form action="${contextPath}/login/confirmPwd" method="Post">
							<div id="inputInfo">
								<input type="text" id="checkId" name="id" placeholder="아이디 입력" class="input_id" /><label id="labelId"></label>
								<input type="text" id="checkEmail" name="email" placeholder="이메일 입력" class="input_email" /><label id="labelEmail"></label>
								<div class="modal-footer">
									<input type="button" id="confirmInfo" class="btn btn-primary" value="확인"/>
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</form>
						<div id="newPasswordDiv" style="display: none;">
							<input type="text" id="newPassword" name="newPassword" placeholder="새 비밀번호" />
							<div class="modal-footer">
								<input type="button" id="confirmPw" class="btn btn-primary" onclick="updatepwd()" value="확인"/>
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>




	<script>

const signInBtn = document.getElementById("signIn");
const signUpBtn = document.getElementById("signUp");
const firstForm = document.getElementById("form1");
const secondForm = document.getElementById("form2");
const container = document.querySelector(".container");
var isValidId = 1;
var isValidName = 1;
var isValidEmail = 1;
var isValidphoneNo = 1;
var isValidpwd = 1;
var isfindid = 1;
var isfindemail = 1;


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
	 //로그인 실패해서 창으로 돌아올때
	let isfail = '<c:out value="${loginfail}"/>';
	console.log('isfail :', isfail);
	checkFail(isfail);
	function checkFail(isfail) {
		if (isfail === '') {
				return; 
			}
		if(isfail === "fail"){
			alert("아이디/비밀번호가 틀렸습니다.")
		}   		
   	}
	 //회원가입->로그인창 이동 시 alert창
	 let result = '<c:out value="${result}"/>';
	 console.log('result :', result);
		isSignUp(result);
		function isSignUp(result) {
			if (result === '') { return; }
			if(result === "success"){
				alert("축하합니다! 회원가입이 완료되었습니다.")
			} 
	   	}
	 
	 
		// show.bs.modal : 모달 팝업 시 발생하는 이벤트
		$('#exampleModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget); // 클릭시 눌려진 버튼을 참조하고 싶을때 event.relatedTarget 사용
			var modal = $(this);

		});
		$("#checkId").on("focusout", function() {
    		var id = $("#checkId").val();
    		if(id == '' || id.length == 0) {
    			$("#labelId").show();
    			$("#labelId").css("color", "red").text("Id를 입력해주세요.");
    			isfindid = 0;
    		}else{
    			$("#labelId").hide();
    			isfindid = 1;
    		}
    	});
		$("#checkEmail").on("focusout", function() {
    		var email = $("#checkEmail").val();
    		if(email == '' || email.length == 0) {
    			$("#labelEmail").show();
    			$("#labelEmail").css("color", "red").text("이메일을 입력해주세요.");
    			isfindemail = 0;
    		}else{
    			$("#labelEmail").hide();
    			isfindemail = 1;
    		}
    	});
		//비밀번호 재설정시 id와 email 확인
		$("#confirmInfo").on("click", function() {
    		var id = $("#checkId").val();
    		var email = $("#checkEmail").val();
    		if(isfindid === 0 || isfindemail === 0){
    			alert("올바른 정보를 입력해주세요.");
    		}else{
        	//Ajax로 전송
        	$.ajax({
        		url : './confirmPwd',
        		data : {
        			id : id,
        			email : email
        		},
        		type : 'POST',
        		dataType : 'json',
        		success : function(result) {
        			if (result == true) {
        				$("#newPasswordDiv").show();
        				$("#inputInfo").hide();
        			}else{
        				$("#labelEmail").show();
        				$("#labelEmail").css("color", "red").text("일치하는 정보가 없습니다.");
        			}
        		}
        	}); //End Ajax
    		}
    	});
		//ID 중복 확인
    	//id를 입력할 수 있는 input text 영역을 벗어나면 동작
    	$("#id").on("focusout", function() {
//     		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
//     		var regExpId = /[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    		var reg2 = /[^\w\s가-힣()0-9]/g;
    		//한글 자음 모음만 입력하는 경우도 안되도록 정규식
    		
    		var id = $("#id").val();
    		
    		if(id == null || id.length == 0 || /\s/.test(id)) {
    			$("#label1").css("color", "red").text("공백은 ID로 사용할 수 없습니다.");
    			isValidId=0;
    			return false;
    		}else if (reg2.test(id)){
    			$("#label1").css("color", "red").text("ID에 특수문자를 사용할 수 없습니다.");
    			isValidId=0;
    			return false;
    		}
    		else{
    			//Ajax로 전송
            	$.ajax({
            		url : './ConfirmId',
            		data : {
            			id : id
            		},
            		type : 'POST',
            		dataType : 'json',
            		success : function(result) {
            			if (result == true) {
            				$("#label1").css("color", "black").text("사용 가능한 ID 입니다.");
            				isValidId=1;

            			} else{
            				$("#label1").css("color", "red").text("사용 불가능한 ID 입니다.");
            				isValidId=0;

//             				$("#id").val(''); //입력된 내용 초기화
            			}
            		}
            	}); //End Ajax
    		}
    	});
     	//이름 정규식
    	$("#name").on("focusout", function() {
    		var regExpName = /^[가-힣]*$/;
    		//한글만 가능하도록 
    		var name = $("#name").val();
    		if(regExpName.test(name)){
    			$("#label2").hide();
    			isValidName=1;
    		}else{
    			$("#label2").show();
    			$("#label2").css("color", "red").text("이름은 공백없이 한글로만 작성해주세요.");
    			isValidName=0;
    		}
    	});
    	$("#email").on("focusout", function() {
    		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		//@포함 해야하고 마지막 . 다음에는 2,3개의 문자만 위치해야함
    		var email = $("#email").val();
    		if(regExpEmail.test(email)){
    			$("#label3").hide();
    			isValidEmail=1;
    		}else{
    			$("#label3").show();
    			$("#label3").css("color", "red").text("올바른 이메일 형식으로 작성해주세요.");
    			isValidEmail=0;
    		}
    	});
    	$("#phoneNo").on("focusout", function() {
    		var regExpphoneNo = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
    		//핸드폰번호 (02같은 지역번호 고려X 핸드폰 번호 형식만)
    		var phoneNo = $("#phoneNo").val();
    		if(regExpphoneNo.test(phoneNo)){
    			$("#label4").hide();
    			isValidphoneNo=1;
    		}else{
    			$("#label4").show();
    			$("#label4").css("color", "red").text("올바른 핸드폰 번호를 작성해주세요.");
    			isValidphoneNo=0;
    		}
    	});
    	$("#pwd").on("focusout", function() {
    		var regExppwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/
    		//영문, 숫자, 비밀번호 조합 8자리 이상
    		var pwd = $("#pwd").val();
    		if(regExppwd.test(pwd)){
    			$("#label5").hide();
    			isValidpwd=1;
    		}else{
    			$("#label5").show();
    			$("#label5").css("color", "red").text("영문, 숫자, 특수문자 조합 8자리 이상을 입력해주세요.");
    			isValidpwd=0;
    		}
    	});
     	
     	
     	
    	
		
		
});
 function checkSignUp(){
		console.log("5: "+isValidId);
		var form = document.form1;
		var id= document.getElementById("id").value;
		var name=document.getElementById("name").value;
		var email=document.getElementById("email").value;
		var password=document.getElementById("pwd").value;
		var phoneNo=document.getElementById("phoneNo").value;
		
		var regExpName = /^[가-힣]*$/;
		var regExpPhoneNo = /^\d{3}-\d{4}-\d{4}$/;

		
		
		if(!id||!name||!email||!password||!phoneNo){
			alert("모든 정보를 입력하세요.");
			return false;
		} else if(isValidId === 0){
			alert("ID를 확인해주세요.");
			return false;	
		} else if(isValidName === 0){
			console.log(isValidName);
			alert("이름을 확인해주세요.");
			return false;	
		} else if(isValidEmail === 0){
			alert("이메일 확인해주세요.");
			return false;	
			
		} else if(isValidpwd === 0){
			alert("비밀번호를 확인해주세요.");
			return false;	
		} else if(isValidphoneNo === 0){
			alert("핸드폰번호를 확인해주세요.");
			return false;	
		} 		
		else{
			form.submit();
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
	function setis(){
		console.log(isfindid+"@@"+isfindemail);
		$("#checkId").val("");
		$("#checkEmail").val("");
		$("#newPassword").val("");
		$("#newPasswordDiv").hide();
		$("#inputInfo").show();
		
		isfindid = 0;
		isfindemail = 0;
	}
	function updatepwd(){
		var id = $("#checkId").val();
		var email = $("#checkEmail").val();
		var pwd = $("#newPassword").val();
		
    	$.ajax({
    		url : '/login/updatePwd',
    		data : {
    			id : id,
    			email : email,
    			pwd : pwd
    		},
    		type : 'POST',
    		dataType : 'json',
    		success : function(result) {
    			if (result == true) {
    				alert("비밀번호 변경이 완료 되었습니다.");
    				location.reload();
    			}else{
    				alert("비밀번호 변경이 실패 했습니다.");
    			}
    		}
    	}); //End Ajax
	}
</script>
</body>
</html>