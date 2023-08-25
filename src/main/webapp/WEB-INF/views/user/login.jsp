<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="utf-8">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>login.jsp</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Orbit&display=swap" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
	
<style>

	#loginDivWrapper {
		height: 100vh;
		display: flex;
  		justify-content: center;
  		align-items: center;
	}
	
	#loginDiv {
		width: 60vh;
		border:solid 2px;
  		border-radius:20px;
  		padding:30px;
  		background-color:white;
	}
	
	#titleImg {
		display:flex;
		justify-content:center;
		align-items: center;
	}
	
	#title {
		display:flex;
		justify-content:center;
		margin-bottom:5vh;
	}
	
	#loginDiv * {
		 font-family: 'Orbit', sans-serif;
	}
	
	#additionalMenu {
		display:flex;
		justify-content:space-around;
	}
	
	#additionalMenu * {
		text-decoration-line:none;
	}
	
	.addMenu-link {
		margin: 20px 20px;
	}
	
	#copyright {
		display:flex;
		justify-content:center;
	}
	
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>		
<script>
$(function() {
	var result = "${result}";
	var findPwdResult = "${findPwdFail}";
	var resultDiv = $("#resultDiv");
	console.log(result);
	
	if (result == "true") {
		resultDiv.show();
		resultDiv.append("회원 가입 완료 !");
	} 
	
	if (findPwdResult == "false") {
		resultDiv.empty();
		resultDiv.append("아이디 혹은 이메일을 다시 확인해주세요.");
		resultDiv.show();
	}
	
});
</script>
<body>
	${result}
	<div id="loginDivWrapper">
		<div id="loginDiv">
			<div id="resultDiv" class="alert alert-info" role="alert"
				style="display: none;">
			</div>
			
			<form action="/user/loginRun" method="post">
			<div id="titleImg">
				<img class="mb-4" src="/images/user/brownie.png"
				alt="logo" width="72" height="57">
			</div>
			
			<div id="title">
				<h1 class="h3 mb-3 fw-normal">로그인</h1>
			</div>

			<div class="form-floating">
				<input type="text" class="form-control" id="floatingInput"
					placeholder="" name="id"> 
				<label for="floatingInput">아이디</label>
				
			</div>
			
			<div class="form-floating">
				<input type="password" class="form-control" id="floatingPassword"
					placeholder="Password" name="pwd"> 
				<label for="floatingPassword">비밀번호</label>
			</div>
			
			<button class="btn btn-primary w-100 py-2" type="submit">로그인</button>
			
			<div id="additionalMenu">
				<a href="/user/join" class="addMenu-link">회원가입</a>
				<a href="/user/findID" class="addMenu-link">아이디 찾기</a>
				<a href="/user/findPwd" class="addMenu-link">비밀번호 찾기</a>
			</div>
			
			<div id="copyright">
				<p class="mt-5 mb-3 text-body-secondary">© 2023-03 ~ 2023-08</p>
			</div>
			
		</form>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
</body>
</html>
