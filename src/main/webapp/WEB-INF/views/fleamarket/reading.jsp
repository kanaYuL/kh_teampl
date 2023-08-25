<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>fleaMarketReading.jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/8398f84275.js" crossorigin="anonymous"></script>
   <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
   
   <script src="/js/utilscript.js"></script>
   <script src="/js/myscript.js"></script>
   
   
   <!-- orbit 폰트 -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<script>
$(function() {
      
   // 첨부파일 보이게 하기
   $.getJSON("/fleamarket/getAttachList/${marketboardVo.mbno}", function(rData) {
      $.each(rData, function(i) {     // rData - 배열 [파일명, 파일명, ....]
      
         var div = $("#uploadedItem").clone();
         div.removeAttr("id");
         div.addClass("uploadedItem");
         
         var fileName = rData[i].substring(rData[i].indexOf("_") + 1);
         div.find("span").attr("style", "display:none;");
         
         if (isImage(fileName)) {
            var thumbnail = getThumbnailName(rData[i]);
            div.find("img").attr("src", "/upload/displayImage?filePath=" + rData[i] +"&type=market");
         }
         
         div.find("a").attr("data-fileName", rData[i]);
         var filename = div.find("a").attr("data-fileName");
         // console.log(div.find("a"));
         
         $("#existedImgDiv").append(div);
         
         div.show();   
      });
      
   });   
   
   // 
   // 첨부파일 삭제 링크
   $("#uploadedDiv").on("click", "div > a", function(e) {
      var that = $(this);
      e.preventDefault();
      var url = "/upload/deleteFile?type=market";
      var fileName = $(this).attr("data-fileName"); 
      
      $.ajax({
         "type" : "delete",
         "url" : url,
         "dataType" : "text",
         "data" : fileName,
         "success" : function(rData) {
            
            if (rData == "SUCCESS") {
               that.parent().fadeOut(1000);
            }
            
         }
      }); // ajax   
   });
   
   // 수정해야 할 것 
   // 첨부파일 삭제 링크
      $(document).on("click",".uploadedItem > a",function(e) {
      var that = $(this);
      e.preventDefault();
      var url = "/upload/deleteAttach";
      var fileName = $(this).attr("data-fileName");
      var data = {
            "filename" : fileName,
            "type" : "market"
      } 
      
      $.ajax({
         
         "type" : "delete",
         "url" : url,
         "dataType" : "text",
         "contentType" : "application/json; charset=utf-8",
         "data" : JSON.stringify(data),
         "success" : function(rData) {
            if (rData == "SUCCESS") {
               that.parent().fadeOut(1000);
            }
            
         }
      }); // ajax   
   });
      
      
   // 글 수정 버튼
   $("#btnModify").click(function() {
      //$(".readonly").prop("readonly", false);
      $("#contextArea").attr("readonly",false);
      $("#titleInput").attr("readonly", false);
      $("#btnModifyFinish").fadeIn(1000);
      $("#uploadDiv").fadeIn(1000);
      $("#ctgInput").hide();
      $("#ctgList").show();
      
      $(this).fadeOut(1000);
      
      // 첨부파일 삭제링크x
      // .uploadedItem 에 <a href="#">&times</a>
      $(".uploadedItem").each(function() {     // 삭제링크x 보이게 하는 방법1
         $(this).find("a").show();
      });
      
      
      // 좋아요(하트)를 눌렀을 때
   $("#likeHeart").click(function() {
      var that = $(this);
      var url = "";
      
      if (likeResult == "true") {
         url = "/like/deleteLike/${marketboardVo.mbno}";
      } else {
         url = "/like/addLike/${marketboardVo.mbno}";
      }
      
      $.post(url, function(rData) {
         
         if (rData == "true") {
            var likeCount = parseInt($("#likeCount").text());
            var color = "";
            
            if (likeResult == "true") {
               color = "black";
               likeResult = "false";
               likeCount--;
            } else {
               color = "red";
               likeResult = "true";
               likeCount++;
            }
            
            $("#likeHeart").css("color", color);
            $("#likeCount").text(likeCount);
         }
      });
   });
      
      
      // 업로드된 파일   
      $("#uploadedDiv").on("click", "a", function(e) {
         e.preventDefault();
         var that = $(this);
         var filename = that.attr("data-filename");
         var url = "/upload/deleteAttach?type='market'";
         $.ajax({
            "type" : "delete",
            "url" : url,
            "data" : filename,
            "dataType" : "text",
            "success" : function(rData) {
               if (rData == "SUCCESS") {
                  that.parent().remove();     // 여기서 $(this)는 $.ajax({})의 {}이다.
               }
               
            }
         });
         
      });
      
      $("#uploadDiv").show();      // 업로드 창 보이게 하기
      
   });      // 글 수정버튼 end
   
   // 노란 내모상자에 첨부파일 드래그시 자동 오픈 방지
   $("#uploadDiv").on("dragenter, dragover", function(e) {
      e.preventDefault();
   });
   
   // 첨부파일 업로드
   $("#uploadDiv").on("drop", function(e) {
      e.preventDefault();
      var file = e.originalEvent.dataTransfer.files[0];
      var formData = new FormData();  // HTML5에서 새로 생김
      formData.append("file", file);
      
      url = "/upload/uploadFile?type=market";
      
      $.ajax({
         "type" : "post",
         "processData" : false,   // ?a=b&c=d (x)
         "contentType" : false,  // application/x-www-form-urlencoded (x)
         "url" : url,
         "data" : formData,
         "success" : function(rData) {
            var div = $("#uploadedItem").clone();
            div.removeAttr("id");
            div.addClass("uploadedItem");
            div.addClass("newUpload");
            var fileName = rData.substring(rData.indexOf("_") + 1);
            div.find("span").text(fileName);
            
            if (isImage(fileName)) {
               var thumbnail = getThumbnailName(rData);
               div.find("img").attr("src", "/upload/displayImage?filePath=" + thumbnail + "&type=market");
            }
            
            div.find("a").attr("data-fileName", rData).show();

            $("#uploadedDiv").append(div);
            div.show();
            
         }
      });
      
   });
   
   
   // 댓글 목록
   function getReplyList() {
      $.get("/reply/list/${marketboardVo.mbno}", function(rData) {
         $.each(rData, function() {
            var tr = $("#replyList").find("tr").eq(0).clone();
            var tds = tr.find("td");
            tds.eq(0).text(this.mbrno);
            tds.eq(1).find("span").text(this.mbrcontents);
            tds.eq(2).find("span").text(this.mbrwriter);
            tds.eq(3).text(toDataString(this.regdate));
            tds.eq(4).text(toDataString(this.updatedate));
            
            if ("${userInfo.id}" != this.mbrwriter) {
               // 수정
               tds.eq(5).empty();
            
               // 삭제
               tds.eq(6).empty();
            }
            
            $("#replyList").append(tr);
            tr.fadeIn(1000);
         });
      });
   }

   getReplyList();
   
   // 댓글 입력 버튼
   $("#btnReplyWrite").click(function() {
      var url = "/reply/insert";
      var data = {
         "mbno" : "${marketboardVo.mbno}",
         "mbrcontents" : $("#replytext").val()
      };
      $.ajax({
         "type" : "post",
         "url" : url,
         "headers" : {
            "Content-Type" : "application/json",
            "X-HTTP-Method-Override" : "post"
         },
         "dataType" : "text",
         "data" : JSON.stringify(data),
         "success" : function(rData) {
            if (rData == "success") {
               $("#replyList").find("tr:gt(0)").remove(); // 현재 표시된 리스트 지우기
               getReplyList(); // 리스트 다시 출력
            }

         }
      });
   });

   // 댓글 수정 버튼
   $("#replyList").on(
         "click",
         ".btn-reply-update",
         function() {
            $(".btn-reply-update").show();
            $(".btn-reply-updateFinish").hide();
            $(".hideSpan").show();

            var mbrcontentsTemp = $("#mbrcontentsTemp");
            var tdmbrcontents = $(this).parent().parent().find("td")
                  .eq(1).find("span");
            var mbrcontents = tdmbrcontents.text().trim();
            
            mbrcontentsTemp.val(mbrcontents);
            tdmbrcontents.hide();
            tdmbrcontents.parent().append(mbrcontentsTemp);
            mbrcontentsTemp.show();

            $(this).hide(); // 수정 버튼 숨기기
            $(this).next().show(); // (수정)완료 버튼 보이게 하기
            
         });
      

   // 댓글 수정 완료 버튼
   $("#replyList").on(
         "click",
         ".btn-reply-updateFinish",
         function() {
            var that = $(this);
            var mbrno = that.parent().parent().find("td").eq(0).text().trim();
            var mbrcontents = $("#mbrcontentsTemp").val().trim();
            var mbrwriter = that.parent().parent().find("td").eq(2).text().trim();
            
            var sData = {
               "mbrno" : parseInt(mbrno),
               "mbrcontents" : mbrcontents,
               "mbrwriter" : mbrwriter
            };
            
            var url = "/reply/update";
            $.ajax({
               "type" : "patch",
               "url" : url,
               "headers" : {
                  "Content-Type" : "application/json",
                  "X-HTTP-Method-Override" : "patch"
               },
               "dataType" : "text",
               "data" : JSON.stringify(sData),
               "success" : function(rData) {
                              console.log("rData", rData);
                              console.log("parseInt(rData)", parseInt(rData));
                              console.log("parseFloat(rData)", parseFloat(rData));
                  if (rData) {
                     var updatedate = toDataString(parseInt(rData));
                     that.parent().prev().text(updatedate);
                     
                     var mbrcontentsTemp = $("#mbrcontentsTemp");
                     var tdmbrcontents = that.parent().parent().find(
                           "td").eq(1);
                     tdmbrcontents.text(mbrcontentsTemp.val());
                     
                     mbrcontentsTemp.val("").hide();
                     $("#replyTempDiv").append(mbrcontentsTemp);
                     
                     that.hide();
                     that.prev().show();
                     
                     $("#replyList").find("tr:gt(0)").remove(); // 현재 표시된 리스트 지우기
                     getReplyList(); // 리스트 다시 출력
                  }
               }
            });
         });
   
   
   // 댓글 삭제 버튼
   $("#replyList").on("click", ".btn-reply-delete", function() {
      
      var that = $(this);
      var mbrno = $(this).parent().parent().find("td").eq(0).text();
      var url = "/reply/delete/" + mbrno + "/${marketboardVo.mbno}";
      $.ajax({
         "type" : "delete",
         "url"  : url,
         "headers" : {
            "X-HTTP-Method-Override" : "delete"
         },
         "success" : function(rData) {
            that.parent().parent().remove();
            
         }
      });   // $.jax() 
      
   });
   
   

   // 폼전송
   $("#myform").submit(function(i) {
      
      // $.each(배열, function(){});
      $(".newUpload").each(function(i) {
         var filename = $(this).find("a").attr("data-fileName");
         var inputTag = "<input type='hidden' ";
         inputTag += " name='filename[" + i + "]'";
         inputTag += " value='" + filename + "'>";
         $("#myform").prepend(inputTag);
         
      });
      //return false;      // 폼전송을 하지 않음

   });

   $("#likeHeartNo").click(function(){
      var that = $(this);
      var count = $("#likeCount").text();
      var data = {
            "mbno" : "${marketboardVo.mbno}"
      }
      var url = "/like/plus";
      //console.log(data);
      $.ajax({
         "url" : url,
         "type" : "get",
         "data" : data,
         "dataType": "text",
         "success" : function(){
            //console.log("good");
            //that.attr("style","font-size:48px;color:#3399EE; cursor:pointer;");
            that.hide();
            $("#likeHeartYes").show();
            //$("#likeCount").text(count++);
            setLike();
         }
      });
   });
   $("#likeHeartYes").click(function(){
      var that = $(this);
      var count = $("#likeCount").text();
      var data = {
            "mbno" : "${marketboardVo.mbno}"
      }
      var url = "/like/cancel";
      $.ajax({
         "url" : url,
         "type" : "get",
         "data" : data,
         "dataType": "text",
         "success" : function(){
            that.hide();
            $("#likeHeartNo").show();
            //$("#likeCount").text(count--);
            setLike();
         }
      });
   });
   function setLike(){
      var url = "/like/set";
      var that = $("#likeHeartNo");
      var data = {
            "mbno" : "${marketboardVo.mbno}"
      }
      $.ajax({
         "url" : url,
         "type" : "get",
         "data" : data,
         "dataType": "text",
         "success" : function(rData){
            if(rData == "yes"){
               that.hide();
               $("#likeHeartYes").show();
            }
         }
      });
      var url2 = "/like/setCount";
      var count = $("#likeCount").text();
      $.ajax({
         "url": url2,
         "type" : "get",
         "data" : data,
         "dataType": "text",
         "success" : function(rData){
            $("#likeCount").text(rData);
         }
      });
   }
   setLike();
   function getDate(timestamp) {
       var date = new Date(timestamp);
        var year = date.getFullYear().toString().slice(-2); 
        var month = ("0" + (date.getMonth() + 1)).slice(-2); 
        var day = ("0" + date.getDate()).slice(-2); 
        var hour = ("0" + date.getHours()).slice(-2); 
        var minute = ("0" + date.getMinutes()).slice(-2); 
        var second = ("0" + date.getSeconds()).slice(-2); 
        
        var returnDate = year + "." + month + "." + day + "  " + hour + ":" + minute + ":" + second;
        return returnDate;
   }
   //dialog 새로 입력
   
   function getDialogList(id){
      var url = "/fleamarket/getDialogList";
      var data = {
         "mbno" : "${marketboardVo.mbno}",
         "attendant" : id   
      }
      $.ajax({
         "url" : url,
         "method" : "post",
         "data": JSON.stringify(data), // JSON 형태로 변환
           "dataType" : "json",
           "contentType" : "application/json; charset=utf-8",
         "success" : function(rData){
            var dialogBody = $("#dialogBody");
            
            dialogBody.empty();
                   
                   // rData를 이용하여 행을 생성하여 테이블에 추가
                   for (var i = 0; i < rData.length; i++) {
                       var marketboarddialogVo = rData[i];
                       var gettedDate = getDate(marketboarddialogVo.regdate);
                       var newRow = "";
                       if(marketboarddialogVo.drole == "seller"){
                          newRow += '<p style="text-align:left">' + marketboarddialogVo.attendant + ':</p>';
                          newRow += '<p style="text-align:left">' + marketboarddialogVo.mbdcontents + '</p>';
                       }
                       else if(marketboarddialogVo.drole == "buyer"){
                          newRow += '<p style="text-align:right">' + marketboarddialogVo.attendant + ':</p>';
                          newRow += '<p style="text-align:right">' + marketboarddialogVo.mbdcontents + '</p>';
                       }
                       dialogBody.append(newRow);
                   }
         }
      });
   }
   function getAttendantList(){
      var targetMbno = "${marketboardVo.mbno}";
      var url = "/fleamarket/getAttendantList/" + targetMbno;
      var dialogBody = $("#dialogBody");
      $.getJSON(url, function(rData) {
         dialogBody.empty();
         if(rData == ""){
            var newRow = "";
            newRow += '<p style="text-align:left">1:1 대화 내역이 없습니다.</p>';
            $("#insertDialog").hide();
            $("#insertContents").hide();
            dialogBody.append(newRow);
         }
         $.each(rData, function(i) {     // rData - 배열 [파일명, 파일명, ....]
            var newRow = "";
            newRow += '<button type="button" class="btn btn-outline-dark select" value="' + rData[i] + '">' + rData[i] +' 님과의 대화창</button>';
            dialogBody.append(newRow);
         });
         
      });
   }
   $("#dialogBody").on("click","button", function(e){
      var id = $(this).val();
      getDialogList(id);
   });
   
   $("#openDialog").click(function(){
      if("${userInfo.id}" != "${marketboardVo.mbwriter}"){
         var id = "${userInfo.id}";
         getDialogList(id);
      }
      else{
         console.log("bad");
         getAttendantList();
      }
   });
   
   $("#insertDialog").click(function(){
      var url = "/fleamarket/insertDialog";
      var contents = $("#insertContents").val();
//      console.log(contents);
      var drole = "buyer";
      if("${userInfo.id}" === "${marketboardVo.mbwriter}"){
         drole = "seller";
      }
      var data = {
                    "mbdcontents": contents, 
                    "mbno": "${marketboardVo.mbno}",
                    "drole" : drole
      }
       $.ajax({
          "url": "/fleamarket/insertDialog",
           "method" : "post",
             "data": JSON.stringify(data), // JSON 형태로 변환
           "dataType" : "json",
           "contentType" : "application/json; charset=utf-8",
           "success" : function(rData) {
              var dialogBody = $("#dialogBody");
               var contents = $("#insertContents").val();
               var reqDrole = rData.drole;
               var newRow = "";
               if(reqDrole == "seller"){
                   newRow += '<p style="text-align:left">' + "${userInfo.id}" + ':</p>';
                   newRow += '<p style="text-align:left">' + rData.mbdcontents + '</p>';
               }
               else if(reqDrole == "buyer"){
                   newRow += '<p style="text-align:right">' + "${userInfo.id}" + ':</p>';
                   newRow += '<p style="text-align:right">' + rData.mbdcontents + '</p>';
               }
               
               dialogBody.append(newRow);
               
               $("#insertContents").val("");
           },
           "error" : function(request, status, error){

             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

             }
      });
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
      margin-bottom: 30px;
      font-family: 'Orbit', sans-serif;
   }
   
   /* 수정, 삭제, 판매완료 Div */
   #updateAndDeleteBtn {
      text-align: right;
      margin: 10px 20px 100px 0px;
   }
   
   
   /*    작성자 시작 */
   #writerDiv {
      text-align: left;
   }
   
   #writerText{
      text-align: right;
   }
   
   #writerInput {
      width: 200px;
   }
   /*    작성자 끝 */
   
   /*    작성일 시작 */
   #writerdateText{
      text-align: right;
   }
   
   #writerdateInput {
      width: 200px;
   }
   /*    작성일 끝 */
   
   /* 글 제목 시작 */
   #titleDiv {
      margin-top: 20px;
      margin-bottom: 20px;
   }
   
   #titleText {
      text-align: right;
   }
   
   #titleInput{
      width: 600px;
      text-align: left;
   }
   /* 글 제목 끝 */
   
   /* 카테고리 시작 */
   #ctgText {
      text-align: right;
   }
   
   #ctgInput{
      width: 200px;
   }
   /* 글 제목 끝 */
   
   
   /* 글 내용 시작 */
   #contextDiv {
      text-align: center;
      margin: 30px 100px 20px 100px;
   }
   
   #contextArea{
      height: 100px;
   }
   /* 글 내용 끝 */
   
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
         text-align:center;
         margin-top: 60px;
   }
   
   /* 업로드된 첨부파일 Div */
   .uploadedItem {
       text-align: center;
      width:300px;
      height:300px;
      margin-top:30px;
      margin-bottom:30px;
   }
   
   /* 댓글 입력 Div */
   #replyInputDiv {
      margin: 10px 50px 0px 50px;
   }
   
   
