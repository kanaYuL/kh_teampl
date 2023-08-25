<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>'NPE'main-page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link rel="stylesheet" href="https://kit.fontawesome.com/8398f84275.css" crossorigin="anonymous">
    
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="https://kit.fontawesome.com/8398f84275.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=248000df0b25ebaf18e3e9e0aba4e3c0&libraries=services,clusterer,drawing"></script>
    <style>
       body{
          font-family: 'orbit', sans-serif;
       }
       /* navbar */
       #inputSearch {
          width : 200px;
       }
       
       .bottomImg{
          margin-top: 10px;
          margin-bottom: 10px;
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
       }
       
       #divSearch * {
          margin: 3px auto; 
       }   
       
       #divRadio {
          margin-top:20px;
       }
            
       .carousel-inner {
          align-items: center;
          overflow: hidden;
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
       
       /* cardDiv */
       .card {
         border: none;
         background-color: #f8f9fa;
         box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
         display: flex; 
         flex-direction: column;
         align-items: center;
         justify-content: space-between;
         margin: 20px;
         padding: 20px;
         text-align: center;
       }
       
       .card-block {
          flex-grow: 1;
          display: flex;
          flex-direction: column;
          justify-content: flex-start;
        }
        
       .card-title {
         font-size: 1.5rem;
         font-weight: bold;
         color: #333;
         margin-bottom: 10px;
       }
       .card-text {
         font-size: 1rem;
         color: #555;
         margin-bottom: 20px;
       }
       
       #cardDiv {
          display:flex;
          flex-direction:row;
          justify-content: space-around;
       }
       
       .container-fluid {
          margin: 10vh auto;
       }
       
       .card-img-top {
          max-width: 100%;
          height: auto;
       }
       .bottomImg img {
         max-width: 100%;
         height: auto;
         border-radius: 10px;
         box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
         transition: transform 0.3s ease-in-out;
       }
       
       .bottomImg img:hover {
         transform: scale(1.05);
       }
       .container-fluid{
          margin: 50px-auto;
       }
       .carousel-caption {
	      color: black;
	   }
	   .carousel-caption h5.carouselName {
		    font-size: 2rem;
		    font-weight: bold;
		}
    </style>
    
