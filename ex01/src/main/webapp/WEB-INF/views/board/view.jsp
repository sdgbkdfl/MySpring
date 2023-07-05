<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Fixed top navbar example · Bootstrap v5.2</title>
    
<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-fixed/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link href ="resource/css/listStyle.css" rel="stylesheet">

</head>
<body>

 <%@include file="../common/header.jsp" %>  
<h2>게시판 상세화면</h2>
<script type="text/javascript">

	function requestAction(url){
		viewForm.action=url;
		viewForm.submit();
	}
</script>

<main class="container">
	<div class="bg-light p-5 rounded">
		<h2>상세보기</h2>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기.</p>
	    <a class="btn btn-lg btn-primary" href="/board/list/" role="button">리스트 &raquo;</a>
	  </div>
	    <p></p>
  <!-- 상세보기 -->
	<div class="list-group w-auto">   
		<form method="get" name="viewForm">
		<input type="text" name="bno" value="${board.bno }">
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
			<div class="d-grid gap-2 d-md-flex justify-content-md-center">
				<button type="submit" class="btn btn-primary btn-lg" onclick="requestAction('/board/edit')">수정</button>
				<button type="submit" class="btn btn-secondary btn-lg" onclick="requestAction('/board/delete')">삭제</button>
			</div>
		</form>
	</div>
</main>
	
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	

</body>
</html>