</style>
      
    
</head>
<body>

 <%@ include file="/WEB-INF/views/include/nav.jsp" %>

<!-- 댓글 수정 input -->
<div id="replyTempDiv">
   <input type="text" class="form-control" id="mbrcontentsTemp" value=""
      style="display: none;"> 
   <input type="text" class="form-control" id="mbrwriterTemp" value="" 
      style="display: none;">
</div>
<!-- // 댓글 수정 input -->

<div class="container-fluid">
   <div class="col-md-12">
      <div class="row">
         <div class="col-md-1">
            <a></a>
         </div>      
         
         <div class="col-md-10">
            <div class="mainTitle">
               <h2>
                  &quot${marketboardVo.mbtitle}&quot 글 상세보기
               </h2>
               
               <a class="btn btn-success" href="/fleamarket/fleaMarket" id="writingList">
                  글목록
               </a>
            </div> 
            <c:if test="${not empty marketboardVo.solddate}">
               <div class="alert alert-primary" role="alert" id="soldout" style="">
                  판매완료된 글입니다.
               </div>
               <br>
            </c:if> 
            <div>
               <form id="myform" role="form" action="/fleamarket/update" method="post">
                  <input type="hidden" value="${marketboardVo.mbno}" name="mbno">
                  
                     <!-- 로그인하면 자동으로 작성자 정해짐 -->
                  <div class="col-md-12">
                     <div class="row">
                        <div class="col-md-4" id="writerDiv">
                           <label class="col-md-3" id="writerText" for="writerText">작성자:</label> 
                           <input type="text"
                              class="col-md-3 readonly" id="writerInput" name="mbwriter"
                              value="${marketboardVo.mbwriter}" readonly />
                        </div>
                        
                        <div class="col-md-4">
                           <label id="ctgText" for="ctgText">카테고리:</label> 
                           <c:if test="${marketboardVo.mbcategories == 'B'}">
                           <input type="text" class="col-md-11 readonly" id="ctgInput" name="mbcategory"
                              value="원두" readonly />
                           </c:if>
                           <c:if test="${marketboardVo.mbcategories == 'G'}">
                           <input type="text" class="col-md-11 readonly" id="ctgInput" name="mbcategory"
                              value="글라인더" readonly />
                           </c:if>
                           <c:if test="${marketboardVo.mbcategories == 'S'}">
                           <input type="text" class="col-md-11 readonly" id="ctgInput" name="mbcategory"
                              value="시럽" readonly />
                           </c:if>
                           <c:if test="${marketboardVo.mbcategories == 'E'}">
                           <input type="text" class="col-md-11 readonly" id="ctgInput" name="mbcategory"
                              value="기타" readonly />
                           </c:if>
                        <div class="col-md-4" id="ctgList" style="display:none">
                                 <select name="mbcategories" id="mbcategories">
                                    <option selected="selected" value="E">항목을 선택해 주세요</option>
                                    <option value="B">원두</option>
                                    <option value="G">글라인더</option>
                                    <option value="S">시럽</option>
                                    <option value="E">기타</option>
                                 </select> 
