console.log('reply.js=========')

// get방식 요청
function fetchGet(url, callback){
	try{
		// url 요청
		fetch(url)
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map));			
	}catch(e){
		console.log('fetchGet',e);
	}
}

// post방식 요청
function fetchPost(url, obj, callback){
	try{
		// url 요청
		fetch(url
				, {
					method : 'post'
					, headers : {'Content-Type' : 'application/json'}
					, body : JSON.stringify(obj)
				})
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map));			
	}catch(e){
		console.log('fetchPost', e);
	}
	
}


//댓글 조회 및 출력
function getReplyList(){
	let bno = document.querySelector('#bno').value;
//	let bno = 50;
	let page = '1';
	console.log('bno:', bno);
	
	console.log('/reply/list/' + bno + '/' + page);
	console.log(`/reply/list/${bno}/${page}`);
	
	// url : 요청 경로
	// callback : 응답결과로 실행시킬 함수 
	fetchGet(`/reply/list/${bno}/${page}`, replyView)
	// 함수를 변수처럼 전달
}

function replyView(map){
	let list = map.list;
	console.log(list);
	// 리스트 사이즈를 확인하여 메세지 처리
	if(list.length ==0){
		replyDiv.innerHTML = '등록된 댓글이 없습니다.'
	}else{
	let replyDivStr = '댓글목록'
			+'<table class="table text-break text-center">    			'
			+'  <thead>                                       			'
			+'    <tr>                                        			'
			+'      <th scope="col-1">#</th>                  			'
			+'      <th scope="col-9">댓글</th>                			'
			+'      <th scope="col-2">작성자</th>               			'
			+'      <th scope="col-1">등록일자</th>             			'
			+'    </tr>                                      			'                                     
			+'  </thead>                                     			'
			+'  <tbody>      					              			';
		// 리스트를 돌며 댓글목록 출력
		list.forEach((reply, rno)=>{
			replyDivStr += 
			 '    <tr id="tr'+reply.rno+'">                             '
			+'      <th scope="row">'+reply.rno+'</th>					'
			+'      <td class="text-start">'+reply.reply
			+'			<i class="fa-regular fa-pen-to-square"			'
			+'				onclick="replyEdit('+reply.rno+')"></i>		'
			+'			<i class="fa-solid fa-delete-left" 				'
			+'				onclick="replyDelete('+reply.rno+')"></i>	'
			+'		</td> 												'
			+'      <td>'+reply.replyer									
			+'		</td>                            					'
			+'      <td>'+reply.replydate+'</td>                        '
			+'    </tr>  												';	
		})
			replyDivStr +=
			 '</tbody>                              					'
			+'</table>                                       			';
		       				
			
			replyDiv.innerHTML = replyDivStr;
	}	
}

// 댓글 등록하기
function replyWrite(){
	
	// 댓글 작성 시 필요한 데이터 수집
	let bno = document.querySelector('#bno').value;
	let reply = document.querySelector('#reply').value;
	let replyer = document.querySelector('#replyer').value;
	
	// 전달형 객체로 생성
	let obj ={
			bno : bno
			, reply : reply
			, replyer : replyer
	};
	console.log(obj);
	// obj : JSON 형식으로 전달할 데이터
	// callback : 응답결과 처리할 함수
	// bno, reply, replyer
	// url : /reply/insert - 요청경로
 	fetchPost('/reply/insert', obj, replyRes);
}


// 답글 등록, 수정, 삭제의 결과를 처리하는 함수
// replyController에서 작성해서 불러옴
function replyRes(map){
	// 성공 :  리스트 조회 및 출력
	if(map.result == 'success'){
		getReplyList();
		alert('댓글이 등록되었습니다.');
	}else{
	// 실패 : 메세지 알림...★
		alert(map.message);
	}
	
}

// 답글 삭제하기
function replyDelete(rno){
	console.log('rno', rno);
	fetchGet('/reply/delete/'+rno, replyRes);
	alert('댓글이 삭제되었습니다.');
}

// 답글 수정화면 요청
function replyEdit(rno){
	// 요소 선택(#아이디 값)
	let editForm = document.querySelector("#tr"+rno) 
	// editForm 요소의 data-value 속성 값을 replyTxt 변수에 할당
	// let replyTxt = editForm.dataset.value;
	
	
	editForm.innerHTML = '<td colspan="3">											   '                                                                          
		+'<div class="input-group">                                                    '
		+'  <span class="input-group-text">댓글 수정 </span>                              '
		+'  <input type="text" aria-label="First name" 								   '
		+'		id="reply'+rno+'" class="form-control" id="reply">                     '
		+'  <input type="button" aria-label="Last name" 							   '
		+'		onclick="replyEditAction" class="input-group-text" value="수정하기">	   '
		+'</div>                                                                       ';
}                                                                                                                    

// 수정 처리






















