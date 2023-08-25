<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="recipeIndex" value="0"/>

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
	body{
       
          font-family: 'orbit', sans-serif;
       }
	/* navbar */
   	#inputSearch {
   		width : 200px;
   	}
   	#title {
	    background-color: #f0f0f0; /* 배경색 설정 */
	    padding: 10px; /* 패딩 추가 */
	    font-weight: bold; /* 텍스트 굵게 설정 */
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
		
		margin-top:500px;	
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
	
	/* 파일 업로드용 Div */
	#uploadDiv {
		width: 100%;
		height: 150px;
		background-color: #DEDEDE; 
		margin: 20px auto;
		border: 2px dashed blue;
	}
	
	/* 수정 시 생성되는 input */
	input {
		margin-top:10px;	
		margin-bottom:10px;
	}
	
	#comment > input {
		width:100%;
	}
	
	.recipe {
		width:100%;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="/js/utilscript.js"></script>
<script>
$(function() {
	$("#btnRecipeUpdate").click(function() {
		// 1. 수정 완료 버튼 보이게 하기. 
		$(this).hide();
		$("#btnUpdateFinish").show();
		
		// 2. 항목들에 대한 수정 가능하게 하기.
		// 2-1. 이름
		$("#titleName").empty();
		$("#titleName").append($('<input/>', {type: 'text', id:'recipeTitle', name: 'recipeTitle', value: '${recipeDetail.recipeTitle}'}));
		
		// 2-2. 한 줄 평 
		$("#comment").show();
		
		// 2-2. 이미지
		$(".delete-link").show();
		$("#uploadDiv").show();
		
		// 2-2-1. 이미 게시글에 첨부된 이미지 -> 'div' id = existedImgDiv
		$("#picture").empty();
		$.getJSON("/recipe/getAttachList/${mno}", function(rData) {
		$.each(rData, function(i) {     // rData - 배열 [파일명, 파일명, ....]
		
			var div = $("#uploadedItem").clone();
			div.removeAttr("id");
			div.addClass("uploadedItem");
			
			var fileName = rData[i].substring(rData[i].indexOf("_") + 1);
			// div.find("span").attr("style", "display:none;");
			
			div.find("span").empty();
			div.find("span").append(fileName);
			
			if (isImage(fileName)) {
				var thumbnail = getThumbnailName(rData[i]);
				div.find("img").attr("style", "width:60px; height:50px;");
				div.find("img").attr("src", "/upload/displayImage?filePath=" + rData[i] +"&type=recipe");
			}
			
			div.find("a").attr("data-fileName", rData[i]);
			var filename = div.find("a").attr("data-fileName");
			
			$("#existedImgDiv").append(div);
			
			div.show();	
			}); // $.each()
		}); // $.getJSON()
		
		// 3. 재료 (Ingredients)
		$("#btnIngredients").show();
		$("#ingredientDetail > ul").empty();
	    $.ajax({
	 		"type" : "get",
	 		"url" : "/recipe/getIngredients/${mno}",
	 		"dataType" : "json",
	 		"contentType" : "application/json; charset=utf-8",
	 		"success" : function(rData) {
	 		// console.log(rData);
	 			
	 			$(rData).each(function(i){
					// console.log(rData[i]);
					$("#ingredientDetail > ul").append($('<input/>', {type: 'text', name: 'ingredients', class: 'inputIngredients', value: rData[i]}));
				
				});
	 				
	 		} // success : function(rData)
	 	}); // $.ajax()
		
	 	// 4. 제조 순서 (recipe)
	 	$("#carouselExampleControls").hide();
	    $("#btnRecipe").show();
	    $.ajax({
	 		"type" : "get",
	 		"url" : "/recipe/getRecipe/${mno}",
	 		"dataType" : "json",
	 		"contentType" : "application/json; charset=utf-8",
	 		"success" : function(rData) {
	 			
	 			$(rData).each(function(i){
					console.log(rData[i]);
					$("#recipe > div[id=updateRecipe]").append($('<input/>', {type: 'text', name: 'recipe', class: 'recipe', value: rData[i]}));
				});	
	 		} // success : function(rData)
	 	}); // $.ajax()
	}); // $("#btnRecipeUpdate").click()
	
	$("#btnUpdateFinish").click(function() {
		
		var form = $('<form></form>');
	    form.attr('action', "/recipe/updateRecipe");
	    form.attr('method', 'post');
	    form.appendTo('body');
	    
		// 1. recipeTitle 
		form.append($('<input type="hidden" value="' + $("#recipeTitle").val() + '" name=recipeTitle>'));
		
		// 2. recipeComment 
		form.append($('<input type="hidden" value="' + $("#recipeComment").val() + '" name=recipeComment>'));
		
		// 4. ingredients
		form.append($('<input type="hidden" value="' + makeArrayFromNames("ingredients") + '" name=ingredients>'));

		var grpl = $("input[name=recipe]").length;
			
	  	// 배열 생성
	  	var grparr = new Array(grpl);
	  			
	  	// 배열에 값 주입
	  	for(var i=0; i<grpl; i++){                          
	  		grparr[i] = $("input[name=recipe]").eq(i).val();
	  	}
		
		// 5. recipe
		form.append($('<input type="hidden" value="' + grparr + '" name=recipe>'));
		
		// 6. filenames
		var filenames = [];
		
		$("#uploadedDiv a, #existedImgDiv a").each(function() {
			var filename = $(this).attr("data-filename");
			filenames.push(filename);
		});
			
		form.append($('<input type="hidden" value="' + filenames + '" name=filenames>'));
		
		//7. mfilename 
		form.append($('<input type="hidden" value="' + $("#mfilename").text() + '" name=mfilename>'));
		
		form.submit();
	});
	
	// ImageFile : uploadDiv -> drop Event
	// 자동 오픈 방지
	$("#uploadDiv").on("dragenter, dragover", function(e) {
		e.preventDefault();
	});
	
	// 첨부파일 업로드
	$("#uploadDiv").on("drop", function(e) {
		e.preventDefault();
		var file = e.originalEvent.dataTransfer.files[0];
		var formData = new FormData();  
		formData.append("file", file);
		
		url = "/upload/uploadFile?type=recipe";
		
		$.ajax({
			"type" : "post",
			"processData" : false,   // ?a=b&c=d (x)
			"contentType" : false,  // application/x-www-form-urlencoded (x)
			"url" : url,
			"data" : formData,
			"success" : function(rData) {
				console.log(rData);
				var div = $("#uploadedItem").clone();
				div.removeAttr("id");
				div.addClass("uploadedItem");
				div.addClass("newUpload");
				var fileName = rData.substring(rData.indexOf("_") + 1);
				div.find("span").text(fileName);
				
				if (isImage(fileName)) {
					var thumbnail = getThumbnailName(rData);
					div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail + "&type=recipe");
				}
				
				div.find("a").attr("data-fileName", rData).show();

				$("#uploadedDiv").append(div);
				div.show();				
			} // ajax success : function(rData)
		}); // $.ajax()
	});// $("#uploadDiv").on("drop", function(e))
	
	// 첨부파일 삭제 링크
	$(document).on("click",".uploadedItem > a", function(e) {
	var that = $(this);
	e.preventDefault();
	var url = "/upload/deleteAttach";
	var fileName = $(this).attr("data-fileName");
	var data = {
			"filename" : fileName,
			"type" : "recipe"
	} 
	
	$.ajax({
		"type" : "delete",
		"url" : url,
		"dataType" : "text",
		"contentType" : "application/json; charset=utf-8",
		"data" : JSON.stringify(data),
		"success" : function(rData) {
			console.log(rData);
			
			if (rData == "SUCCESS") {
				that.parent().fadeOut(1000);
			}
			
		} // success : function(rData)
	}); // $.ajax()	
  }); // $(document).on("click",".uploadedItem > a", function(e)
		  
  //대표 이벤트 지정하기 :  동적(JavaScript)으로 생성된 태그들에 대한 이벤트 -> on method
  // 1. 선택한 이미지에 대해 체크 표시 (CSS) : O 
  // 2. form에 전송할 썸네일 파일 이름 등록 하기 
  $(document).on("click", "div[class='uploadedItem'], div[class='uploadedItem newUpload']", function() {
	// console.log("this div is clicked");
	$(".uploadedItem").attr("style","");
	$(this).attr("style","border:solid 2px; border-radius:20px; padding:10px;");
	var filename = $(this).find("a").attr("data-filename");
	
	$("#mfilename").text(filename);
  });
  

		  
  // add ingredients
  $("#btnIngredients").click(function() {
	 var input = $("#ingredientDetail > ul").find('input').eq(0).clone();
	 input.attr("value","");
     $("#ingredientDetail > ul").append(input);
  });
  
  // add Recipe
  $("#btnRecipe").click(function() {
	 var input = $("#recipe > div[id=updateRecipe]").find('input').eq(0).clone();
	 input.attr("value","");
     $("#recipe > div[id=updateRecipe]").append(input);
  });
  
  $("#btnRecipeDelete").click(function(){
	  $("#deleteConfirmationModal").modal("show");
  });
  $("#confirmDeleteButton").click(function() {
	 	var url = "/recipe/recipeDelete/${mno}";
	 	$.ajax({
			"type" : "get",
			"url" : url,
			"success" : function() {
		  		$("#deleteConfirmationModal .modal-body").text("삭제가 완료되었습니다. 2초후 레시피페이지로 이동합니다.");
                // 2초 후에 모달 창 닫기 및 리다이렉트
                $("#confirmDeleteButton").hide();
                setTimeout(function() {
                    $("#deleteConfirmationModal").modal("hide");
                    window.location.href = "/recipe/recipeList"; 
                }, 2000);
			}, 
		 	"error": function(error) {
	            console.error("레시피 삭제 중 오류 발생: ", error);
	        }
		}); // $.ajax()	
  });
  $("#btnReturnRecipe").click(function(){
	 window.location.href = "/recipe/recipeList"; 
  });
  
	
}); // $(function()
</script>
</head>

