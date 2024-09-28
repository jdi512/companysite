<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    

<footer>
    <div class="footer-widgets">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-xl-4">
                    <div class="single-widget contact-widget" data-aos="fade-up" data-aos-delay="0">
                        <h6 class="widget-tiltle">&nbsp;</h6>
                        <p><a href="/"><img src="/resources/dist/images/logo.png" alt="Multipurpose"></a></p>

                        <div class="media">
                            <i class="fa fa-envelope-o"></i>
                            <div class="media-body ml-5">
                                <h6>메일</h6>
                                <a href="mailto:terran4805@gmail.com">terran4805@gmail.com</a>
                            </div>
                        </div>
                        <div class="media">
                            <i class="fa fa-phone"></i>
                            <div class="media-body ml-5">
                                <h6>전화</h6>
                                <a href="tel:+8201062975120">01062975120</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-xl-4">
                    <div class="row">
                        <div class="single-widget tags-widget" data-aos="fade-up" data-aos-delay="800">
                            <h6 class="widget-tiltle">메뉴 이동</h6>
                            <a href="/">HOME</a>
                            <a href="/about">ABOUT</a>
                            <a href="/introduce">INTRODUCE</a>
                        </div>
                    </div>
                </div>
</footer>    
<script>

  
setInterval(function () {
	 let now = new Date();
     let year = now.getFullYear();
     let month = now.getMonth() + 1;
     let weekday = ['일', '월', '화', '수', '목', '금', '토'];
     let week = weekday[now.getDay()];
     let date = now.getDate();
     let hour = now.getHours();
     let minute = now.getMinutes();
     let second = now.getSeconds();
     let Monthzero = '';
     let Datezero = '';
     let Hourzero = '';
     let Minutezero = '';
     let Secondzero = '';
     if (month < 10) {
       Monthzero += '0'
     }
     if (date < 10) {
       Datezero += '0'
     }
     if (hour < 10) {
       Hourzero += '0'
     }
     if (minute < 10) {
       Minutezero += '0'
     }
     if (second < 10) {
       Secondzero += '0'
     }

     let time = year + '-' + Monthzero + month + '-' + Datezero + date + ' (' + week + ')<br> ' + Hourzero + hour + '<b class="blink">:</b>' + Minutezero + minute + '<b class="blink">:</b>' + Secondzero + second;

     document.querySelector('#local-time').innerHTML = time;
  }, 1000);
</script>
    <!--Plugins-->
    
