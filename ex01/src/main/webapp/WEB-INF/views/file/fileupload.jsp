<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.addEventListener('load', function(){
		// 리스트 조회
		btnList.addEventListener('click' ,function(){
			getFileList();
		});
		// 파일 업로드
		btnFileupload.addEventListener('click', function(){
			// 웹개발에서 HTML 폼 데이터를
			// JavaScript로 쉽게 조작하고 전송하는 방법을 제공하는 API
			let formData = new FormData(fileuploadForm);
			// 데이터 넣어주는 방법 
			formData.append('name','uuu');
			
			console.log("formData : ", formData);
			// FormData값 확인
			for(var pair of formData.entries()){
				//console.log(pair);
				//console.log(pair[0]+ ':'+ pair[1]);
				
				if(typeof(pair[1]) == 'object'){
					let fileName = pair[1].name;
					let fileSize = pair[1].fileSize;
					
					// 파일 확장자, 크기 check!
					// 서버에 전송가능한 형식인지
					// 최대 전송가능한 용량을 초과하지 않는지
					if(!checkExtension(fileName, fileSize)){
						return false;
					} 
					
					console.log('filename', fileName);
					console.log('filesize', fileSize);
				}
			}
		
			fetch('/file/fileuploadActionFetch', {method : 'post', body : formData})
			// 요청 결과  json문자열을 javascript 객체로 반환
			.then(response => response.json()) 
			.then(map => fileuploadRes(map));
		
		});
	}); // window.addE 끝
	
	
	// 파일의 확장자와 크기 검사
	function checkExtension(fileName, fileSize){
		let maxSize = 1024 * 1024 * 1;
		// 정규 표현식 : 특정 규칙을 가진 문자열을 검색하거나 치환할때 사용
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		if(maxSize <= fileSize){
			alert("파일 사이즈 초과");
			return false;
		}
		// 문자열에 정규식 패턴을 만족하는 값이 있으면 true 아니면 false
		if(regex.test(fileName)){
			alert("해당 조건의 파일은 업로드 할 수 없습니다.")
			return false;
		}
		return true;
	} 
	
	// 파일 업로드 요청 결과 처리
	// map → 파일 업로드 결과에 대한 정보 들어있음
	function fileuploadRes(map){
		if(map.result =='success'){
			divFileuploadRes.innerHTML=map.msg;
			// 게시글 등록
		}else{
			alert(map.msg);
		}
	}	
	
	function getFileList(){
		///file/list/{bno}
		let bno = document.querySelector("#bno").value;
		fetch('/file/list/'+bno)
			.then(response => response.json())
			.then(map => viewFileList(map));
	}
	
	// 첨부파일 삭제
	function attachFileDelete(e){
		
		let bno = e.dataset.bno;
		let uuid = e.dataset.uuid;
			
		// 값이 유효하지 않은 경우 메세지 처리
		// fetch 요청
		// fetch에 들어가는 url...controller에서 준...
		 fetch(`/file/delete/\${bno}/\${uuid}`)
			  .then(response => response.json())
			  .then(map => fileDeleteRes(map));
	}
	// 삭제 결과 처리
	function fileDeleteRes(map){
		if(map.result == 'success'){
			console.log(map.msg);
			//리스트 조회
			getFileList();
		}else{
			alert(map.msg);
		}
	}
	function viewFileList(map){
		console.log(map);
		let content = '';
		if(map.list.length > 0){
			map.list.forEach(function(item, index){
			let savePath = encodeURIComponent(item.savePath);
			content += "<a href='/file/download?fileName=" 
				    + savePath+"'>"
					+ item.filename + '</a>'
					+ ' <i onclick="attachFileDelete(this)" '
					+ '   data-bno="'+item.bno+'" data-uuid="'+item.uuid+'" '
					+ '   class="fa-regular fa-square-minus"></i>'
					+ '<br>';
			})
		} else {
			content = '등록된 파일이 없습니다.';
		}
		divFileupload.innerHTML = content;
	}
	

</script>
</head>
<body>

	<!-- rest방식 이용한 파일업로드하기 위해 name 달아줌-->	
	<form action="/file/fileuploadAction" 
			method="post" enctype="multipart/form-data" name="fileuploadForm">
			
		bno : <input type="text" name="bno" id="bno" value="50"><br>
		
		<div class="input-group mb-3">
		  <input type="file" class="form-control" name="files" multiple="multiple">
		  <button type="button" id="btnFileupload" class="input-group-text" for="inputGroupFile02">Upload</button>
		</div>
	</form>
		<h2>파일 리스트 조회</h2>
		<button type="button" id="btnList"> 리스트 조회</button>
		<div id="divFileupload">
		
	
		</div>
	


</body>
</html>