<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>join.jsp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&family=Orbit&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    
  <style>
  
  	* {
  		font-family: 'Orbit', sans-serif;
  	}
  	
  	#joinDivWrapper {
  		height: 100vh;
		display: flex;
  		justify-content: center;
  		align-items: center;
  		
  	}
  	
  	#joinDiv {
  		border:solid 2px;
  		border-radius:20px;
  		padding:30px;
  		background-color:white;
  	}
  	
  	#title {
  		display:flex;
  		justify-content:center;
  	}
  	
  	#dupCheckDiv {
  		display:flex;
  		margin: 10px;
  	}
  	
  	#dupMsg {
  		margin: 5px;
  	}
  	
  	#btnJoin {
  		margin-left: 5px;
  	}
  	
  </style> 
  </head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>			
  <script>
  
  $(function() {
	  
	  // condId, condPwd 둘 다 참일 때 회원가입 할 수 있도록 함. 
	  var condId = false;
	  var condPwd = false;
	  
	  // 검증 1. 아이디 중복 체크 -> DB에 존재하는 아이디와 동일한지 체크 
	  $("#dupCheckBtn").click(function() {
		 	  
		  var id = $("#id").val();
		  var url = "/user/isDupId";
		  var data = {
				  "id" : id
		  }
		  
		  $.ajax({
			type: "POST",
		    url: url,
		    contentType : "application/json; charset=utf-8",
		    data: JSON.stringify(data),
		    dataType: "text",
		    success: function(rData) {
		    	console.log(rData);
		    	var dupMsg = "";
		    	
		    	// 중복된 아이디 -> 검증 실패
		    	if(rData == "TRUE") {
		    		condId = false;
		    		dupMsg = "중복된 아이디";
		    		
		    	// 중복되지 않은 아이디 -> 검증 성공
		    	} else if(rData == "FALSE") {
		    		condId = true;
		    		dupMsg = "중복되지 않은 아이디";
		    	}
		    	
		    	$("#dupMsg").text(dupMsg);
		    },
		    error: function(request, status, error){
		    	var code = "code: " + request.status + "\n";
		    	var message = "message: " + +request.responseText + "\n";
		    	var errorMsg = "error: " + error
				alert(code + message + errorMsg);
			}
		   
		  });
		  
	  });
	  
	  // 검증 2. 비밀번호 확인 검사 -> 기존의 입력 비밀번호와 동일한지 확인
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
	  
	  
	  $("#btnJoin").click(function() {
		 // 아이디 중복 검증, 패스워드 확인 검증 둘다 만족 시, Controller로 이동 
		  if (condId && condPwd) {
			  $("#frmJoin").submit();
		  } else {
			  $("#alertDiv").show();
		  }
		 
	  });
	  
  });
  </script>
  <body>
	<div id="joinDivWrapper">
		<div id="joinDiv">
			<form id="frmJoin" action="/user/joinRun" method="post">
			
				<div id="alertDiv" class="alert alert-warning" role="alert"
				     style="display:none;">
				 	 가입 양식을 다시 확인해주세요. 
				</div>
				
				<div id="title">
					<h2>회원 가입</h2>
				</div>
				
				<div class="mb-3">
					<label for="inputId" class="form-label">아이디</label> 
					<input type="text" class="form-control"
						   id="id" name="id" aria-describedby="idHelp"
						   value="cigr45">
					<div id="idHelp" class="form-text">
						아이디는 영문과 숫자의 조합으로 입력해주세요.
					</div>
					
					<div id="dupCheckDiv">
						<button id="dupCheckBtn" class="btn btn-success btn-sm" type="button">중복 체크</button>
						<div><span id="dupMsg"></span></div>
					</div>
				</div>

				<div class="mb-3">
					<label for="pwd" class="form-label">비밀번호</label>
					<input type="password" class="form-control"
						   id="pwd" name="pwd"
						   value="1q2w3e4r">
				</div>
				
				<div class="mb-3">
<!-- 					<label for="pwdCheck" class="form-label">비밀번호 확인</label> -->
					<div id="pwdCheckDiv" class="form-floating">
						<input type="password" class="form-control" 
						       id="pwdCheck" placeholder="Password"> 
						<label id="pwdCheckLabel" for="pwdCheck">비밀번호 확인</label>
					</div>
<!-- 					<input type="password" class="form-control" -->
<!-- 						   id="pwdCheck" name="pwdCheck" aria-describedby="pwdCheckHelp" -->
<!-- 						   value="1qq22w3"> -->
					<div id="pwdCheckHelp" class="form-text">
						비밀번호와 동일하게 입력해주세요. 
					</div>
				</div>
				
				<div class="mb-3">
					<label for="email" class="form-label">이메일</label> 
					<input type="email" class="form-control"
						   id="email" name="email"
						   value="chul4450@naver.com">
				</div>
			
				<button id="btnJoin" type="button" class="btn btn-primary">가입하기</button>
			</form>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  </body>
</html>