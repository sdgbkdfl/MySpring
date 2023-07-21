<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>

	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">



	<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-fixed/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link href="/resources/css/listStyle.css" rel="stylesheet">
	<!-- link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet"> -->

<script type="text/javascript">

	//폼 이름 확인
	function requestAction(url){
		viewForm.action=url;
		viewForm.submit();
	}
	
	// 게시물 수정 후에도 검색어 유지
	window.addEventListener('load', function(){
		btnList.addEventListener('click', function(){
			viewForm.action ="/board/list";
			viewForm.method = get();
			viewForm.submit();
		});
		// 파일목록 조회 및 출력
		getFileList();
	})
	function getFileList(){
	///file/list/{bno}
	let bno = '${board.bno}';
	if(bno){
		fetch('/file/list/'+bno)
			.then(response => response.json())
			.then(map => viewFileList(map));
	}
}
	function viewFileList(map){
		console.log(map);
		let content = '';
		if(map.list.length > 0){
			content += '<div class="mb-3">        				   '	                                     '
					+'  <label for="attachFile" class="form-label">'
					+'		첨부파일 목록</label> 					   '
					+'  <div class="form-control" id="attachFile"> ';			
			
			
			map.list.forEach(function(item, index){
			let savePath = encodeURIComponent(item.savePath);
			content += "<a href='/file/download?fileName=" 
				    + savePath+"'>"
					+ item.filename + '</a>'
					+ ' <i onclick="attachFileDelete(this)" '
					+ '   data-bno="'+item.bno+'" data-uuid="'+item.uuid+'" '
					+ '   class="fa-regular fa-square-minus"></i>'
					+ '	<br>';
			})
			content +='  </div>                      		 '
					+'	 </div>                              ';				
			
		} else {
			content = '등록된 파일이 없습니다.';
		}
		divFileupload.innerHTML = content;
	}	
	function attachFileDelete(e){
		let bno = e.dataset.bno;
		let uuid = e.dataset.uuid;
		// 값이 유효하지 않은 경우 메세지 처리
		// fetch 요청
		//fetch('/file/delete/'+uuid+'/'+bno)
		// el 표현식 -> \${ } (el 표현식으로 처리 하지 않음)
		fetch(`/file/delete/\${uuid}/\${bno}`)
			.then(response => response.json())
			.then(map => fileDeleteRes(map));
	}
	
	// 삭제 결과 처리
	function fileDeleteRes(map){
		if(map.result == 'success'){
			console.log(map.msg);
			// 리스트 조회
			getFileList();
		} else {
			alert(map.msg);
		}
	}
	
	
</script>

</head>
<body>
 <%@include file="../common/header.jsp" %>   
	<main class="container">
	  <div class="bg-light p-5 rounded">
		<h2>게시판 글쓰기</h2>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기✨</p>
	    <a class="btn btn-lg btn-primary" href="/board/list" role="button">리스트 &raquo;</a>
	  </div>
	 <p></p>

	<!-- 글쓰기 -->
	<div class="list-group w-auto">
	<form method="post" enctype="multipart/form-data" action="/board/write" name="viewForm">
	
    <!-- 페이지, 검색 유지 -->
	<c:if test="${not empty param.pageNo}">
	    <input type="text" name="pageNo" value="${param.pageNo}">
	</c:if>
	<c:if test="${empty param.pageNo}">
	    <input type="text" name="pageNo" value="1">
	</c:if>        
    <input type="text" name="searchField" value="${param.searchField }">
    <input type="text" name="searchWord" value="${param.searchWord }">
	
	
		<div class="mb-3">
		  <label for="title" class="form-label">제목</label>
		  <input type="text" name="title" id="title" class="form-control" value="${board.title}" >
		</div>
		<div class="mb-3">
		  <label for="cotent" class="form-label">내용</label>
		  <textarea class="form-control" id="content" name="content" rows="3">${board.content}</textarea>
		</div>
		<div class="mb-3">
		  <label for="writer" class="form-label">작성자</label>
		  
		  <!-- 작성화면일때 -->
		  <c:if test="${empty board.writer}">
			  <input type="text" class="form-control" id="writer" name="writer" 
			  			readonly="readonly" value="${userId}">
		  </c:if>
		  <!-- 수정화면일때 -->
	  	  <c:if test="${not empty board.writer}">
			  <input type="text" class="form-control" id="writer" name="writer" 
			  			readonly="readonly" value="${board.writer}">
		  </c:if>
		 <!-- 첨부파일 -->
		<%@include file="../file/fileupload.jsp" %>  
		  
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-center">
			<!-- bno가 빈문자열이 아닐 때 수정하기-->
			<c:if test="${not empty board.bno}" var="res">
				<input type="text" name="bno" value="${board.bno}">
				<button type="submit" class="btn btn-secondary btn-lg" onclick="requestAction('/board/editAction')">수정하기</button>
			</c:if>
			
			<!-- bno값 없으면 등록하기-->
			<c:if test="${not res}">
				<button type="submit" class="btn btn-secondary btn-lg">글쓰기</button>			
			</c:if>
				<button type="reset" class="btn btn-primary btn-lg">초기화</button>
		</div>
	</form>
	</div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>