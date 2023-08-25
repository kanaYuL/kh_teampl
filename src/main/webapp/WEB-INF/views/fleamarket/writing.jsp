<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>fleaMarketWriting.jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/8398f84275.js" crossorigin="anonymous"></script>
   
   <!-- orbit 폰트 -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">
   
   <script src="https://code.jquery.com/jquery-3.4.1.js"></script>      <!-- 제이쿼리 사용을 위한 스크립트 -->
   <script src="/js/utilscript.js"></script>       <!-- 올린 이미지 사진인지 아닌지 판명 코드 모음 (js) -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=248000df0b25ebaf18e3e9e0aba4e3c0"></script>
   
   <script>
   $(function() {
      $("#uploadDiv").on("dragenter dragover", function(e) {
         e.preventDefault();
      });
      
      $("#uploadDiv").on("drop", function(e) {
         e.preventDefault();
         console.log(e);
         var file = e.originalEvent.dataTransfer.files[0];
         console.log(file);
         // <form enctype="multipart/form-data" action="/upload/uploadFile">
         //    <input type="file" name="file">
         // </form>
         var formData = new FormData();  // HTML5에서 새로 생김
         formData.append("file", file);
         formData.append("type", "market");
         url = "/upload/uploadFile";
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
               var fileName = rData.substring(rData.indexOf("_") + 1);
               div.find("span").text(fileName);
               
               if (isImage(fileName)) {
                  var thumbnail = getThumbnailName(rData);
                  div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail + "&type=market");
               }
               
               div.find("a").attr("data-fileName", rData);

               $("#uploadedDiv").append(div);
               div.show();
               imgFlag = 1;
            }
         });
         
      });
      
      // 첨부파일 삭제 링크
      $("#uploadedDiv").on("click", "div > a", function(e) {
         var that = $(this);
         e.preventDefault();
         console.log("x");
         var url = "/upload/deleteFile";
         var fileName = $(this).attr("data-fileName"); 
         
         $.ajax({
            "type" : "delete",
            "url" : url,
            "dataType" : "text",
            "data" : fileName,
            "success" : function(rData) {
               console.log(rData);
               
               if (rData == "SUCCESS") {
                  that.parent().fadeOut(1000);
               }
               
            }
         });
         
      });
      
      var index = 0;
      var imgFlag = 0;
      //폼 전송
      $("#myform").submit(function() {
         if(imgFlag == 0){
//             alert("nope");
//             console.log("hihi");
            $("#plzimg").fadeIn();
            return false;
         }
//          var as = $("#uploadedItem a");
//          for(var v = 0; v <as.length; v++) {}
         else if(imgFlag == 1){
            $("#plzimg").fadeOut();
            $(".uploadedItem a").each(function() {
               var fullname = $(this).attr("data-fileName")
               console.log(fullname);
               var inputTag = "<input type='hidden' ";
               inputTag += " name='filename[" + (index++) + "]'";
               inputTag += " value='" + fullname + "'>";
               $("#myform").prepend(inputTag);
            });
   //           return false;  // 전송을 하지 않음
            return true;
         }
      });
      
      
   });
   
   
   
   
   
   </script>
   
   
<style>
	body{
          font-family: 'orbit', sans-serif;
       }
   /* navbar 시작 */
   #divNav {
      display:flex;
      flex-direction:row;
      justify-content: space-between;
   }
   
   nav {
      height: 10vh;
      margin: auto 10px;
   }
   /* navbar 끝 */
   
   /* 플리마켓 게시판 글 상세 보기 */
   .mainTitle {
      text-align: center;
      margin-top: 10px;
      margin-left: 30px;
      margin-bottom: 10px;
      font-family: 'Orbit', sans-serif;
   }
   
   /* 글 내용 시작 */
   .contextDiv {
      margin-top: 30px;
      margin-bottom: 50px;
   }
   
   #mbcontents {
      height:100px;
   }
   /* 글 내용 끝 */
   
   /* 등록, 취소 버튼 Div */
   #writingAndCencelBtnDiv {
      text-align: right;
   }
   
   /* 파일 업로드용 Div */
   #uploadDiv {
      width: 85%;
      height: 150px;
      background-color: #DEDEDE; 
      margin: 20px auto;
      border: 2px dashed blue;
   }
   
   /* 파일 업로드용 div 속 글자 */
   #uploadText {
      display:flex;
         flex-direction:column;
         align-items: center;
         margin-top: 60px;
   }
   
   /* 업로드된 파일 */
   .uploadedItem {
      display: none;
      float: left;
      width: 150px;
   }
   
   /* 게시판 항목 선택 */
   #searchType {
      margin-bottom: 10px;
      margin-left: 20px;
   }
   
   /* 작성자Div */
   #writerDiv {
      margin-top:20px;
   }
   /* 내용입력  */

   /* 글목록 버튼 */
   #writingList {
      margin-top: 20px;
   }
   
