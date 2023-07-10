<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Test</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/f4b2fcf146.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	
	
	//서버에 댓글 리스트 요청
	function getList(){
		
		let bno = document.querySelector("#bno").value;
		
		//url의 요청 결과 받아옴
		fetch('/reply/list/'+bno)
		//요청결과(json형식의 문자열)를 js object형식으로 반환
		.then(response => response.json())
		//반환받은 오브젝트를 이용하여 화면 출력
		.then(list => replyView(list));
	}
	//리스트를 화면에 출력
	function replyView(list){
			//콘솔창에 리스트 출력
			console.log(list);
			

		
		//div초기화(새댓글 등록될 때마다 보여질 수 있게)
		replyDiv.innerHTML = '';
			
		//답글을 DIV에 출력
		//댓글 리스트로부터 댓글을 하나씩 읽어와서 div에 출력
		list.forEach((reply, index)=>{

			replyDiv.innerHTML +=
				'<div class="accordion" id="accordionPanelsStayOpenExample"'+index+'>'
				+	'<div class="accordion-item">'
				+		'<h2 class="accordion-header" id="panelsStayOpen-headingOne">'
				+			'<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">'
				+			reply.reply
				+			'<i class="fa-regular fa-pen-to-square" style="color: #625ff7;"></i><br>'
				+			'<i class="fa-solid fa-delete-left" onclick="replyDelete('+reply.rno+')"></i>'
				+			'</button>'
				+		'</h2>'
				+		'<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">'
				+			'<div class="accordion-body">'
				+			'<strong>'+reply.replyer
				+			'</strong><br>'+reply.replydate
				+			'</div>'
				+		'</div>'
				+	'</div>'
				+'</div>'		
		});
	}
		
		//버튼 생성 후 이벤트 부여
		window.onload = function(){
			//리스트 조회 및 출력
			getList();
			
			btnWrite.addEventListener('click', function(){
				//서버에 전송할 파라미터 수집
				let bno = document.querySelector("#bno").value;
				let reply = document.querySelector("#reply").value;
				let replyer = document.querySelector("#replyer").value;

				//1. 전송할 데이터를 js객체로 생성 (이름 : 값)
				let replyObj = {
						bno : bno
						, reply : reply
						, replyer : replyer
				};
				
				//2. 생성 객체를 json타입으로 변환
				let replyJson =JSON.stringify(replyObj);
				
				console.log("replyObj" + replyObj);
				console.log("replyJson" + replyJson);
				
				//3. 서버에 요청
				fetch("/reply/insert" 
						, {method : 'post'
							, headers :{'Content-Type' : 'application/json'} 
							, body : replyJson})
				
				//4. 응답받아옴
				.then(response => response.json())
				.then(map => replyWrite(map));
			
				
			});
		}
		function replyWrite(map){
			if(map.result == 'success'){
				//등록성공
				//리스트 조회 및 출력
				getList();
			}else{
				//등록실패
				alert(map.message);
			}
		}
		
		function replyDelete(rno){
			//url의 요청 결과 받아옴
			fetch('/reply/delete/'+rno)
			//요청결과(json형식의 문자열)를 js object형식으로 반환
			.then(response => response.json())
			//반환받은 오브젝트를 이용하여 화면 출력
			.then(map => replyWrite(map));
			alert(rno+"번 댓글이 삭제되었습니다.")
		}
		
</script>
</head>
<body>

<h2>무플방지위원회 활동내역</h2><br>
	<input type="text" id="bno" name="bno" value="50">
	
	<div class="input-group mb-3">
		<input type="text" id="replyer">
		<input type="text" id= "reply" class="form-control" placeholder="댓글내용입력하기" aria-label="Recipient's username" aria-describedby="basic-addon2">
		<span class="input-group-text" id="btnWrite">작성</span>
	</div>

	<div id="replyDiv"></div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>