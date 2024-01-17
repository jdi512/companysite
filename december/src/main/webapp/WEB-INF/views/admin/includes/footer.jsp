<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- footer Start -->
                                    </div>
                                    <!-- Page-body end -->
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Warning Section Starts -->
    <!-- Older IE warning message -->
    <!--[if lt IE 10]>
<div class="ie-warning">
    <h1>Warning!!</h1>
    <p>You are using an outdated version of Internet Explorer, please upgrade <br/>to any of the following web browsers to access this website.</p>
    <div class="iew-container">
        <ul class="iew-download">
            <li>
                <a href="http://www.google.com/chrome/">
                    <img src="/resources/assets/images/browser/chrome.png" alt="Chrome">
                    <div>Chrome</div>
                </a>
            </li>
            <li>
                <a href="https://www.mozilla.org/en-US/firefox/new/">
                    <img src="/resources/assets/images/browser/firefox.png" alt="Firefox">
                    <div>Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com">
                    <img src="/resources/assets/images/browser/opera.png" alt="Opera">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="https://www.apple.com/safari/">
                    <img src="/resources/assets/images/browser/safari.png" alt="Safari">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                    <img src="/resources/assets/images/browser/ie.png" alt="">
                    <div>IE (9 & above)</div>
                </a>
            </li>
        </ul>
    </div>
    <p>Sorry for the inconvenience!</p>
</div>
<![endif]-->
    <!-- Warning Section Ends -->

    <!-- Required Jquery -->
    <script type="text/javascript" src="/resources/assets/js/jquery-ui/jquery-ui.min.js "></script>
    <script type="text/javascript" src="/resources/assets/js/popper.js/popper.min.js"></script>
    <script type="text/javascript" src="/resources/assets/js/bootstrap/js/bootstrap.min.js "></script>
    <!-- waves js -->
    <script src="/resources/assets/pages/waves/js/waves.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="/resources/assets/js/jquery-slimscroll/jquery.slimscroll.js"></script>

    <!-- slimscroll js -->
    <script src="/resources/assets/js/jquery.mCustomScrollbar.concat.min.js "></script>

    <!-- menu js -->
    <script src="/resources/assets/js/pcoded.min.js"></script>
    <script src="/resources/assets/js/vertical/vertical-layout.min.js "></script>

    <script type="text/javascript" src="/resources/assets/js/script.js "></script>

</body>
<script>
$(document).ready(function() {

    $(".sidebar-nav")
    .attr("class", "sidebar-nav navbar-collapse collapse")
    .attr("aria-expanded", "false")
    .attr("style", "height:1px");
           
    

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

      let day = year + '-' + Monthzero + month + '-' + Datezero + date + '(' + week + ')'; 
      let time = Hourzero + hour + '<b class="blink">:</b>' + Minutezero + minute + '<b class="blink">:</b>' + Secondzero + second;
      document.querySelector('#local-time1').innerHTML = day;
      document.querySelector('#local-time2').innerHTML = time;
    }, 1000);
    let time = 1800;
	 setInterval(function() {
	    	time--
	    	let hour = Math.floor((time / (60 * 60)) % 60);
	    	let min = Math.floor((time / 60) % 60);
	        let sec = Math.floor(time % 60); 
	        let hourzero = '';
	        let minzero = '';
	        let seczero = '';
	        if (hour < 10) {
	            hourzero += '0'
           	}
            if (min < 10) {
            minzero += '0'
            }
            if (sec < 10) {
             seczero += '0'
            }
	    	if(time == 0){
	    		location.href="/customLogout"
	    	}
	    	if(time < 120){
	    		document.getElementById("remain-time").style.color = "red";
	    	}
	    	
	    	let remaintime = "<b>" + hourzero + hour + "<b class='blink'>:</b>" + minzero + min + "<b class='blink'>:</b>" + seczero + sec + "</b>";
	    	document.querySelector("#remain-time").innerHTML = remaintime;
		}, 1000);

	
	
    
});


</script>

</script>

</html>
