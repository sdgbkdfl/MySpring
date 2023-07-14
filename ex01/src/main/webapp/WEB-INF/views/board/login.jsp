<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>로그인 Signin Bootstrap v5.2</title>
	    
	<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">

	<style>
	    .bd-placeholder-img {
	      font-size: 1.125rem;
	      text-anchor: middle;
	      -webkit-user-select: none;
	      -moz-user-select: none;
	      user-select: none;
	    }
	
	    @media (min-width: 768px) {
	      .bd-placeholder-img-lg {
	        font-size: 3.5rem;
	      }
	    }
	
	    .b-example-divider {
	      height: 3rem;
	      background-color: rgba(0, 0, 0, .1);
	      border: solid rgba(0, 0, 0, .15);
	      border-width: 1px 0;
	      box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
	    }
	
	    .b-example-vr {
	      flex-shrink: 0;
	      width: 1.5rem;
	      height: 100vh;
	    }
	
	    .bi {
	      vertical-align: -.125em;
	      fill: currentColor;
	    }
	
	    .nav-scroller {
	      position: relative;
	      z-index: 2;
	      height: 2.75rem;
	      overflow-y: hidden;
	    }
	
	    .nav-scroller .nav {
	      display: flex;
	      flex-wrap: nowrap;
	      padding-bottom: 1rem;
	      margin-top: -1px;
	      overflow-x: auto;
	      text-align: center;
	      white-space: nowrap;
	      -webkit-overflow-scrolling: touch;
	    }
	    html,
	    body {
	      height: 100%;
	    }
	
	    body {
	      display: flex;
	      align-items: center;
	      padding-top: 40px;
	      padding-bottom: 40px;
	      background-color: #f5f5f5;
	    }
	
	    .form-signin {
	      max-width: 330px;
	      padding: 15px;
	    }
	
	    .form-signin .form-floating:focus-within {
	      z-index: 2;
	    }
	
	 .middle{
	   border-bottom-right-radius: 0;
	      border-bottom-left-radius: 0;
	      border-top-left-radius: 0;
	      border-top-right-radius: 0;
	      margin-bottom: -1px;
	      
	 }
	    .start  {
	      margin-bottom: -1px;
	      border-bottom-right-radius: 0;
	      border-bottom-left-radius: 0;
	    }
	 
	    .end  {
	      margin-bottom: 10px;
	      border-top-left-radius: 0;
	      border-top-right-radius: 0;
	    }
	
	</style>

<script type="text/javascript">
	window.addEventListener('load', function(){
		
		//로그인 버튼이 클릭되었을 때 실행될 함수를 등록
		btnLogin.addEventListener('click',function(e){
			// 기본 이벤트 제거
			/* 로그인 버튼이 <form> 태그 내부에 있을 경우, 
			      클릭 시 폼의 기본 동작인 페이지 전환을 막음 */
			e.preventDefault();
			
			// 파라메터 수집
			// 사용자가 입력한 아이디와 비밀번호 값을 수집하여 obj 객체에 저장
				let obj={
					// value값 null임 
					//id: document.querySelector('#id').value,
					//pw: document.querySelector('#pw').value
					id : signinForm.id.value,
					pw : signinForm.pw.value
			}
			console.log(obj);
			///loginAction URL로 POST 요청을 보내고, 
			// 요청 데이터로 obj 객체를 전달
			// 응답을 받으면 loginCheck 함수가 실행
			// 요청
			fetchPost('/loginAction', obj, loginCheck);
		})
	
		
		// 버튼을 클릭하면 회원가입과 로그인 창 중 하나만 보여주도록 처리
		// 버튼 클릭 시 이벤트 실행 -> 로그인 폼 출력
		btnSigninView.addEventListener('click', function(){
			signupForm.style.display='none'; // 로그인 클릭시 회원가입창 비활성화
			signinForm.style.display='';
			
		})
		// 회원가입폼 출력
		btnSignupView.addEventListener('click', function(){
			signupForm.style.display=''; // 회원가입 버튼 클릭시 로그인 창 비활성화
			signinForm.style.display='none';
		})
	
		signUpId.addEventListener('blur', function(){
			
			// 입력체크
			if(!signUpId.value){
				signupMsg.innerHTML = '아이디를 입력 해주세요';
				return;
			}
			
			// 파라메터 세팅
			let obj={ id : signUpId.value };
			console.log("아이디 체크", obj);
			
			
			// 아이디 체크에 대한 콜백 함수
			// 아이디 체크 -> 서버에 다녀와야 함
			fetchPost('/idCheck', obj, (map)=>{
		    	  if(map.result == 'success'){
		    		  idCheckRes.value='1'; // 아이디 사용 가능
		    		  signUpName.focus();
		    	  } else {
		    		  idCheckRes.value='0'; // 아이디 사용 불가능
		    			signUpId.focus();
		    	  }
		   		  signupMsg.innerHTML = map.msg; // 메세지 출력
		    });
		});
		
        pwCheck.addEventListener('blur', function(){
			
			if(!signUpPw.value){
				signupMsg.innerHTML = '비밀번호를 입력해주세요';
				return;
			}
			if(!pwCheck.value){
				signupMsg.innerHTML = '비밀번호 확인을 입력해주세요';
				return;
			}
			if(signUpPw.value == pwCheck.value){
				pwCheckRes.value=1;
				signupMsg.innerHTML='';
			} else{
				signupMsg.innerHTML = '비밀번호가 일치하지 않습니다.';
				pwCheckRes.value=0;
				signUpPw.focus();
				pwCheck.value='';
				signUpPw.value='';
			}
		});
        
        btnSignup.addEventListener('click', function(e){
        	// 기본 이벤트 초기화
        	e.preventDefault();
        	
        	let id = signUpId.value;
        	let pw = signUpPw.value;
        	let name = signUpName.value;
        	
        	if(!id){
        		signupMsg.innerHTML = '아이디를 입력해주세요';
        		return;
        	}
        	if(!pw){
        		signupMsg.innerHTML = '비밀번호를 입력해주세요';
        		return;
        	}
        	if(!name){
        		signupMsg.innerHTML = '이름을 입력해주세요';
        		return;
        	}
        	
        	// 아이디 중복체크 확인
        	if(idCheckRes.value != 1){
        		signupMsg.innerHTML = "아이디 중복체크를 해주세요.";
        		sighUpId.focus();
        		return;
        	}
        	
        	// 비밀번호 일치 확인
        	if(pwCheckRes.value !=1){
        		signupMsg.innerHTML = "비밀번호가 일치하는지 확인해주세요.";
        		pwCheckRes.focus();
        		return;	
        	}
        	
        	
        	obj = {
        			id : id
        			, pw : pw
        			, name : name
        	}
        	
        	console.log('회원가입 obj : ', obj);
        	
        	// 회원가입 요청
        	fetchPost('/register'
        				, obj
        				, (map)=>{
				        		if(map.result =='success'){
				        			location.href ='/board/login?msg='+map.msg;
				        		}else{
				        			signupMsg.innerHTML = map.msg;
				        		}
					        	});
        })

		
	}) // window.addEventListner 함수 끝
	
		// 로그인 버튼 클릭 시 로그인 처리하는 함수
		function loginCheck(map){
			
			if(map.result == 'success'){
				//로그인 성공 ->list 이동
				location.href= '/board/list'
				alert(signinForm.signUpName.value+"님 환영합니다.")
				
			}else{
		        // 로그인 실패 시 메시지 처리
		        signInMsg.innerHTML=map.msg;
		        alert(map.message);
			}
			console.log(map);
			
		}
	


