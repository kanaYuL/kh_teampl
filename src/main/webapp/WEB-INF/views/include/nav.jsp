<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
   #divNav {
       display: flex;
       flex-direction: row;
       justify-content: space-between;
       background-color: #a0a0a0;
       padding: 15px;
       color: white; /* 글자색 변경 */
       font-weight: bold; /* 글꼴 굵기 추가 */
   }
   /* navbar 스타일 */
     nav.navbar {
        background-color: #343a40; /* 어두운 회색 배경색상 */
       font-size: 18px; /* 글자 크기 */
     }
   
     /* 네비게이션 바 왼쪽 아이템 스타일 */
     #divNav ul.navbar-nav li.nav-item a.nav-link {
       font-size: 20px; /* 글자 크기 */
       color: #ffffff; /* 글자 색상 */
       transition: color 0.3s; /* hover 효과를 위한 트랜지션 */
     }
     
     /* 네비게이션 바 왼쪽 아이템 hover 스타일 */
     #divNav ul.navbar-nav li.nav-item a.nav-link:hover {
       color: #f8c95a; /* hover 시 글자 색상 변경 */
     }
     
     /* 네비게이션 바 오른쪽 아이템 스타일 */
     #rightNavbar ul.navbar-nav li.nav-item a.nav-link {
       font-size: 20px; /* 글자 크기 */
       color: #ffffff; /* 글자 색상 */
       transition: color 0.3s; /* hover 효과를 위한 트랜지션 */
     }
     
     /* 네비게이션 바 오른쪽 아이템 hover 스타일 */
     #rightNavbar ul.navbar-nav li.nav-item a.nav-link:hover {
       color: #ff8575; /* hover 시 글자 색상 변경 */
     }
      /* navbar-brand 스타일 */
     nav.navbar a.navbar-brand {
       font-size: 24px; /* 글자 크기 */
       color: #553830; /* 글자 색상 */
       font-weight: bold; /* 글자 두께 */
       transition: color 0.3s; /* hover 효과를 위한 트랜지션 */
     }
     
     /* navbar-brand hover 스타일 */
     nav.navbar a.navbar-brand:hover {
       color: #ffffff; /* hover 시 글자 색상 변경 */
       text-decoration: none; /* 밑줄 제거 */
     }

</style>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
         <a class="navbar-brand" href="/">NPE</a>
         <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
         </button>
         
         <div id="divNav" class="collapse navbar-collapse" id="navbarSupportedContent">
            <div id="leftNavbar">
               <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item"><a class="nav-link" href="/fleamarket/fleaMarket">플리마켓</a></li>
                  <li class="nav-item"><a class="nav-link active"
                     aria-current="page" href="/recipe/recipeList">커피레시피</a></li>
<!--                   <li><a id="searchLink" href="#"><i class="fa-solid fa-magnifying-glass"></i></a></li> -->
               </ul>
            </div>
            
            <div id="rightNavbar">
               <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <c:choose>
                     <c:when test="${empty sessionScope.userInfo}">
                        <li class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
                        <li class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
                     </c:when>
                     <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="#"
                            data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                           aria-controls="offcanvasRight">${userInfo.id}</a></li>
                        <li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
                     </c:otherwise>
                  </c:choose>
               
<!--                   <li><button class="btn btn-primary" type="button" -->
<!--                   data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" -->
<!--                   aria-controls="offcanvasRight">Toggle right offcanvas</button> -->
<!--                   </li> -->
               </ul>
            </div> <!-- /rightNavbar -->
      </div> <!-- /divNav -->   
   </div>
</nav> <!-- /nav -->

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
   aria-labelledby="offcanvasRightLabel"
   style="width:30vh;">
   <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="offcanvasRightLabel">마이 페이지</h5>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
         aria-label="Close"></button>
   </div>

   <div class="offcanvas-body">
   	  <p>사용자: ${userInfo.id}</p>
      <p>이메일: ${userInfo.email}</p>
      <p>가입일: 
          <fmt:formatDate value="${userInfo.regdate}" pattern="yyyy-MM-dd" />
      </p>
   </div>
</div>