<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>

	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    
<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-fixed/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<script src="https://kit.fontawesome.com/f4b2fcf146.js" crossorigin="anonymous"></script>

<!-- CSS -->
<link href ="/resources/css/listStyle.css" rel="stylesheet">
<!-- JS -->
<script src="/resources/js/reply.js"></script>

</head>
<body>

 <%@include file="common/header.jsp" %>  
 
<script type="text/javascript">

	//버튼에 이벤트
window.addEventListener('load', function(){
	
	// 로그인한 아이디와 게시글의 작성자가 일치하면
	// 수정, 삭제 버튼에 이벤트 적용
	if(${userId eq board.writer}){
		// 수정 버튼 클릭시 action 발생 - 수정페이지 이동
		btnEdit.addEventListener('click', function(){
			viewForm.action='/board/edit';
			viewForm.submit();
		});
		
		// 삭제 처리 후 리스트 페이지로 이동
		btnDelete.addEventListener('click', function(){
			viewForm.action='/board/delete';
			viewForm.submit();
		});
	}
	// 리스트 페이지 이동
	btnlist.addEventListener('click', function(){
		viewForm.action='/board/list';
		viewForm.submit();
	});
	// 댓글 등록 버튼 
	btnReplyWrite.addEventListener('click', function(){
		replyWrite();
	});
	// 파일목록 조회 및 출력
	getFileList();
	
	// 댓글 목록 조회 및 출력
	getReplyList();
	
}); 
<!--
function requestAction(url){
	viewForm.action=url;
	viewForm.submit();
}
-->

// 파일 목록을 가져옴
function getFileList(){
	///file/list/{bno}
	//id가 bno
	let bno = document.querySelector("#bno").value;
	fetch('/file/list/'+bno)
		.then(response=> response.json())
		.then(map=> viewFileList(map));
}

// 파일 리스트를 화면상에 보여줌
function viewFileList(map){
	console.log(map);
	let content = '';
	
	// encodeURIComponent : 깨지지않고 url 전송
	if(map.list.length > 0){                                              
		content += '<div class="mb-3">                                     			'                                                                
				+'  <label for="filelist" class="form-label">첨부파일 목록</label'>		'
				+'  <div class="form-control" id="attachFile">                 		'
				
				
		map.list.forEach(function(item, index){							
			let savePath = encodeURIComponent(item.savePath)				
		content +=' <a href ="/file/download?fileName="'+savePath+'">				'
				+	item.fileName + '</a>											'
				+' <br>																';
	})                                           									
		content +=' </div>															'
				+'  </div>															';		

	}else{
		content = '등록된 파일이 없습니다.'
	}
	divFileupload.innerHTML = content;		
}
</script>

<main class="container">
	<div class="bg-light p-5 rounded">
		<h2>상세보기</h2>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기✨ </p>
	    <a class="btn btn-lg btn-secondary" 
	    href="#" id="btnlist" role="button">리스트 &raquo;</a> 
	    <!-- href에 #입력해야 나중에 이벤트 발생안함 -->
	 </div>
	 <p></p>
	    
	 <!-- 상세보기 -->
	<div class="list-group w-auto">   
		<form method="get" name="viewForm">
		
		<!-- 파라메터 
		검색할 때 필요한 값들 링크에 달고 다니지 말고 필드로 설정해주는 것이 더 유용
		pageNo=${param.pageNo}
		&searchField=${param.searchField}
		&searchWord=${param.searchWord}
		 -->
		<input type="text" name="pageNo" value="${param.pageNo}">
		<input type="text" name="searchField" value="${param.searchField}">
		<input type="text" name="searchWord" value="${param.searchWord}">	
		<input type="hidden" name="bno" id="bno" value="${board.bno}">
		
			<div class="mb-3">
			  <label for="title" class="form-label">제목</label>
			  <input type="text" name="title" id="title" readonly class="form-control" value="${board.title}"  placeholder="제목을 작성해주세요">
			</div>
			<div class="mb-3">
			  <label for="cotent" class="form-label">내용</label>
			  <textarea class="form-control" id="content" readonly name="content" rows="3">${board.content}</textarea>
			</div>
			<div class="mb-3">
			  <label for="writer" class="form-label">작성자</label>
			  <input type="text" name="writer" id="writer" class="form-control" value="${board.writer}">
			</div>
			<!-- 첨부파일 -->
			<div id="divFileupload"></div>

				<div class="d-grid gap-2 d-md-flex justify-content-md-center">
				
	
			<!-- 수정하기 -->
			<!-- bno가 빈문자열이 아닐 때 수정하기-->
			<c:if test="${not empty board.bno}" var="res">
				<input type="text" name="bno" value="${board.bno}">
				<button type="submit" class="btn btn-secondary btn-lg" onclick="requestAction('/board/editAction')">수정하기</button>
			</c:if>
			
			<!-- bno값 없으면 등록하기-->
			<c:if test="${not res}">
				<button type="submit" class="btn btn-secondary btn-lg">제출</button>			
			</c:if>
				<button type="reset" class="btn btn-primary btn-lg">초기화</button>
			</div>
			
			<div class="d-grid gap-2 d-md-flex justify-content-md-center">
				<button type="button" class="btn btn-secondary btn-lg" id="btnEdit">수정</button>
				<button type="button" class="btn btn-primary btn-lg" id="btnDelete">삭제</button>
			</div>
		</form>
		
	</div>

	<p></p>
	<p></p>
	<div class="input-group">
	<span class="input-group-text">작성자 </span>
	<input type="text" id="replyer" value="${userId}">
	  <span class="input-group-text">댓글 작성 </span>
	  <input type="text" aria-label="First name" class="form-control" id="reply">
	  <input type="button" aria-label="Last name" id="btnReplyWrite" class="input-group-text" value="등록하기">
	</div>
		
	<!-- 댓글리스트 -->
<div id="replyDiv"></div>


</main>
	
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	
</body>
</html>