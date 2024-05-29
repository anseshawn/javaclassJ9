<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-expand-lg navigation" id="navbar">
	<div class="container">
	 	 <a class="navbar-brand mr-auto" href="Main.do">
		  	<img src="images/logo.png" alt="" class="img-fluid">
		  </a>

	  	<button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarmain" aria-controls="navbarmain" aria-expanded="false" aria-label="Toggle navigation">
		<span class="icofont-navigation-menu"></span>
	  </button>
  
	  <div class="collapse navbar-collapse" id="navbarmain">
		<ul class="navbar-nav ml-auto">
		  <li class="nav-item active">
			<a class="nav-link" href="Main.do">Home</a>
		  </li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="department.html" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">소개말<i class="icofont-thin-down"></i></a>
			<ul class="dropdown-menu" aria-labelledby="dropdown01">
				<li><a class="dropdown-item" href="#">공지사항</a></li>
				<li><a class="dropdown-item" href="AboutUs.do">기업소개</a></li>
				<li><a class="dropdown-item" href="#">자료실</a></li>
			</ul>
			</li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="department.html" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제품문의<i class="icofont-thin-down"></i></a>
			<ul class="dropdown-menu" aria-labelledby="dropdown02">
				<li><a class="dropdown-item" href="department.html">분석장비</a></li>
				<li><a class="dropdown-item" href="department-single.html">소모품</a></li>
				<li><a class="dropdown-item" href="#">A/S 신청</a></li>
			</ul>
			</li>
		  	
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="doctor.html" id="dropdown03" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">회원게시판<i class="icofont-thin-down"></i></a>
			<ul class="dropdown-menu" aria-labelledby="dropdown03">
				<li><a class="dropdown-item" href="doctor.html">Q&A</a></li>
				<li><a class="dropdown-item" href="FreeBoard.do">자유게시판</a></li>
				<li><a class="dropdown-item" href="appoinment.html">채용공고</a></li>
			</ul>
			</li>

			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="blog-sidebar.html" id="dropdown05" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">고객서비스<i class="icofont-thin-down"></i></a>
			<ul class="dropdown-menu" aria-labelledby="dropdown04">
				<li><a class="dropdown-item" href="blog-sidebar.html">온라인상담</a></li>
				<li><a class="dropdown-item" href="blog-single.html">불편사항 신고</a></li>
			</ul>
			</li>
			<c:if test="${level != 0 && level != 1 && level !=2}">
				<li class="nav-item"><a class="nav-link" href="MemberLogin.do">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="MemberJoin.do">회원가입</a></li>
			</c:if>
			<c:if test="${level==0 || level==1 || level==2}">
				<li class="nav-item"><a class="nav-link" href="MemberLogout.mem">로그아웃</a></li>
				<c:if test="${level==1 || level==2}">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="blog-sidebar.html" id="dropdown05" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">마이페이지<i class="icofont-thin-down"></i></a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">내정보 관리</a></li>
								<li><a class="dropdown-item" href="PasswordChange.do">비밀번호 변경</a></li>
							</ul>
					</li>
				</c:if>
				<c:if test="${level==0}"><li class="nav-item"><a class="nav-link" href="#">관리자모드</a></li></c:if>
			</c:if>
		</ul>
	  </div>
	</div>
</nav>