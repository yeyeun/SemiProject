<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read</title>
<c:set value="${pageContext.request.contextPath}/resources" var="resourceurl" scope="application"/>
<c:set value="${pageContext.request.contextPath}" var="contextPath" />
<script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
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
				<td>작성일</td><td><fmt:formatDate pattern="yyyy/MM/dd hh:mm" value="${board.regDate}"/></td><td>조회수</td><td>${board.hit}</td>
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
				<!-- 로그인 세션 여부에 따라 보이는 버튼 다르게 하기 -->
 				<c:choose>
					<c:when test="${sessionScope.loginId == board.writer }">
						<button data-oper='modify' type="button" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">수정하기</button>
						<button data-oper='remove' type="button" onclick="location.href='/board/remove?bno=<c:out value="${board.bno}"/>'">삭제하기</button>
						<button type="button" onclick="location.href='/board/list'">목록 보기</button>
					</c:when>
					<c:otherwise>
						<button type="button" onclick="location.href='/board/list'">목록 보기</button>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</table>
	</form>
	<div class="comment-wrapper" style="width:100%; margin-top:15px;">
		<div class="comment">
		<div class="container bootstrap snippets bootdey">
    <div class="row">
		<div class="col-md-12">
		    <div class="blog-comment">
				<h4>Comments</h4>
				<div class="comment-header">
				<input type="text" id="content"/>
				<button type="button" id="registerBtn">댓글 등록</button>
                <hr/>
                </div>
				<ul class="comments">
				
				
				
<%-- 				<li class="clearfix">
				  <img src="${resourceurl}/images/user-icon.png" class="avatar" alt="">
				  <div class="post-comments">
				      <p class="meta"><a href="#">유저아이디</a>2024-04-16<i class="pull-right">
				      <a href="#"><small>수정하기</small></a><a href="#"><small>삭제하기</small></a></i></p>
				      <p>
				      안녕하세요 댓글예제
				      </p>
				  </div>
				</li> --%>
				
				
				
				</ul>
			</div>
		</div>
	</div>
</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	let bnoValue = '<c:out value="${board.bno}"/>';
	let sessionid = '<%=(String)session.getAttribute("loginId")%>';

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
	let replyUL = $(".comments");
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
					if(sessionid == item.id){
					str+=`

					<li class="clearfix" data-commentid="\${item.commentid}">
					  <img src="${resourceurl}/images/user-icon.png" class="avatar" alt="">
					  <div class="post-comments">
				     	 <div class="comment-button">
				      		<button type="button" id="modifyBtn">수정하기</button>
				      		<button type="button" id="removeBtn">삭제하기</button>
				      	</div>

					      <p class="meta"><span class="id">\${item.id}</span>\${displayTime(item.regDate)}</p>
					      <p id="comment-content">
					      \${item.content}
					      </p>
					      <p id="modifycomment"><input type="hidden" value="\${item.content}"></p>
					  </div>
					</li>

					`;
						
					}
					else{
					str+=`
					<li class="clearfix" data-commentid="\${item.commentid}">
						<img src="${resourceurl}/images/user-icon.png" class="avatar" alt="">
						<div class="post-comments">
							 <p class="meta"><span class="id">\${item.id}</span>\${displayTime(item.regDate)}</p>
							 <p id="comment-content">
							    \${item.content}
							 </p>
							 <p id="modifycomment"><input type="hidden" value="\${item.content}"></p>
						</div>
					</li>
					`;	
						
					}

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
	
	let modifyBtn = $("#modifyBtn");
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
			$('#content').val(""); //댓글 등록이 되면, 텍스트 내용을 지움
			showList(1);
		});
	});
	
	//댓글 수정버튼 클릭시 input 활성화
	$(document).on("click","#modifyBtn",function(){
		$(this).attr('hidden',true);
		$(this).next().attr('hidden',true);
		$(this).parent().append('<button type="button" id="updateBtn" style="margin:0; background:#FF8383">수정완료</button>');
		$(this).parent().next().next().attr('hidden',true); //댓글 감추기
		$(this).parent().next().next().next().children().prop("type","text"); //input type 변경
	});
	
	//특정 댓글 수정
	$(document).on("click","#updateBtn",function(){
		var idData = document.querySelector(".clearfix"); //.clearfix의 data 속성 가져오기
		var commentid = idData.dataset.commentid; //해당 댓글의 id값 가져오기
		var modifycomment = $(this).parent().next().next().next().children();
		//console.log("댓글id값====="+commentid);
		//console.log("수정내용======"+modifycomment);
  		var comment = {commentid:commentid, content:modifycomment.val()};
		update(comment,function(result){
			alert("수정되었습니다");
			showList(1);
		});
	});
	
	//특정 댓글 삭제
	$(document).on("click","#removeBtn",function(){
		var idData = document.querySelector(".clearfix"); //.clearfix의 data 속성 가져오기
		var commentid = idData.dataset.commentid;
		remove(commentid,function(result){
			alert("삭제되었습니다");
			showList(1);
		});
	});

});


</script>
</body>
</html>