<!--                                  <p class="fs-6" style="color:#9e9e9e;">고르지 않으면 '기타'항목으로 적용됩니다.</p> -->
                             </div>
                        </div>
                        
                        <div class="col-md-4" id="writerDiv">
                           <label class="col-md-3" id="writerdateText" for="writerdateText" >작성일:</label> 
                           <input type="text" class="col-md-3 readonly" id="writerdateInput" readonly value="${marketboardVo.regdate }" name="regdate"/>
                        </div>
                     </div>
                  </div>
                  <!-- // 로그인하면 자동으로 작성자 정해짐 -->
                        
                  <div class="col-md-12">
                     <div class="row" id="titleDiv">
                        <label id="titleText" class="col-md-3" for="titleText">제목:</label> 
                        <input type="text" class="col-md-9 readonly" id="titleInput" name="mbtitle"
                           value="${marketboardVo.mbtitle}" readonly />
                     </div>
                  </div>
                  
                  <!-- 수정 시 이미 DB에 존재하는 파일들 추가되는 영역 -->
                  <div id="existedImgDiv">
                  
                  </div>
                                 
                  <div id="contextDiv" class="contextDiv">
                     <label id="contextText" for="contextText"></label>
                     <textarea class="form-control readonly" id="contextArea" name="mbcontents"
                        readonly>${marketboardVo.mbcontents}</textarea>
                  </div>
            
                   
                  <!-- 좋아요(하트) (미완성) -->
                  <div class="text-center">
                     <i class="fa fa-thumbs-up" style="font-size:48px;color:#aaaaaa; cursor:pointer;" id="likeHeartNo"></i>
                     <i class="fa fa-thumbs-up" style="font-size:48px;color:#3399EE; cursor:pointer; display:none;" id="likeHeartYes"></i>
                     <br><span id="likeCount">3</span>
                  </div>
                  <!-- // 좋아요(하트) (미완성) -->
               
               
                     <!-- 이미지 업로드 구역 시작 -->
                  <div id="uploadDiv" style="display: none">       <!-- 이미지 업로드 구역 (노란색 네모) -->
                     <a id="uploadText">업로드할 파일을 안쪽으로 드래그해서 가져오세요.</a>
                  </div>    
                  
                  <div id="uploadedItem" style="display:none;">
                     <img src="/images/default.png" height="100%"><br>
                     <span>default</span>
                     <a class="delete-link" href="#" style="display:none;">&times;</a>
                  </div>
                  
                  <!-- append 되는 영역 -->
                  <div id="uploadedDiv">     
                     
                  </div>
                  
                  <!-- 이미지 업로드 구역 끝 -->
               
               
               
                  <c:if test="${userInfo.id eq marketboardVo.mbwriter || userInfo.id == 'admin11'}">
                     <div id="updateAndDeleteBtn">
                        <button type="button" class="btn btn-secondary" id="btnModify">수정</button>
                        <button type="submit" class="btn btn-primary" id="btnModifyFinish"
                           style="display: none">수정완료</button>
                        <a href="/fleamarket/delete?mbno=${marketboardVo.mbno}"
                           class="btn btn-danger">삭제</a>
                        <c:if test="${empty marketboardVo.solddate}">
                           <a class="btn btn-info" id="btnSoldOut" href="/fleamarket/soldOut?mbno=${marketboardVo.mbno}">판매완료</a>
                        </c:if>   
                     </div>
                  </c:if>
               
                  <br>
                  <a class="btn btn-success" href="/fleamarket/fleaMarket" id="writingList">
                     글목록
                  </a>
                  <!-- Modal -->
                  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable" id="openDialog">
                    1:1 대화하기
                  </button>
                  
                  <!-- 모달 창 -->
                  <div class="modal fade" id="exampleModalScrollable" tabindex="-1" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true" style="display: none;">
                    <div class="modal-dialog modal-dialog-scrollable">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h1 class="modal-title fs-5" id="exampleModalScrollableTitle"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">1:1 대화창</font></font></h1>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>
                        <div class="modal-body" id="dialogBody">
                        
                        </div>
                        <div class="modal-footer">
                          <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" id="insertContents">
                          <button type="button" class="btn btn-primary" id="insertDialog"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">메세지 보내기</font></font></button>
                        </div>
                      </div>
                    </div>
                  </div>

               
                  <!-- 댓글 입력 -->
                  <div id="replyInputDiv" class="row" style="margin-top: 30px;">
                  
                     <div class="col-md-10">
                        <input type="text" class="form-control" placeholder="댓글내용"
                           id="replytext">
                     </div>

                     <div class="col-md-2">
                        <button type="button" class="btn btn-sm btn-primary"
                           id="btnReplyWrite">입력</button>
                     </div>
                     
                  </div>
               
                  <!-- 댓글 목록 -->
                  <div id="replyListDiv" class="row" style="margin-top: 30px;">
                     <div class="col-md-12">
                        <table class="table">
                           <thead>
                              <tr>
                                 <th>#</th>
                                 <th>댓글 내용</th>
                                 <th>작성자</th>
                                 <th>작성일</th>
                                 <th>수정일</th>
                                 <th>수정</th>
                                 <th>삭제</th>
                              </tr>
                           </thead>
                           <tbody id="replyList">
                              <tr style="display: none">
                                 <td></td>
                                 <td><span class="hideSpan"></span></td>
                                 <td><span class="hideSpan"></span></td>
                                 <td></td>
                                 <td></td>
                                 <td><button type="button"
                                       class="btn btn-sm btn-secondary btn-reply-update">수정</button>
                                    <button type="button"
                                       class="btn btn-sm btn-primary btn-reply-updateFinish"
                                       style="display: none">완료</button></td>
                                 <td><button type="button"
                                       class="btn btn-sm btn-danger btn-reply-delete">삭제</button></td>
                              </tr>
               
                           </tbody>
                        </table>
                     </div>
                  </div>
                        
                                 
                                    
                  <div style="clear:both;"></div>
                  
                  
               </form>
            </div>
         
         </div>
         
         <div class="col-md-1">
            <a></a>
         </div>   
            
      </div>
   </div>
</div>


</body>
</html>