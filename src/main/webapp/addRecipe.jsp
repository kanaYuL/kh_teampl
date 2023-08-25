<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>addRecipe.jsp</title>
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
   	
   	/* title */
   	#title {
   		height:10vh;
   	}
   	
   	/* addRecipeForm */
   	#addRecipeFormWrapper {
 
		height: 100vh;
		width: 100%;
		/* background-color: black; */
		background-image: images/addRecipeBackground.jpg;
		display: flex;
		flex-direction:row;
		justify-content: center;
		align-items: center;	
	}
 		
	#addRecipeForm {
		border:solid 2px;
		border-radius:20px;
		padding:30px;
		background-color:white;
		width:80vh;
	}
	
	/* ingredients */
	#ingredients {
		margin-bottom:10px;
	}
	.recipe {
		display:flex;
		
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
	
	
	
	<!-- addRecipeForm -->
	<div id="addRecipeFormWrapper" style="background-image: images/addRecipeBackground.jpg;">
		<div id="addRecipeForm">
		
			<form>
				<div class="mb-3">
					<label for="recipeTitle" class="form-label">레시피 이름</label> 
					<input type="text" class="form-control" id="recipeTitle">									
				</div>
   
   				<hr>
   				
				<!-- '재료 추가' 버튼으로 해당 div 내 input clone하는 방향으로 재료 늘려나감 -->
				<div id="ingredients">
					<div class="mb-3 add-ingredient">
						<label for="recipeTitle" class="form-label">재료</label>
						<div id="ingredientsHelp" class="form-text">모든 재료 양은 1인분을 기준으로 합니다.</div>  	 
						<input type="text" class="form-control" class="ingredients"
						       aria-describedby="ingredientsHelp">
					</div>
					
					<div class="mb-3 add-ingredient">
						<input type="text" class="form-control" id="ingredients"
						       aria-describedby="ingredientsHelp">
						<div id="ingredientsHelp" class="form-text"></div>  									
					</div>
					
					<div>
						<button type="button" class="btn btn-success">재료 추가</button>
					</div>
					
				</div>
				
				<hr>
				
				<div id="recipe">
					<div>
						<label for="recipeTitle" class="form-label">만드는 법</label>
						<div id="ingredientsHelp" class="form-text">순서대로 적어주세요.</div>
					</div>
					
					<div class="mb-3 recipe">
						 	 
						1.&nbsp;&nbsp; <input type="text" class="form-control" class="ingredients"
						       aria-describedby="ingredientsHelp">
					</div>
								
					<div class="mb-3 recipe">
						2.&nbsp;&nbsp;  <input type="text" class="form-control" id="ingredients"
						       aria-describedby="ingredientsHelp">
						<div id="ingredientsHelp" class="form-text"></div>  									
					</div>
					
					<div>
						<button type="button" class="btn btn-success">순서 추가</button>
					</div>
					
				</div>
				
				<hr>
				
				<div id="addPicture">
					<label for="recipeTitle" class="form-label">사진</label>
					<div id="pictureDiv">
					
					</div>
					
					<button type="button" class="btn btn-success">사진 첨부</button>
				</div>
				
			</form>
		</div>
	</div>
	<!-- /addRecipeForm -->
	
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  </body>
</html>