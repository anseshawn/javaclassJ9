<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Q&A 게시판</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
		'use strict';
		
		function pageSizeCheck(){
			let pageSize = $("#pageSize").val();
			if('${search}'=='part') {
				location.href = "QuestionBoardSearch.do?search=${search}&partSelect=${searchString}&pageSize="+pageSize;
			}
			else {
				location.href = "QuestionBoardSearch.do?search=${search}&searchString=${searchString}&pageSize="+pageSize;
			}
		}
		
		function searchValue(){
			if($("#search").val()=='part') {
				$("#searchSelect").show();
				$("#searchString").hide();
			}
			else {
				$("#searchSelect").hide();
				$("#searchString").show();				
			}
		}
		
		function searchEnter(){
			searchForm.submit();
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

<section class="page-title bg-3">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="block text-center">
          <span class="text-white">실험에 관한 질문을 올려주세요</span>
          <h1 class="text-capitalize text-lg"><a href="QuestionBoard.do" style="color: #fff;">Q & A</a></h1>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section blog-wrap">
	<div class="container">
	
		<div class="row">
			<div class="col-lg-9"><h2>검색결과</h2></div>
			<br/>
			<div class="col-lg-9" style="font-size:1.2rem;"><p>${searchTitle}(으)로 '${searchString}'(을)를 검색한 결과 <b>${searchCount}</b> 건의 게시글이 검색되었습니다.</p></div>
		</div>
		<div class="row mb-2">
			<div class="col-lg-9 text-right">
				<a href="QuestionBoard.do" class="btn btn-main btn-icon-sm btn-round">전체목록으로</a>
			</div>
		</div>
		<div class="row mb-1">
			<div class="col-lg-9 search text-right">
				<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
					<option value="5" ${pageSize==5 ? "selected" : ""}>5개 보기</option>
					<option value="10" ${pageSize==10 ? "selected" : ""}>10개 보기</option>
					<option value="20" ${pageSize==20 ? "selected" : ""}>20개 보기</option>
				</select>
			</div>
		</div>
		<div class="row">
		<div class="col-lg-9">
 			<table class="table table-hover text-center">
				<tr style="pointer-events: none; background:#223a66; color:#fff;">
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="15%">작성자</th>
					<th width="15%">작성일</th>
					<th width="10%">조회수</th>
					<th width="5%"><i class="icofont-thumbs-up mr-1"></i></th>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo}"/>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td>${curScrStartNo}</td>
						<td class="text-left"><a href="QuestionBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}">${vo.title}</a></td>
						<td>${vo.nickName}</td>
						<td>${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}</td>
						<td>${vo.readNum}</td>
						<td>${vo.good}</td>
					</tr>
					<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
				</c:forEach>
				<tr><td colspan="6" class="m-0 p-0"></td></tr>
			</table>

		<!-- 블록페이지 시작(목록 아래 딱 붙어 나오도록) -->	
    <div class="row mt-5">
      <div class="col-lg-9">
        <nav class="pagination py-2 d-inline-block">
          <div class="nav-links">
	          <c:if test="${pag > 1}"><a class="page-numbers" href="${ctp}/QuestionBoard.do?pag=1&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-double-left"></i></a></c:if>
	          <c:if test="${curBlock > 0}"><a class="page-numbers" href="${ctp}/QuestionBoard.do?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-left"></i></a></c:if>
						<c:forEach var="i" begin="${(curBlock*blockSize+1)}" end="${(curBlock)*blockSize+blockSize}" varStatus="st">
							<c:if test="${i <= totPage && i == pag}"><span aria-current="page" class="page-numbers current">${i}</span></c:if>
							<c:if test="${i <= totPage && i != pag}"><a class="page-numbers" href="${ctp}/QuestionBoard.do?pag=${i}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}">${i}</a></c:if>
						</c:forEach>
						<c:if test="${curBlock < lastBlock}"><a class="page-numbers" href="${ctp}/QuestionBoard.do?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-right"></i></a></c:if>
						<c:if test="${pag < totPage}"><a class="page-numbers" href="${ctp}/QuestionBoard.do?pag=${totPage}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-double-right"></i></a></c:if>
        	</div>
      	</nav>
			</div>
		</div>
		<!-- 블록페이지 끝 -->
		</div>
		
		<div class="col-lg-3">
			<div class="sidebar-wrap pl-lg-4 mt-5 mt-lg-0">
			<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
				<div class="sidebar-widget write text-center mb-5 ">
					<a href="QuestionBoardInput.do" class="btn btn-main btn-icon btn-round" style="width:80%;">질문하기</a>
				</div>
			</c:if>	
			<!-- 검색창 -->
			<div class="sidebar-widget search mb-3 ">
				<h5>질문 검색</h5>
				<form name="searchForm" method="post" action="QuestionBoardSearch.do">
					<select name="search" id="search" class="form-control" onchange="searchValue()">
						<option value="title">제목</option>
						<option value="nickName">작성자</option>
						<option value="content">내용</option>
						<option value="part">분류</option>
					</select>
					<select name="searchSelect" id="searchSelect" class="form-control mt-2" style="display:none;">
						<option>실험방법</option>
						<option>실험장비</option>
						<option>법규</option>
						<option>기타</option>
					</select>
					<input type="text" name="searchString" id="searchString" class="form-control mt-2" placeholder="검색어를 입력하세요." required />
					<i class="ti-search"></i>
					<div class="text-right"><a href="javascript:searchEnter()" class="btn btn-main btn-icon-sm btn-round mt-2"><i class="icofont-search-2"></i> 검색</a></div>
				</form>
			</div>
			<!-- 검색창 끝 -->
			
			<div class="sidebar-widget latest-post mb-2">
				<h5>최근 댓글</h5>
				<c:forEach var="rVo" items="${rVos}" varStatus="st">
	     		<div class="py-1">
	      		<span class="text-sm text-muted">${rVo.date_diff == 0 ? fn:substring(rVo.wDate,11,19) : fn:substring(rVo.wDate,0,10) }</span>
	          <h6 class="my-1"><a href="QuestionBoardContent.do?idx=${rVo.idx}&pag=${pag}&pageSize=${pageSize}">${rVo.title}</a></h6>
	     		</div>
		    </c:forEach>
			</div>
			
			</div>
		</div>
		</div>
	</div>
</section>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>