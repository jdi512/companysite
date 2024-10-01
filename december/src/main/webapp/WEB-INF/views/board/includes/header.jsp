<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Multipurpose</title>
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,700,700i%7CRajdhani:400,600,700"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/dist/css/loader/loaders.css">
<link rel="stylesheet"
	href="/resources/dist/css/font-awesome/font-awesome.css">
<link rel="stylesheet" href="/resources/dist/css/bootstrap.css">
<link rel="stylesheet" href="/resources/dist/css/aos/aos.css">
<link rel="stylesheet" href="/resources/dist/css/swiper/swiper.css">
<link rel="stylesheet" href="/resources/dist/css/lightgallery.min.css">
<link rel="stylesheet"
	href="http://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="/resources/dist/css/style.css">
<link rel="stylesheet" href="/resources/dist/css/responsive.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/resources/dist/js/jquery-3.3.1.js"></script>
<script src="/resources/dist/js/bootstrap.bundle.js"></script>
<script src="/resources/dist/js/loaders.css.js"></script>
<script src="/resources/dist/js/aos.js"></script>
<script src="/resources/dist/js/swiper.min.js"></script>
<script src="/resources/dist/js/lightgallery-all.min.js"></script>
<script src="/resources/dist/js/main.js"></script>
</head>
<style>
.blink {
	animation: blinker 1s linear infinite;
}

@keyframes blinker { 50% 
{
	opacity: 0;
	}
}
</style>
<body>
	<div class="css-loader">
		<div
			class="loader-inner line-scale d-flex align-items-center justify-content-center"></div>
	</div>
	<header class="position-absolute w-100">
		<div class="container">
			<div
				class="top-header d-none d-sm-flex justify-content-between align-items-center">
				<div class="contact">
					<i class="fa fa-phone" aria-hidden="true"><a href="tel:+8201062975120" class="tel">01062975120</a></i> 
					<i class="fa fa-envelope" aria-hidden="true"><a href="mailto:terran4805@gmail.com">terran4805@gmail.com</a></i> 
				</div>
				<nav class="d-flex aic">
					<ul class="nav social d-none d-md-flex">
						<li id="local-time"></li>
					</ul>
					
					<sec:authorize access="isAuthenticated()">
					<a href="/logout" class="login"><i class="fa fa-user"
						aria-hidden="true"></i>로그아웃</a>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
					<a href="/login" class="login"><i class="fa fa-user"
						aria-hidden="true"></i>로그인</a>
					</sec:authorize>
					

				</nav>
			</div>
			<nav class="navbar navbar-expand-md navbar-light">
				<a class="navbar-brand" href="/"><img
					src="/resources/dist/images/logo.png" width=50%; alt="Multipurpose"></a>
				<div class="group d-flex align-items-center">
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<a class="login-icon d-sm-none" href="#"><i class="fa fa-user"></i></a>
				</div>
				<a class="search-icon d-none d-md-block" href="#"><i
					class="fa fa-search"></i></a>
				<div class="collapse navbar-collapse justify-content-end"
					id="navbarSupportedContent">
					<ul class="navbar-nav">
						<li class="nav-item">
						<sec:authorize access="isAnonymous()">
						<a href="/"><b class="blink">방문자</b></a>님 환영합니다.
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
						<a href="/admin/member/myPage"><b class="blink"><sec:authentication property="principal.member.userName" /></b></a>님 환영합니다.
						</sec:authorize>
						</li>
						<li class="nav-item"><a class="nav-link" href="/">메인으로</a></li>
						<li class="nav-item"><a class="nav-link" href="/location">회사
								위치</a></li>
						<li class="nav-item"><a class="nav-link" href="/introduce">회사
								소개</a></li>
					</ul>
					<form class="bg-white search-form" method="get" id="searchform">
						<div class="input-group">
							<input class="field form-control" id="s" name="s" type="text"
								placeholder="Search"> <span class="input-group-btn">
								<input class="submit btn btn-primary" id="searchsubmit"
								name="submit" type="submit" value="Search">
							</span>
						</div>
					</form>
				</div>
			</nav>
		</div>
	</header>
	<section class="hero">
		<div class="container">
			<div class="row">
				<div class="col-12 offset-md-1 col-md-11">
					<div class="swiper-container hero-slider">
						<div class="swiper-wrapper">
							<div class="swiper-slide slide-content d-flex align-items-center">
								<div class="single-slide">
									<h1 data-aos="fade-right" data-aos-delay="200">저희 회사의 위치를
										알고 싶으시다면</h1>
									<a data-aos="fade-right" data-aos-delay="900" href="/location"
										class="btn btn-primary">회사 위치 보기</a>
								</div>
							</div>
							<div></div>
							<div class="swiper-slide slide-content d-flex align-items-center">
								<div class="single-slide">
									<h1 data-aos="fade-right" data-aos-delay="200">회사 소개를 보고
										싶으시다면</h1>
									<a data-aos="fade-right" data-aos-delay="900" href="/introduce"
										class="btn btn-primary">회사 소개 보기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<span class="arr-left"><i class="fa fa-angle-left"></i></span> <span
				class="arr-right"><i class="fa fa-angle-right"></i></span>
		</div>
		<div class="texture"></div>
		<div class="diag-bg"></div>
	</section>
