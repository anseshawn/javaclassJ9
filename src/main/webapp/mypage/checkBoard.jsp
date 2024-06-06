<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>내가 쓴 글 보기</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<%-- <jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" /> --%>
<p><br/></p>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-10">
			<table class="table table-hover text-center">
				<tr>
					<th style="width:20%;">게시판</th>
					<th style="width:50%;">제목</th>
					<th style="width:20%;">날짜</th>
					<th style="width:10%;">추천</th>
				</tr>
				<c:forEach var="vo" items="${fVos}" varStatus="st">
					<tr>
						<td><a href="FreeBoard.do"> 자유게시판</a></td>
						<td class="text-left"><a href="FreeBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a> (${vo.replyCnt+vo.reCnt})</td>
						<td>${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}</td>
						<td>${vo.good}</td>
					</tr>
				</c:forEach>
				<c:forEach var="vo" items="${qVos}" varStatus="st">
					<tr>
						<td><a href="QuestionBoard.do">Q&A</a></td>
						<td class="text-left"><a href="QuestionBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a> (${vo.replyCnt+vo.reCnt})</td>
						<td>${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}</td>
						<td>${vo.good}</td>
					</tr>
				</c:forEach>
				<c:forEach var="vo" items="${rcVos}" varStatus="st">
					<tr>
						<td><a href="RecruitBoard.do">채용공고</a></td>
						<td class="text-left"><a href="RecruitBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a> (${vo.replyCnt+vo.reCnt})</td>
						<td>${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}</td>
						<td>${vo.good}</td>
					</tr>
				</c:forEach>
				<div id="#context"></div>
				<tr><td colspan="4" class="m-0 p-0"></td></tr>
			</table>
			<!-- 블록페이지 시작(목록 아래 딱 붙어 나오도록) -->	
			<!-- 
	    <div class="row mt-5">
	      <div class="col-lg-9">
	        <nav class="pagination py-2 d-inline-block">
	          <div class="nav-links">
		          <c:if test="${pag > 1}"><a class="page-numbers" href="javascript:mypage(${ctp}/CheckBoard.do?pag=1&pageSize=${pageSize})"><i class="icofont-thin-double-left"></i></a></c:if>
		          <c:if test="${curBlock > 0}"><a class="page-numbers" href="javascript:mypage(${ctp}/CheckBoard.do?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize})"><i class="icofont-thin-left"></i></a></c:if>
							<c:forEach var="i" begin="${(curBlock*blockSize+1)}" end="${(curBlock)*blockSize+blockSize}" varStatus="st">
								<c:if test="${i <= totPage && i == pag}"><span aria-current="page" class="page-numbers current">${i}</span></c:if>
								<c:if test="${i <= totPage && i != pag}"><a class="page-numbers" href="javascript:mypage(${ctp}/CheckBoard.do?pag=${i}&pageSize=${pageSize})">${i}</a></c:if>
							</c:forEach>
							<c:if test="${curBlock < lastBlock}"><a class="page-numbers" href="javascript:mypage(${ctp}/CheckBoard.do?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize})"><i class="icofont-thin-right"></i></a></c:if>
							<c:if test="${pag < totPage}"><a class="page-numbers" href="javascript:mypage(${ctp}/CheckBoard.do?pag=${totPage}&pageSize=${pageSize})"><i class="icofont-thin-double-right"></i></a></c:if>
	        	</div>
	      	</nav>
				</div>
			</div>
			 -->
			<!-- 블록페이지 끝 -->
		</div>
	</div>
</div>
<p><br/></p>
<%-- <jsp:include page="/include/footer.jsp" /> --%>
</body>
</html>