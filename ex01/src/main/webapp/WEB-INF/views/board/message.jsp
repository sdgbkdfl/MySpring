<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩을 사용하기 위해 css js 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script type="text/javascript">
	/*
	부트스트랩을 이용한 모달창 띄우기
	
	1. css, js 파일 추가하기
	2. 모달 요소 복사 - 타이틀 및 메세지 수정
	3. 모달창 열기 - 자스 이용해서 모달 객체 생성 후 show()메서드 호출
	4. 모달창 닫기 (닫기 버튼, 배경 클릭)
	 	- 자스 이용하여 닫는 이벤트(hidden.bs/modal) 발생 시 뒤로가기
	*/
		//메세지 처리
		let msg = '${msg}';
		/*
		if(msg != ''){
			alert(msg);
			history.go(-1);
		}*/
	window.onload = function(){
		if(msg != ""){
			document.querySelector(".modal-body").innerHTML = msg;
			
			const myModal = new bootstrap.Modal(document.getElementById('myModal'), {
		  		keyboard: false
		});
			myModal.show();
	}
		
		//myModal요소 선택
		const myModalEl = document.getElementById('myModal')
		
		//이벤트 등록
		myModalEl.addEventListener('hidden.bs.modal', event=> {
			history.go(-1);
		});
	}
</script>
</head>
<body>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">알림❗❗</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	       ㅋㅋ
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary">저장</button>
	      </div>
	    </div>
	  </div>
	</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>