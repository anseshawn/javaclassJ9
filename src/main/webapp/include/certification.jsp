<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- certification.jsp -->
<%
	String mid = session.getAttribute("sMid")==null ? "" : session.getAttribute("sMid").toString();
	if(mid.equals("")) {
		out.println("<script>");
		out.println("alert('로그인 후 사용하세요.');");
		out.println("location.href='"+request.getContextPath()+"/study/database/login.jsp';");
		out.println("</script>");
	}
%>