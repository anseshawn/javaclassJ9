<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>


<!-- Favicon -->
<link rel="shortcut icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />

<link rel="apple-touch-icon" sizes="180x180" href="${ctp}/images/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="${ctp}/images/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="${ctp}/images/favicon-16x16.png">
<link rel="manifest" href="${ctp}/images/site.webmanifest">

<!-- <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon"> -->
<!-- <link rel="icon" href="data:;base64,iVBORw0KGgo="> -->


<!-- bootstrap.min css -->
<link rel="stylesheet" href="${ctp}/plugins/bootstrap/css/bootstrap.min.css">
<!-- Icon Font Css (css폴더로 이동했음) -->
<link rel="stylesheet" href="${ctp}/css/icofont/icofont.min.css">
<!-- Slick Slider  CSS -->
<link rel="stylesheet" href="${ctp}/plugins/slick-carousel/slick/slick.css">
<link rel="stylesheet" href="${ctp}/plugins/slick-carousel/slick/slick-theme.css">
<!-- Main Stylesheet -->
<link rel="stylesheet" href="${ctp}/css/style.css">