<script>
$(function() {
	$(".carousel-control-prev").click(function() {
		console.log("prev");	
	});
	
	$(".carousel-control-next").click(function() {
		console.log("next");	
	});
});
</script>

<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	
	<!-- 1 개 Wrapper - 4 개 Div -->
	<div id="recipeDetailWrapper">
		<div id="recipeDetail">
		
			<div id="title">
				-이름-
				<div id="titleName">${recipeDetail.recipeTitle}</div>	
			</div>
			
			<hr>
			
			<div id="comment" style="display:none;">
				<div>한 줄 평</div> 
				<input type="text" id="recipeComment" name="recipeComment" value="${recipeDetail.recipeComment}">
			</div>
			
			<hr>	
		
			<div id="picture">
				<c:forEach var="filename" items="${recipeDetail.filenames}">
					<img src="/upload/displayImage?filePath=${filename}&type=recipe">
					<a class="delete-link" href="#" style="display:none;">&times;</a>
				</c:forEach>
			</div>
			
			<!-- 수정 시 이미 DB에 존재하는 파일들 추가되는 영역 -->
			<div id="existedImgDiv">
			
			</div>
			
			<!-- 이미지 업로드 구역 시작 -->
			<div id="uploadDiv" style="display: none">       <!-- 이미지 업로드 구역 -->
				<a id="uploadText">파일 첨부</a>
			</div>    
			
			<div id="uploadedItem" style="display:none;">
				<img src="/images/default.png" height="100%"><br>
				<span id="mfilename" style="display:none;"></span>
				<span>default</span>
				<a class="delete-link" href="#" style="display:none;">&times;</a>
			</div>
			
			<!-- append 되는 영역 -->
			<div id="uploadedDiv">     
				
			</div>
			
			<!-- 이미지 업로드 구역 끝 -->

			<hr>
		
			<div id="ingredient" class="detail-element">
				재료
				<div id="ingredientDetail">
					<ul>
						<c:forEach var="ingredient" items="${recipeDetail.ingredients}">
							<li>${ingredient}</li>
						</c:forEach>
					</ul>
					
					<div>
						<button id="btnIngredients" type="button" 
						class="btn btn-success" style="display:none;">재료 추가</button>
					</div>
				</div>
			</div>
		
			<hr>
			
			<div id="recipe" class="detail-element">
			
				순서

				<div id="carouselExampleControls" class="carousel slide" data-bs-touch="false" data-bs-interval="false">
					
					<div class="carousel-inner">
					
						<c:forEach var="recipe" items="${recipeDetail.recipe}" varStatus="vs">
						<c:choose>
							<c:when test="${vs.count == 1}">
								<div class="carousel-item active">
							</c:when>
							<c:otherwise>
								<div class="carousel-item">	
							</c:otherwise>
						</c:choose>
									${vs.count}. ${recipe}
								</div>
						</c:forEach>
					</div>

					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>

					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
				<!-- /Recipe Carousel -->
				<div id="updateRecipe">
					
				</div>
				<div>
					<button id="btnRecipe" type="button" 
					class="btn btn-success" style="display:none;">순서 추가</button>
				</div>
			</div>
			
			<hr> 
			
			<div class="d-grid gap-2">
					<c:if test="${id == 'admin11'}">
<!-- 						<button id="btnRecipeUpdate" class="btn btn-primary" type="button">레시피 수정하기</button> -->
						<button id="btnRecipeDelete" class="btn btn-primary" type="button">레시피 삭제</button>
					</c:if>
					<button id="btnReturnRecipe" class="btn btn-primary" type="button">돌아가기</button>					
			</div>
		</div>		
		<!-- 게시글 삭제 확인 모달 -->
		<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="deleteConfirmationModalLabel">게시글 삭제 확인</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
		      </div>
		      <div class="modal-body">
		        해당 게시글을 삭제하시겠습니까?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-danger" id="confirmDeleteButton">삭제</button>
		      </div>
		    </div>
		  </div>
		</div>

		<div id="space">
		
		</div>
	
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>