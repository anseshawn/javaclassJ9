<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>자유게시판</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		.blog-item-content .title {
			font-family: "Do Hyeon";
		  font-weight: 700;
		  font-size: 30px;
		}
	</style>
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
          <span class="text-white">다양한 이야기를 올려주세요</span>
          <h1 class="text-capitalize mb-5 text-lg"><a href="FreeBoard.do" style="color: #fff;">자유게시판</a></h1>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section blog-wrap">
	<div class="container">
		<div class="row">
 			<div class="col-lg-8">
				<div class="row">
				
					<div class="col-lg-12 col-md-12 mb-3">
						<div class="blog-item">
							<div class="blog-item-content">
								<div class="blog-item-meta mb-3 mt-4">
									<span class="text-muted text-capitalize mr-3"><i class="icofont-comment mr-2"></i>5 Comments</span>
									<span class="text-black text-capitalize mr-3"><i class="icofont-calendar mr-1"></i> 28th January</span>
								</div> 
								<h2 class="mt-3 mb-3"><a href="#">작업중...</a></h2>
								<!-- <p class="mb-4">[에너지데일리 조남준 기자] 환경부 소속 국립환경과학원(원장 김동진)은 대기오염물질 배출시설의 시료채취 및 분석방법 등 최신 기술동향을 반영해 제·개정한 대기오염공정시험기준을 국립환경과학원 누리집(nier.go.kr)에 4일 공개한다.</p>
								<a href="blog-single.html" target="_blank" class="btn btn-main btn-icon btn-round-full">게시글 보기<i class="icofont-simple-right ml-2  "></i></a> -->
							</div>
						</div>
						<hr/>
					</div>
					<hr/>

					<c:set var="curScrStartNo" value="${curScrStartNo}"/>
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<div class="col-lg-12 col-md-12 mb-3">
							<div class="blog-item">
								<div class="blog-item-content">
									<div class="blog-item-meta mb-3 mt-4">
										<span class="text-muted text-capitalize mr-3"><i class="fa-solid fa-eye mr-2"></i>${vo.readNum}</span>
										<span class="text-muted text-capitalize mr-3"><i class="icofont-comment mr-2"></i>${vo.replyCnt} Comments</span>
										<span class="text-black text-capitalize mr-3">
											<i class="icofont-calendar mr-2"></i> ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10) }
										</span>
										<span class="text-muted text-capitalize mr-3"><i class="icofont-user mr-2"></i>${vo.nickName}</span>										
									</div> 
									<div class="title mt-3 mb-3">
										<a href="FreeBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
									</div>
									<p class="mb-4">
										<a href="FreeBoardContent.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" target="_blank" class="btn btn-main btn-icon-sm btn-round-full">새창으로 보기<i class="icofont-simple-right ml-2  "></i></a>
									</p>
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
			          <c:if test="${pag > 1}"><a class="page-numbers" href="${ctp}/FreeBoard.do?pag=1&pageSize=${pageSize}"><i class="icofont-thin-double-left"></i></a></c:if>
			          <c:if test="${curBlock > 0}"><a class="page-numbers" href="${ctp}/FreeBoard.do?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}"><i class="icofont-thin-left"></i></a></c:if>
								<c:forEach var="i" begin="${(curBlock*blockSize+1)}" end="${(curBlock)*blockSize+blockSize}" varStatus="st">
									<c:if test="${i <= totPage && i == pag}"><span aria-current="page" class="page-numbers current">${i}</span></c:if>
									<c:if test="${i <= totPage && i != pag}"><a class="page-numbers" href="${ctp}/FreeBoard.do?pag=${i}&pageSize=${pageSize}">${i}</a></c:if>
								</c:forEach>
								<c:if test="${curBlock < lastBlock}"><a class="page-numbers" href="${ctp}/FreeBoard.do?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}"><i class="icofont-thin-right"></i></a></c:if>
								<c:if test="${pag < totPage}"><a class="page-numbers" href="${ctp}/FreeBoard.do?pag=${totPage}&pageSize=${pageSize}"><i class="icofont-thin-double-right"></i></a></c:if>
		        	</div>
		      	</nav>
					</div>
				</div>
				<!-- 블록페이지 끝 -->
			</div>
			
			<div class="col-lg-4">
				<div class="sidebar-wrap pl-lg-4 mt-5 mt-lg-0">
				<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
					<div class="sidebar-widget write mb-3 ">
						<a href="FreeBoardInput.do" class="btn btn-main-2 btn-icon btn-round-full" style="width:300px; margin:8px;">글쓰기</a>
					</div>
				</c:if>	
					<!-- 검색창 -->
					<div class="sidebar-widget search mb-3 ">
						<h5>게시판 검색</h5>
						<form name="search-form" method="post" action="FreeBoardSearch.do">
							<select name="search" id="search" class="form-control">
								<option value="title">제목</option>
								<option value="nickName">작성자</option>
								<option value="content">내용</option>
							</select>
							<div class="input-group mb-1">
								<input type="text" name="searchString" id="searchString" class="form-control mt-2" placeholder="검색어를 입력하세요." required />
								<i class="ti-search"></i>
								<div class="input-group-append">
									<input type="submit" value="  search  " class="btn btn-main btn-icon-sm btn-round mt-2"/>
								</div>
							</div>
						</form>
					</div>
					<!-- 검색창 끝 -->
					
					<div class="sidebar-widget latest-post mb-3">
						<h5>인기 게시글</h5>
						<c:forEach var="gVo" items="${gVos}" varStatus="st">
	        		<div class="py-2">
		        		<span class="text-sm text-muted">${gVo.date_diff == 0 ? fn:substring(gVo.wDate,11,19) : fn:substring(gVo.wDate,0,10) }</span>
		            <h6 class="my-2"><a href="FreeBoardContent.do?idx=${gVo.idx}&pag=${pag}&pageSize=${pageSize}">${gVo.title}</a></h6>
	        		</div>
        		</c:forEach>
					</div>

					<!-- 
					<div class="sidebar-widget category mb-3">
						<h5 class="mb-4">분류</h5>
						<ul class="list-unstyled">
						  <li class="align-items-center">
						    <a href="#">Medicine</a>
						    <span>(14)</span>
						  </li>
						  <li class="align-items-center">
						    <a href="#">Equipments</a>
						    <span>(2)</span>
						  </li>
						  <li class="align-items-center">
						    <a href="#">Heart</a>
						    <span>(10)</span>
						  </li>
						  <li class="align-items-center">
						    <a href="#">Free counselling</a>
						    <span>(5)</span>
						  </li>
						  <li class="align-items-center">
						    <a href="#">Lab test</a>
						    <span>(5)</span>
						  </li>
						</ul>
					</div>
					-->
					<div class="sidebar-widget tags mb-3">
						<h5 class="mb-4">Tags</h5>
						<a href="#">Doctors</a>
						<a href="#">agency</a>
						<a href="#">company</a>
						<a href="#">medicine</a>
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