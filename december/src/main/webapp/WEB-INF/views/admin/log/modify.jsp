<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<link href="/resources/dist/css/file.css" rel="stylesheet">

        
          <div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>업무일지ㅣ</h5>
				<span>업무일지 수정페이지입니다.</span>
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
                            
	                           	<div class="form-group">
	                            	<label>작성일자</label>
	                            	<input type="date" name="title" id="title" value="<fmt:formatDate value='${log.title}' pattern='yyyy-MM-dd'/>" class="form-control" required="required">
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>금일실시사항</label>
	                            	<textarea name="content" id="content" class="form-control" style="height:150px;" required="required">${log.content}</textarea>
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>법인카드사용내역</label>
	                            	<textarea name="bill" id="bill"  class="form-control" style="height:150px;" >${log.bill}</textarea>
	                            	
                            	</div>
                            	<div class="form-group">
	                            	<label>특이사항 보고</label>
	                            	<textarea name="etc" id="etc"  class="form-control" style="height:150px;" >${log.etc}</textarea>
	                       
                            	</div>
	                           	<sec:authentication property="principal" var="pinfo"/>
	                           	<sec:authorize access="isAuthenticated()">
	                           		<c:if test="${pinfo.username eq log.writer }">
	                           	<button data-oper="modify" type="button" class="btn btn-default button">수정</button>
	                           	<button data-oper="remove" type="button" class="btn btn-danger button">삭제</button>
	                           		</c:if>
                           		</sec:authorize>
	                           	<button data-oper="list" type="button" class="btn btn-info button">목록</button>
	                            
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
    
            
<form id="actionForm">

</form>

<script>
	$(document).ready(function(){
		var formObj = $("#form");
		var actionFormObj = $("#actionForm");
		
		
		$(".button").on("click", function(e){
			
			e.preventDefault();
						
			var operation = $(this).data("oper");
			
			if(operation === 'remove') {
				if(confirm("정말로 삭제하시겠습니까?")){
					formObj.attr("action", "remove");	
				} else {
					return;
				}
			} else if(operation === 'list'){
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
				return;
			} 

			formObj.submit();
		});
	});
</script>            


<%@ include file="../includes/footer.jsp" %>