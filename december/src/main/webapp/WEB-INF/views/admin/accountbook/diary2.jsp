<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>  

<script src='/resources/assets/js/diary.js'></script>
<script src='/resources/dist/index.global.js'></script>
<script src='/resources/assets/js/moment.js'></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    
    function getList(callback, error){
		var es;
		$.ajax({
			type:"get",
			url:"/admin/diaries/month.json",
			async:false,
			success: function(data){
				es = data;
			}
		});
		return es;
	}//function

	events = getList();
	
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: new Date(),
      navLinks: true, // can click day/week names to navigate views
      buttonText:{
    	today : '오늘',
    	month : '월',
    	week : '주',
    	day : '일',
    	list : '주간 일정표'
      },
      locale:'ko',
      timeZone: 'Asia/Seoul',
      selectable: true,
      selectMirror: true,
      select: function(arg) {

    	$("#title").val('');
		$("#allDay").val(arg.allDay);

		$("#start").val(moment(arg.start).format('YYYY-MM-DDTHH:mm:ss'));
		$("#end2").val(moment(arg.end).subtract(1, 'days').format('YYYY-MM-DDTHH:mm:ss'));
		$("#end").val(moment(arg.end).format('YYYY-MM-DDTHH:mm:ss'));
		
		$("#start").addClass('fill');
		$("#end2").addClass('fill');
		
		$("#btnRemove").hide();
		$("#btnModify").hide();
	  	$("#btnSave").show();
		
		$("#exampleModal").modal('show');
		eventCal = calendar;

        calendar.unselect()//
      },
      eventClick: function(arg) {
    	  console.log(arg.event);
		  
	  	  $("#btnRemove").show();
	  	  $("#btnModify").show();
	  	  $("#btnSave").hide();
	  		
    	  $("#exampleModal").modal('show');
    	  
    	  diaryService.get(arg.event.extendedProps.dno, function(result){
    		  
    		  $("#allDay").val(result.allDay);

    		  $("#dno").val(result.dno);
    		  $("#title").val(result.title);
    		  $("#start").val(moment(result.start).format('YYYY-MM-DDTHH:mm:ss'));
    		  $("#end2").val(moment(result.end).subtract(1, 'days').format('YYYY-MM-DDTHH:mm:ss'));
    		  $("#end").val(moment(result.end).format('YYYY-MM-DDTHH:mm:ss'));

    		  $("#title").addClass('fill');
    		  $("#start").addClass('fill');
    		  $("#end2").addClass('fill');
    		  
    	  });
    	  eventCal = calendar;
          calendar.unselect()//
    	  
        /* if (confirm('Are you sure you want to delete this event?')) {
          arg.event.remove()
        } */
      },
      eventDrop: function(arg){
    	  console.log("eventDrop:"+arg);
      },
      eventResize: function(arg){
    	  console.log("eventResize:"+arg);
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: events
    });

    calendar.render();
  });

</script>
<style>

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>

                                    
                                    
                                    
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Hello card</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li>
                                                                    <i class="fa fa fa-wrench open-card-option"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fa fa-window-maximize full-card"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fa fa-minus minimize-card"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fa fa-refresh reload-card"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fa fa-trash close-card"></i>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id='calendar'></div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title fs-5" id="exampleModalLabel">일정관리</h4>
        <span class="ti-close" data-bs-dismiss="modal" aria-label="Close"></span>
      </div>
      <div class="modal-body form-material">
      
      
      <input type="hidden" name="allDay" id="allDay">
      <input type="hidden" name="dno" id="dno">
      
      
	      <div class="form-group form-primary">
	          <input type="text" name="title" id="title" class="form-control">
	          <span class="form-bar"></span>
	          <label class="float-label">일정제목</label>
	      </div>
	      <div class="form-group form-primary">
	          <input type="datetime-local" name="start" id="start" class="form-control" value="">
	          <span class="form-bar"></span>
	          <label class="float-label">일정시작일</label>
	      </div>
	      <div class="form-group form-primary">
	          <input type="datetime-local" name="end2" id="end2" class="form-control" value="">
	          <input type="hidden" name="end" id="end" value="">
	          <span class="form-bar"></span>
	          <label class="float-label">일정종료일</label>
	      </div>
	      <div class="form-group form-primary">
	          <input type="text" name="url" id="url" class="form-control">
	          <span class="form-bar"></span>
	          <label class="float-label">url</label>
	      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" id="btnModify" class="btn btn-primary">Modify</button>
        <button type="button" id="btnRemove" class="btn btn-primary">Remove</button>
        <button type="button" id="btnSave" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>    
    
    <script>
    $(document).ready(function(){
    	$("[data-bs-dismiss='modal']").on("click", function(){
    		$("#exampleModal").modal('hide');
    	});


    	var csrfHeaderName = "${_csrf.headerName}";
    	var csrfTokenValue = "${_csrf.token}";
    	
    	$(document).ajaxSend(function(e, xhr, options){
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	});	
    	
    	
    	$("#btnSave").on("click", function(){
    		let dno = '';
    		let title = $('#title').val();
    		let start = $('#start').val();
    		let end = moment($('#end2').val()).add(1, 'days').format('YYYY-MM-DDTHH:mm:ss');
    		let url = $('#url').val();
    		let allDay = $('#allDay').val();
			
    		var diary = {
    				dno: dno,
    				title: title,
    				start: start,
    				end: end,
    				url: url,
    				allDay: allDay
    				};
    		diaryService.add(
    				diary,
    				function(result){
    					alert("RESULT: " + result);

    					if (title) {
    						eventCal.addEvent({
    						dno: dno,
				            title: title,
				            start: start,
				            end: end,
				            allDay: allDay
				          })
				        }
    					//모달창 닫기
    					$("#exampleModal").modal('hide');
    					location.reload();//새로고침
    				}
    			);
    	});
    	
    	//수정
    	$("#btnModify").on("click", function(){
    		let dno = $('#dno').val();
    		let title = $('#title').val();
    		let start = $('#start').val();
  		  	
    		let end = moment($('#end2').val()).add(1, 'days').format('YYYY-MM-DDTHH:mm:ss');
    		let url = $('#url').val();
    		let allDay = $('#allDay').val();
			console.log(end);
    		var diary = {
    				dno: dno,
    				title: title,
    				start: start,
    				end: end,
    				url: url,
    				allDay: allDay
    				};
    		diaryService.update(
    				diary,
    				function(result){
    					alert("RESULT: " + result);
    					
    					//모달창 닫기
    					$("#exampleModal").modal('hide');
    					location.reload();//새로고침
    				}
    			);
    	});
    	

    	//삭제
    	$("#btnRemove").on("click", function(){
    		let dno = $('#dno').val();
			
    		diaryService.remove(
    				dno,
    				function(result){
    					alert("RESULT: " + result);
    					
    					//모달창 닫기
    					$("#exampleModal").modal('hide');
    					location.reload();//새로고침
    				}
    			);
    	});
    });
    </script>
    
<%@ include file="../includes/footer.jsp" %>  