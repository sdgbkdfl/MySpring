<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@include file="./header.jsp" %>

<html lang="ko">


 <!-- 게시판 -->
 <div id="page-wrapper">
 ${pageDto}<br>
 ${totalCnt}
     <div class="row">
         <div class="col-lg-12">
	            <!-- 검색폼 -->
	           <%@include file="searchForm.jsp" %>
             <h1 class="page-header"></h1>
         </div>
         <!-- /.col-lg-12 -->
     </div>
     <!-- /.row -->
     <div class="row">
         <div class="col-lg-12">
             <div class="panel panel-default">
                 <div class="panel-heading">
                     	<h4>도서리스트</h4>
                 </div>
            
          
                 <!-- /.panel-heading -->
                 <div class="panel-body">
		<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
           <thead>
               <tr align="center">
                   <th>✔️</th>
                   <th>번호</th>
                   <th>도서명</th>
                   <th>저자</th>
                   <th>대여여부</th>
               </tr>
           </thead>
           <tbody>
	       <c:forEach items="${list}" var="book">	
	               <tr class="odd gradeX" >
	              	 <td><input type="checkbox"></td>
	                   <td>${book.no}</td>
	                   <td>${book.title}</td>
	                   <td>${book.author}</td>
	                   <td class="center">${book.rentStr}</td>
	               </tr>
	       </c:forEach>
           </tbody>
		</table>
                   <%@include file="../book/pageNav.jsp" %>
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>   
</div>
  <!-- 게시판 끝-->
  <!-- /#page-wrapper -->

<%@include file="./footer.jsp" %>