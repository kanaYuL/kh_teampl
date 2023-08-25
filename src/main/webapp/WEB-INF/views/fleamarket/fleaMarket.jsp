<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>fleaMarketMain.jsp</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://kit.fontawesome.com/8398f84275.js"
	crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<!-- orbit 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<script>
	$(function() {
		var msg = "${msg}";
		if (msg == "SUCCESS") {
			alert("처리가 완료되었습니다.");
		}
		
		// 엔터로 검색 버튼 작동 (수정함)
		function press(f){
		    if(f.keyCode == 13){ //javascript에서는 13이 enter키를 의미함
		        formname.submit(); //formname에 사용자가 지정한 form의 name입력
		    }
		}
		
		$('input[type="checkbox"][name="categories"]').click(
				function() {
					if ($(this).prop('checked')) {
						$('input[type="checkbox"][name="categories"]').prop(
								'checked', false);
						$(this).prop('checked', true);
					}

				});
		
		
		  var categories;
		   
		   $(".btn-check").click(function(){
		      
//		       $("input[name='categories']:checked").each(function(){
//		          var ck = $(this).val();
//		       	console.log("fleaMarket.jsp, .btn-check, ck:", ck);
//		          categories = ck;
//		       });
		      
		      if($(this).is(":checked")){
		    	  ck = $(this).val();
		           categories = ck;
		      } else {
		    	 categories = null;
		      }
		      
		   });
		   
		   
		function getDate(timestamp) {
			var date = new Date(timestamp);
			var year = date.getFullYear().toString().slice(-2);
			var month = ("0" + (date.getMonth() + 1)).slice(-2);
			var day = ("0" + date.getDate()).slice(-2);
			var hour = ("0" + date.getHours()).slice(-2);
			var minute = ("0" + date.getMinutes()).slice(-2);
			var second = ("0" + date.getSeconds()).slice(-2);

			var returnDate = year + "." + month + "." + day + "  " + hour + ":"
					+ minute + ":" + second;
			return returnDate;
		}
		
		
		// 게시판 검색 버튼 (수정함)
		$("#searchBtn").click(function() {
			event.preventDefault(); // 폼의 기본 동작 차단
	
			if (categories == null) {
	
				var keyword = $('input[name="keyword"]').val();
				var data = {
					"categories" : 'A',
					"keyword" : keyword
				}
				
				$.ajax({
						"url" : "/fleamarket/searchListAll",
						"method" : "post",
						"data" : JSON.stringify(data), // JSON 형태로 변환
						"dataType" : "json",
						"contentType" : "application/json",
						"success" : function(rData) {
							var tableBody = $("#tableBody"); // 기존의 테이블 body 엘리먼트
		
							// 기존에 있던 내용 삭제
							tableBody.empty();
		
							// rData를 이용하여 행을 생성하여 테이블에 추가
							for (var i = 0; i < rData.length; i++) {
								var marketboardVo = rData[i];
								var gettedDate = getDate(marketboardVo.regdate);
								var row = "<tr>"
										+ "<td>"
										+ marketboardVo.mbno
										+ "</td>"
										+ "<td><a class='a_title' style='text-decoration-line: none;' href='/fleamarket/reading?mbno="
										+ marketboardVo.mbno
										+ "'>"
										+ marketboardVo.mbtitle
										+ "</a></td>"
										+ "<td>"
										+ marketboardVo.mbwriter
										+ "</td>"
										+ "<td>"
										+ gettedDate
										+ "</td>"
										+ "<td>"
										+ marketboardVo.readcount
										+ "</td>" + "</tr>";
								tableBody.append(row);
							}

						}
					});

			} else {
				console.log("#searchBtn click, categories: ",
						categories);
	
				var keyword = $('input[name="keyword"]').val();
				var data = {
					"categories" : categories,
					"keyword" : keyword
				}
				
				$.ajax({
						"url" : "/fleamarket/searchList",
						"method" : "post",
						"data" : JSON.stringify(data), // JSON 형태로 변환
						"dataType" : "json",
						"contentType" : "application/json",
						"success" : function(rData) {
							
							var tableBody = $("#tableBody"); // 기존의 테이블 body 엘리먼트

							// 기존에 있던 내용 삭제
							tableBody.empty();

							// rData를 이용하여 행을 생성하여 테이블에 추가
							for (var i = 0; i < rData.length; i++) {
								var marketboardVo = rData[i];
								var gettedDate = getDate(marketboardVo.regdate);
								var row = "<tr>"
										+ "<td>"
										+ marketboardVo.mbno
										+ "</td>"
										+ "<td><a class='a_title' style='text-decoration-line: none;' href='/fleamarket/reading?mbno="
										+ marketboardVo.mbno
										+ "'>"
										+ marketboardVo.mbtitle
										+ "</a></td>"
										+ "<td>"
										+ marketboardVo.mbwriter
										+ "</td>"
										+ "<td>"
										+ gettedDate
										+ "</td>"
										+ "<td>"
										+ marketboardVo.readcount
										+ "</td>" + "</tr>";
								tableBody.append(row);
							}

						}
				});

			} //else

		});
		
		
		
		var itemsPerPage = 30;

		// "더 보기" 버튼 클릭 시 숨겨진 항목을 보여줌
		$("#loadMore").click(function() {
			var hiddenItems = $(".hidden-item-row");

			var itemsToShow = hiddenItems.slice(0, itemsPerPage);
			itemsToShow.removeClass("hidden-item-row");

			if (hiddenItems.length <= itemsPerPage) {
				$("#loadMoreButton").hide();
			}
		});

		//최상단으로 이동 버튼
		$('#scrollToTopBtn').click(function() {
			//       $('html, body').animate({ scrollTop: 0 }, 'slow');
			$('html, body').scrollTop(0);

			return false;
		});

		//$(".MarketBoardDiv").css("background-image", "url('/images/fleamarket/fleamarket.jpg')");
		$(".MarketBoardDiv").fadeIn(1000); // 페이드인
	});//끝