</script>
<!-- css 링크.. -->
<script type="text/javascript" src="/resources/js/common.js"></script>    
</head>

<body class="text-center">

<main class="form-signin w-100 m-auto">
	<!-- 로그인 폼 -->
	<form name='signinForm'>
	    <img class="mb-4" src="../resources/brand/music.GIF" alt="" width="300" height="200">
	    <h1 class="h3 mb-3 fw-normal">로그인</h1>
		<div id='signInMsg'></div>
	    <div class="form-floating">
	      <input type="text" class="form-control start" id="id" required="required" >
	      <label for="id">ID</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control end"  value="1234" id="pw" placeholder="Password" required="required">
	      <label for="pw">Password</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> Remember me
	      </label>
	    </div>
	    <button class="w-100 btn btn-lg btn-secondary" id="btnLogin" type="submit">로그인하기</button>
	    <p class="mt-5 mb-3 text-muted">&copy; 2017–2022</p>	    
	  </form>
	  
	  
	  <!-- 회원가입폼 -->
	  <form name='signupForm' style='display:none'>
	  
	    <img class="mb-4" src="../resources/brand/rock.JPG" alt="" width="300" height="200">
	    <h1 class="h3 mb-3 fw-normal">회원가입</h1>
		<div id='signupMsg'></div>
	    <div class="form-floating">
	      <input type="text" class="form-control start" id="signUpId" placeholder="id">
	      <label for="id">ID</label>
	    </div>
	    <div class="form-floating">
	      <input type="text" class="form-control middle" id="signUpName" placeholder="name">
	      <label for="signUpName">name</label>
    	</div>
	    <div class="form-floating">
	      <input type="password" class="form-control middle" id="signUpPw"  placeholder="Password">
	      <label for="pw">Password</label>
	    </div>
	
    <div class="form-floating">
      <input type="password" class="form-control end" id="pwCheck" placeholder="Password">
      <label for="pwCheck">Password Check</label>
    </div>
	    
	    
	    <button class="w-100 btn btn-lg btn-secondary" id="btnSignup" type="submit">회원가입</button>
	    <p class="mt-5 mb-3 text-muted">&copy; 2017–2023</p>
	    
	   	  <!-- 아이디 체크 검증을 위한 박스인데.. 뭔지...왜 만든건지... -->
		  <input type="text" value="0" id="idCheckRes">
		  <input type="text" value="0" id="pwCheckRes">
	  </form>
	  
	      <p></p>
		  <button id="btnSignupView">회원가입</button>
		  <button id="btnSigninView">로그인</button>
</main>	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>