<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>납품업체관리</h5>
				<span>납품업체관리 페이지입니다.</span>
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
			
			<div class="card-block table-border-style">
			  <div class="row row-right">
			   	<button id="regBtn" type="button" class="btn btn-primary btn-sm ">납품업체등록</button>
			   </div>
               <div class="table-responsive">
                   <table class="table table-striped table-hover table-bordered">
                       <colgroup>
                           <col style="width:5%;">
                           <col style="width:;">
                           <col style="width:;">
                           <col style="width:;">
                           <col style="width:;">
                       </colgroup> 
                       <thead>
                           <tr>
                               <th>#</th>
                               <th>사업자등록번호</th>
                               <th>상호(법인명)</th>
                               <th>성명</th>
                               <th>전화번호</th>
                           </tr>
                       </thead>
                       <tbody>
                       		
                       	   <c:set var="total" value="${total}"/>
                           <c:forEach items="${list}" var="company">
	                       <tr>
                               <th scope="row">${total}</th>
                               <td>${company.taxId }</td>
                               <td><a href="get?compName=${company.companyName }">${company.companyName }</a></td>
                               <td>${company.ceoName }</td>
                               <td>${company.tel }</td>
                           </tr>
						   <c:set var="total" value="${total -1}"/>
						   </c:forEach>
                       </tbody>
                   </table>
                   
                   <div class="row row-right">
				       <nav aria-label="Page navigation example">
						  <ul class="pagination">
						  
						  	<c:if test="${pageMaker.prev }">
					    		<li class="page-item">
					    			<a class="page-link" href="${pageMaker.startPage -1 }">Previous</a>
					    		</li>
						    </c:if>
						    <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
							    
							    <c:choose>
								    <c:when test="${num ne pageMaker.cri.pageNum }">
								    	<li class="page-item"><a class="page-link" href="${num}">${num}</a></li>
								    </c:when>
								    <c:otherwise>									    
									    <li class="page-item active" aria-current="page">
									      <span class="page-link">${num}</span>
									    </li>
								    </c:otherwise>
							    </c:choose>
							    
						    </c:forEach>
						    <c:if test="${pageMaker.next }">
							    <li class="page-item">
							      <a class="page-link" href="${pageMaker.endPage +1 }">Next</a>
							    </li>
						    </c:if>
						  </ul>
						</nav>
				    </div>
               </div>
           </div>
		</div>
	</div>

</div>
       
<form id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	
	<input type="hidden" name="majorCode" value="${pageMaker.cri.majorCode }">
	<input type="hidden" name="majorName" value="${pageMaker.cri.majorName }">
	<input type="hidden" name="detailedCode" value="${pageMaker.cri.detailedCode }">
	<input type="hidden" name="detailedName" value="${pageMaker.cri.detailedName }">
	
</form>   
     
<script>
$(document).ready(function(){
	 
	//뒤로가기 문제해결
	history.replaceState({}, null, null);
	
	//게시판생성버튼
	$("#regBtn").on("click", function(){
		location.href="/admin/company/register";
	});

	var actionForm = $("#actionForm");
	
	//페이징 번호 링크
	$(".page-item a").on("click", function(e){
		
		e.preventDefault();
		//1. actionForm에  bno삭제
		$("input[name='bno']").remove();
		//2.  get 대신에 list <== <form action 값수정
		actionForm.attr("action", "list");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		actionForm.submit();
	});
	
	
	//게시글 제목 링크
	$(".move").on("click", function(e){
		e.preventDefault();
		//삭제
		$("input[name='bno']").remove();
		//등록
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "get");
		actionForm.submit();
	});

});
</script>



<%@ include file="../includes/footer.jsp"%>
