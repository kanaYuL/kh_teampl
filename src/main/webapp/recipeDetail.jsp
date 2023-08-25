<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!doctype html>
<html lang="utf-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>recipeDetail.jsp</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Orbit&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	/* navbar */
   	#inputSearch {
   		width : 200px;
   	}
   	
   	#divNav {
   		display:flex;
   		flex-direction:row;
   		justify-content: space-between;
   	}
   	
   	nav {
   		height: 10vh;
   		margin: auto 10px;
   	}
   	
   	/* recipeDetailWrapper */
   	#recipeDetailWrapper {
		height: 90vh;
		/* background-color: black; */
		display: flex;
		flex-direction:row;
		justify-content: center;
		align-items: center;	
	}
	
	#recipeDetail {
		width: 80vh;
		border:solid 2px white;
  		border-radius:20px;
  		padding:30px;
  		background-color:white;
  		align-items: center;
  		margin-top:200px;
  		font-family:'Orbit', sans-serif;
  		font-size:x-large;
  			
	}
	
	#picture {
		display:flex;
		flex-direction:column;
  		justify-content:center;
	}
	
	.detail-element {
		border:solid 1px;
		padding:20px;
  		background-color:white;
  		align-items: center;
	}
	
	#ingredientDetail {
		display:flex;
		flex-direction:column;
	}

	#space {
		height:600px;
	}
	
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div id="divNav" class="collapse navbar-collapse" id="navbarSupportedContent">
				<div id="leftNavbar">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">플리마켓</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">커피 레시피</a></li>
						<li><a id="searchLink" href="#"><i class="fa-solid fa-magnifying-glass"></i></a></li>
					</ul>
				</div>
				
				<div id="rightNavbar">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="#">회원가입</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav> <!-- /nav -->
	
	<!-- 1 개 Wrapper - 4 개 Div -->
	<div id="recipeDetailWrapper">
		<div id="recipeDetail">
		
			<div id="title">
				이름 
				<div id="titleName">에스프레소</div>	
			</div>
			
			<hr>
		
			<div id="picture">
				사진
				<img src="images/돌체라떼.jpg">
			</div>
			
			<hr>
		
			<div id="ingredient" class="detail-element">
				재료
				<div id="ingredientDetail">
					<ul>
						<li>우유 50000ml</li> 
						<li>설탕 1kg</li> 
						<li>원두 100g</li> 
					</ul>
				</div>
			</div>
		
			<hr>
			
			<div id="recipe" class="detail-element">
			
				순서
				<div>
					
				</div>

			</div>
		</div>	
		
		<div id="space">
		
		</div>
	
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>