<script>
$(function() {
     var maxCardHeight = 0;
     $('.card').each(function() {
       var cardHeight = $(this).outerHeight();
       if (cardHeight > maxCardHeight) {
         maxCardHeight = cardHeight;
       }
     });
   
     $('.card').css('min-height', maxCardHeight + 'px');
     
     // random 이미지 3개 표시 (tbl_menu -> mfilenames)
     $.ajax({
         "type" : "get",
         "processData" : false,   // ?a=b&c=d (x)
         "contentType" : false,  // application/x-www-form-urlencoded (x)
         "dataType" : "json",
         "url" : "/recipe/getMfileNames",
         "success" : function(rData) {
        	 
        	$('.carouselImg').each(function (index, item) {
        		// console.log(rData[index]);
        		
        		var mfilename = rData[index].mfilename;
        		
        		// 1. img
        		url = "/upload/displayImage?filePath=";
        		url += mfilename;
        		url += "&type=recipe";
        		
        		// console.log($(this));
        		
        		$(this).attr("src", url);
        		$(this).parent().attr("href","/recipe/recipeDetail?mno=" + rData[index].mno);
        		
			});
        	
        	// 2. name
        	$('.carouselName').each(function (index, item) {
        		$(this).empty();
        		$(this).append(rData[index].mname);
        	});
         } // success 
      });
});
</script>
   
  </head>
  <body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>

   <div id="carouselExampleCaptions" class="carousel slide">
      <div class="carousel-indicators">
         <button type="button" data-bs-target="#carouselExampleCaptions"
            data-bs-slide-to="0" class="active" aria-current="true"
            aria-label="Slide 1"></button>
         <button type="button" data-bs-target="#carouselExampleCaptions"
            data-bs-slide-to="1" aria-label="Slide 2"></button>
         <button type="button" data-bs-target="#carouselExampleCaptions"
            data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      
      <div class="carousel-inner">
         <div class="carousel-item active">
            <a href="#"><img src="images/구룸.jpg" class="d-block w-100 carouselImg" alt="..."></a>
            <div class="carousel-caption d-none d-md-block">
               <h5 class="carouselName">First slide label</h5>
            </div>
         </div>
         
         <div class="carousel-item">
            <a href="#"><img src="images/돌체라떼.jpg" class="d-block w-100 carouselImg" alt="..."></a>
            <div class="carousel-caption d-none d-md-block">
               <h5 class="carouselName">Second slide label</h5>
            </div>
         </div>
         
         <div class="carousel-item">
            <a href="#"><img src="images/혼돈.jpg" class="d-block w-100 carouselImg" alt="..."></a>
            <div class="carousel-caption d-none d-md-block">
               <h5 class="carouselName">Third slide label</h5>
            </div>
         </div>
      </div>
      <button class="carousel-control-prev" type="button"
         data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
         <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
            class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button"
         data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
         <span class="carousel-control-next-icon" aria-hidden="true"></span> <span
            class="visually-hidden">Next</span>
      </button>
   </div> <!-- / carousel -->

   <div class="container-fluid">
   <div style="text-align:center; margin-left:30px; margin-right:30px;">
	   <h2>NPE 란?</h2>
	   <p>저희 웹사이트를 통해 여러분은 원두 종류, 로스팅 프로세스, 추출 방법, 향과 맛의 조합, 그리고 커피 문화에 대한 흥미로운 정보를 찾을 수 있습니다. 뿐만 아니라 커피를 더 맛있게 즐기는 방법과 전문적인 조리법을 배우고, 커피의 다양한 풍미를 경험할 수 있도록 여러 커피 레시피도 제공하고 있습니다.</p>
	   <br><p>커피를 좋아하고 이에 대한 지식을 확장하고 싶은 분들을 위한 커피 학습의 보고서이자, 커피 마스터로 거듭나는 계기가 될 것입니다. 우리와 함께 커피의 신세계를 탐험하고, 커피에 대한 새로운 발견을 즐겨보세요. 커피에 대한 지식을 공유하며 커피 커뮤니티에 함께 참여해보세요.</p>	   
   </div>
      <div class="row">
         <div class="col-md-12">
            <div class="row">
               <div class="col-md-4">
                  <div class="card">
                     <img class="card-img-top" alt="Bootstrap Thumbnail First" src="images/원두.png" />
                     <div class="card-block">
                        <h5 class="card-title">생산지에 따른 원두별 특징</h5>
                        <p class="card-text">
                           1. 중남미지역(멕시코, 과테말라, 콜롬비아, 브라질등): 대체적으로 바디감이 깊고, 풍부하며
                           고소한 향과 단맛이 조화를 이룹니다.
                        </p>
                        
                        <p class="card-text">
                           2. 아프리카지역(에티오피아, 케냐, 탄자니아등): 다채로운 향을 가지고 있으며, 개성이 강하고,
                           산미가 강한것이 특징입니다.
                        </p>
                        <p class="card-text">
                           3. 아시아지역(인도네시아, 인도, 파푸아뉴기니등): 부드러우면서 바디감이 좋으며, 다크초콜릿과
                           같은 단맛을 느낄 수 있습니다.
                        </p>
                        
                        <p>
                           <a class="btn btn-primary" href="/fleamarket/fleaMarket">원두 사러 가기</a> 
                        </p>
                     </div>
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="card">
                     <img class="card-img-top" alt="Bootstrap Thumbnail Second"
                        src="images/quick_tips.jpg" />
                     <div class="card-block">
                        <h5 class="card-title">사이트 이용시 주의사항</h5>
                        <p class="card-text">
                           1. 플리마켓을 이용할 시에 로그인을 하지 않으면 게시판을 이용할 수 
                           없습니다.
                        </p>
                        <p class="card-text">
                           2. 정확한 정보만을 전달하려 하고 있으나 모든 사용자가 올리는 정보를 확인하여
                           검수하는것이 아니므로 오류가 있을수 있습니다.
                        </p>
                        
