<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>

<section class="cta" data-aos="fade-up" data-aos-delay="0">
	<div class="container">
		<div
			class="cta-content d-xl-flex align-items-center justify-content-around text-center text-xl-left">
			<div class="content" data-aos="fade-right" data-aos-delay="200">
				<h2>회사 소식을 보고 싶다면</h2>
				<p>지금 바로 회사 소식을 구독하세요</p>
			</div>
			<div class="subscribe-btn" data-aos="fade-left" data-aos-delay="400"
				data-aos-offset="0">
				<a href="/about" class="btn btn-primary">뉴스레터 구독하기</a>
			</div>
		</div>
	</div>
</section>

<section class="testimonial-and-clients">
	<div class="container">
		<div class="testimonials">
			<div class="swiper-container test-slider">
				<div class="swiper-wrapper">
					<div class="swiper-slide text-center">
						<div class="row">
							<div class="offset-lg-1 col-lg-10">
								<div class="test-img" data-aos="fade-up" data-aos-delay="0"
									data-aos-offset="0">
									<img src="resources/dist/images/star.png" alt="Testimonial 1">
								</div>
								<h5 data-aos="fade-up" data-aos-delay="200"
									data-aos-duration="600" data-aos-offset="0">star</h5>
								<p data-aos="fade-up" data-aos-delay="600"
									data-aos-duration="600" data-aos-offset="0">
									Twinkle, twinkle little star<br> How I wonder what you are<br>
									Up above the world so high<br> Like a diamond in the sky<br>
									Twinkle, twinkle little star<br> How I wonder what you are
								</p>
							</div>
						</div>

					</div>
				</div>
				<div class="test-pagination"></div>
			</div>
		</div>
	</div>
</section>
<section class="recent-posts">
	<div class="container">
		<h1 class="title-primary text-center">Event</h1>
		<div class="row" id="daumbook"></div>
		<div class="text-center">
			<a href="http://www.daum.net" class="btn btn-primary"
				id="remain-time"></a>
		</div>
	</div>
</section>
<section class="cta cta2" data-aos="fade-up" data-aos-delay="0">
	<div class="container">
		<div
			class="cta-content d-xl-flex align-items-center justify-content-around text-center text-xl-left">
			<div class="content" data-aos="fade-right" data-aos-delay="200">
				<h2>저희 회사의 소식을 알고 싶다면</h2>
			</div>
			<div class="subscribe-btn" data-aos="fade-left" data-aos-delay="400"
				data-aos-offset="0">
				<a href="/about" class="btn btn-primary">회사 소식 구독</a>
			</div>
		</div>
	</div>
</section>
<script>
    
    //책정보 출력
        function getBest() {
            $.ajax({
                type: "get",
                url: "https://dapi.kakao.com/v3/search/book",
                data: {
                    query: "별",
                    target: "title",
                    size: 8
                },
                headers: { Authorization: "KakaoAK 26e253cda867120a05230e16f30c137e" },
                dataType: "json",
                success: function (data) {
                    for (let i = 0; i < data.documents.length; i++) {
                        let book = "";
                        if (i % 2 == 0) {
                            book += '<div class="col-lg-6">';
                            book += '    <div class="single-rpost d-sm-flex align-items-center" dat-aos-delay="200" data-aos="fade-right" data-aos-duration="800">';
                            book += '        <div class="post-content">';
                            book += '            <h3><a href =' + data.documents[i].url + ">" + data.documents[i].title + '</a></h3>';
                            book += '            <p><a href =' + data.documents[i].url + ">" + data.documents[i].price.toLocaleString('ko-KR') + '</a></p>';
                            book += '            <a class="post-btn" href="' + data.documents[i].url + '"><i class="fa fa-arrow-right"></i></a>';
                            book += '        </div>';
                            book += '        <div class="post-thumb">';
                            book += '            <img class="img-fluid" src="' + data.documents[i].thumbnail + '" alt="Post 1">';
                            book += '        </div>';
                            book += '    </div>';
                            book += '</div>';
                        } else {
                            book += '<div class="col-lg-6">';
                            book += '    <div class="single-rpost d-sm-flex align-items-center" dat-aos-delay="200" data-aos="fade-left" data-aos-duration="800">';
                            book += '        <div class="post-thumb">';
                            book += '            <img class="img-fluid" src="' + data.documents[i].thumbnail + '" alt="Post 1">';
                            book += '        </div>';
                            book += '        <div class="post-content">';
                            book += '            <h3><a href =' + data.documents[i].url + ">" + data.documents[i].title + '</a></h3>';
                            book += '            <p><a href =' + data.documents[i].url + ">" + data.documents[i].price.toLocaleString('ko-KR') + '</a></p>';
                            book += '            <a class="post-btn" href="' + data.documents[i].url + '"><i class="fa fa-arrow-right"></i></a>';
                            book += '        </div>';
                            book += '    </div>';
                            book += '</div>';
                        }

                        $("#daumbook").append(book);
                    }

                }

            });
        }
	
        $(document).ready(function () {
            getBest();

        })
       
	//카운트다운    
    setInterval(function () {
        let standardTime = new Date("2023-12-27 00:00:00");
        let todayTime = new Date();
        let getDiffdayzero = '';
        let getDiffhourzero = '';
        let getDiffminuteszero = '';
        let getDiffsecondzero = '';
        let diff = standardTime-todayTime;
        let diffDay = Math.floor(diff / (1000 * 60 * 60 * 24));
        let diffHour = Math.floor((diff / (1000 * 60 * 60)) % 24);
        let diffMin = Math.floor((diff / (1000 * 60)) % 60);
        let diffSec = Math.floor(diff / 1000 % 60);
        if (diffDay < 10) {
            getDiffdayzero += '0'
        }
        if (diffHour < 10) {
            getDiffhourzero += '0'
        }
        if (diffMin < 10) {
            getDiffminuteszero += '0'
        }
        if (diffSec < 10) {
            getDiffsecondzero += '0'
        }
		if(diff <= 0){
		JavaScript: void(0)
		let remaintime = "00:00:00:00";
		document.querySelector("#remain-time").innerHTML = remaintime;
		document.querySelector("#remain-time").removeAttribute('href');
		} else {
		  let remaintime = '<b class="blink">' + getDiffdayzero + diffDay + ':' + getDiffhourzero + diffHour + ':' + getDiffminuteszero + diffMin + ':' + getDiffsecondzero + diffSec + '</b>';
		  
        document.querySelector("#remain-time").innerHTML = remaintime;
		  }
		  
    }
        , 1000);
</script>

<%@ include file="includes/footer.jsp"%>
