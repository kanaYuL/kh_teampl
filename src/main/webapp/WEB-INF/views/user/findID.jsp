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
	  $("#btnLogin").click(function() {
		 location.href = "/user/login"; 
	  });
	  
	  $("#btnFindID").click(function() {
		  var email = $("#email").val();
		  var data = {
				  "email" : email
		  };
		  
		  $.ajax({
				"type" : "post",
				"url" : "/user/findIDRun",
				"dataType" : "text",
				"contentType" : "application/json; charset=utf-8",
				"data" : JSON.stringify(data),
				"success" : function(rData) {
					$("#idAlert").show();
					$("#idAlert").append("아이디는 " + rData + "입니다.");
					
					$("#btnFindID").hide();
					$("#btnLogin").show();
				}
			}); // ajax
	  });
	  
  });
  </script>
  <body>
	<div id="joinDivWrapper">
		<div id="joinDiv">
			<form action="/user/findIDRun" method="post">
			
				<div id="idAlert" class="alert alert-info" role="alert" style="display:none;">
  					
				</div>
				
				<div id="title">
					<h2>아이디 찾기</h2>
				</div>
				
				<div class="mb-3">
					<label for="inputEmail" class="form-label">이메일</label> 
					<input type="email" class="form-control"
						   id="email" name="email" aria-describedby="emailHelp"
						   value="">
					<div id="emailHelp" class="form-text">
						가입 시 작성했던 이메일을 입력해주세요.
					</div>
					
				</div>
			
				<button id="btnFindID" type="button" class="btn btn-primary">아이디 찾기</button>
				<button id="btnLogin" type="button" class="btn btn-primary"
				        style="display:none;">돌아가기</button>
			</form>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  </body>
</html>