<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>검색결과 - 채용공고</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
		'use strict';
		
		function pageSizeCheck(){
			let pageSize = $("#pageSize").val();
			if('${search}'=='part') {
				location.href = "RecruitBoardSearch.do?search=${search}&partSelect=${searchString}&pageSize="+pageSize;
			}
			else {
				location.href = "RecruitBoardSearch.do?search=${search}&searchString=${searchString}&pageSize="+pageSize;
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

<section class="page-title bg-1">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="block text-center">
          <span class="text-white">진행 중인 공고를 올려주세요</span>
          <h1 class="text-capitalize mb-5 text-lg"><a href="RecruitBoard.do" style="color: #fff;">채용공고</a></h1>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section blog-wrap">
	<div class="container">
	
		<div class="row mb-2">
			<div class="col-lg-8 text-right">
				<a href="RecruitBoard.do" class="btn btn-main btn-icon-sm btn-round">전체목록으로</a>
			</div>
		</div>
		<div class="row mb-1">
			<div class="col-lg-8 search text-right">
				<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
					<option value="5" ${pageSize==5 ? "selected" : ""}>5개 보기</option>
					<option value="10" ${pageSize==10 ? "selected" : ""}>10개 보기</option>
					<option value="20" ${pageSize==20 ? "selected" : ""}>20개 보기</option>
				</select>
			</div>
		</div>
		
		<div class="row">
			<div class="row">
				<div class="col-lg-12"><h2>검색결과</h2></div>
				<br/>
				<div class="col-lg-12" style="font-size:1.2rem;"><p>${searchTitle}(으)로 '${searchString}'(을)를 검색한 결과 <b>${searchCount}</b> 건의 게시글이 검색되었습니다.</p></div>
			</div>
 			<div class="col-lg-8">
				<div class="row">
				
					<c:set var="curScrStartNo" value="${curScrStartNo}"/>
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<div class="col-lg-12 col-md-12 mb-3">
							<div class="blog-item">
								<div class="blog-item-content">
									<div class="blog-item-meta mb-2 mt-4">
										<span class="text-muted text-capitalize mr-3"><i class="fa-solid fa-eye mr-2"></i>${vo.readNum}</span>
										<span class="text-muted text-capitalize mr-3"><i class="icofont-comment mr-2"></i>${vo.replyCnt} Comments</span>
										<span class="text-black text-capitalize mr-3">
											<i class="icofont-calendar mr-2"></i> ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10) }
										</span>
										<span class="text-muted text-capitalize mr-3"><i class="icofont-user mr-2"></i>${vo.nickName}</span>										
									</div>
									<div class="blog-item-meta mb-3">
										<span class="text-muted text-capitalize mr-3"><i class="icofont-clock-time mr-2"></i>${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</span>
									</div>
									<c:if test="${today <= fn:substring(vo.endDate,0,10)}">
										<div class="title mt-3 mb-3">
											<a href="RecruitBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}">${vo.title}</a>
										</div>
									</c:if>
									<c:if test="${today > fn:substring(vo.endDate,0,10)}">
										<div class="title mt-3 mb-3">
											<div>${vo.title}(종료)</div>
										</div>
									</c:if>
								</div>
							</div>
							<hr/>			
						</div>
					</c:forEach>
				</div>
				
				<!-- 블록페이지 시작(목록 아래 딱 붙어 나오도록) -->	
		    <div class="row mt-2 text-center">
		      <div class="col-lg-12">
		        <nav class="pagination py-2 d-inline-block">
		          <div class="nav-links">
			          <c:if test="${pag > 1}"><a class="page-numbers" href="${ctp}/RecruitBoardSearch.do?pag=1&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-double-left"></i></a></c:if>
			          <c:if test="${curBlock > 0}"><a class="page-numbers" href="${ctp}/RecruitBoardSearch.do?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-left"></i></a></c:if>
								<c:forEach var="i" begin="${(curBlock*blockSize+1)}" end="${(curBlock)*blockSize+blockSize}" varStatus="st">
									<c:if test="${i <= totPage && i == pag}"><span aria-current="page" class="page-numbers current">${i}</span></c:if>
									<c:if test="${i <= totPage && i != pag}"><a class="page-numbers" href="${ctp}/RecruitBoardSearch.do?pag=${i}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}">${i}</a></c:if>
								</c:forEach>
								<c:if test="${curBlock < lastBlock}"><a class="page-numbers" href="${ctp}/RecruitBoardSearch.do?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-right"></i></a></c:if>
								<c:if test="${pag < totPage}"><a class="page-numbers" href="${ctp}/RecruitBoardSearch.do?pag=${totPage}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}"><i class="icofont-thin-double-right"></i></a></c:if>
		        	</div>
		      	</nav>
					</div>
				</div>
				<!-- 블록페이지 끝 -->
			</div>
			
			<div class="col-lg-4">
				<div class="sidebar-wrap pl-lg-4 mt-5 mt-lg-0">
				<c:if test="${sLevel==0 || sLevel==2}">
					<div class="sidebar-widget write mb-3 ">
						<a href="RecruitBoardInput.do" class="btn btn-main-2 btn-icon btn-round-full" style="width:300px; margin:8px;">글쓰기</a>
					</div>
				</c:if>	
				<!-- 검색창 -->
				<div class="sidebar-widget search mb-3 ">
					<h5>공고 검색</h5>
					<form name="searchForm" method="post" action="RecruitBoardSearch.do">
						<select name="search" id="search" class="form-control" onchange="searchValue()">
							<option value="title">제목</option>
							<option value="nickName">작성자</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="searchString" id="searchString" class="form-control mt-2" placeholder="검색어를 입력하세요." required />
						<i class="ti-search"></i>
						<div class="text-right"><a href="javascript:searchEnter()" class="btn btn-main btn-icon-sm btn-round mt-2"><i class="icofont-search-2"></i> 검색</a></div>
					</form>
				</div>
				<!-- 검색창 끝 -->
					
				<div class="sidebar-widget category mb-3">
					<h5 class="mb-4">분류</h5>
					<ul class="list-unstyled">
						<c:forEach var="rcVo" items="${rcVos}" varStatus="st">
							<li class="align-items-center">
						    <a href="${ctp}/RecruitBoardSearch.do?pag=1&pageSize=${pageSize}&flag=search&search=part&partSelect=${rcVo.part}">${rcVo.part}</a>
						    <span>(${rcVo.partCnt})</span>
						  </li>
						</c:forEach>
					</ul>
				</div>
					 
				<div class="sidebar-widget tags mb-3">
					<h5 class="mb-4">Tags</h5>
					<a href="#">정규직</a>
					<a href="#">파견직</a>
					<a href="#">위촉직</a>
					<a href="#">계약직</a>
					<a href="#">프리랜서</a>
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