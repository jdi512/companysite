<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>물품관리</h5>
				<span>물품관리 페이지입니다.</span>
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
			
			<%-- <div class="card-body">
			<form>
			<input type="hidden" name="pageNum" value="1">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<div class="form-inline">
					<div class="form-group" style="margin-right: 1em;">
						<label>대분류코드</label> <input name="majorCode" class="form-control">
					</div>
					<div class="form-group" style="margin-right: 1em;">
						<label>대분류명</label> <input name="majorName" class="form-control">
					</div>
					<div class="form-group" style="margin-right: 1em;">
						<label>세세분류코드</label> <input name="detailedCode" class="form-control">
					</div>
					<div class="form-group" style="margin-right: 1em;">
						<label>세세분류명</label> <input name="detailedName" class="form-control">
					</div>
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			</div> --%>
			
			
			<div class="card-block table-border-style">
			  <div class="row row-right">
			   	<button id="regBtn" type="button" class="btn btn-primary btn-sm ">물품등록</button>
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
                               <th>물품코드</th>
                               <th>물품이름</th>
                               <th>제조업체</th>
                               <th>단가</th>
                           </tr>
                       </thead>
                       <tbody>
                       		
                       	   <c:set var="total" value="${total}"/>
                           <c:forEach items="${list}" var="product">
	                       <tr>
                               <th scope="row">${total}</th>
                               <td>${product.productCode }</td>
                               <td><a href="get?productCode=${product.productCode }">${product.productName }</a></td>
                               <td>${product.manufacturer}</td>
                               <td>${product.unitPrice}</td>
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
	
<%-- 	<input type="hidden" name="majorCode" value="${pageMaker.cri.majorCode }">
	<input type="hidden" name="majorName" value="${pageMaker.cri.majorName }">
	<input type="hidden" name="detailedCode" value="${pageMaker.cri.detailedCode }">
	<input type="hidden" name="detailedName" value="${pageMaker.cri.detailedName }"> --%>
	
</form>   
     
<script>
$(document).ready(function(){
	 
	//뒤로가기 문제해결
	history.replaceState({}, null, null);
	
	//게시판생성버튼
	$("#regBtn").on("click", function(){
		location.href="/admin/product/register";
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