</script>


<style>
 body{
       font-family: 'orbit', sans-serif;
   }
.btn-primary {
	background-color: #007bff; /* 기본 버튼 색상 변경 */
	border-radius: 5px; /* 둥근 모서리 스타일 추가 */
	padding: 10px 20px; /* 버튼 내부 패딩 조정 */
}

.card {
	border: none; /* 기본 카드 테두리 제거 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 카드 그림자 추가 */
}

.table {
	background-color: #f8f9fa; /* 테이블 배경색 변경 */
	border-radius: 5px; /* 테이블 둥근 모서리 스타일 추가 */
}

.table tbody tr:hover {
	background-color: #e2e6ea; /* 마우스 호버 시 배경색 변경 */
}

nav {
	height: 10vh;
	margin: auto 10px;
}
/* 플리마켓 전체 묶음 div */
.MarketBoardDiv {
	height: 100vh;
	font-family: 'Orbit', sans-serif;
	width: 100%; /* 전체 너비를 화면 가로폭에 맞추기 */
	text-align: center; /* 가운데 정렬 추가 */
	/*          opacity: 1; */
}
/* 제목 */
#MarketDiv {
	margin-top: 20px;
	text-align: center;
}

.background-image-container {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-image: url('/images/fleamarket/fleamarket.jpg');
	background-size: cover;
	background-position: center;
	opacity: 0.5; /* 투명도 조절 */
	z-index: -1; /* 배경을 콘텐츠 뒤로 */
}

/* 글쓰기 */
#writing {
	text-align: right;
	margin-top: 10px;
	padding: 20px 0; /* 패딩 추가 */
}
/* 검색 */
#searchType {
	text-align: center;
	margin-bottom: 30px;
}

/* 카드 2개 시작 */
#searchLink {
	/* 위 오른쪽 아래 왼쪽 */
	margin: 10px 10px 0 auto;
}

.container-fluid {
	margin: 10vh auto;
}

.card-img-top {
	height: 150px;
}
/* 카드 2개 끝 */

/* 인기글 목록 */
#popularList {
	text-align: center;
	margin-right: 40px;
}

/* 플리마켓 상세검색 전체 div */
#divSearch {
	display: flex;
	flex-direction: column;
	align-items: center;
}

