<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>게시판관리</h5>
				<span>게시판을 생성 게시판 아이디 중복체크후 등록.</span>
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
			   <form id="form" role="form" action="/admin/board/register" method="post">
               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
               <input type="hidden" name="writer" id="writer" value='<sec:authentication property="principal.member.userid"/>'>
               	<div class="form-group">
                	<label>게시판아이디</label>
                	<div style="display: flex;">
                	<input type="text" name="boardId" maxlength="200" id="boardId" class="form-control" required="required">
                	<button type="button" id="tableDuplicateChk" class="btn btn-default btn-sm">게시판아이디중복체크</button>
                	</div>
               	</div>
               	<div class="form-group">
                	<label>게시판이름</label>
                	<input type="text" name="boardName" maxlength="200" id="boardName" class="form-control" required="required">
               	</div>
               	<button type="submit" class="btn btn-primary btn-sm">게시판생성</button>
               	<button type="reset" class="btn btn-default btn-sm">다시작성</button>
               </form>
           </div>
		</div>
	</div>

</div>
     
<script>
$(document).ready(function(){
	 
	var formObj = $("form[role='form']");
	/*  */
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
	
		submitChk = true;
	
		formObj.submit();
	});

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var idDuplicateChk = false;
	
	
	$("#tableDuplicateChk").on("click", function(){
		
		//id="userId" value값을 가지고 온다.
		let boardId = $("#boardId").val();
		//가져온 value값을 REST API를 이용하여 아이디 중복체크를 한다.
		// /admin/member/idValue 으로 중복되지 않으면 success 그렇지 않으면 없지뭐?
		//중복체크를 했는지여부를 변수또는 input에 저장한다.
		
		if(boardId == ''){
			alert("테이블아이디를 입력하세요");
			$("#boardId").focus();
			return;
		}
		
		$.ajax({
			url : "/admin/board/tbl_"+boardId+"_write",
			type : "post",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function (result){
				if(result == 'success'){
					alert("이미 있는 테이블아이디입니다.");
					$("#boardId").select();
				} else {
					if(confirm("사용가능한 테이블아이디입니다.\n사용하실려면 확인을 눌러주세요.")){
						$("#boardId").attr("readonly", "readonly");
						idDuplicateChk = true;
					} else {
						$("#boardId").select();
					}
				}
			}
		});
		
		
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



<%@ include file="../includes/footer.jsp"%>
