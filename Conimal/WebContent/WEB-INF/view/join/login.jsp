<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>MyBoard</title>
	<%@ include file="../include/head.jsp" %>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

$(document).ready(function() {
	$("#login-btn").click(function(){
		var id = $("#user-id").val();
		var idR = /^[a-z0-9]{4,10}$/;
		var pwd = $("#user-pwd").val();
		var pwdR = /^[A-Za-z0-9]{6,16}$/; 

		$.ajax({
			url : '${pageContext.request.contextPath}/login',
			type : 'post',
			data : { id : id, pwd : pwd },
			dataType : 'json',
			success : function(data) {
				if(id !== null) {
					$('#check_id').text('아이디를 입력해주세요.');
					$('#check_id').css('color', 'red');
					$('#check_id').focus();
					$('#login-btn').attr("disabled", true);
				} else if (idR.test(id)) {
					$('#check_id').text('아이디는 소문자와 숫자 4~10자리만 가능합니다.');
					$('#check_id').css('color', 'red');
					$('#check_id').focus();
					$('#login-btn').attr("disabled", true);
				} else {
					$('#check_id').text("");
					$('#login-btn').attr("disabled", false);
					$('#check_pwd').focus();
				}
		
				if(pwd !== null) {
					$('#check_pwd').text('비밀번호를 입력해주세요.');
					$('#check_pwd').css('color', 'red');
					$('#check_pwd').focus();
					$('#login-btn').attr("disabled", true);
				} else if (pwdR.test(pwd)) {
					$('#check_pwd').text('비밀번호는 소문자와 숫자 8~16자리만 가능합니다.');
					$('#check_pwd').css('color', 'red');
					$('#check_pwd').focus();
					$('#login-btn').attr("disabled", true);
				} else {
					$('#check_pwd').text("");
					$('#login-btn').attr("disabled", false);
				}
			}, fail : function() {
				console.log("로그인 실패");
				alert("아이디나 비밀번호를 확인해주세요.");
			}
		});
	});
});
</script>
<body>
<%@ include file="../include/header.jsp" %>
<div class = "page-container">

	<div class="login-wrapper">
		<h2 class="navy noto-sans marB_75">로그인</h2>
		<div class="login-container">
			<c:if test="${user == null}">
				<div class="login-box">
					<form action="/login" method="post">		
						<div class="user-input"><input type="text" id="user-id" name="id" placeholder="아이디"/><div id="check_id"></div></div>
						<div class="user-input marB_30"><input type="password" id="user-pwd" name="password" placeholder="비밀번호"/><div id="check_pwd"></div></div>
						<button class="btn login-btn mar0_auto" id="login-btn">로그인</button>
					</form>
				</div>
			</c:if>
			
		</div>
		<div class="user-find-box">
			<a href ="/join/join-form" class="text-button">회원가입</a>
		</div>
	
	</div>
	
</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>