/* 플리마켓 상세검색 입력 창 */
#inputSearch {
	width: 300px;
}

/* 플리마켓 상세검색 입력검색 & 버튼 div */

#searchInputDiv {
	margin-bottom: 10px;
}

.hidden-item-row {
	display: none;
}
#searchInputDiv input {
		float: left;	
	}
</style>

</head>

<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<!-- 플리마켓 보드 시작 -->
	<div class="col-md-12">
		<div class="row">

			<div class="col-md-1"></div>

			<div class="col-md-10">

				<div class="MarketBoardDiv">
					<div class="background-image-container"></div>
					<div class="container-fluid text-center mt-5 pt-5"
						style="height: 40vh;">
						<h1 style="font-family: 'Orbit', sans-serif;" class="display-1">
							플리마켓</h1>
					</div>
				</div>

				<div class="container-fluid">
						
					<div class="row">
						<div class="col-md-12">
							<div class="row">

								<div class="col-md-6">

									<h2 id="popularList">* 조회수 Top 3 *</h2>
									<div class="popularTable">
										<table class="table">
											<thead>
												<tr>
													<th>글번호</th>
													<th>제목</th>
													<th>조회수</th>
													<!-- 조회수? 좋아요? -->
												</tr>
											</thead>

											<tbody>
												<c:forEach items="${recountList}" var="marketboardVo">
													<tr>
														<td>${marketboardVo.mbno}</td>
														<c:choose>
															<c:when test="${not empty marketboardVo.solddate }">
																<td><a class="a_title"
																	href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																	style="text-decoration-line: none;">${marketboardVo.mbtitle}(판매완료)</a></td>
															</c:when>
															<c:otherwise>
																<td><a class="a_title"
																	href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																	style="text-decoration-line: none;">${marketboardVo.mbtitle}</a></td>
															</c:otherwise>
														</c:choose>
														<td>${marketboardVo.readcount}</td>
													</tr>
												</c:forEach>
											</tbody>

										</table>

										<a class="btn btn-primary" href="/fleamarket/writing"> 글쓰기
										</a>

									</div>


								</div>

								<div class="col-md-6">
									<div class="row">
										<div class="col-md-6">
											<div class="card">
												<img class="card-img-top" src="/images/원두.png" />
												<div class="card-block">
													<h5 class="card-title">좋은 원두 고르는 Tip</h5>
													<p>1. 생 원두 수확 연도 확인하기</p>
													<p>2. 로스팅 날짜 확인하기</p>
													<p>3. 색과 크기가 균일한 원두 찾기</p>
												</div>
											</div>
										</div>

										<div class="col-md-6">
											<div class="card">
												<img class="card-img-top" src="/images/quick_tips.jpg" />
												<div class="card-block">
													<h5 class="card-title">사이트 이용시 주의사항</h5>
													<p>1. 카테고리를 지켜서 글을 작성해주세요.</p>
													<p>2. 상품 구매 이외의 댓글은 삼가해주세요.</p>
													<p>3. 너무 많을 글을 연속해서 작성하지 말아주세요.</p>
												</div>
											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>
				</div>


				<!-- 플리마켓 상세 검색 searchDiv 시작  (수정함) -->
				<form action="nextpage.php" method="post" name="formName">
					<div class="container-fluid">
						<div class="row bg-secondary-subtle">
							<div class="col-md-12">
								<div id="divSearch" class="jumbotron">
									<h3>플리마켓 게시판 검색</h3>
									
									
									<!-- div : check box -->
									<div id="divCheckbox" class="btn-group" role="group"
										style="margin: 10px 0px 10px 0px;"
										aria-label="Basic checkbox toggle button group">
										<input type="checkbox" class="btn-check" id="btncheck1"
											autocomplete="off" value="B" name="categories"> <label
											class="btn btn-outline-primary" for="btncheck1">원두</label> <input
											type="checkbox" class="btn-check" id="btncheck2"
											autocomplete="off" name="categories" value="G"> <label
											class="btn btn-outline-primary" for="btncheck2">글라인더</label> <input
											type="checkbox" class="btn-check" id="btncheck3"
											autocomplete="off" name="categories" value="S"> <label
											class="btn btn-outline-primary" for="btncheck3">시럽</label> <input
											type="checkbox" class="btn-check" id="btncheck4"
											autocomplete="off" name="categories" value="E"> <label
											class="btn btn-outline-primary" for="btncheck4">기타</label>
		
									</div>
		
									<!-- div : search input -->
									<div id="searchInputDiv">
