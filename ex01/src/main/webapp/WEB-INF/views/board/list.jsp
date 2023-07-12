<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!doctype html>
<html lang="ko">
<head>

	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>게시판 만들기  Bootstrap v5.2</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/navbar-fixed/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href ="/resources/css/listStyle.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <%--link href="navbar-top-fixed.css" rel="stylesheet"--%>
<script type="text/javascript">

	//폼 이름 확인
	function requestAction(url,bno){
		
		searchForm.action=url;
		searchForm.bno.value=bno;
		searchForm.submit();
	}
</script>
</head>
<body>
  
 <%@include file="../common/header.jsp" %>  

  
	<main class="container">
	  <div class="bg-light p-5 rounded">
	  	<br>
	    <h3>게시판</h3>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기✨</p>
	    <a class="btn btn-lg btn-primary" href="/board/write/" role="button">글쓰기 &raquo;</a>
	  </div>
	    <p></p>
	    <%@include file="../common/searchForm.jsp" %>
		<!-- 리스트 출력 -->
		<div class="list-group w-auto">
		
		  <c:forEach items="${list}" var="vo">
		  <a onclick="requestAction('/board/view',${vo.bno })" href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
		    <img src="https://github.com/twbs.png" alt="twbs" width="32" height="32" class="rounded-circle flex-shrink-0">
		    <div class="d-flex gap-2 w-100 justify-content-between">
		      <div>
		        <h6 class="mb-0">${vo.title}</h6>
		        <p class="mb-0 opacity-75">${vo.writer}</p>
		      </div>
		      <small class="opacity-50 text-nowrap">${vo.regdate}</small>
		    </div>
		  </a>
		  </c:forEach>
		</div>
		<div><%@include file="../common/pageNav.jsp" %></div>
		
	</main>
  
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  
  

  </body>
</html>
    