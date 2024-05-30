<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원정보 수정</title>
	<jsp:include page="/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
	<script>
 		'use strict';
	 	// 개인 / 재직자에 따라 회사 정보 입력창 보이기/감추기
	 	$(function(){
	 		if("${vo.mGroup}"=="재직자")
	 		$("#company").show();
	 		$("#personMent").hide(); 		
	 	});
	 	function companyShow(){
	 		$("#company").show(); 		
	 		$("#personMent").hide(); 		
	 	}
	 	function companyHide(){
	 		$("#company").hide(); 		
	 		$("#personMent").show(); 		
	 	}
 	
 		let idCheckSw = 0;
		let nickCheckSw = 0;
    
		function fCheck() {
			// 필수항목 입력여부 확인 
			let mid = document.getElementById("mid").value.trim();
			let nickName = document.getElementById("nickName").value.trim();
			let name = document.getElementById("name").value.trim();
			let email1 = myform.email1.value.trim();
			
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
				return false;
			}
			else if(nickName == "") {
				alert("닉네임을 입력하세요");
				myform.nickName.focus();
				return false;
			}
			else if(name == "") {
				alert("이름을 입력하세요");
				myform.name.focus();
				return false;
			}
			else if(email1 == "") {
				alert("이메일을 입력하세요");
				myform.email1.focus();
				return false;
			}
			
			// 1.정규식을 이용한 유효성 검사처리
			// 아이디와 닉네임은 중복체크 검사시에 수행...
			let regName = /^[a-zA-Z가-힣]{2,10}$/; 
			let regEmail = /^[a-zA-Z0-9]([-_]?[a-zA-Z0-9])*$/i;
			let regTel = /\d{2,3}-\d{3,4}-\d{4}$/;
			if(!regName.test(name)) {
				alert("이름은 영문과 한글만 사용하여 2~10자까지 가능합니다.");
				document.getElementById("name").focus();
				return false;
			}
			if(!regEmail.test(email1)) {
				alert("이메일 형식에 맞도록 작성해주세요.");
				myform.email1.focus();
				return false;
			}    	
			
			// 2.검사 후 필요한 내용들을 변수에 담아 회원가입 처리한다.
			
			let email2 = myform.email2.value;
			let email = email1+"@"+email2;
			// 개인 연락처
			let tel1 = myform.tel1.value;
			let tel2 = myform.tel2.value.trim();
			let tel3 = myform.tel3.value.trim();
			let phone = tel1+"-"+tel2+"-"+tel3;
			// 회사 연락처
			let tel4 = myform.tel4.value;
			let tel5 = myform.tel5.value.trim();
			let tel6 = myform.tel6.value.trim();
			let cTel = tel4+"-"+tel5+"-"+tel6;
			if(tel2 != "" || tel3 != ""){
			 	if(!regTel.test(phone)) {
			 		alert("연락처를 형식(000-0000-0000)에 맞도록 작성해주세요.");
			 		myform.tel2.focus();
			 		return false;
			 	}
			}
			else {
				tel2 = " ";
				tel3 = " ";
				phone = tel1+"-"+tel2+"-"+tel3;
			}
			if(tel5 != "" || tel6 != ""){
			 	if(!regTel.test(cTel)) {
			 		alert("회사 연락처를 형식(000-0000-0000)에 맞도록 작성해주세요.");
			 		myform.tel5.focus();
			 		return false;
			 	}
			}
			else {
				tel5 = " ";
				tel6 = " ";
				cTel = tel4+"-"+tel5+"-"+tel6;
			}
			
			// 개인 주소
			let postcode = myform.postcode.value + " ";
			let roadAddress = myform.roadAddress.value + " ";
			let detailAddress = myform.detailAddress.value + " ";
			let extraAddress = myform.extraAddress.value + " ";
			let address = postcode+"/"+roadAddress+"/"+detailAddress+"/"+extraAddress;
			
			// 회사 주소
			let cPostcode = myform.cPostcode.value + " ";
			let cRoadAddress = myform.cRoadAddress.value + " ";
			let cDetailAddress = myform.cDetailAddress.value + " ";
			let cExtraAddress = myform.cExtraAddress.value + " ";
			let cAddress = cPostcode+"/"+cRoadAddress+"/"+cDetailAddress+"/"+cExtraAddress;
			
			// 회원 가입 전 체크
			if(nickCheckSw == 0) {
				alert("닉네임 중복 체크를 수행해주세요.");
				document.getElementById("nickNameBtn").focus();
			}
			else {
				myform.email.value = email; // email 결합
				myform.phone.value = phone;
				myform.cTel.value = cTel;
				myform.address.value = address;
				myform.cAddress.value = cAddress;
				
				/* 값 넘어왔는지 확인하는 과정
				let su = "";
				let checkedValues = [];
				let checkboxes = document.getElementsByName("purpose");
				alert(checkboxes);
				for (let i = 0; i < checkboxes.length; i++) {
				    if (checkboxes[i].checked) {
				        su += checkboxes[i].value; // value를 숫자로 변환하여 더하기
				        checkedValues.push(checkboxes[i].value); // 체크된 값들을 배열에 추가
				    }
				}
		
				alert("su: " + su);
				alert("Checked values: " + checkedValues.join(", "));
				*/
				
				myform.submit();
			}
		}
  
 // 닉네임 중복체크
	function nickCheck() {
		let nickName = document.getElementById("nickName").value.trim();
		let regNickName = /^[a-zA-Z0-9가-힣]{2,10}$/;
		if(nickName.trim() == "") {
			alert("닉네임을 입력하세요.");
			myform.nickName.focus();
			return false;
		}
		else if(nickName == "${sNickName}") {
			nickCheckSw = 1;
			$("#nickNameBtn").attr("disabled",true);
			return false;
		}
		else if(!regNickName.test(nickName)){
			alert("닉네임은 영문과 한글, 숫자만 사용하여 2~10자까지 가능합니다.");
			document.getElementById("nickName").focus();
			return false;
		}
		else {
			nickCheckSw = 1;
			$.ajax({
				url: "${ctp}/MemberNickCheck.mem",
				type: "get",
				data: {nickName:nickName, mid:""},
				success: function(res) {
					if(res != 0) {
						alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
						nickCheckSw = 0;
						myform.nickName.focus();
					}
					else {
						alert("사용 가능한 닉네임 입니다.");
						$("#nickNameBtn").attr("disabled",true);
					}
				},
				error : function() {
					alert("전송 오류");
				}
			});
		}
	}
  
	// 입력창 누르면 스위치 리셋...?
	window.onload = function(){
		nickName.addEventListener('click',function(){
			nickCheckSw = 0;
			$("#nickNameBtn").removeAttr("disabled");
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
<div class="row justify-content-center">
<div class="col-xl-6 col-lg-8">
	<form name="myform" method="post" action="${ctp}/MemberUpdateOk.mem" class="was-validated">
    <h2 class="text-center">회원정보 수정</h2>
    <br/>
    <div class="form-group">
      <label for="name">이름 :</label>
      <input type="text" class="form-control" id="name" value="${vo.name}" name="name" required autofocus />
    </div>
    <div class="form-group">
      <label for="mid">아이디 : </label>
      <input type="text" class="form-control text-sm" name="mid" id="mid" value="${sMid}" readonly required />
    </div>
    <div class="form-group text-center">
      <a href="PwdChange.do" class="btn btn-main btn-icon-sm btn-round form-control">비밀번호 변경하기</a>
    </div>
    <div class="form-group">
      <label for="mid">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" id="nickNameBtn" class="btn btn-main-2 btn-round-full btn-icon-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control text-sm" name="nickName" id="nickName" value="${vo.nickName}" required />
    </div>
    <div class="form-group">
      <label for="email1">E-mail address: &nbsp;&nbsp;</label>
        <div class="form-check-inline">
	        <label class="form-check-label" style="font-size:13px">
	          <input type="checkbox" class="form-check-input" value="OK" name="emailNews" ${vo.emailNews=='OK' ? 'checked' : '' }/>뉴스레터 구독하기
	        </label>
      	</div>
        <div class="input-group mb-3">
        	<c:set var="email" value="${fn:split(vo.email,'@')}"/>
          <input type="text" class="form-control" value="${email[0]}" id="email1" name="email1" required />
          <select name="email2" class="form-control" style="height:auto">
            <option value="naver.com" ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
            <option value="gmail.com" ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
            <option value="hanmail.net" ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
            <option value="daum.net" ${email[1]=='daum.net' ? 'selected' : ''}>daum.net</option>
            <option value="nate.com" ${email[1]=='nate.com' ? 'selected' : ''}>nate.com</option>
            <option value="yahoo.com" ${email[1]=='yahoo.com' ? 'selected' : ''}>yahoo.com</option>
            <option value="korea.com" ${email[1]=='korea.com' ? 'selected' : ''}>korea.com</option>
          </select>
        </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control"/>
    </div>
    <div class="form-group-2">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select" style="height:auto">
              <option value="010" ${tel1=='010' ? 'selected' : ''}>010</option>
              <option value="02" ${tel1=='02' ? 'selected' : ''}>02</option>
              <option value="031" ${tel1=='031' ? 'selected' : ''}>031</option>
              <option value="032" ${tel1=='032' ? 'selected' : ''}>032</option>
              <option value="041" ${tel1=='041' ? 'selected' : ''}>041</option>
              <option value="042" ${tel1=='042' ? 'selected' : ''}>042</option>
              <option value="043" ${tel1=='043' ? 'selected' : ''}>043</option>
              <option value="051" ${tel1=='051' ? 'selected' : ''}>051</option>
              <option value="052" ${tel1=='052' ? 'selected' : ''}>052</option>
              <option value="061" ${tel1=='061' ? 'selected' : ''}>061</option>
              <option value="062" ${tel1=='062' ? 'selected' : ''}>062</option>
            </select>-
        </div>
        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-main-2 btn-round btn-icon-sm">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" value="${roadAddress}" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">분류 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="mGroup" value="개인" onclick="companyHide()" ${vo.mGroup=='개인'?'checked':''}>개인
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="mGroup" onclick="companyShow()" value="재직자" ${vo.mGroup=='재직자'?'checked':''}>재직자
        </label>
      </div>
      <div id="personMent" class="text-center" style="font-size:13px">개인 고객의 경우 일부 물품 구매가 제한될 수 있습니다.</div>
    </div>
    <div id="company">
	    <div class="form-group">
	      <label for="cName">회사명</label>
	      <input type="text" class="form-control" name="cName" value="${vo.cName}" id="cName"/>
	    </div>
	    <div class="form-group">
	      <label for="name">업종을 선택하세요.</label>
	      <select class="form-control" id="cCategory" name="cCategory">
	        <option ${vo.cCategory=='바이오 및 제약'?'selected':''}>바이오 및 제약</option>
	        <option ${vo.cCategory=='에너지 및 화학'?'selected':''}>에너지 및 화학</option>
	        <option ${vo.cCategory=='식품 및 음료'?'selected':''}>식품 및 음료</option>
	        <option ${vo.cCategory=='환경'?'selected':''}>환경</option>
	        <option ${vo.cCategory=='임상 진단'?'selected':''}>임상 진단</option>
	        <option ${vo.cCategory=='재료연구'?'selected':''}>재료연구</option>
	        <option ${vo.cCategory=='세포분석'?'selected':''}>세포분석</option>
	        <option ${vo.cCategory=='학교 연구실'?'selected':''}>학교 연구실</option>
	        <option ${vo.cCategory=='기타'?'selected':''}>기타</option>
	      </select>
	    </div>
	    <div class="form-group">
	      <label for="cAddress">회사 소재지</label>
	      <div class="input-group mb-1">
	        <input type="text" name="cPostcode" id="sample6_postcode2" value="${cPostcode}" class="form-control">
	        <div class="input-group-append">
	          <input type="button" onclick="sample6_execDaumPostcode2()" value="우편번호 찾기" class="btn btn-main-2 btn-round btn-icon-sm">
	        </div>
	      </div>
	      <input type="text" name="cRoadAddress" id="sample6_address2" size="50" value="${cRoadAddress}" class="form-control mb-1">
	      <div class="input-group mb-1">
	        <input type="text" name="cDetailAddress" id="sample6_detailAddress2" value="${cDetailAddress}" class="form-control"> &nbsp;&nbsp;
	        <div class="input-group-append">
	          <input type="text" name="cExtraAddress" id="sample6_extraAddress2" value="${cExtraAddress}" class="form-control">
	        </div>
	      </div>
	    </div>
	    <div class="form-group">
	      <div class="input-group mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">회사연락처 :</span> &nbsp;&nbsp;
	            <select name="tel4" class="custom-select" style="height:auto">
	              <option value="010" ${tel4=='010' ? 'selected' : ''}>010</option>
	              <option value="02" ${tel4=='02' ? 'selected' : ''}>02</option>
	              <option value="031" ${tel4=='031' ? 'selected' : ''}>031</option>
	              <option value="032" ${tel4=='032' ? 'selected' : ''}>032</option>
	              <option value="041" ${tel4=='041' ? 'selected' : ''}>041</option>
	              <option value="042" ${tel4=='042' ? 'selected' : ''}>042</option>
	              <option value="043" ${tel4=='043' ? 'selected' : ''}>043</option>
	              <option value="051" ${tel4=='051' ? 'selected' : ''}>051</option>
	              <option value="052" ${tel4=='052' ? 'selected' : ''}>052</option>
	              <option value="061" ${tel4=='061' ? 'selected' : ''}>061</option>
	              <option value="062" ${tel4=='062' ? 'selected' : ''}>062</option>
	            </select>-
	        </div>
	        <input type="text" name="tel5" value="${tel5}" size=4 maxlength=4 class="form-control"/>-
	        <input type="text" name="tel6" value="${tel6}" size=4 maxlength=4 class="form-control"/>
	      </div>
	    </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">가입 목적</span> &nbsp;
        <c:set var="varPurposes" value="${fn:split(('실험정보/기기구매/소모품구매/채용공고/기타'),'/') }"/>
        <c:forEach var="tempPurpose" items="${varPurposes}" varStatus="st">
        	<label class="form-check-label">
        		<input type="checkbox" class="form-check-input" name="purpose" value="${tempPurpose}" ${fn:contains(purpose,tempPurpose)?'checked':''}/>${tempPurpose}&nbsp;
        	</label>
        </c:forEach>
      </div>
    </div>
    <hr/>
    <div class="text-center">
	    <button type="button" class="btn btn-main-2 btn-round-full btn-icon" onclick="fCheck()">수정하기</button> &nbsp;
	    <button type="reset" class="btn btn-main btn-round-full btn-icon">다시작성</button> &nbsp;
	    <button type="button" class="btn btn-main btn-round-full btn-icon" onclick="location.href='${ctp}/Main.do';">돌아가기</button>
    </div>
    <input type="hidden" name="email" />
    <input type="hidden" name="phone" />
    <input type="hidden" name="address" />
    <input type="hidden" name="cTel" />
    <input type="hidden" name="cAddress" />
  </form>
</div>
</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>