<!-- 											<form class="d-flex" role="search"> -->
										<input id="inputSearch" class="form-control me-2"
											type="search" placeholder="검색어를 입력하세요" aria-label="Search"
											name="keyword">
	
										<button class="btn btn-outline-success" type="submit"
											id="searchBtn">검색</button>
<!-- 											</form> -->
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</form>
				<!-- 플리마켓 상세 검색 searchDiv 끝 -->


				<!-- 게시판 목록 -->
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-2"></div>

						<div class="col-md-8">
							<p class="fs-6" style="color: #9e9e9e;">최초30개까지 보여집니다.</p>
							<table class="table">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>

								<tbody id="tableBody">
									<c:forEach items="${list}" var="marketboardVo" varStatus="loop">
										<c:choose>
											<c:when test="${loop.index >= 30}">
												<tr class="hidden-item-row">
													<td>${marketboardVo.mbno}</td>
													<c:choose>
														<c:when test="${not empty marketboardVo.solddate }">
															<td><a class="a_title"
																href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																style="text-decoration-line: none;">${marketboardVo.mbtitle}(판매완료)</a></td>
														</c:when>
														<c:otherwise>
															<td><a class="a_title"
																href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																style="text-decoration-line: none;">${marketboardVo.mbtitle}</a></td>
														</c:otherwise>
													</c:choose>
													<td>${marketboardVo.mbwriter}</td>
													<td>${marketboardVo.regdate}</td>
													<td>${marketboardVo.readcount}</td>
												</tr>
											</c:when>
											<c:otherwise>
												<tr class="item-row">
													<td>${marketboardVo.mbno}</td>
													<c:choose>
														<c:when test="${not empty marketboardVo.solddate }">
															<td><a class="a_title"
																href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																style="text-decoration-line: none;">${marketboardVo.mbtitle}(판매완료)</a></td>
														</c:when>
														<c:otherwise>
															<td><a class="a_title"
																href="/fleamarket/reading?mbno=${marketboardVo.mbno}"
																style="text-decoration-line: none;">${marketboardVo.mbtitle}</a></td>
														</c:otherwise>
													</c:choose>
													<td>${marketboardVo.mbwriter}</td>
													<td>${marketboardVo.regdate}</td>
													<td>${marketboardVo.readcount}</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</tbody>
							</table>
							<div class="text-center mt-3" id="loadMoreButton">
								<button class="btn btn-primary" id="loadMore">더 보기</button>
							</div>

						</div>

						<div class="col-md-2"></div>


					</div>
				</div>
				<!-- // 게시판 목록 -->


				<!-- 글쓰기 버튼 시작 -->
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-2"></div>

						<div class="col-md-8" id="writing">
							<a class="btn btn-primary" href="/fleamarket/writing"> 글쓰기 </a>
							<button id="scrollToTopBtn" class="btn btn-primary">최상단으로
								이동</button>
						</div>

						<div class="col-md-2"></div>
					</div>
				</div>
				<!-- 글쓰기 버튼 끝 -->


				<!--             게시판 검색 버튼 시작 -->
				<!--             <div class="col-md-12" id="searchType"> -->
				<!--                <select name="searchType" id="searchType"> -->
				<!--                   <option>제목</option> -->
				<!--                   <option>내용</option> -->
				<!--                   <option>작성자</option> -->
				<!--                </select>  -->
				<!--                <input type="text" name="keyword" id="keyword" -->
				<%--                   value="${pagingDto.keyword}"> --%>
				<!--                <button type="button" id="btnSearch">검색</button> -->
				<!--             </div> -->
				<!--             게시판 검색 버튼 끝 -->



			</div>

			<div class="col-md-1">
				<a></a>
			</div>

		</div>
	</div>
	<!-- 플리마켓 보드  끝 -->


</body>
</html>