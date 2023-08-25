<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="index" value="0" scope="page"></c:set>

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
          font-family: 'orbit', sans-serif;
        background-color:bg-info-subtle;
     }
  
     h1, h2, h3, p, span {
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
         height:45vh;
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
      
      #divSearchInput {
         display:flex;
         justify-content:center;
         margin-left:5px;
         margin-right:5px;
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
      
      .listItem img {
         width:300px;
         height:300px;
      }
      
      .itemTextDiv {
         
      }
      
      /* pagingDiv */
      #pagingDiv {
         display:flex;
         justify-content:center;
      }
      
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script> 
    $(function() {
    	
    	$("#openVideoModal").click(function() {
    	      $("#videoModal").modal("show");
   	    });
    	$("#openVideoModal2").click(function() {
    	      $("#videoModal2").modal("show");
   	    });
       
       // 레시피 공유하기 버튼
        $("#btnAddRecipe").click(function() {
           location.href = "/recipe/addRecipe";
        });
       
       function getSearchingState() {
          // 1. 카테고리 
          // 1-1. 온도 ( Radio Box )
          if(${pagingDto.temp == 'H'}) {
             $("#hot").prop("checked", true);
          } else if(${pagingDto.temp == 'I'}) {
             $("#ice").prop("checked", true);
          }
          
          // 1-2 . 카테고리 ( Check box - latte, syrub, cream, fruit, alcohol )
          if(${pagingDto.latte == 'Y'}) {
             $("#latte").prop("checked", true);
          } else if (${pagingDto.latte == 'N'}) {
             $("#latte").prop("checked", false);   
          }
          
          if(${pagingDto.syrub == 'Y'}) {
             $("#syrub").prop("checked", true);
          } else if (${pagingDto.syrub == 'N'}) {
             $("#syrub").prop("checked", false);   
          }
          
          if(${pagingDto.alcohol == 'Y'}) {
             $("#alcohol").prop("checked", true);
          } else if (${pagingDto.alcohol == 'N'}) {
             $("#alcohol").prop("checked", false);   
          }
          
          if(${pagingDto.fruit == 'Y'}) {
             $("#fruit").prop("checked",true);
          } else if (${pagingDto.fruit == 'N'}) {
             $("#fruit").prop("checked", false);   
          }
          
          if(${pagingDto.cream == 'Y'}) {
             $("#cream").prop("checked",true);
          } else if (${pagingDto.cream == 'N'}) {
             $("#cream").prop("checked", false);   
          }

          // 2. 제목, 제목 + 내용, 내용, 검색어
          // 유지된 검색 조건에 대한 표시
          var condText = "";
          
          if (${pagingDto.searchType == 't'}) {
             condText = "제목";
          } else if (${pagingDto.searchType == 'c'}) {
             condText = "내용";
          } else if (${pagingDto.searchType == 'tc'}) {
             condText = "제목 + 내용";
          } else {
             condText = "제목";
          }
          
          $("#btnSearchType").text(condText);
          $("#inputKeyword").val("${pagingDto.keyword}");
          $("#searchType").attr("value", "${pagingDto.searchType}");
       }
       
       getSearchingState();
       
       // 검색 조건 
       $(".dropdown-item").click(function() {
          var searchType = $(this).text();
          
          // console.log("searchType : ", searchType);
          // 1. 시각적으로 표시
          $("#btnSearchType").text(searchType);
          
          // 2. form의 input type hidden에 넣기
          $("#searchType").attr("value",$(this).attr("data-type"));
       });
       
       // 검색 조건 유지한 채로 다른 page 이동
       $(".page-link").click(function(e) {
          e.preventDefault();
          var url = "/recipe/recipeList"
          var page = $(this).attr("data-page");
          var searchType = "${pagingDto.searchType}";
          var keyword = "${pagingDto.keyword}";
          
          url += ("?" + "page=" + page);
          url += ("&" + "searchType=" + searchType);
          url += ("&" + "keyword=" + keyword);
          
          // console.log(url);
          
          location.href = url;
       });
       
       // 검색 버튼 (카테고리, 검색어)
       $("#btnSearch").click(function() {
          var form = $("#formSearch");
          var categories = "";
          
          // 1. temp
          var temp = $("input[name='temp']:checked").val();
          categories += (temp + " ");   
          
          // form.append($('<input type="hidden" value="' + temp + '" name=categories>'));
          
          var cond = "";
          
          // 2. latte ~ cream ( latte, syrub, alcohol, fruit, cream )
          $("input[name='categories']").each(function() {
             // console.log($(this).val());
             if ($(this).prop("checked") == true) {
                 cond = "Y";
                 categories += ($(this).val() + " ");
              } else {
                 cond = "N";   
              }
             
             // form.append($('<input type="hidden" value="' + cond + '" name=categories>'));
             
          });
          
          
          form.append($('<input type="hidden" value="' + categories + '" name=categories>'));
          form.submit();
       });
    
     });
  </script>