<!--                         <p> -->
<!--                            <a class="btn btn-primary" href="#">Action</a> <a class="btn" -->
<!--                               href="#">Action</a> -->
<!--                         </p> -->
                     </div>
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="card">
                     <img class="card-img-top" alt="Bootstrap Thumbnail Third"
                        src="images/완제품.jpg" />
                     <div class="card-block">
                        <h5 class="card-title">'블렌드'와 '싱글 오리진'의 차이 </h5>
                        <p class="card-text">
                           대부분의 사람들이 구할 수 있는 원두는 크게 '블렌드'와 '싱글 오리진'이 
                           있습니다. 이둘은 확실한 차이가 있기 때문에 정확하게 구분할 수 있어야 
                           합니다.
                        </p>
                        
                        <p class="card-text">
                           싱글 오리진: 싱글 오리진 원두랑 한나라에서 재배된 단일 원두를 말합니다.
                           즉, 케냐 커피, 에티오피아 커피와 같이 한 종류로 이루어진 원두입니다. 이는 
                           각 생산지만의 독특한 특징을 가지고 있으며 핸드드립으로 본연의 맛을 느낄 수 있습니다.
                        </p>
                        <p class="card-text">
                           블렌드: 블렌드 원두란 2개 이상의 원두를 섞어서 만든 원두입니다. 이는 품종, 로스팅 정도, 
                           가공법이 다른 2가지 이상을 말합니다. 이를 통해 기존에 없던 새로운 맛을 만들어
                           낼 수 있습니다. 블렌드 원두는 에스프레소로 추출하여 마시기 좋은 원두입니다.
                        </p>
                        
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <h3 class="text-center">원두 로스팅 정보</h3><br>
   <!-- 로스팅 정보 캐로셀 -->
   <div id="textCarousel" class="carousel slide" data-bs-ride="carousel">
     <div class="carousel-inner">
     
       <div class="carousel-item active">
         <div class="carousel-content text-center">
           <h2>라이팅 로스팅(1단계)</h2>
           <p>로스팅중에서 가장 연하고 동시에 가장 강한 신맛을 느낄 수 있습니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>시나몬 로스팅(2단계)</h2>
           <p>산미가 활성화 되며 1단계 보단 약하지만 강한 신맛을 느낄 수 있습니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>미디엄 로스팅(3단계)</h2>
           <p>여전히 신맛을 강하게 느낄 수 있지만, 산미라고 느끼는 단계입니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>하이 로스팅(4단계)</h2>
           <p>산미가 억제되고 쓴 맛과 단맛이나며 밸런스가 잡힌 맛을 느낄 수 있습니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>시티 로스팅(5단계)</h2>
           <p>8단계의 로스팅중 표준 로스팅단계입니다. 적당한 산미와 깊은 쓴 맛을 느낄 수 있습니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>풀 시티 로스팅(6단계)</h2>
           <p>산미는 거의 사라지고 쓴 맛이 더 강해집니다. 우유와 즐기기 좋은 단계입니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>프렌치 로스팅(7단계)</h2>
           <p>쓴 맛이 극대화되는 단계로 우리나라 사람들이 가장 즐기는 로스팅입니다.</p>
         </div>
       </div>
       
       <div class="carousel-item">
         <div class="carousel-content text-center">
           <h2>이탈리안 로스팅(8단계)</h2>
           <p>로스팅중에서 가장 쓴 맛을 내는 단계입니다. 엄청난 쓴 맛과 함께 얇은 바디감이 느껴집니다.</p>
         </div>
       </div>
       
     </div>
     <button class="carousel-control-prev" type="button" data-bs-target="#textCarousel" data-bs-slide="prev">
       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
       <span class="visually-hidden">Previous</span>
     </button>
     <button class="carousel-control-next" type="button" data-bs-target="#textCarousel" data-bs-slide="next">
       <span class="carousel-control-next-icon" aria-hidden="true"></span>
       <span class="visually-hidden">Next</span>
     </button>
   </div><!-- 끝 -->
   
   
    
   <div class="container-fluid">
      <div class="row bg-secondary-subtle">
         <div class="col-md-12">
<!--             <div id="divSearch" class="jumbotron"> -->
<!--                <h3>레시피 상세 검색</h3> -->
               
<!--                div : radio box                -->
<!--                <div id="divRadio" class="btn-group" role="group" aria-label="Basic radio toggle button group"> -->
<!--                     <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked> -->
<!--                     <label class="btn btn-outline-primary" for="btnradio1">Hot</label> -->

<!--                     <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"> -->
<!--                     <label class="btn btn-outline-primary" for="btnradio2">Ice</label> -->
<!--                </div> -->
               
<!--                div : check box -->
<!--                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group"> -->
<!--                     <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"> -->
<!--                    <label class="btn btn-outline-primary" for="btncheck1">라떼</label> -->

<!--                     <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off"> -->
<!--                    <label class="btn btn-outline-primary" for="btncheck2">시럽</label> -->

<!--                     <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off"> -->
<!--                     <label class="btn btn-outline-primary" for="btncheck3">알코올</label> -->
                    
<!--                     <input type="checkbox" class="btn-check" id="btncheck4" autocomplete="off"> -->
<!--                     <label class="btn btn-outline-primary" for="btncheck4">과일</label> -->
                    
<!--                     <input type="checkbox" class="btn-check" id="btncheck5" autocomplete="off"> -->
<!--                     <label class="btn btn-outline-primary" for="btncheck5">크림</label> -->
<!--                </div> -->
               
<!--                div : search input -->
<!--                <div> -->
<!--                   <form class="d-flex" role="search"> -->
<!--                      <input id="inputSearch" class="form-control me-2" type="search" placeholder="Search" -->
<!--                         aria-label="Search"> -->
<!--                      <button class="btn btn-outline-success" type="submit">Search</button> -->
<!--                   </form> -->
<!--                </div> -->
               
<!--             </div> -->
            <div class="row bottomImg">
<!--                <div class="col-md-1"> -->
<!--                </div> -->
               <div class="col-md-3">
                  <img src="/images/246.jpg" alt="...">
               </div>
               <div class="col-md-3">
                  <img src="/images/135.jpg" alt="...">
               </div>
               <div class="col-md-3">
                  <img src="/images/789.jpg" alt="...">
               </div>
               <div class="col-md-3">
                  <img src="/images/123.jpg" alt="...">
               </div>
<!--                <div class="col-md-2"> -->
<!--                   <img src="/images/123.jpg" alt="..."> -->
<!--                </div> -->
<!--                <div class="col-md-1"> -->
<!--                </div> -->
            </div>
         </div>
      </div>
   </div> <!-- /searchDiv -->



   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
     
  </body>
</html>