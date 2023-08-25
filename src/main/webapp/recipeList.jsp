<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>recipeList.jsp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&family=Orbit&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  </head>
  <style>
  
  	body {
  		background-color:bg-info-subtle;
  	}
  
  	h1, h2, h3, p {
  		font-family: 'Orbit', sans-serif;
  	}	
  	
  	/* Wrapper */
  	#recipeListWrapper {
  		height: 100vh;
  	}
  
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
   	
   	
   	
   	/* divSearch */
   	#divSearch {
   		display:flex;
   		flex-direction:column;
   		align-items: center;
   		height:30vh;
   	}
   	
   	#divSearch * {
   		margin: 3px auto; 
   	}	
   	
   	#divRadio {
   		margin-top:20px;
   	}
   	
   	.carousel-inner {
   		align-items: center;
   	}
   	
   	#searchLink {
   	
   		/* 위 오른쪽 아래 왼쪽 */
   		margin: 10px 10px 0 auto;
   		
   	}
   	
   	.d-block {
   		width:1500x;
   		height:540px;
   		text-align:center;
   	}
   	
   	
   	/* shareRecipe */
   	#shareRecipe {
   		display:flex;
   		justify-content:center;
   		align-items:center;
   	}
   	
   	#shareRecipe > a {
   		 text-decoration-line: none;
   		 color:black;
   	}
   	
   	/* recipeListDiv */
   	#recipeListDiv {
	
   	}
   	
   	.itemRow {
   		margin: 5vh;
   	}
   	
   	.listItem {
   		display:flex;
   		flex-direction:column;
   		align-items:center;
   	}
   	
   	.listItem * {
   		margin: 5px;
   	}
   	
   	.itemTextDiv {
   		
   	}
   	
   	/* pagingDiv */
   	#pagingDiv {
   		display:flex;
   		justify-content:center;
   	}
   	
 
  </style>
<body>
	<div id="recipeListWrapper">
		<!-- navbar -->
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">Navbar</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div id="divNav" class="collapse navbar-collapse"
					id="navbarSupportedContent">
					<div id="leftNavbar">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li id="fleamarket" class="nav-item"><a class="nav-link"
								href="#">플리마켓</a></li>
							<li id="recipeList" class="nav-item"><a
								class="nav-link active" aria-current="page" href="#">커피 레시피</a></li>
							<li><a id="searchLink" href="#"><i
									class="fa-solid fa-magnifying-glass"></i></a></li>
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
		</nav>
		<!-- /nav -->
		
		<!-- searchDiv -->
		<div class="container-fluid">
			<div class="row bg-secondary-subtle">
				<div class="col-md-12">
					<div id="divSearch" class="jumbotron">
						<h3>레시피 상세 검색</h3>

						<!-- div : radio box -->
						<div id="divRadio" class="btn-group" role="group"
							aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" name="btnradio"
								id="btnradio1" autocomplete="off" checked> <label
								class="btn btn-outline-primary" for="btnradio1">Hot</label> <input
								type="radio" class="btn-check" name="btnradio" id="btnradio2"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btnradio2">Ice</label>
						</div>

						<!-- div : check box -->
						<div id="divCheckbox" class="btn-group" role="group"
							aria-label="Basic checkbox toggle button group">
							<input type="checkbox" class="btn-check" id="btncheck1"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btncheck1">라떼</label> <input
								type="checkbox" class="btn-check" id="btncheck2"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btncheck2">시럽</label> <input
								type="checkbox" class="btn-check" id="btncheck3"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btncheck3">알코올</label> <input
								type="checkbox" class="btn-check" id="btncheck4"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btncheck4">과일</label> <input
								type="checkbox" class="btn-check" id="btncheck5"
								autocomplete="off"> <label
								class="btn btn-outline-primary" for="btncheck5">크림</label>
						</div>

						<!-- div : search input -->
						<div>
							<form class="d-flex" role="search">
								<input id="inputSearch" class="form-control me-2" type="search"
									placeholder="Search" aria-label="Search">
								<button class="btn btn-outline-success" type="submit">Search</button>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- /searchDiv -->
		
		<!-- shareRecipe  -->
		<div id="shareRecipe">
			<button type="button" class="btn btn-success">레시피 공유하기</button>
		</div>
		<!-- /shareRecipe  -->
		
		<!-- recipeListDiv -->
		<!-- 들어오는 ${recipeList}의 갯수에 따라서 for:each로 조절  -->
		<div id="recipeListDiv" >	
			<div class="row itemRow">
				<div class="col-4 listItem">
					<a href="#"><img class="itemImg" alt="straw" src="images/블루 쿨.jpg"></a>
					<span>딸기 크림 커피</span>
					<span>딸기를 넣고 크림을 넣고 섞으면 됨</span>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="espresso" src="images/아모레 미오.jpg"></a>
					<span>에스프레소</span>
					<span>근본 원액 그 자체. 물 타서 마시면 됨</span>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="vanilla" src="images/셀레브레이션 드림.jpg"></a>
					<p>바닐라</p>
					<p>달달하게 즐길 수 있는 커피</p>
				</div>
			</div>
			
			<div class="row itemRow">
				<div class="col-4 listItem">
					<a href="#"><img alt="straw" src="images/아모레 미오.jpg"></a>
					<p>딸기 크림 커피</p>
					<p>딸기를 넣고 크림을 넣고 섞으면 됨</p>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="espresso" src="images/블루 쿨.jpg"></a>
					<p>에스프레소</p>
					<p>근본 원액 그 자체. 물 타서 마시면 됨</p>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="vanilla" src="images/셀레브레이션 드림.jpg"></a>
					<p>바닐라</p>
					<p>달달하게 즐길 수 있는 커피</p>
				</div>
			</div>
			
			<div class="row itemRow">
				<div class="col-4 listItem">
					<a href="#"><img alt="straw" src="images/아모레 미오.jpg"></a>
					<p>딸기 크림 커피</p>
					<p>딸기를 넣고 크림을 넣고 섞으면 됨</p>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="espresso" src="images/블루 쿨.jpg"></a>
					<p>에스프레소</p>
					<p>근본 원액 그 자체. 물 타서 마시면 됨</p>
				</div>
				
				<div class="col-4 listItem">
					<a href="#"><img alt="vanilla" src="images/셀레브레이션 드림.jpg"></a>
					<p>바닐라</p>
					<p>달달하게 즐길 수 있는 커피</p>
				</div>
			</div>
		</div>		
		<!-- /recipeListDiv -->
		
		<!-- default : 1번 페이지가 선택된 상태 -->
		<div id="pagingDiv" aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
				<li class="page-item active"><a class="page-link" href="#"
				    aria-current="page">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
</body>
</html>