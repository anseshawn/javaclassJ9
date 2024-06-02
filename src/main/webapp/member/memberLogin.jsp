<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	// 로그인창에 아이디 체크 유무에 대한 처리
	// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
	Cookie[] cookies = request.getCookies();

	if(cookies != null) { // 저장된 쿠키가 있으면 작동하도록 if문 먼저
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
		'use strict';
		
		function loginCheck(){
			let mid = document.getElementById("mid").value;
			let pwd = document.getElementById("pwd").value;
			
			if(mid.trim()==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(pwd.trim()==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			myform.submit();
		}
		
		window.onload = function(){
    	if("${mid}" != null) {
    		$('#idSave').attr('checked',true);
    	}
    	else {
    		$("#idSave").removeAttr('checked');
    	}
    }
	</script>
</head>
<body id="top">
<header>
	<jsp:include page="/include/header.jsp" />
	<jsp:include page="/include/nav.jsp" />
</header>
<p><br/></p>
<div class="container">
	<!-- Start Account Sign In Area -->
  <div class="account-login section">
		<div class="row">
		  <div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
		   <form name="myform" class="login-form inner-content" method="post" action="${ctp}/MemberLoginOk.mem">
		     <div class="card-body">
		       <div class="title">
		         <h3>Login</h3>
		       </div>
		       <div class="input-head">
		         <div class="form-group input-group">
		           <!-- <label><i class="fa-solid fa-user"></i>&nbsp;</label> -->
		           <input class="form-control" type="text" id="mid" name="mid" value="${mid}" placeholder="아이디를 입력해주세요" required/>
		         </div>
		         <div class="form-group input-group">
		           <!-- <label><i class="fa-solid fa-lock"></i>&nbsp;</label> -->
		           <input class="form-control" type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요" required/>
		         </div>
		       </div>
		       <div class="d-flex flex-wrap justify-content-between bottom-content">
		         <div class="form-check">
		           <input type="checkbox" class="form-check-input width-auto" id="idSave" name="idSave" />
		           <label class="form-check-label">아이디 저장하기</label>
		         </div>
		         <div>
		         <a href="MidSearch.do">아이디 찾기</a> │ <a href="PwdSearch.do">비밀번호 찾기</a>
		         </div>
		       </div>
		       <hr/>
		       <div class="button text-center">
		         <input type="button" onclick="loginCheck()" class="btn btn-main-2 mr-3" value="로그인" />
		         <a class="btn btn-main" href="${ctp}/MemberJoin.do">회원가입</a>
		       </div>
		      </div>
		    </form>
		  </div>
		</div>
  </div>
  <!-- End Account Sign In Area -->
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>