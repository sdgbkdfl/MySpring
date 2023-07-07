<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

		}		
</script>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"> localhost:8080/board/list.book</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">🏠</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">회원가입</a>
        </li>
      </ul>
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
	        <h1 class="modal-title fs-5" id="exampleModalLabel">알림❗❗</h1>
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