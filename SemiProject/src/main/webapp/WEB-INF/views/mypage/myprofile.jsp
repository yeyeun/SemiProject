<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value='${pageContext.request.contextPath}' />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="${contextPath}/resources/css/mypage/myprofile.css">
</head>
<body>
	<div id="myprofile_container">
		<div class=" p-5 mb-4 bg-body-secondary ">
			<div class="container-fluid py-3">
				<h1 class="display-3" style="font-size: 45px;">개인정보 조회</h1>
				<hr style="height: 4px; opacity: 1;">
			</div>
		</div>
		<div class="container" style="margin-right: 0px">
			<form name="myprofile" action="${contextPath}/mypage/updateprofile">
				<!-- 파일이 있을경우 무조건 post방식 -->

				<div class="row mb-2" style="margin-bottom: 40px !important;">
					<label class="col-sm-2">Name </label>
					<div class="col-sm-5">
						<input type="text" id="name" name="name" class="form-control" value="${member.name}" readonly>
					</div>
				</div>
				<div class="row mb-2" style="margin-bottom: 40px !important;">
					<label class="col-sm-2">ID</label>
					<div class="col-sm-5">
						<input type="text" id="id" name="id" class="form-control" value="${member.id}" readonly>
					</div>
				</div>
				<div class="row mb-2" style="margin-bottom: 40px !important;">
					<label class="col-sm-2">PassWord</label>
					<div class="col-sm-5">
						<input type="text" id="pwd" name="pwd" class="form-control" value="${member.pwd}">
					</div>
				</div>
				<div class="row mb-2" style="margin-bottom: 40px !important;">
					<label class="col-sm-2">Phone</label>
					<div class="col-sm-5">
						<input type="text" id="phoneNo" name="phoneNo" class="form-control" value="${member.phoneNo}">
					</div>
				</div>
				<div class="row mb-2" style="margin-bottom: 40px !important;">
					<label class="col-sm-2">Email</label>
					<div class="col-sm-5">
						<input type="text" id="email" name="email" class="form-control" value="${member.email}">
					</div>
				</div>
				<input type="button" class="btn btn-primary" value="저장" onclick="checkAddProduct()" style="margin-left: 120px;">
			</form>
		</div>
	</div>

	<script>
		function handleResponse(){
			 alert("변경되었습니다");
		}
		function checkAddProduct() {
			//다음의 네 가지 input에 대해 id 부여할 것
			// 			var id = document.getElementById("id");
			// 			var unitPrice = document.getElementById("unitPrice");
			// 			var noOfStock = document.getElementById("noOfStock");
			// 			// 상품아이디 체크
			// 			if (!check(/^P[0-9]{4,11}$/, id,
			// 					"[상품 코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요"))
			// 				return false;
			// 			// 상품 가격 체크
			// 			if (unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
			// 				alert("[가격]\n숫자만 입력하세요");
			// 				unitPrice.select();
			// 				unitPrice.focus();
			// 				return false;
			// 			}
			// 			if (unitPrice.value < 0) {
			// 				alert("[가격]\n음수를 입력할 수 없습니다");
			// 				unitPrice.select();
			// 				unitPrice.focus();
			// 				return false;
			// 			}
			// 			// 재고 수 체크
			// 			if (isNaN(noOfStock.value)) {
			// 				alert("[재고 수]\n숫자만 입력하세요");
			// 				noOfStock.select();
			// 				noOfStock.focus();
			// 				return false;
			// 			}
			document.myprofile.submit();
			handleResponse();

		}
		// 		function check(regExp, e, msg) {
		// 			if (regExp.test(e.value)) {
		// 				return true;
		// 			}
		// 			alert(msg);
		// 			e.select();
		// 			e.focus();
		// 			return false;
		// 		} // 정규식 검사하는 함수
	</script>
</body>
</html>