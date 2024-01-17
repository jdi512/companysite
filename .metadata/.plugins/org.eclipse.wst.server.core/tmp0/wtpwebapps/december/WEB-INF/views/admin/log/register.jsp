<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<link href="/resources/dist/css/file.css" rel="stylesheet">


   <div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>업무일지</h5>
				<span>업무일지 등록페이지입니다.</span>
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
                            <form id="form" role="form" action="/admin/log/register" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            <input type="hidden" name="writer" id="writer" value='<sec:authentication property="principal.member.userid"/>'>
                            	<div class="form-group">
	                            	<label>업무일자</label>
	                            	<input type="date" name="title" id="title" class="form-control" required="required">
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>금일실시사항</label>
	                            	<textarea name="content" id="content" class="form-control" style="height:150px;" required="required"></textarea>
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>법인카드사용내역</label>
	                            	<textarea name="bill" id="bill" class="form-control" style="height:150px;" ></textarea>
	                            	
                            	</div>
                            	<div class="form-group">
	                            	<label>특이사항 보고</label>
	                            	<textarea name="etc" id="etc" class="form-control" style="height:150px;" ></textarea>
	                       
                            	</div>
                            	
                            	<button type="submit" class="btn btn-primary">등록</button>
                            	<button type="reset" class="btn btn-default">초기화</button>
                            </form>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

          
<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
		
			submitChk = true;
			
			formObj.submit();
		});	
	});	

	submitChk = false;
    window.addEventListener('beforeunload', (event) => {
    	if(!submitChk){
	        // 명세에 따라 preventDefault는 호출해야하며, 기본 동작을 방지합니다.
	        event.preventDefault();
	
	        // 대표적으로 Chrome에서는 returnValue 설정이 필요합니다.
	        event.returnValue = '';
    	}
    });
</script>
<%@ include file="../includes/footer.jsp" %>