<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글쓰기 - 채용공고</title>
	<jsp:include page="/include/bs4.jsp" />
	 
<!-- datepicker 는 jquery 1.7.1 이상 bootstrap 2.0.4 이상 버전이 필요함 -->
<!-- jQuery가 먼저 로드 된 후 datepicker가 로드 되어야함.-->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" > -->
<link rel="stylesheet" href="${ctp}/css/bootstrap-datepicker.css">

<!-- <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
<!-- <script src="${ctp}/js/bootstrap-datepicker.js"></script> -->
<%-- <script src="${ctp}/js/bootstrap-datepicker.ko.js"></script> --%>
	<style>
	</style>
	<script>
		'use strict';
		
		$(function() {	
			$('#datePicker').datepicker({
			    format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
			    startDate: '-0d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
			    endDate: '+10m',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
			    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
			    //clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
			    disableTouchKeyboard : false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
			    immediateUpdates: true,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
			    multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
			    multidateSeparator :"~", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
			    templates : {
			        leftArrow: '&laquo;',
			        rightArrow: '&raquo;'
			    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
			    showWeekDays : true,// 위에 요일 보여주는 옵션 기본값 : true
			    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
			    toggleActive : false,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
			    weekStart : 0 ,//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
			    language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
			    
			});//datepicker end
      //.on("changeDate", function(e) {
          //이벤트의 종류
          //show : datePicker가 보이는 순간 호출
          //hide : datePicker가 숨겨지는 순간 호출
          //clearDate: clear 버튼 누르면 호출
          //changeDate : 사용자가 클릭해서 날짜가 변경되면 호출 (개인적으로 가장 많이 사용함)
          //changeMonth : 월이 변경되면 호출
          //changeYear : 년이 변경되는 호출
          //changeCentury : 한 세기가 변경되면 호출 ex) 20세기에서 21세기가 되는 순간
          
          //console.log(e);// 찍어보면 event 객체가 나온다.
          //간혹 e 객체에서 date 를 추출해야 하는 경우가 있는데 
          // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시)
          // 위와 같은 형태로 보인다. 
          // 추후에 yyyy-mm-dd 형태로 변경하는 코드를 업로드 하겠습니다. 
     	//}
		});//ready end
		
  	// 파일박스 추가하기
  	let cnt = 1;
  	function fileBoxAppend() {
  		cnt++;
  		let fileBox = '';
  		fileBox += '<div class="input-group mb-2">';
  		fileBox += '<div id="fBox'+cnt+'">';
  		fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control-file border mb-2" style="float:left; width:95%;" />';
  		fileBox += '<div class="input-group-append"><a href="javascript:deleteBox('+cnt+')"><i class="fa-solid fa-square-minus ml-2 mt-2"></i></a></div>';
  		fileBox += '</div></div>';
  		$("#addFileBox").append(fileBox);
  	}
  	
  	// 파일박스 삭제
  	function deleteBox(cnt) {
  		$("#fBox"+cnt).remove();
  	}
		
		function fCheck(){
			let part = $("#part").val();
			let title = $("#title").val();
			let content = $("#content").val();
			let location = $("#location").val();
			
			if(part.trim()=="채용구분") {
				alert("채용구분 카테고리를 선택하세요.");
				return false;
			}
			else if(title.trim()=="") {
				alert("제목을 입력하세요.");
				return false;
			}
			else if(location.trim()=="") {
				alert("근무지역을 입력하세요.");
				return false;
			}
			else if(content.trim()==""){
				alert("내용을 입력하세요.");
				return false;
			}
			
  		let fName1 = document.getElementById("fName1").value;
  		let maxSize = 1024 * 1024 * 10; // 기본 단위 : Byte, 1024 * 1024: Mb, 1024*1024*10 = 10MByte 허용
  		
  		if(fName1.trim() != "") {
	  		let ext1 = fName1.substring(fName1.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
	  		let fileSize1 = document.getElementById("fName1").files[0].size;
	  		if(fileSize1 > maxSize) {
	  			alert("업로드할 파일의 최대용량은 10MByte입니다.");
	  		}
	  		else if(ext1 != 'jpg' && ext1 != 'gif' && ext1 != 'png' && ext1 != 'zip' && ext1 != 'hwp' && ext1 != 'doc' && ext1 != 'pdf') {
	  			alert("업로드 가능한 파일은 '그림파일(jpg/gif/png) 및 pdf/zip/hwp/doc' 입니다.");
	  		}
  		}
			
			myform.submit();
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
<form name="myform" method="post" action="RecruitBoardEditOk.bo" enctype="multipart/form-data">
	<div class="row justify-content-center mb-2">
		<div class="col-md-8 col-md-offset-2">
			<div class="form-group">
				<input type="text" name="board" id="board" class="form-control" value="채용공고" readonly />
			</div>
		</div>
	</div>
	<div class="row justify-content-center mb-2">
		<div class="col-md-4">
			<input type="text" name="writer" id="writer" class="form-control" value="${sNickName} (${sMid})" readonly />		
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<select class="form-control" name="part" id="part" style="height:45px;">
					<option>채용구분</option>
					<option ${vo.part=='신입'? 'selected' : '' }>신입</option>
					<option ${vo.part=='경력'? 'selected' : '' }>경력</option>
					<option ${vo.part=='경력무관'? 'selected' : '' }>경력무관</option>
					<option ${vo.part=='인턴'? 'selected' : '' }>인턴</option>
					<option ${vo.part=='기타'? 'selected' : '' }>기타</option>
				</select>
			</div>
		</div>
	</div>
	<div class="divider2 mx-auto my-4"></div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2"><h4 style="font-family:Gowun Dodum;">제목</h4>
			<input type="text" name="title" id="title" class="form-control mt-2" value="${vo.title}" required/>
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2"><h4 style="font-family:Gowun Dodum;">근무지역</h4>
			<input type="text" name="location" id="location" class="form-control mt-2" value="${vo.location}" required/>
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2"><h4 style="font-family:Gowun Dodum;">채용마감일</h4>
			<input type="text" id="datePicker" name="datePicker" class="form-control" value="${fn:substring(vo.endDate,0,10)}">
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2"><h4 style="font-family:Gowun Dodum;">유의사항</h4>
			<input type="text" name="etcContent" id="etcContent" class="form-control mt-2" value="${vo.etcContent}"/>
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2"><h4 style="font-family:Gowun Dodum;">내용</h4>
			<textarea name="content" id="content" rows="10" class="form-control">${vo.content}</textarea>
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2">
			<label style="font-family:Gowun Dodum;">첨부파일</label><a href="javascript:fileBoxAppend()"><i class="fa-solid fa-square-plus ml-2"></i></a>
			<input type="file" name="fName1" id="fName1" class="form-control-file border mb-3" style="float:left;" />
			<div id="addFileBox"></div>
		</div>
	</div>
	<div class="divider2 mx-auto my-4"></div>
	<div class="row justify-content-center mb-3">
		<div class="col-md-8 col-md-offset-2 text-right">
			<input type="button" value="등록하기" onclick="fCheck()" class="btn btn-main-2 btn-icon btn-round-full" />
			<input type="button" value="취소" onclick="location.href='QuestionBoard.do';" class="btn btn-main btn-icon btn-round-full" />
		</div>
	</div>
	<input type="hidden" name="idx" value="${vo.idx}"/>
	<input type="hidden" name="mid" value="${sMid}"/>
	<input type="hidden" name="nickName" value="${sNickName}"/>
	<input type="hidden" name="pag" value="${pag}"/>
	<input type="hidden" name="pageSize" value="${pageSize}"/>
	<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script> -->
<script src="${ctp}/js/bootstrap-datepicker.ko.js"></script>

</body>
</html>