<body>
   <div id="recipeListWrapper">
      <%@ include file="/WEB-INF/views/include/nav.jsp" %>

      <!-- searchDiv -->
      <div class="container-fluid">
         <div class="row bg-secondary-subtle">
            <div class="col-md-12">
               <div id="divSearch" class="jumbotron">
                  <h1>레시피 상세 검색</h1>
<!--                   <h3>제외 하고 싶은 카테고리의 버튼을 off해주세요.</h3> -->

                  <!-- div : radio box -->
                  <div id="divRadio" class="btn-group" role="group"
                     aria-label="Basic radio toggle button group">
                     <input type="radio" class="btn-check" name="temp" value="H"
                           id="hot" autocomplete="off" checked> 
                     <label class="btn btn-outline-primary" for="hot">Hot</label> 
                     <input type="radio" class="btn-check" name="temp" value="I"
                           id="ice" autocomplete="off"> 
                     <label class="btn btn-outline-primary" for="ice">Ice</label>
                  </div>
	
                  <!-- div : check box -->
                  <div id="divCheckbox" class="btn-group" role="group"
                     aria-label="Basic checkbox toggle button group" style="display:none;">
                     
                     <input type="checkbox" class="btn-check" id="latte" name="categories"
                           autocomplete="off" value="latte" checked> 
                     <label class="btn btn-outline-primary" for="latte">라떼</label>
                      
                     <input type="checkbox" class="btn-check" id="syrub" name="categories"
                           autocomplete="off" value="syrub" checked> 
                     <label class="btn btn-outline-primary" for="syrub">시럽</label>
                      
                     <input type="checkbox" class="btn-check" id="alcohol" name="categories"
                           autocomplete="off" value="alcohol" checked> 
                     <label class="btn btn-outline-primary" for="alcohol">알코올</label>
                      
                     <input type="checkbox" class="btn-check" id="fruit" name="categories"
                           autocomplete="off" value="fruit" checked> 
                     <label class="btn btn-outline-primary" for="fruit">과일</label>
                      
                     <input type="checkbox" class="btn-check" id="cream" name="categories"
                           autocomplete="off" value="cream" checked> 
                     <label class="btn btn-outline-primary" for="cream">크림</label> 
                     
                  </div>

                  <!-- div : search input -->
                  <div id="divSearchInput">
                     <div class="dropdown">
                       <button id="btnSearchType" class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                         제목 
                       </button>
                       <ul class="dropdown-menu">
                         <li><a class="dropdown-item" href="#" data-type="t">제목</a></li>
                         <li><a class="dropdown-item" href="#" data-type="c">내용</a></li>
                         <li><a class="dropdown-item" href="#" data-type="tc">제목 + 내용</a></li>
                       </ul>
                     </div>
                                    
                     <form id ="formSearch" class="d-flex" role="search" action="/recipe/recipeList" method="get">
                        <!-- default SearchType : 제목 ( t )  -->
                        <input type="hidden" id="searchType" name="searchType" value="t">
                        
                        <input id="inputKeyword" class="form-control me-2" type="search"
                              name="keyword" placeholder="Search" aria-label="Search">
                        <button id="btnSearch" class="btn btn-outline-success" type="button">Search</button>
                        
                     </form>
                  </div>
                  
                  <!-- shareRecipe  -->
                  <div id="shareRecipe">
                     <button id="btnAddRecipe" type="button" class="btn btn-success">레시피 공유하기</button>
                  </div>
                  <p>레시피 활용에 도움되는 정보들!</p>
	               <button id="openVideoModal" type="button" class="btn btn-dark">우유 스티밍 강의 영상보기(유튜브)</button>
	               <button id="openVideoModal2" type="button" class="btn btn-dark">밀크 베버리지 영상보기(유튜브)</button>
                  <!-- /shareRecipe  -->

               </div>
            </div>
         </div>
      </div>
      <!-- /searchDiv -->
   
      <!-- recipeListDiv -->
      <!-- 들어오는 ${recipeList}의 갯수에 따라서 for:each로 조절  -->
      <div id="recipeListDiv" >   
         <c:forEach var="row" begin="0" end="${rowNum - 1}" step="1">
         
         <div class="row itemRow">
            <c:forEach var="col" begin="${rowNum * row}" end="${rowNum * row + 2}" step="1">
            <c:if test="${col <= pagingDto.endRow - pagingDto.startRow}">
            <div class="col-4 listItem">
               <a href="/recipe/recipeDetail?mno=${menuList[col].mno}"><img alt="espresso" src="/upload/displayImage?filePath=${menuList[col].mfilename}&type=recipe"></a>
               <span>${menuList[col].mname}</span>
               <span>${menuList[col].mdesc}</span>
            </div>
            </c:if>
            </c:forEach>   
         </div>
         </c:forEach>
      </div>
      <!-- /recipeListDiv -->
      
      <!-- default : 1번 페이지가 선택된 상태 -->
      <div id="pagingDiv" aria-label="Page navigation example">
         <ul class="pagination">
         
            <c:if test="${pagingDto.startPage ne 1}"> 
            <li class="page-item"><a class="page-link" href="#" data-page="${pagingDto.startPage - 1}"
               aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
            </a></li>
            </c:if>
            
            <c:forEach var="page" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
            <c:choose>
               <c:when test="${page == pagingDto.page}">
               <li class="page-item active">
               </c:when>
               <c:otherwise>
               <li class="page-item">   
               </c:otherwise>
            </c:choose>
            <a class="page-link" href="#" data-page="${page}">${page}</a></li>   
            </c:forEach>
            
            <c:if test="${pagingDto.endPage lt pagingDto.totalPage}"> 
            <li class="page-item"><a class="page-link" href="#" data-page="${pagingDto.endPage + 1}"
               aria-label="Next"> <span aria-hidden="true">&raquo;</span>
            </a></li>
            </c:if>
            
         </ul>
      </div>
   </div>
   <!--  유튜브 모달 창 -->
	<div class="modal fade" id="videoModal" tabindex="-1" aria-labelledby="videoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="videoModalLabel">우유 스티밍</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <!-- 여기에 유튜브 영상을 포함할 iframe을 추가합니다. -->
	        <iframe id="ytPlayer" width="100%" height="400" src="https://www.youtube.com/embed/P-R_ubMGoTQ?si=9HMd3Z9E-TzoHtaI" frameborder="0" allowfullscreen></iframe>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="modal fade" id="videoModal2" tabindex="-1" aria-labelledby="videoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="videoModalLabel">밀크 베버리지 종류</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <!-- 여기에 유튜브 영상을 포함할 iframe을 추가합니다. -->
	        <iframe id="ytPlayer" width="100%" height="400" src="https://www.youtube.com/embed/UQgfm2csYmk?si=o9HXTu22-Qpjhg6h" frameborder="0"></iframe>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous"></script>
</body>
</html>