</style>
      
</head>
<body>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
   <%@ include file="/WEB-INF/views/include/nav.jsp" %>
<div class="container-fluid">
   <div class="col-md-12">
      <div class="row">
         <div class="col-md-2"></div>    <!-- 왼쪽 공백 -->
                  
         <div class=" col-md-8">
         
            <div class="mainTitle">
               <h2>
                  플리마켓 게시판 글쓰기
               </h2>
               
               <a class="btn btn-success" href="/fleamarket/fleaMarket" id="writingList">
                  글목록
               </a>
               
            </div> 
            
            
            <div class="col-md-12">
               <div class="row">
                   <form id="myform" role="form" action="/fleamarket/writing" method="post">
                   
                        <!-- 게시판 항목 선택 시작 -->
                     <div class="col-md-12" id="searchType">
                        <select name="mbcategories" id="mbcategories">
                           <option selected="selected" value="E">항목을 선택해 주세요</option>
                           <option value="B">원두</option>
                           <option value="G">글라인더</option>
                           <option value="S">시럽</option>
                           <option value="E">기타</option>
                        </select> 
                        <p class="fs-6" style="color:#9e9e9e;">고르지 않으면 '기타'항목으로 적용됩니다.</p>
                     </div>
                     <!-- 게시판 항목 선택 끝 -->
                     
                     
                     <!-- 제목 -->
                     <div class="form-group">
                        <label for="mbtitle">제목</label> 
                        <input type="text" class="form-control" id="mbtitle" name="mbtitle"
                           value="${marketboardVo.mbtitle}">
                     </div>
                     <!-- // 제목 -->
                     
                     <!-- 내용 -->
                     <div class="contextDiv">
                        <label for="mbcontents">내용</label>
                        <textarea class="form-control" id="mbcontents" name="mbcontents">
                           ${marketboardVo.mbcontents}
                        </textarea>
                     </div>
                     <!-- // 내용 -->
                     
                     <!-- 이미지 업로드 구역 시작 -->
                     <div id="uploadDiv">       <!-- 이미지 업로드 구역 (노란색 네모) -->
                        <a id="uploadText">업로드할 파일을 안쪽으로 드래그해서 가져오세요.</a>
                     </div>    
                  
                     <div class="alert alert-primary" role="alert" id="plzimg" style="display:none;">
                        1장이상의 사진을 등록하여야 합니다.
                     </div>
                     <br>
               
                     <div id="uploadedItem" style="display:none;">
                        <img src="/images/default.png" height="100"><br>
                        <span>default</span>
                        <a href="#">&times;</a>
                     </div>
                     
                     
                     <div id="uploadedDiv">      <!-- 업로드된 이미지 표시구역 -->
                     
                     </div>
                           <!-- 이미지 업로드 구역 끝 -->
                      <!-- 지도div	 -->      
				    <div id="map" style="width:500px;height:400px;"></div>  
				    <p><em>지도를 클릭해주세요!</em></p> 
					<div id="clickLatlng"></div> 	
                     
                     <div id="writingAndCencelBtnDiv">
                        <button type="submit" class="btn btn-primary" style="margin-top: 30px;">
                           등록하기
                        </button>
                     
                        <a href="/fleamarket/fleaMarket" class="btn btn-success" style="margin-top: 30px;">
                           취소
                        </a>
                     </div>
                        
                  </form>
               </div>
               
            </div>
               
            <div class="col-md-2"></div>    <!-- 오른쪽 공백 -->
            
         </div>
         
         
      </div>
   </div>
</div>
<script>
	   var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	   var options = { //지도를 생성할 때 필요한 기본 옵션
	   	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	   	level: 3 //지도의 레벨(확대, 축소 정도)
	   };
	
	   var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	   // 지도를 클릭한 위치에 표출할 마커입니다
	   var marker = new kakao.maps.Marker({ 
	       // 지도 중심좌표에 마커를 생성합니다 
	       position: map.getCenter() 
	   }); 
	   // 지도에 마커를 표시합니다
	   marker.setMap(map);
	   
	   kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = message;
		    
		});
  </script>


</body>
</html>