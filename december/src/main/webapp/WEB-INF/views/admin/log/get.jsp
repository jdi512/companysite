<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>업무 일지</h5>
				<span>업무 일지 상세 페이지입니다.</span>
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
                            <table class="table table-bordered">
                            <tr>
                            <th>업무일</th>
                            <td><fmt:formatDate value='${log.title}' pattern='yyyy-MM-dd'/></td>
                            <th>직원명</th>
                            <td>${member.userName}</td>
                            <th>직책</th>
                            <td>${member.position}</td>
                            </tr>
                            <tr>
                            <th>부서명</th>
                            <td>${member.department}</td>
                            <th>이메일</th>
                            <td>${member.email}</td>
                            <th>전화번호</th>
                            <td>${member.tel}</td>
                            </tr>
                            </table>
                            	<div class="form-group">
	                            	<label>작성일자</label>
	                            	<input type="date" name="title" id="title" class="form-control"  value="<fmt:formatDate value='${log.regdate}' pattern='yyyy-MM-dd'/>" readonly="readonly">
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>금일실시사항</label>
	                            	<textarea name="content" id="content" class="form-control" style="height:150px;" readonly="readonly">${log.content}</textarea>
	                          
                            	</div>
                            	<div class="form-group">
	                            	<label>법인카드사용내역</label>
	                            	<textarea name="bill" id="bill" class="form-control"  style="height:150px;" readonly="readonly">${log.bill}</textarea>
	                            	
                            	</div>
                            	<div class="form-group">
	                            	<label>특이사항 보고</label>
	                            	<textarea name="etc" id="etc" class="form-control"  style="height:150px;" readonly="readonly">${log.etc}</textarea>
	                       
                            	</div>
                           	<sec:authentication property="principal" var="pinfo"/>
                           	<sec:authorize access="isAuthenticated()">
                           		<c:if test="${pinfo.username eq log.writer }">
                           			<button data-oper="modify" type="button" class="btn btn-default">Modify</button>
                           		</c:if>
                           	</sec:authorize>
                           	<button data-oper="list" type="button" class="btn btn-info">List</button>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        
           
            
            

            
<form id="operForm" action="modify" method="get">
	<input type="hidden" name="bno" id="bno" value="${log.bno }">
	<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" id="amount" value="${cri.amount }">
	
	<input type="hidden" name="type" id="type" value="${cri.type }">
	<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
</form>


<script>
$(document).ready(function(){
		
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(){		
		operForm.find("#bno").remove();
		operForm.append("<input type='hidden' name='bno' id='bno' value='${log.bno}'>");

		operForm.attr("action", "modify");
		
		operForm.submit();
	});

	$("button[data-oper='list']").on("click", function(){
		operForm.find("#bno").remove();
		operForm.attr("action", "list");
		operForm.submit();
	});
});
</script>

<%@ include file="../includes/footer.jsp" %>