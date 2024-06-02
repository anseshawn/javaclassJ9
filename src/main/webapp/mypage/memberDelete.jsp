<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>그린 엔지니어링에 오신 것을 환영합니다!</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		ul {
		  display: block;
		  list-style-type: disc;
		  margin-block-start: 1em;
		  margin-block-end: 1em;
		  margin-inline-start: 0px;
		  margin-inline-end: 0px;
		  padding-inline-start: 40px;
		  padding-inline-end: 20px;
		}
	</style>
	<script>
		'use strict';
		
		function etcShow(){
			$("#resonTxt").show();
		}
		function etcHide(){
			$("#resonTxt").hide();
		}
		
		function MemberDeleteOk(){
			if(!$("input[type=radio][name=deleteReason]:checked").is(':checked')) {
				alert("탈퇴 사유를 선택하세요.");
				return false;
			}
			if($("input[type=radio]:checked").val()=='6' && $("#resonTxt").val().trim()==""){
				alert("기타 사유를 입력하세요.");
				return false;
			}
			let deleteReason = myform.deleteReason.value;
			if(deleteReason=='6') deleteReason += "/"+$("#resonTxt").val();
			
			let query={
					
			}
			$.ajax({
				url: "",
				type: "post",
				data: query,
				success: function(res) {
					
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
	<div class="row justify-content-center mb-3">
		<div class="col-lg-8">
			<h2>회원탈퇴</h2>
		</div>
	</div>
	<div class="divider2 mx-auto my-4" style="width:80%;"></div>
	<div class="row justify-content-center mb-5">
		<div class="col-lg-8 col-lg-offset-2" style="border:1px solid #eee; color:black;">
			<ul>
				<li class="mb-4">
				회원 탈퇴 시 회원님의 계정 및 프로필이 삭제됩니다. 삭제된 정보는 어떠한 경우에도 복구할 수 없으며,
				<font color="red">작성한 글 및 댓글은 자동으로 삭제되지 않습니다.</font>
				</li>
				<li>
					<div>회원으로 탈퇴하시면 같은 아이디로 한달 간 활동하실 수 없습니다.</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="row justify-content-center mb-5">
		<div class="col-lg-8 col-lg-offset-2">
			<form name="myform" method="post" action="#">
				<p>탈퇴하는 이유를 말씀해주세요. 사이트 개선에 중요 자료로 활용하겠습니다.</p>
				<div class="mb-2">
					<input type="radio" id="reason1" value="1" name="deleteReason" onclick="etcHide()">
	        <label for="reason1">기록 삭제 목적</label>
        </div>
        <div class="mb-2">
					<input type="radio" id="reason2" value="2" name="deleteReason" onclick="etcHide()">
	        <label for="reason2">이용이 불편해서</label>
        </div>
        <div class="mb-2">
					<input type="radio" id="reason3" value="3" name="deleteReason" onclick="etcHide()">
	        <label for="reason3">다른 사이트가 더 좋아서</label>
        </div>
        <div class="mb-2">
					<input type="radio" id="reason4" value="4" name="deleteReason" onclick="etcHide()">
	        <label for="reason4">사용 빈도가 낮아서</label>
        </div>
        <div class="mb-2">
					<input type="radio" id="reason5" value="5" name="deleteReason" onclick="etcHide()">
	        <label for="reason5">콘텐츠 불만</label>
        </div>
        <div class="mb-2">
					<input type="radio" id="reason6" value="6" name="deleteReason" onclick="etcShow()">
	        <label for="reason6">기타</label>
				</div>
        <div id="etc"><textarea rows="2" id="resonTxt" class="form-control" style="display:none"></textarea></div>
			</form>
		</div>
	</div>
	<div class="row justify-content-center mt-3 mb-3">
		<div class="col-lg-8">
			<form name="enterPwd">
				<h4>현재 비밀번호</h4>
				<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" required/>
				<div class="text-right" style="font-size:12px;"><a href="#">비밀번호를 잊으셨습니까?</a></div>
				<a href="MemberUpdate.do" class="btn btn-main btn-icon-sm float-left mt-5">뒤로</a>
				<a href="javascript:MemberDeleteOk()" class="btn btn-main-2 btn-icon-sm float-right mt-5">탈퇴하기</a>
			</form>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>