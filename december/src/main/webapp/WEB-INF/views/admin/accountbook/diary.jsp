<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<!-- 부트스트랩CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>Hello card</h5>
				<span>lorem ipsum dolor sit amet, consectetur adipisicing
					elit</span>
				<div class="card-header-right">
					<ul class="list-unstyled card-option">
						<li><i class="fa fa fa-wrench open-card-option"></i></li>
						<li><i class="fa fa-window-maximize full-card"></i></li>
						<li><i class="fa fa-minus minimize-card"></i></li>
						<li><i class="fa fa-refresh reload-card"></i></li>
						<li><i class="fa fa-trash close-card"></i></li>
					</ul>
				</div>
			</div>
			<div class="card-block">
				<div id='calendar'></div>
			</div>
		</div>
	</div>

</div>
<!-- 부트스트랩 modal 부분 -->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
				<span class="ti-close" data-bs-dismiss="modal" aria-label="Close"></span>
			</div>
			<div class="modal-body form-material">
				<div class="form-group form-primary">
		          <input type="text" id="title" class="form-control">
		          <span class="form-bar"></span>
		          <label class="float-label">일정제목</label>
		        </div>
				<div class="form-group form-primary">
		          <input type="datetime-local" id="start" class="form-control">
		          <span class="form-bar"></span>
		          <label class="float-label">시작시간</label>
		        </div>
				<div class="form-group form-primary">
		          <input type="datetime-local" id="end" class="form-control">
		          <span class="form-bar"></span>
		          <label class="float-label">종료시간</label>
		        </div>
				<div class="form-group form-primary">
		          <select id="color" class="form-control">
					<option value="red">빨강색</option>
					<option value="orange">주황색</option>
					<option value="yellow">노랑색</option>
					<option value="green">초록색</option>
					<option value="blue">파랑색</option>
					<option value="indigo">남색</option>
					<option value="purple">보라색</option>
				  </select>
		          <span class="form-bar"></span>
		          <label class="float-label">배경색상</label>
		        </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="saveChanges">추가</button>
			</div>
		</div>
	</div>
</div>
<script>


  (function(){
    $(function(){
   	  let _csrf = '${_csrf.token}';
   	  let _csrf_header = '${_csrf.headerName}';
   	  
   	  
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        googleCalendarApiKey: '',// 여기에 구글캘린더 api키 입력하시면 됩니다.
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        customButtons:{
          myCustomButton:{
            text:"일정추가",
            click : function(){
       		  $("#start").addClass('fill');
       		  $("#end").addClass('fill');
       		  $("#color").addClass('fill');
       		  
              //부트스트랩 모달 열기
              $("#exampleModal").modal("show");              
            }
          },
          mySaveButton:{
            text:"저장",
            click: async function () {
              if (confirm("저장하시겠습니까?")) {
                //지금까지 생성된 모든 이벤트 저장하기
                var allEvent = calendar.getEvents();
                console.log("모든 이벤트들", allEvent);
                //이벤트 저장하기
                const saveEvent = await axios({
                  method: "POST",
                  url: "/admin/fullcalendar/new",
                  data: allEvent,
				  headers: {
						"Content-Type" : "application/json; charset=utf-8",
						[_csrf_header]: _csrf
				  }
                });
              }
            },
          }
        },
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,next today,myCustomButton,mySaveButton',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        // initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: false, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        selectMirror: true,
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          console.log("eventAdd" + obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log("eventChange" + obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log("eventRemove" + obj);
        },
        eventClick: function(obj){ // 이벤트가 클릭하면 발생하는 이벤트
        	if(confirm('정말로 삭제하시겠습니까?')){
        		obj.event.remove();	
        	}
          console.log("eventClick" + obj);
        },   
        eventDrop: function(arg){
      	  console.log("eventDrop:"+arg);
        },
        eventResize: function(arg){
      	  console.log("eventResize:"+arg);
        },     
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title = prompt('Event Title:');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        //데이터 가져오는 이벤트
        eventSources:[
          {
            events: async function (info, successCallback, failureCallback) {
          const eventResult = await axios({
            method: "GET",
            url: "/admin/fullcalendar/eventData",
          });
          const eventData = eventResult.data;
          //이벤트에 넣을 배열 선언하기
          const eventArray = [];
          
          eventData.forEach((res) => {
        	/* if(res.start.substr(0, 10) != res.end.substr(0, 10)){
        		res.start = res.start.substr(0, 10);
        		res.end = res.end.substr(0, 10);
        	}  */

            eventArray.push({
              id: res.id,
              title: res.title,
              start: res.start,
              end: res.end,
              backgroundColor: res.backgroundColor,
            });
          });
          successCallback(eventArray);
        
        },
          },
            {
              googleCalendarId : 'ko.south_korea.official#holiday@group.v.calendar.google.com',
              backgroundColor: 'red',
            }
        ]
      });

      //모달창 이벤트
      $("#saveChanges").on("click", function () {
            var eventData = {
              title: $("#title").val(),
              start: $("#start").val(),
              end: $("#end").val(),
              color: $("#color").val(),
            };
            //빈값입력시 오류
            if (
              eventData.title == "" ||
              eventData.start == "" ||
              eventData.end == ""
            ) {
              alert("입력하지 않은 값이 있습니다.");

              //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
            } else if ($("#start").val() > $("#end").val()) {
              alert("시간을 잘못입력 하셨습니다.");
            } else {
              // 이벤트 추가
              calendar.addEvent(eventData);
              $("#exampleModal").modal("hide");
              $("#title").val("");
              $("#start").val("");
              $("#end").val("");
              $("#color").val("");
            }
          });
      // 캘린더 랜더링
      calendar.render();
    });
  })();
</script>

<%@ include file="../includes/footer.jsp"%>
