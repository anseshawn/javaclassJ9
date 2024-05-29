<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>자유게시판 - ${vo.title}</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
		'use strict';
		
		function deleteCheck(){
			let ans = confirm("현재 게시글을 삭제하시겠습니까?");
			if(!ans) return false;
			else if(${vo.replyCnt} != 0) {
				ans = confirm("현재 게시글을 삭제하면 다른 회원의 댓글까지 모두 삭제됩니다.\n정말 삭제하시겠습니까?");
				if(!ans) return false;
			}
			location.href="FreeBoardDelete.bo?idx="+${vo.idx}+"&replyCnt="+${vo.replyCnt};
		}
		
		function replyCheck(){
			let reMid = "";
			let reNickName = "";
			//let reEmail = "";
			let reContent = replyForm.content.value;
			if('${sLevel}'=='') {
				reMid = "guest";
				reNickName = replyForm.nickName.value;
				//reEmail = replyForm.email.value;
				if(reNickName.trim()=="") {
					alert("댓글 작성자를 입력해주세요.");
					return false;
				}
			}
			else {
				reMid = "${sMid}"
				reNickName = "${sNickName}";
			}
			if(reContent.trim()=="") {
				alert("내용을 입력해주세요.");
				return false;
			}
			let query = {
					board: "freeBoard",
					boardIdx: ${vo.idx},
					mid: reMid,
					nickName: reNickName,
					hostIp: "${pageContext.request.remoteAddr}",
					content: reContent
			}
			$.ajax({
				url: "ReplyInputOk.bo",
				type: "post",
				data: query,
				success: function(res){
					if(res != 0) {
						alert("댓글이 등록되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 등록 실패");
					}
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		
		function replyDelete(reIdx) {
			let ans = confirm("현재 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url: "ReplyDelete.bo",
				type: "post",
				data: {idx : reIdx},
				success: function(res){
					if(res != 0){
						alert("댓글을 삭제했습니다.");
						location.reload();
					}
					else alert("댓글 삭제 실패");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		
		//let editForm = 0;
		function replyEdit(idx,nickName,mid,content){
			/* 토글처럼 버튼 하나로 창 제어...?
			if(editForm != 0) {
				let item = document.getElementById("reEditDemo"+idx);
				item.remove(item);
			}
			*/
			//else {
			let str='<div class="col-lg-10">';
			str+='<hr/>';
			str+='<form class="comment-form" name="replyEditForm" >';
			str+='<div class="row">';
			str+='<div class="col-md-4">';
			str+='<div class="form-group">';
			str+='<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">';
			str+='<input class="form-control" type="text" name="nickName" value="'+nickName+'('+mid+')" readonly>';
			str+='</c:if>';
			str+='</div>';
			str+='</div>';
			str+='</div>';
			str+='<textarea class="form-control mb-4" name="content" id="content'+idx+'" cols="30" rows="5" placeholder="Comment">'+content+'</textarea>';
			str+='<div class="text-right">';
			str+='<input class="btn btn-main-2 btn-icon-sm btn-round-full mr-2" type="button" onclick="replyEditCheck('+idx+')" value="수정하기"/>';
			str+='<input class="btn btn-main btn-icon-sm btn-round-full" type="button" onclick="editFormClose('+idx+')" value="닫기"/>';
			str+='</div>';
			str+='</form>';
			str+='</div>';
			
			$("#reEditDemo"+idx).html(str);
			//editForm = 1;
			//}
		}
		
		function replyEditCheck(idx) {
			let content = $("#content"+idx).val();
			
			$.ajax({
				url: "ReplyEditOk.bo",
				type: "post",
				data: {
					idx:idx,
					content:content
				},
				success:function(res) {
					if(res != 0) {
						location.reload();
					}
				},
				error: function(){
					alert("전송 오류");
				}
			});
		}
		function editFormClose(idx){
			$("#reEditDemo"+idx).hide();
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
					<div class="col-lg-12 mb-5">
						<div class="single-blog-item">
							<div class="blog-item-content mt-2">
								<div class="blog-item-meta mb-3">
									<span class="text-muted text-capitalize mr-3"><i class="fa-solid fa-eye mr-2"></i>${vo.readNum}</span>
									<span class="text-muted text-capitalize mr-3"><i class="icofont-comment mr-2"></i>${vo.replyCnt} Comments</span>
									<span class="text-black text-capitalize mr-3"><i class="icofont-calendar mr-2"></i> ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10) }</span>
								</div>
												
								<h2 class="mb-2 text-md"><a href="#">${vo.title}</a></h2>
								<div class="nav-item lead mb-4 font-weight-normal text-black">${vo.nickName}(${vo.mid})</div>
								<c:if test="${sLevel==0 || sMid==vo.mid}">
									<div class="text-right">
										<input type="button" value="수정하기" onclick="location.href='FreeBoardEdit.do?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-main-2 btn-icon-sm btn-round-full mr-2" >
										<input type="button" value="삭제하기" onclick="deleteCheck()" class="btn btn-main btn-icon-sm btn-round-full" >
									</div>
								</c:if>
								<hr/>
								<p>${fn:replace(vo.content,newLine,'<br/>')}</p>
				
								<div class="mt-5 clearfix">
							    <ul class="float-left list-inline tag-option">
							    	<li class="list-inline-item"><a href="#">
							    		<i class="icofont-thumbs-up mr-1"></i>추천<c:if test="${vo.good > 0}"><span class="ml-1">${vo.good}</span></c:if>
							    	</a></li>
							    	<li class="list-inline-item"><a href="#"><i class="fa-solid fa-triangle-exclamation mr-2"></i>신고</a></li>
							   	</ul>        
							    <ul class="float-right list-inline">
						        <li class="list-inline-item"> 공유하기: </li>
						        <li class="list-inline-item"><a href="#" target="_blank"><i class="icofont-facebook" aria-hidden="true"></i></a></li>
						        <li class="list-inline-item"><a href="#" target="_blank"><i class="icofont-twitter" aria-hidden="true"></i></a></li>
						        <li class="list-inline-item"><a href="#" target="_blank"><i class="icofont-linkedin" aria-hidden="true"></i></a></li>
							  	</ul>
							  </div>
							</div>
						</div>
					</div>

					<div class="col-lg-12">
						<div class="comment-area mt-4 mb-5">
							<h4 class="mb-5">${vo.replyCnt} 개의 댓글</h4>
							<ul class="comment-tree list-unstyled">
								<c:forEach var="rVo" items="${replyVos}" varStatus="st">
									<li class="mb-5">
										<div class="comment-area-box">
											<!-- 
											<div class="comment-thumb float-left">
												<img alt="" src="images/blog/noimage.jpg" width="50px" class="img-fluid">
											</div>
											 -->
											<div class="comment-info">
												<h5 class="mb-1">${rVo.nickName}(${rVo.mid})</h5>
												<span>${rVo.hostIp}</span>
												<span class="date-comm mr-2">| ${rVo.date_diff == 0 ? fn:substring(rVo.rDate,11,19) : fn:substring(rVo.rDate,0,10) }</span>
												<span class="comment-meta mr-2"><a href="#"><i class="icofont-reply mr-2 text-muted"></i>답글</a></span>
												<c:if test="${sLevel==0 || sMid == rVo.mid}">
												 <span class="comment-meta mr-2"><a href="javascript:replyEdit('${rVo.idx}','${rVo.nickName}','${rVo.mid}','${rVo.content}')"><i class="icofont-edit mr-2 text-muted"></i>수정</a></span>
												 <span class="comment-meta"><a href="javascript:replyDelete(${rVo.idx})"><i class="icofont-ui-delete mr-2 text-muted"></i>삭제</a></span>
												</c:if>
											</div>
											<div class="comment-content mt-3">
												${fn:replace(rVo.content,newLine,'<br/>')}
											</div>
											<div id="reEditDemo${rVo.idx}">
											
											</div>
										</div>
									</li>
								</c:forEach>
								<!-- 
								<li>
									<div class="comment-area-box">
										<div class="comment-thumb float-left">
											<img alt="" src="images/blog/testimonial2.jpg" class="img-fluid">
										</div>
										<div class="comment-info">
											<h5 class="mb-1">Philip W</h5>
											<span>United Kingdom</span>
											<span class="date-comm">| Posted June 7, 2019</span>
										</div>
				
										<div class="comment-meta mt-2">
											<a href="#"><i class="icofont-reply mr-2 text-muted"></i>Reply </a>
										</div>
				
										<div class="comment-content mt-3">
											<p>Some consultants are employed indirectly by the client via a consultancy staffing company, a company that provides consultants on an agency basis. </p>
										</div>
									</div>
								</li>
								-->
								
							</ul>
						</div>
					</div>
					<div class="col-lg-12">
					<hr/>
						<form class="comment-form my-5" name="replyForm" >
							<h4 class="mb-4">댓글 쓰기</h4>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
											<input class="form-control" type="text" name="nickName" value="${sNickName}(${sMid})" readonly>
										</c:if>
										<c:if test="${sLevel==''}">
											<input class="form-control" type="text" name="nickName" placeholder="Name:">
										</c:if>
									</div>
								</div>
								<!-- 
								<c:if test="${sLevel!=0 && sLevel!=1 && sLevel!=2}">
									<div class="col-md-6">
										<div class="form-group">
											<input class="form-control" type="text" name="email" id="email" placeholder="Email:">
										</div>
									</div>
								</c:if>
								 -->
							</div>
							<textarea class="form-control mb-4" name="content" id="content" cols="30" rows="5" placeholder="Comment"></textarea>
							<div class="text-right">
								<input class="btn btn-main-2 btn-round-full" type="button" onclick="replyCheck()" value="댓글 작성"/>
							</div>
						</form>
					</div>
					<div class="col-lg-12 text-center">
						<div class="mt-5">
							<hr/>
							<a href="FreeBoard.do?pag=${pag}&pageSize=${pageSize}" class="btn btn-main btn-icon" style="padding: .4rem 1.2rem;">목록으로</a>
						</div>
					</div>
				</div>
			</div>
      <div class="col-lg-4">
				<div class="sidebar-wrap pl-lg-4 mt-5 mt-lg-0">
					<!-- 검색창 -->
					<div class="sidebar-widget search mb-3 ">
						<h5>게시판 검색</h5>
						<form name="search-form" method="post" action="BoardSearchList.bo">
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