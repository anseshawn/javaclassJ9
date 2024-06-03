<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>분석장비 - 그린 엔지니어링</title>
	<jsp:include page="/include/bs4.jsp" />
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
          <span class="text-white">좋은 장비는 분석 효율을 높입니다</span>
          <h1 class="text-capitalize mb-5 text-lg">분석장비</h1>
        </div>
      </div>
    </div>
  </div>
</section>


<!-- portfolio -->
<section class="section doctors">
  <div class="container">
  	  <div class="row justify-content-center">
             <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h2>실험실 장비 목록</h2>
                    <div class="divider mx-auto my-4"></div>
                    <p>성능 좋은 중고 장비를 취급하여 판매하고 있습니다.</p>
                </div>
            </div>
        </div>
        <c:if test="${sLevel==0}">
					<div class="col-12 text-right mb-5">
						<input type="button" value="장비 등록하기" class="btn btn-main btn-icon btn-round" />
					</div>
				</c:if>
      	<div class="col-12 text-center  mb-5">
	        <div class="btn-group btn-group-toggle " data-toggle="buttons">
	          <label class="btn active ">
	            <input type="radio" name="shuffle-filter" value="all" checked="checked" />전체상품
	          </label>
	          <label class="btn ">
	            <input type="radio" name="shuffle-filter" value="cat1" />UV
	          </label>
	          <label class="btn">
	            <input type="radio" name="shuffle-filter" value="cat2" />AAs
	          </label>
	          <label class="btn">
	            <input type="radio" name="shuffle-filter" value="cat3" />ICP
	          </label>
	          <label class="btn">
	            <input type="radio" name="shuffle-filter" value="cat4" />GC
	          </label>
	           <label class="btn">
	            <input type="radio" name="shuffle-filter" value="cat5" />LC
	          </label>
	          <label class="btn">
	            <input type="radio" name="shuffle-filter" value="cat6" />전처리장비
	          </label>
	        </div>
      </div>

    <div class="row shuffle-wrapper portfolio-gallery">
      	<div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat1','cat2']">
	      	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
	               <div class="doctor-img">
	               		<img src="images/product/aas1.jpg" alt="product-image" class="img-fluid w-100">
	               </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="#">contrAA 800 F</a></h4>
                	<p>(2016년) 식품, 환경, 생명</p>
                </div> 
	      	</div>
      	</div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat2']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/aas2.jpg" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="#">Agilent 240FS</a></h4>
                	<p>(2015년) 식품, 환경, 생명, 화학, 의약품</p>
                </div> 
	      	</div>
      </div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat3']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/APK1500.png" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="#">APK1500</a></h4>
                	<p>(2022년) 화학, 환경, 생명, 식품</p>
                </div> 
	      	</div>
      </div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat3','cat4']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/APK720R.png" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="#">APK720R</a></h4>
                	<p>(2020년) 화학, 환경, 생명, 식품</p>
                </div> 
	      	</div>
      </div>

      	<div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat5']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/APK950.png" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="doctor-single.html">APK950</a></h4>
                	<p>(2022년) 화학, 환경</p>
                </div> 
	      	</div>
      	</div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat6']">
       		 <div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/gc1.png" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="doctor-single.html">Agilent</a></h4>
                	<p>(2018년) 화학, 환경, 생명, 식품</p>
                </div> 
	      	</div>
      </div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat4']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/glassReactor.jpg" alt="doctor-image" class="img-fluid w-100">
		            </div>
	            </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="doctor-single.html">Glass Reactor</a></h4>
                	<p>(2018년) 화학, 환경, 생명</p>
                </div> 
	        </div>
      </div>

      <div class="col-lg-3 col-sm-6 col-md-6 mb-4 shuffle-item" data-groups="['cat5','cat6','cat1']">
        	<div class="position-relative doctor-inner-box">
		        <div class="doctor-profile">
		        	<div class="doctor-img">
		               <img src="images/product/lc1.jpg" alt="doctor-image" class="img-fluid w-100">
		             </div>
	             </div>
                <div class="content mt-3">
                	<h4 class="mb-0"><a href="doctor-single.html">Ultimate 3000</a></h4>
                	<p>(2012년) 화학, 환경, 생명, 식품</p>
                </div> 
	      	</div>
      </div>

    </div>
  </div>
</section>
<!-- /portfolio -->
<section class="section cta-page">
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<div class="cta-content">
					<div class="divider mb-4"></div>
					<h2 class="mb-5 text-lg">찾고 있는 제품이 있다면 <br/><span class="title-color">언제든지 문의 주세요</span></h2>
					<a href="#" class="btn btn-main-2 btn-round-full">견적 문의<i class="icofont-simple-right  ml-2"></i></a>
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