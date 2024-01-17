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
			   <form id="form" role="form" action="modify" method="post">
	            <input type="hidden" name="pageNum" value="${cri.pageNum }">
	            <input type="hidden" name="amount" value="${cri.amount }">
				<input type="hidden" name="type" value="${cri.type }">
				<input type="hidden" name="keyword" value="${cri.keyword }">
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="hidden" name="bno" value="${board.bno }">            
               	<div class="form-group">
                	<label>게시판아이디</label>
                	<input type="text" name="boardId" maxlength="200" id="boardId" class="form-control" readonly="readonly" value="${board.boardId}">
               	</div>
               	<div class="form-group">
                	<label>게시판이름</label>
                	<input type="text" name="boardName" maxlength="200" id="boardName" class="form-control" required="required" value="${board.boardName}">
               	</div>
               	<button id="modify" type="button" class="btn btn-default btn-sm">수정</button>
	            <button id="remove" type="button" class="btn btn-danger btn-sm">삭제</button>
               	<button id="list" type="button" class="btn btn-primary btn-sm">목록</button>
               </form>
           </div>
		</div>
	</div>

</div>
             
            
<form id="actionForm">
</form>

<script>
$(document).ready(function(){
	
	var formObj = $("#form");
	var actionFormObj = $("#actionForm");
	 
	$("#modify").on("click", function(e){
		e.preventDefault();
			
		submitChk = true;
	
		formObj.submit();
	});
	
	 
	$("#remove").on("click", function(e){
		e.preventDefault();
			
		if(confirm("정말로 삭제하시겠습니까?")){
			formObj.attr("action", "remove");	
			submitChk = true;
			formObj.submit();
		}
		
	});

	$("#list").on("click", function(e){
		
		submitChk = true;
		
		actionFormObj.attr("action", "list");
		actionFormObj.attr("method", "get");
		
		var pageNumTag = $("input[name='pageNum']").clone();//태그복사
		var amountTag = $("input[name='amount']").clone();//태그복사

		var typeTag = $("input[name='type']").clone();//태그복사
		var keywordTag = $("input[name='keyword']").clone();//태그복사
		
		// 폼안의 요소를 삭제
		actionFormObj.empty();
		actionFormObj.append(pageNumTag);
		actionFormObj.append(amountTag);
		actionFormObj.append(typeTag);
		actionFormObj.append(keywordTag);
		
		actionFormObj.submit();
		
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
