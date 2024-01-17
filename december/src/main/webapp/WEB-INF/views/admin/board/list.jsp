<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>게시판관리</h5>
				<span>게시판을 생성하면 자동으로 테이블이 만들어지고 공통클래스를 사용한다.</span>
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
			   	<button id="regBtn" type="button" class="btn btn-primary btn-sm ">게시판생성</button>
			   </div>
               <div class="table-responsive">
                   <table class="table table-striped table-hover table-bordered">
                       <colgroup>
                           <col style="width:10%;">
                           <col style="width:;">
                           <col style="width:;">
                           <col style="width:10%;">
                           <col style="width:15%;">
                           <col style="width:15%;">
                       </colgroup> 
                       <thead>
                           <tr>
                               <th>#</th>
                               <th>게시판아이디</th>
                               <th>게시판이름</th>
                               <th>작성자</th>
                               <th>게시판생성일시</th>
                               <th>게시판관리</th>
                           </tr>
                       </thead>
                       <tbody>
                       		
                       
                           <c:forEach items="${list}" var="board">
						   <c:set var="total" value="${total -1}"/>
						   <c:set var="ix" value="${ix +1}"/>
	                       <tr>
                               <th scope="row">${total}</th>
                               <td><a href="/board/list?boardId=${board.boardId }" target="_blank">${board.boardId }</a></td>
                               <td>${board.boardName }</td>
                               <td>${board.writer }</td>
                               <td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                               <td>
                               	<div style="display:flex;">
                               		<div style="margin-right:20px;">
                               			<a class="move" href="${board.bno }"><i class="fa fa-edit close-card" aria-hidden="true"></i></a>
                               		</div>
	                             	<div><i class="fa fa-trash close-card" aria-hidden="true"></i></div>
	                            </div>
                               </td>
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
	
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>   
     
<script>
$(document).ready(function(){
	 
	//뒤로가기 문제해결
	history.replaceState({}, null, null);
	
	//게시판생성버튼
	$("#regBtn").on("click", function(){
		location.href="/admin/board/register";
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
