<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>댓글리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/f4b2fcf146.js" crossorigin="anonymous"></script>
<script type="text/javascript">

		// 버튼 생성 후 이벤트 부여
		window.onload = function(){
			// 리스트 조회 및 출력
			getList();
			
			// btnWrite : '작성' 버튼의 id값
			btnWrite.addEventListener('click', function(){
				// 1.서버에 전송할 파라미터 수집
				let bno = document.querySelector("#bno").value;
				let reply = document.querySelector("#reply").value;
				let replyer = document.querySelector("#replyer").value;

				// 2.전송할 데이터를 js객체로 생성 (이름 : 값)
				let replyObj = {
						bno : bno
						, reply : reply
						, replyer : replyer
				};
				
				// 3.생성 객체를 json타입으로 변환
				let replyJson =JSON.stringify(replyObj);
				
				console.log("replyObj" + replyObj);
				console.log("replyJson" + replyJson);
				
				// 4. 서버에 요청
				fetch("/reply/insert" 
						, {method : 'post'
							, headers :{'Content-Type' : 'application/json'} 
							, body : replyJson})
				
				// 5.응답받아옴
				.then(response => response.json())
				.then(map => replyWrite(map));	
			});
		}
	
	
	// 서버에 댓글 리스트 요청
	function getList(){
		
		let bno = document.querySelector("#bno").value;
		let page = document.querySelector("#page").value;

		
		// url의 요청 결과 받아옴
		fetch('/reply/list/'+bno+'/'+page)
		// 요청결과(json형식의 문자열)를 js object형식으로 반환
		.then(response => response.json())
		// 반환받은 오브젝트를 이용하여 화면 출력 함수 호출
		.then(map => replyView(map));
	}
	
	
	// 페이지 번호를 클릭했을 때 호출되어 페이지 번호를 설정하고,
	// getList() 함수를 호출(해당 페이지 목록 호출)
	function getPage(page){ // page 번호를 인자로 받음
		// 페이지 번호를 선택한 페이지 번호 필드(#page) 값으로 설정
		document.querySelector("#page").value = page;
		// 페이지 번호에 해당하는 목록 가져옴
		getList();
	}
	
	// 리스트를 화면에 출력
	function replyView(map){
		
		let list = map.list;
		let pageDto = map.pageDto;

		
		// 콘솔창에 리스트 출력
		console.log(list);
		console.log(pageDto);
					
		// div초기화(새댓글 등록될 때마다 보여질 수 있게)
		replyDiv.innerHTML = '';
			
		// 댓글 리스트로부터 댓글을 하나씩 읽어와서 div에 출력
		list.forEach((reply, index)=>{

			// 답글을 DIV에 출력
			replyDiv.innerHTML +=
				'<div class="accordion" id="reply'+index+'" data-value="'+reply.reply+'" data-rno="'+reply.rno+'">'
				+	'<div class="accordion-item">'
				+		'<h2 class="accordion-header" id="panelsStayOpen-headingOne">'
				+			'<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">'
				+			reply.reply+'<br>'
				+			'<i class="fa-solid fa-pen" onclick="replyEdit('+index+','+reply.rno+');"></i><br>'
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
				+'</div>';		
		});
//페이징===========================================================================================================		

		// 페이지 블럭 생성
		let pageBlock= '';
		pageBlock +=
				 '<nav aria-label="...">'
				+  '<ul class="pagination" justify-content-center>';
		
		// prev 버튼 
		if(pageDto.prev){
			pageBlock +=
					     '<li class="page-item" '
					+    ' onclick="getPage('+ (pageDto.startNo-1) +')" >'
					+    '<span class="page-link">Previous</span>'
					+    '</li>';
		}
		
		// 반복해서 페이지 번호를 출력		    
		for(i=pageDto.startNo;i<=pageDto.endNo;i++){
			// 현재 페이지 번호와 반복되는 페이지 번호를 비교하여, 현재 페이지인 경우 'active' 클래스??를 추가
			let activeStr = (pageDto.cri.pageNo == i)? 'active':''; 
			// 페이지 번호 생성(반복문 startNo ~ endNo)		    
			pageBlock +=		    
					    '<li class="page-item '+ activeStr+'" '
					    // , 클릭 이벤트에 getPage() 함수를 호출하여 해당 페이지 번호를 전달
					+   'onclick="getPage('+ i +')" >'
						// 페이지 번호를 표시하는 링크를 생성
					+	'<a class="page-link" href="#">'+ i +'</a></li>';
		}		    
				    
		// next 버튼
		if(pageDto.next){
			pageBlock +=		    
					   ' <li class="page-item"'
					+  ' onclick="getPage('+ (pageDto.endNo+1) +')" ' 
					+  '<a class="page-link" href="#" >Next</a>'
					+  ' </li>';
		}
		pageBlock +=
				  	  '</ul>'
					+ '</nav>';
				
		replyDiv.innerHTML += pageBlock; 

	}
