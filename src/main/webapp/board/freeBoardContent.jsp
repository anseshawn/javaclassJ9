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
			location.href="FreeBoardDelete.do?idx="+${vo.idx}+"&replyCnt="+${vo.replyCnt};
		}
		
		// 좋아요 수 (중복 불허)
		function goodCheck(){
			$.ajax({
				url: "BoardGoodCheck.do",
				type: "post",
				data: {
					board:"freeBoard",
					idx:${vo.idx}
				},
				success: function(res){
					if(res != "0") location.reload();
					else alert("이미 좋아요 버튼을 클릭했습니다.");
				},
				error: function() {
					alert("좋아요 전송오류");
				}
			});
		}
		// 신고 (중복 불허)
		function etcShow(){
			$("#reportTxt").show();
		}
		// 신고사항 전송하기
		function reportCheck(){
			if(!$("input[type=radio][name=report]:checked").is(':checked')) {
				alert("신고 사유를 선택하세요.");
				return false;
			}
			if($("input[type=radio]:checked").val()=='기타' && $("#reportTxt").val().trim()==""){
				alert("기타 사유를 입력하세요.");
				return false;
			}
			let rpContent = modalForm.report.value;
			if(rpContent=='기타') rpContent += "/"+$("#reportTxt").val();
			
			let query = {
					board: 'freeBoard',
					boardIdx: ${vo.idx},
					rpMid: '${sMid}',
					rpContent: rpContent 
			}
			
			$.ajax({
				url: "BoardReportOk.do",
				type: "post",
				data: query,
				success: function(res){
					if(res!="0") {
						alert("신고가 완료되었습니다.");
						location.reload();
					}
					else alert("이미 게시글에 대한 신고를 완료했습니다.");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		
		// 댓글 기능
		function replyCheck(){
			let mid = "";
			let nickName = "";
			let content = replyForm.content.value;
			if('${sLevel}'=='') {
				mid = "guest";
				nickName = replyForm.nickName.value;
				if(nickName.trim()=="") {
					alert("댓글 작성자를 입력해주세요.");
					return false;
				}
			}
			else {
				mid = "${sMid}";
				nickName = "${sNickName}";
			}
			if(content.trim()=="") {
				alert("내용을 입력해주세요.");
				return false;
			}
			let query = {
					board: "freeBoard",
					boardIdx: ${vo.idx},
					mid: mid,
					nickName: nickName,
					hostIp: "${pageContext.request.remoteAddr}",
					content: content
			}
			$.ajax({
				url: "ReplyInputOk.do",
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
					alert("댓글전송오류");
				}
			});
		}
		
		function replyDelete(idx) {
			let ans = confirm("현재 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			$.ajax({
				url: "ReplyDelete.do",
				type: "post",
				data: {idx : idx},
				success: function(res){
					if(res != 0){
						alert("댓글을 삭제했습니다.");
						location.reload();
					}
					else alert("답글이 달린 댓글은 삭제할 수 없습니다.");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		// 댓글 수정창 토글
		function replyEdit(idx){
			let replyDisplay = window.getComputedStyle(document.getElementById("reEditDemo"+idx)).display;
			if(replyDisplay=='none') {
				$(".reEditDemo").hide();
				$("#reEditDemo"+idx).show();
			}
			else {
				$("#reEditDemo"+idx).toggle();				
			}
		}
		function editFormClose(idx){
			$("#reEditDemo"+idx).hide();
		}
		// 댓글 수정
		function replyEditCheck(idx) {
			let content = $("#content"+idx).val();
			
			$.ajax({
				url: "ReplyEditOk.do",
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
		
		// 대댓글 영역
		// 대댓글 입력창 토글
		function reReplyForm(idx){
			$(".reEditDemo").hide();
			let reReplyDisplay = window.getComputedStyle(document.getElementById("reReplyDemo"+idx)).display;
			if(reReplyDisplay=='none') {
				$(".reReplyDemo").hide();
				$("#reReplyDemo"+idx).show();
			}
			else {
				$("#reReplyDemo"+idx).toggle();				
			}
		}
		function reReplyFormClose(idx){
			$("#reReplyDemo"+idx).hide();
		}
		// 대댓글 입력
		function reReplyInput(idx){
			let reMid = "";
			let reNickName = "";
			let reContent = $("#reContent"+idx).val();
			if('${sLevel}'=='') {
				reMid = "guest";
				reNickName = $("#guestNickName").val();
				if(reNickName.trim()=="") {
					alert("작성자를 입력해주세요.");
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
					replyIdx: idx,
					mid: reMid,
					nickName: reNickName,
					hostIp: "${pageContext.request.remoteAddr}",
					content: reContent
			}
			$.ajax({
				url: "ReReplyInputOk.do",
				type: "post",
				data: query,
				success: function(res){
					if(res != 0) {
						alert("답글이 등록되었습니다."); 
						location.reload();
					}
					else {
						alert("답글 등록 실패");
					}
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		//대댓글삭제
		function reReplyDelete(reIdx) {
			let ans = confirm("현재 답글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url: "ReReplyDelete.do",
				type: "post",
				data: {reIdx : reIdx},
				success: function(res){
					if(res != 0){
						alert("답글을 삭제했습니다.");
						location.reload();
					}
					else alert("답글 삭제 실패");
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
		// 대댓글 수정창 토글
		function reReplyEdit(reIdx){
			let reReplyEditDisplay = window.getComputedStyle(document.getElementById("reReEditDemo"+reIdx)).display;
			if(reReplyEditDisplay=='none') {
				$(".reReEditDemo").hide();
				$("#reReEditDemo"+reIdx).show();
			}
			else {
				$("#reReEditDemo"+reIdx).toggle();				
			}
		}
		function reEditFormClose(reIdx){
			$("#reReEditDemo"+reIdx).hide();
		}
		// 대댓글 수정
		function reReplyEditCheck(reIdx) {
			let reContent = $("#reContent"+reIdx).val();
			
			$.ajax({
				url: "ReReplyEditOk.do",
				type: "post",
				data: {
					reIdx:reIdx,
					reContent:reContent
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
<c:set var="reCnt" value="0"/>
<c:forEach var="rVo" items="${replyVos}" varStatus="st">
	<c:set var="reCnt" value="${rVo.reCnt}"/>
</c:forEach>
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
									<span class="text-muted text-capitalize mr-3"><i class="icofont-comment mr-2"></i>${vo.replyCnt+reCnt} Comments</span>
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
							    	<c:if test="${vo.mid != sMid}">
						    		<c:if test="${good!='1'}">
								    	<li class="list-inline-item"><a href="javascript:goodCheck()" style="border:2px solid #e12454; border-radius:5px;">
								    		<font color="#e12454"><i class="icofont-thumbs-up mr-1"></i>추천<c:if test="${vo.good > 0}"><span class="ml-1">${vo.good}</span></c:if></font>
								    	</a></li>
						    		</c:if>
						    		<c:if test="${good=='1'}">
								    	<li class="list-inline-item"><a href="javascript:goodCheck()">
								    		<i class="icofont-thumbs-up mr-1"></i>추천<c:if test="${vo.good > 0}"><span class="ml-1">${vo.good}</span></c:if>
								    	</a></li>
						    		</c:if>
							    	<li class="list-inline-item"><a href="#" data-toggle="modal" data-target="#myModal">
							    		<i class="fa-solid fa-triangle-exclamation mr-2"></i>신고
							    	</a></li>
							    	</c:if>
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
							<h4 class="mb-5">${vo.replyCnt+reCnt} 개의 댓글</h4>
							<ul class="comment-tree list-unstyled">
							
								<c:set var="imsiIdx" value="0"/>
								<c:forEach var="rVo" items="${replyVos}" varStatus="st">
									<li class="mb-5">
										<div class="comment-area-box">
										<c:if test="${imsiIdx != rVo.idx}">
											<div class="comment-info">
												<h5 class="mb-1">${rVo.nickName}(${rVo.mid})</h5>
												<span>${rVo.hostIp}</span>
												<span class="date-comm mr-2">| ${rVo.date_diff == 0 ? fn:substring(rVo.rDate,11,19) : fn:substring(rVo.rDate,0,10) }</span>
												<span class="comment-meta mr-2"><a href="javascript:reReplyForm(${rVo.idx})" ><i class="icofont-reply mr-2 text-muted"></i>답글</a></span>
												<c:if test="${sLevel==0 || sMid == rVo.mid}">
												 <span class="comment-meta mr-2"><a href="javascript:replyEdit(${rVo.idx})"><i class="icofont-edit mr-2 text-muted"></i>수정</a></span>
												 <span class="comment-meta"><a href="javascript:replyDelete(${rVo.idx})"><i class="icofont-ui-delete mr-2 text-muted"></i>삭제</a></span>
												</c:if>
											</div>
											<div class="comment-content mt-3">
												${fn:replace(rVo.content,newLine,'<br/>')}
											</div>
											
											<!-- 댓글 수정창 -->
											<div class="reEditDemo" id="reEditDemo${rVo.idx}" style="display:none;">
												<div class="col-lg-10">
												<hr/>
												<form class="comment-form" name="replyEditForm" >
													<div class="row">
														<div class="col-md-4">
															<div class="form-group">
																<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
																	<input class="form-control" type="text" name="nickName" value="${rVo.nickName}(${rVo.mid})" readonly>
																</c:if>
															</div>
														</div>
													</div>
													<textarea class="form-control mb-4" name="content" id="content${rVo.idx}" cols="30" rows="5">${rVo.content}</textarea>
													<div class="text-right">
														<input class="btn btn-main-2 btn-icon-sm btn-round-full mr-2" type="button" onclick="replyEditCheck(${rVo.idx})" value="수정하기"/>
														<input class="btn btn-main btn-icon-sm btn-round-full" type="button" onclick="editFormClose(${rVo.idx})" value="닫기"/>
													</div>
												</form>
												</div>
											</div>
											</c:if>
											<c:set var="imsiIdx" value="${rVo.idx}"/>
											<!-- 댓글 수정창 끝 -->
											<!-- 대댓글 창 -->
											<c:if test="${!empty rVo.reContent}">
											<hr/>
												<div class="col-lg-8">
												<div class="comment-info">
													<h5 class="mb-1">${rVo.reNickName}(${rVo.reMid})</h5>
													<span>${rVo.reHostIp}</span>
													<span class="date-comm mr-2">| ${rVo.reDate_diff == 0 ? fn:substring(rVo.reDate,11,19) : fn:substring(rVo.reDate,0,10) }</span>
													<c:if test="${sLevel==0 || sMid == rVo.reMid}">
													 <span class="comment-meta mr-2"><a href="javascript:reReplyEdit(${rVo.reIdx})"><i class="icofont-edit mr-2 text-muted"></i>수정</a></span>
													 <span class="comment-meta"><a href="javascript:reReplyDelete(${rVo.reIdx})"><i class="icofont-ui-delete mr-2 text-muted"></i>삭제</a></span>
													</c:if>
												</div>
												<div class="comment-content mt-3">
													${fn:replace(rVo.reContent,newLine,'<br/>')}
												</div>
												</div>
											</c:if>
											<!-- 대댓글 창 끝 -->
											<!-- 대댓글 수정창 -->
											<div class="reReEditDemo" id="reReEditDemo${rVo.reIdx}" style="display:none;">
												<div class="col-lg-10">
												<hr/>
												<form class="comment-form" name="reReplyEditForm" >
													<div class="row">
														<div class="col-md-4">
															<div class="form-group">
																<input class="form-control" type="text" name="reNickName" value="${rVo.reNickName}(${rVo.reMid})" readonly>
															</div>
														</div>
													</div>
													<textarea class="form-control mb-4" name="reContent" id="reContent${rVo.reIdx}" cols="30" rows="5">${rVo.reContent}</textarea>
													<div class="text-right">
														<input class="btn btn-main-2 btn-icon-sm btn-round-full mr-2" type="button" onclick="reReplyEditCheck(${rVo.reIdx})" value="수정하기"/>
														<input class="btn btn-main btn-icon-sm btn-round-full" type="button" onclick="reEditFormClose(${rVo.reIdx})" value="닫기"/>
													</div>
												</form>
												</div>
											</div>
											<!-- 대댓글 수정창 끝 -->
											<!-- 대댓글 입력창 -->
											<div class="reReplyDemo" id="reReplyDemo${rVo.idx}" style="display:none;">
												<div class="col-lg-10">
												<hr/>
												<form class="comment-form" name="reReplyForm" >
													<div class="row">
														<div class="col-md-4">
															<div class="form-group">
																<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
																	<input class="form-control" type="text" name="reNickName" value="${sNickName}(${sMid})" readonly>
																</c:if>
																<c:if test="${sLevel!=0 && sLevel!=1 && sLevel!=2}">
																	<input class="form-control" type="text" name="reNickName" id="guestNickName" placeholder="Name:">
																</c:if>
															</div>
														</div>
													</div>
													<textarea class="form-control mb-4" name="content" id="reContent${rVo.idx}" cols="30" rows="5"></textarea>
													<div class="text-right">
														<input class="btn btn-main-2 btn-icon-sm btn-round-full mr-2" type="button" onclick="reReplyInput(${rVo.idx})" value="등록하기"/>
														<input class="btn btn-main btn-icon-sm btn-round-full" type="button" onclick="reReplyFormClose(${rVo.idx})" value="닫기"/>
													</div>
												</form>
												</div>
											</div>
											<!-- 대댓글 입력창 끝 -->
										</div>
									</li>
								</c:forEach>
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
										<c:if test="${sLevel!=0 && sLevel!=1 && sLevel!=2}">
											<input class="form-control" type="text" name="nickName" placeholder="Name:">
										</c:if>
									</div>
								</div>
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
							<c:if test="${empty flag}"><a href="FreeBoard.do?pag=${pag}&pageSize=${pageSize}" class="btn btn-main btn-icon" style="padding: .4rem 1.2rem;">목록으로</a></c:if>
							<c:if test="${!empty flag}"><a href="FreeBoardSearch.do?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}" class="btn btn-main btn-icon" style="padding: .4rem 1.2rem;">목록으로</a></c:if>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-lg-4">
				<div class="sidebar-wrap pl-lg-4 mt-5 mt-lg-0">
				<c:if test="${sLevel==0 || sLevel==1 || sLevel==2}">
					<div class="sidebar-widget write mb-3 ">
						<a href="FreeBoardInput.do" class="btn btn-main-2 btn-icon btn-round-full" style="width:80%; margin:8px;">글쓰기</a>
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
	
				</div>
    	</div>   
		</div>
	</div>
</section>
</div>
<p><br/></p>

<!-- 신고하기 폼 modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <div class="modal-title">현재 게시글 신고하기</div>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
      	<h3 class="mt-2">신고사유</h3>
      	<div class="divider2 mt-4 mb-4" style="width:100%"></div>
      	<form name="modalForm">
      		<div class="mb-2"><input type="radio" name="report" id="report1" value="광고,홍보,영리목적" /> 광고,홍보,영리목적</div>
      		<div class="mb-2"><input type="radio" name="report" id="report2" value="욕설,비방,차별,혐오" /> 욕설,비방,차별,혐오</div>
      		<div class="mb-2"><input type="radio" name="report" id="report3" value="불법정보" /> 불법정보</div>
      		<div class="mb-2"><input type="radio" name="report" id="report4" value="음란,청소년유해" /> 음란,청소년유해</div>
      		<div class="mb-2"><input type="radio" name="report" id="report5" value="개인정보노출,유포,거래" /> 개인정보노출,유포,거래</div>
      		<div class="mb-2"><input type="radio" name="report" id="report6" value="도배,스팸" /> 도배,스팸</div>
      		<div class="mb-2"><input type="radio" name="report" id="report7" value="기타" onclick="etcShow()" /> 기타</div>
      		<div id="etc"><textarea rows="2" id="reportTxt" class="form-control" style="display:none"></textarea> </div>
      		<div class="divider2 mt-4 mb-4" style="width:100%"></div>
      		<input type="button" value="확인" onclick="reportCheck()" class="btn btn-main-2 btn-icon-sm form-control" />
      	</form>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-main btn-icon-sm" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>