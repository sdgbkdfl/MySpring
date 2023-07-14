<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.addEventListner('load', function(){
		btnLogin.addEventListner('click',function(e){
			// 기본 이벤트 제거
			e.preventDefault();
			
			// 파라메터 수집
				let obj={
					id: document.querySelector('#id').value,
					pw: document.querySelector('#pw').value,
			}
			// 요청
			console.log(obj);
			fetchPost('/loginAction', obj, loginCheck)
		})
	
			
		function loginCheck(map){
			//로그인 성공 ->list 이동
			
			//실패 -> 메세지 처리
			if(map.result == 'result'){
				location.href= '/board/loginAction/'
			}else{
		        // 로그인 실패 시 메시지 처리
		        alert(map.message);
			}
			
		}
		})
		

</script>
</head>
<body>
	<h1>로그인</h1>
	<form method="post" action="./loginAction">
		id<input type="text" name="id" value="ADMIN"><br>
		pw<input type="text" name="pw" value="1234"><br>
		<input type="submit">
	
	</form>
</body>
</html>