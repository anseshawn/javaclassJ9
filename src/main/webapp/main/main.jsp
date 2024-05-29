<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>그린 엔지니어링에 오신 것을 환영합니다!</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body id="top">
<header>
	<jsp:include page="/include/header.jsp" />
	<jsp:include page="/include/nav.jsp" />
</header>

<!-- Slider Start -->
<section class="banner">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 col-md-12 col-xl-7">
				<div class="block">
					<div class="divider mb-3"></div>
					<span class="text-uppercase text-sm letter-spacing ">실험실에 대한 모든 것</span>
					<h1 class="mb-3 mt-3">Your most trusted partner</h1>
					
					<p class="mb-4 pr-5">우리 엔지니어링은 실험실 전반에 대한 기기와 소모품을 다루고 있습니다.<br/>항상 고객과의 소통을 추구하여 세계로 나아가는 그린 엔지니어링이 되겠습니다.</p>
					<div class="btn-container ">
						<a href="appoinment.html" target="_blank" class="btn btn-main-3 btn-icon btn-round-full">견적문의 <i class="icofont-simple-right ml-2  "></i></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="features">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="feature-block d-lg-flex">
					<div class="feature-item mb-5 mb-lg-0">
						<div class="feature-icon mb-4">
							<i class="icofont-laboratory"></i>
						</div>
						<span>실험실 기초장비</span>
						<h4 class="mb-3">중고기기 확인하기</h4>
						<p class="mb-4">분석에 도움이 되어드리겠습니다. 실험에 필요한 장비들을 합리적인 가격에 제공합니다.</p>
						<a href="appoinment.html" class="btn btn-main btn-round-full">장비리스트 보기</a>
					</div>
				
					<div class="feature-item mb-5 mb-lg-0">
						<div class="feature-icon mb-4">
							<i class="icofont-google-talk"></i>
						</div>
						<span>실험에 필요한 정보</span>
						<h4 class="mb-3">다른 연구원과 소통하기</h4>
						<ul class="w-hours list-unstyled">
              <li class="d-flex justify-content-between">Sun - Wed : <span>8:00 - 17:00</span></li>
              <li class="d-flex justify-content-between">Thu - Fri : <span>9:00 - 17:00</span></li>
              <li class="d-flex justify-content-between">Sat - sun : <span>10:00 - 17:00</span></li>
            </ul>
					</div>
				
					<div class="feature-item mb-5 mb-lg-0">
						<div class="feature-icon mb-4">
							<i class="icofont-support"></i>
						</div>
						<span>Emegency Cases</span>
						<h4 class="mb-3">1-800-700-6200</h4>
						<p>Get ALl time support for emergency.We have introduced the principle of family medicine.Get Conneted with us for any urgency .</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="section about">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-lg-4 col-sm-6">
				<div class="about-img">
					<img src="images/about/img-1.jpg" alt="" class="img-fluid">
					<img src="images/about/img-2.jpg" alt="" class="img-fluid mt-4">
				</div>
			</div>
			<div class="col-lg-4 col-sm-6">
				<div class="about-img mt-4 mt-lg-0">
					<img src="images/about/img-3.jpg" alt="" class="img-fluid">
				</div>
			</div>
			<div class="col-lg-4">
				<div class="about-content pl-4 mt-4 mt-lg-0">
					<h2 class="title-color">Personal care <br>& healthy living</h2>
					<p class="mt-4 mb-5">We provide best leading medicle service Nulla perferendis veniam deleniti ipsum officia dolores repellat laudantium obcaecati neque.</p>

					<a href="service.html" class="btn btn-main-2 btn-round-full btn-icon">Services<i class="icofont-simple-right ml-3"></i></a>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="cta-section ">
	<div class="container">
		<div class="cta position-relative">
			<div class="row">
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="counter-stat">
						<i class="icofont-doctor"></i>
						<span class="h3">58</span>k
						<p>Happy People</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="counter-stat">
						<i class="icofont-flag"></i>
						<span class="h3">700</span>+
						<p>Surgery Comepleted</p>
					</div>
				</div>
				
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="counter-stat">
						<i class="icofont-badge"></i>
						<span class="h3">40</span>+
						<p>Expert Doctors</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="counter-stat">
						<i class="icofont-globe"></i>
						<span class="h3">20</span>
						<p>Worldwide Branch</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="section service gray-bg">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-7 text-center">
				<div class="section-title">
					<h2>Award winning patient care</h2>
					<div class="divider mx-auto my-4"></div>
					<p>Lets know moreel necessitatibus dolor asperiores illum possimus sint voluptates incidunt molestias nostrum laudantium. Maiores porro cumque quaerat.</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-laboratory text-lg"></i>
						<h4 class="mt-3 mb-3">Laboratory services</h4>
					</div>

					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-heart-beat-alt text-lg"></i>
						<h4 class="mt-3 mb-3">Heart Disease</h4>
					</div>
					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-tooth text-lg"></i>
						<h4 class="mt-3 mb-3">Dental Care</h4>
					</div>
					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>


			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-crutch text-lg"></i>
						<h4 class="mt-3 mb-3">Body Surgery</h4>
					</div>

					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-brain-alt text-lg"></i>
						<h4 class="mt-3 mb-3">Neurology Sargery</h4>
					</div>
					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="service-item mb-4">
					<div class="icon d-flex align-items-center">
						<i class="icofont-dna-alt-1 text-lg"></i>
						<h4 class="mt-3 mb-3">Gynecology</h4>
					</div>
					<div class="content">
						<p class="mb-4">Saepe nulla praesentium eaque omnis perferendis a doloremque.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="section appoinment">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-lg-6 ">
				<div class="appoinment-content">
					<img src="images/about/img-3.jpg" alt="" class="img-fluid">
					<div class="emergency">
						<h2 class="text-lg"><i class="icofont-phone-circle text-lg"></i>+23 345 67980</h2>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-md-10 ">
				<div class="appoinment-wrap mt-5 mt-lg-0">
					<h2 class="mb-2 title-color">문의 메일 보내기</h2>
					<p class="mb-4">문의 사항이 있다면 메일을 보내주세요. 혹은 하단에서 뉴스레터 구독이 가능합니다.</p>
				    <form id="#" class="appoinment-form" method="post" action="#">
	            <div class="row">
	             	<div class="col-lg-6">
	              	<div class="form-group">
	                	<select class="form-control" id="exampleFormControlSelect1">
	                    <option>Choose Department</option>
	                    <option>Software Design</option>
	                    <option>Development cycle</option>
	                    <option>Software Development</option>
	                    <option>Maintenance</option>
	                    <option>Process Query</option>
	                    <option>Cost and Duration</option>
	                    <option>Modal Delivery</option>
	                  </select>
	                </div>
	              </div>
	            	<div class="col-lg-6">
	              	<div class="form-group">
	                	<select class="form-control" id="exampleFormControlSelect2">
	                    <option>Select Doctors</option>
	                    <option>Software Design</option>
	                    <option>Development cycle</option>
	                    <option>Software Development</option>
	                    <option>Maintenance</option>
	                    <option>Process Query</option>
	                    <option>Cost and Duration</option>
	                    <option>Modal Delivery</option>
	                  </select>
	                </div>
								</div>
	
								<div class="col-lg-6">
									<div class="form-group">
										<input name="date" id="date" type="text" class="form-control" placeholder="dd/mm/yyyy">
									</div>
								</div>
	
								<div class="col-lg-6">
									<div class="form-group">
										<input name="time" id="time" type="text" class="form-control" placeholder="Time">
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<input name="name" id="name" type="text" class="form-control" placeholder="Full Name">
									</div>
								</div>
	
								<div class="col-lg-6">
									<div class="form-group">
										<input name="phone" id="phone" type="Number" class="form-control" placeholder="Phone Number">
									</div>
								</div>
							</div>
							<div class="form-group-2 mb-4">
								<textarea name="message" id="message" class="form-control" rows="6" placeholder="Your Message"></textarea>
							</div>
			
			    	<a class="btn btn-main btn-round-full" href="appoinment.html" >Make Appoinment <i class="icofont-simple-right ml-2  "></i></a>
			  	</form>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="/include/footer.jsp" />
<jsp:include page="/include/scripts.jsp" />
</body>
</html>