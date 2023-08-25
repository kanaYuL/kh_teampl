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
	var condPwd = false;
	
	$("#pwdCheck").keyup(function(e) {
		
		  $("#pwdCheckLabel").text("다른 비밀번호");

		  var pwd = $("#pwd").val();
		  var pwdCheck = $(this).val();
		  
		  if (pwd == pwdCheck) {
			  $("#pwdCheckLabel").text("동일한 비밀번호");
			  condPwd = true;
		  } else {
			  condPwd = false;
		  }
		  
		  console.log("condPwd: " + condPwd);
	});
	
	$("#btnNewPwd").click(function() {
		
		  // 아이디 중복 검증, 패스워드 확인 검증 둘다 만족 시, Controller로 이동 
		  if (condPwd) {
			  $("#frmNewPwd").submit();
		  } else {
			  $("#alertDiv").show();
			  return false;
		  }
	 
	  });
});
</script>
<body>
	<div id="loginDivWrapper">
		<div id="loginDiv">
			<div id="alertDiv" class="alert alert-info" role="alert"
				style="display: none;">
				패스워드를 동일하게 입력해주세요.
			</div>
			
			<form id="frmNewPwd" action="/user/setNewPwdRun" method="post">
			<input type="hidden" name="id" value="${id}">
			
			<div id="titleImg">
				<img class="mb-4" src="/images/user/brownie.png"
				alt="logo" width="72" height="57">
			</div>
			
			<div id="title">
				<h1 class="h3 mb-3 fw-normal">새 비밀번호</h1>
			</div>

			<div class="mb-3">
					<label for="pwd" class="form-label">비밀번호</label>
					<input type="password" class="form-control"
						   id="pwd" name="pwd"
						   value="">
			</div>
				
			<div class="mb-3">
				<div id="pwdCheckDiv" class="form-floating">
					<input type="password" class="form-control" 
					       id="pwdCheck" placeholder="Password"> 
					<label id="pwdCheckLabel" for="pwdCheck">비밀번호 확인</label>
				</div>
				<div id="pwdCheckHelp" class="form-text">
					비밀번호와 동일하게 입력해주세요. 
				</div>
			</div>
		
			<button id="btnNewPwd" class="btn btn-primary w-100 py-2" type="submit">비밀번호 변경</button>
					
			<div id="copyright">
				<p class="mt-5 mb-3 text-body-secondary"> © 2023-03 ~ 2023-08 </p>
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
