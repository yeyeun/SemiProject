<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<c:set value="${pageContext.request.contextPath}" var="contextPath" />
<link href="${resourceurl}/css/board/common.css" rel="stylesheet">
<link href="${resourceurl}/css/board/read.css" rel="stylesheet">
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp"/>
<div class="board-wrapper">
	<table class="table-top">
		<tr>
			<td>
				<h2>상세보기</h2>
			</td>
		</tr>
	</table>
	<form>
		<table class="table-middle">
			<tr>
				<td class="middle-menu">번호</td><td>${board.bno}</td><td class="middle-menu">작성자</td><td>${board.writer}</td>
			</tr>
			<tr>
				<td>작성일</td><td>${board.regDate}</td><td>조회수</td><td>${board.hit}</td>
			</tr>
			<tr>
				<td>제목</td><td colspan="3"><span style="font-weight:bold">[${board.btype}]</span>&nbsp;${board.title}</td>
			</tr>
			<tr>
				<td>내용</td><td colspan="3" height="200">${board.content}</td>
			</tr>
		</table>
		<table class="table-bottom">
			<tr>
				<td class="bottom-button">
					<button data-oper='modify' type="button" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">수정하기</button>
					<button data-oper='delete' type="button" onclick="location.href='/board/deleteProc?bno=<c:out value="${board.bno}"/>'">삭제하기</button>
					<button type="button" onclick="location.href='/board/list'">목록 보기</button>
				
				<!-- 로그인 세션 여부에 따라 보이는 버튼 다르게 하기 -->
<%-- 				<c:choose>
					<c:when test="${sessionScope.loginId == board.writer }">
						<button type="button" onclick="location.href='${contextPath}/board/modify.jsp?bno=${board.bno}';">수정하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/deleteProc.jsp?bno=${board.bno}';">삭제하기</button>
						<button type="button" onclick="location.href='${contextPath}/board/board.jsp';">목록 보기</button>
					</c:when>
					<c:otherwise>
						<button type="button" onclick="location.href='${contextPath}/board/board.jsp';">목록 보기</button>
					</c:otherwise>
				</c:choose> --%>
				</td>
			</tr>
		</table>
	</form>
	<div class="comment-wrapper" style="width:100%; margin-top:15px;">
		<div class="comment-header">
		<p>COMMENT<p>
		<input type="text" id="content"/>
		<button type="button" id="registerBtn">댓글 달기</button>
		</div>
		<ul class="comment">
		
		
<!-- 			<li class="list-group-item" data-rno="12">
				<strong class="primary-font">user00</strong>
				<small>2023-06-18 13:13</small>
				<p>Good job</p>
			</li> -->
			
			
		</ul>
	</div>
</div>

<script>
$(document).ready(function(){
	let bnoValue = '<c:out value="${board.bno}"/>';
	
	/* ======댓글 함수 호출========= */
	
	//현재 게시글에 댓글 추가(테스트용)
/* 	add({content:"JS TEST", id:"js tester", bno:bnoValue}, //댓글 데이터
			function(result) {alert("RESULT : " + result)}); */
	
	//댓글 목록 가져오기
/* 	getList({
		bno: bnoValue,
		page : 1
		}, function(list){
			list.forEach(function(item){
				console.log(item);
		});	
	}); */
			
	//댓글 삭제
/* 	remove(
		4,
		function(count){
			console.log(count);
			if(count==="success"){
				alert("REMOVED");
			}
		},
		function(err){
			alert('error occurred....');
		}); */
	
	//댓글 수정
/* 	update({
		commentid:7,
		bno:bnoValue,
		content:"modified reply..."
	},
	function(result){alert("수정 완료");
	}); */
	
	//특정 댓글 조회
	/* get(9,function(data){console.log(data);}); */
			
			
	/* ======댓글 함수 정의========== */
	
	//댓글 추가 함수
	function add(comment, callback, error){
		console.log("reply....");
		$.ajax({
			type:'post',
			url:'/comments/new',
			data:JSON.stringify(comment),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){ callback(result); }
			},
			error:function(xhr,status,er){
				if(error) { error(er); }
			}
		});
	}
	
	//댓글 목록 불러오는 함수
	function getList(param, callback, error){
		var bno = param.bno;
		var page = param.page||1;
		$.getJSON("/comments/pages/"+bno+"/"+page+".json",
			function(data){
			 if(callback) {callback(data);}
		}).fail(function(xhr,status,err){
			if(error) {error();}
		});
	}
	
	//댓글 삭제
	function remove(commentid,callback,error){
		$.ajax({
			type:'delete',
			url:'/comments/' + commentid,
			success:function(deleteResult, status, xhr){
				if(callback) { callback(deleteResult);}
			},
			error:function(xhr,status,er){
				if(error) { error(er); }
			}
		});
	}
	
	//댓글 수정
	function update(comment, callback, error){
		$.ajax({
			type:'put',
			url:'/comments/' + comment.commentid,
			data:JSON.stringify(comment),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){ callback(result); }
			},
			error:function(xhr,status,er){
				if(error) { error(er); }
			}
		});
	}
	
	//특정 댓글 조회
	function get(commentid, callback, error){
		$.get("/comments/"+commentid+".json",function(result){
			if(callback) { callback(result); }
		}).fail(function(xhr,status,err){
			if(error) { error(); }
		});
	}
	
	//댓글 목록 처리
	let replyUL = $(".comment");
	showList(1);
	function showList(page){
		getList(
			{bno:bnoValue, page:page||1},
			function(list){
				let str="";
				if(list == null || list.length==0){
					replyUL.html("<p>등록된 댓글이 없습니다</p>");
					return;
				}
				list.forEach(function(item){
					str+=`
					<li class="list-group-item" data-commentid="\${item.commentid}">
						<strong class="primary-font">\${item.id}</strong>
						<small>\${displayTime(item.regDate)}</small>
						<p>\${item.content}</p>
					</li>
					`;
				}); //forEach
				replyUL.html(str);
			}); //getList
	} //showList
	
	//시간 처리
	function displayTime(timeValue){
		let today = new Date();
		let gap = today.getTime()-timeValue;
		let dateObj = new Date(timeValue);
		if(gap<(1000*60*60*24)){
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			return [(hh>9?'':'0')+hh, ':', (mi>9?'':'0')+mi, ':', (ss>9?'':'0')+ss].join('');		
		}else{
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth()+1;
			let dd = dateObj.getDate();
			return [yy, '/', (mm>9?'':'0')+mm, '/', (dd>9?'':'0')+dd].join('');
		}
	}
	

	let loginId = '<%=(String)session.getAttribute("loginId")%>';
	
	//새로운 댓글 처리
	$("#registerBtn").on("click",function(e){
		if(loginId=="null"){
			alert("로그인 후 사용해주세요");
			return;
		}
/* 		console.log("content값============"+document.getElementById('content').value);
		console.log("loginId값============"+loginId); */
 		var comment={
			content:document.getElementById('content').value,
			id:loginId,
			bno:bnoValue
		};
		add(comment,function(result){
			alert("댓글이 등록되었습니다");
			document.getElementById('content').innerText = ""; //댓글 등록이 되면, 텍스트 내용을 지움
			showList(1);
		});
	});

});
</script>
</body>
</html>
