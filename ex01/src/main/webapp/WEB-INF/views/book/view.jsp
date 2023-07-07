<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    


<%@include file="./header.jsp" %>
	<!-- 게시판 -->
	<div id="page-wrapper">
	<div class="row">
		<p></p>
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    ${book.title }
                </div>
                <div class="panel-body">
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt est vitae ultrices accumsan. Aliquam ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
                </div>
                <div class="panel-footer">
                    ${book.author }
                </div>
            </div>
        </div>
	</div>    
	</div>
	<!-- 게시판 끝-->
	
<%@include file="./footer.jsp" %>