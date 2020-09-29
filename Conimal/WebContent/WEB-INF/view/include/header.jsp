<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String hostname = request.getScheme() + "://" + request.getServerName() +":" + request.getServerPort() + "/conimal/"; %>
<c:set var="hostname" value="<%=hostname%>"/>
<head>
<%@ include file="head.jsp" %>
</head> 

<header>
	
	<!-- 비로그인 상태 -->
	<c:if test="${user == null}">
	<div class="logo"><span onClick="document.location.href='main'">코니멀</span></div>
	<ul class="category">
		<li><div onClick="document.location.href='#'">코니멀소개</div></li>
		<li><div onClick="document.location.href='/pet_dictionary/pet_dictionary'">펫과사전</div></li>
		<li><div onClick="document.location.href='/community/community-list'">커뮤니티</div></li>
	</ul>

	<div class="header-right">
		<div class="btn login-btn"><button onclick="location.href='/join/login'">Login / Sign Up</button></div>
	</div>
	</c:if>
	
	<!-- 로그인 상태 -->
	<c:if test="${user != null}">
	<div class="logo"><span onClick="document.location.href='main'">코니멀</span></div>
	<ul class="category">
		<li><div onClick="document.location.href='#'">코니멀소개</div></li>
		<li><div onClick="document.location.href='/pet_dictionary/pet_dictionary'">펫과사전</div></li>
		<li><div onClick="document.location.href='/community/community-list'">커뮤니티</div></li>
	</ul>

	<div class="header-right">
		<div class="btn mypage-btn"><button onclick="location.href='/my-page/my-page'">마이페이지</button></div>
		<div class="btn logout-btn"><button onclick="location.href='/logout'">${nickname} Logout</button></div>
	</div>
	</c:if>
	
</header>