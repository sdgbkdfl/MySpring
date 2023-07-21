<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search Form</title>
</head>
<body>

<form action="/board/list" method="get" name="searchForm">

<input type="hidden" name="bno" value="">
<input type="hidden" name="pageNo" value="${pageDto.cri.pageNo }">
<div class="row g-3 justify-content-center">
	  <div class="col-auto">
		   <select class="form-select" name="searchField" aria-label="Default select example">
			  <option selected>선택</option>
			  <option value="title"  ${(pageDto.cri.searchField eq 'title')? 'selected':''}>제목</option>
			  <option value="content"  ${(pageDto.cri.searchField eq 'content')? 'selected':''} >내용</option>
			  <option value="writer"  ${(pageDto.cri.searchField eq 'writer')? 'selected':''} >작성자</option>
			</select>
	  </div>
	  <div class="col-auto">
	    <label for="searchword" class="visually-hidden">검색어</label>
	    <input type="text" class="form-control" name="searchWord" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord}">
	  </div>
	  <div class="col-auto">
	    <button type="submit" class="btn btn-secondary mb-3 w-100" onclick="go(1)">검색</button>
	  </div>
 </div>
</form>
</body>
</html>