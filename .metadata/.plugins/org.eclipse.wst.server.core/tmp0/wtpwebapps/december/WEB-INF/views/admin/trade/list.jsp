<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>거래 명세서</h5>
				<span>${company.companyName}의 거래명세서 목록페이지입니다</span>
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
			   	<button id="regBtn" type="button" class="btn btn-primary btn-sm ">거래명세서 등록</button>
			   </div>
               <div class="table-responsive">
                   <table class="table table-striped table-hover table-bordered">
                       <colgroup>
                           <col style="width:10%;">
                           <col style="width:;">
                           <col style="width:;">
                           <col style="width:15%;">
                           <col style="width:15%;">
                       </colgroup> 
                       <thead>
                           <tr>
                               <th>#</th>
                               <th>공급받는자</th>
                               <th>합계금액</th>
                               <th>작성일</th>
                               <th>영수청구여부</th>
                           </tr>
                       </thead>
                       <tbody>
                       		
                       
                           <c:forEach items="${list}" var="trade">
						   <c:set var="total" value="${total -1}"/>
	                       <tr>
                               <th scope="row">${total}</th>
                               <td><a class="move" href="${trade.tno}">${trade.supplyer}</a></td>
                               <td><fmt:formatNumber value="${trade.finalAmount }" pattern="#,###"/>(VAT 10% 포함)</td>
                               <td><fmt:formatDate value="${trade.regdate }" pattern="yyyy-MM-dd"/></td>
                               <td>${trade.receipt?'영수':'청구'}</td>
                           </tr>
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
</form>   
     
<script>
$(document).ready(function(){
	 
	//뒤로가기 문제해결
	history.replaceState({}, null, null);
	
	//게시판생성버튼
	$("#regBtn").on("click", function(){
		location.href="/admin/trade/register";
	});

	var actionForm = $("#actionForm");
	
	//페이징 번호 링크
	$(".page-item a").on("click", function(e){
		
		e.preventDefault();
		//1. actionForm에  tno삭제
		$("input[name='tno']").remove();
		//2.  get 대신에 list <== <form action 값수정
		actionForm.attr("action", "list");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		actionForm.submit();
	});
	
	
	//게시글 제목 링크
	$(".move").on("click", function(e){
		e.preventDefault();
		//삭제
		$("input[name='tno']").remove();
		//등록
		actionForm.append("<input type='hidden' name='tno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "get");
		actionForm.submit();
	});

});
</script>



<%@ include file="../includes/footer.jsp"%>
