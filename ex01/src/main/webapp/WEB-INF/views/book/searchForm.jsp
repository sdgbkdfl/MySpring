<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <form name="searchForm" action="/book/booklist">
      <input type="text" name="pageNo" value="1">
      <div class="form-inline text-center"> 
      <p></p>
    <div class="form-group">
        <select class="form-control" name='searchField'>
            <option value='title'>제목</option>
            <option value='author'>작가</option>
        </select>
    </div>
    <div class="form-group">
        <input class="form-control" name='searchWord'>
    </div>
    <button type="submit" class="btn btn-default">검색</button>
	</div>
      </form>