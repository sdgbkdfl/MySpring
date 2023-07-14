<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#loginId{
	 			text-align: right;
	 			color: yellow;
	 			padding: 2em;
	}
</style>
</head>
<script type="text/javascript">
		//메세지 처리
		let msg = '${msg}';
		
		/* 스크립트로 알림 주면 통일성 떨어짐
		if( msg != ''){
			alert(msg);
		}
		*/
		window.onload = function(){
			if(msg != ""){
				//메세지 출력
				document.querySelector(".modal-body").innerHTML = msg;
				//버튼 출력 제어
				document.querySelector("#save").style.display='none'
				
				//모달 생성
				const myModal = new bootstrap.Modal(document.getElementById('myModal'), {
			  		keyboard: false
			});
				//모달 보여주기
				myModal.show();
		}
			
			//myModal요소 선택 - 왜 지우는거지?
			const myModalEl = document.getElementById('myModal')


			// 회원가입폼 출력 - 실행 안됨
			btnSignupView.addEventListener('click', function(){
			signupForm.style.display=''; // 회원가입 버튼 클릭시 로그인 창 비활성화
			signinForm.style.display='none';
		})

		}		
</script>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="../board/list.book"> 게시판 구현하기😆 </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
         <!-- active : css에서 활성화된 요소 나타냄 -->
          <a class="nav-link active" aria-current="page" href="#">🏠 HOME</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link active" href="../board/login" id="btnSignupView">☁️ Sign Up</a>
        </li>
      	<!-- userId 변수가 비어있는지 확인 -->
		<c:if test="${empty userId}" var="res">
			<li class="nav-item">
				<a class="nav-link active" href="../board/login">💗 Login</a>
			</li>
		</c:if>
		<c:if test="${not res}">
			<li class="nav-item">
				<a class="nav-link" href="../logout" style="color: white;">✨ Logout</a>
			</li>
		</c:if>
      </ul>
    <c:if test="${not empty userId}" var="res">	
        <a class="nav-link" id="loginId" href="#" >${userId} 님이 로그인하셨습니다.</a>
    </c:if>
 		
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">💥 알림💥 </h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	       msg
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
	        <button type="button" id="save" class="btn btn-primary">저장</button>
	      </div>
	    </div>
	  </div>
	</div>      

</body>
</html>