//==============================================================================================================		
		
		// 댓글 작성 후 서버로부터 받은 응답(map)을 처리하는 JavaScript 함수
		function replyWrite(map){
			if(map.result == 'success'){
				// 등록성공
				// 리스트 조회 및 출력
				getList();
			}else{
				// 등록실패
				alert(map.message);
			}
		}
		
		// 댓글 삭제 함수
		function replyDelete(rno){
			// url의 요청 결과 받아옴
			fetch('/reply/delete/'+rno)
			// 요청결과(json형식의 문자열)를 js object형식으로 반환
			.then(response => response.json())
			// 반환받은 오브젝트를 이용하여 화면 출력
			// (반환값에 대한 이름 : map)
			.then(map => replyWrite(map));
			alert(rno+"번 댓글이 삭제되었습니다.");
		}
		
		// 수정 화면 출력 요청
		function replyEdit(index, rno){
			// 요소 선택
			let editDiv = document.querySelector('#reply'+index);
			let replyText = editDiv.dataset.value;
			
			editDiv.innerHTML = ''
				+	'<div class="input-group mb-3">'
				+		'<p>'
				+		'<input type="text" id="editReply'+rno+'" value="'+replyText+'" class="form-control" aria-describedby="basic-addon2">'
				+		'</p>'
				+		'<p>'
				+		'<span class="input-group-text" id="btnWrite" onclick="editAction('+rno+')">수정</span>'
				+		'</p>'
				+	'</div>';
		}
		// 수정 처리
		function editAction(rno){
			// 서버에 전송할 파라미터 수집
			let reply = document.querySelector("#editReply"+rno).value;
			
			//1. 전송할 데이터를 js객체로 생성 (이름 : 값)
			let replyObj = {
					 rno : rno //화면에서 부터 받아오는 값
					, reply : reply
			};
			//2. 생성 객체를 json타입으로 변환
			let replyJson =JSON.stringify(replyObj);
			
			//3. 서버에 요청
			fetch("/reply/editAction" 
					, {method : 'post'
						, headers :{'Content-Type' : 'application/json'} 
						, body : replyJson})
			
			//4. 응답받아옴
			.then(response => response.json())
			.then(map => replyWrite(map));
			alert("수정되었습니다.")
	
		}
</script>
</head>
<body>

<h2>무플방지위원회 활동내역</h2><br>
	<input type="text" id="bno" name="bno" value="50">
	<input type="text" id="page" name="page" value="1">
	
	<div class="input-group mb-3">
		<p>
			<input type="text" id="replyer" placeholder="작성자" class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2">
		</p>
		<p>
			<input type="text" id= "reply" class="form-control" placeholder="댓글내용" aria-label="Recipient's username" aria-describedby="basic-addon2">
		</p>
		<p>
			<span class="input-group-text" id="btnWrite">작성</span>
		</p>
	</div>

	<div id="replyDiv"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	

</body>
</html>