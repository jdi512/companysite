<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="includes/header.jsp" %>

    
    <!-- Hero Start -->
    <section class="board">
        <div class="container">
            <div class="row">
            	<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span>${boardInfo.boardName } 목록</span>
                            <sec:authorize access="isAuthenticated()">
                            <button id="regBtn" type="button" class="btn btn-primary btn-xs pull-right">${boardInfo.boardName }등록</button>
                            </sec:authorize>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <colgroup>
                                <col style="width:10%;">
                                <col style="width:;">
                                <col style="width:8%;">
                                <col style="width:17%;">
                                <col style="width:17%;">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <tbody>
									
									<c:forEach items="${list}" var="board">
									<c:set var="total" value="${total -1}"/>
									<c:set var="ix" value="${ix +1}"/><!-- //popover -->
                                    <tr class="even">
                                        <td>${total}</td>
                                        <td><a class="move" href="${board.bno }">${board.title }</a>
                                        <span class="badge" style="color:${board.replyCnt > 5?'red':''};">${board.replyCnt == 0?"":board.replyCnt}</span>
                                        <c:if test="${board.attachCnt != 0}">
                                        	<i class="fa fa-paperclip"></i>
                                        </a>
                                        </c:if>
                                        </td>
                                        <td>${board.writer }</td>
                                        <td class="center"><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td class="center"><fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    </tr>
                                    </c:forEach>
                                    
                                </tbody>
                            </table>
                            <div class="row">
                            	<div class="col-md-9 text-right">
                            		<form id="searchForm" class="form-inline">
                            			<select name="type" class="form-control">
                            				<option value="" <c:if test="${pageMaker.cri.type == null}">selected</c:if>>선택</option>
                            				<option value="T" ${pageMaker.cri.type eq 'T'?'selected':'' }>제목</option>
                            				<option value="C" ${pageMaker.cri.type eq 'C'?'selected':'' }>내용</option>
                            				<option value="W" ${pageMaker.cri.type eq 'W'?'selected':'' }>작성자</option>
                            				<option value="TC" ${pageMaker.cri.type eq 'TC'?'selected':'' }>제목 or 내용</option>
                            				<option value="TW" ${pageMaker.cri.type eq 'TW'?'selected':'' }>제목 or 작성자</option>
                            				<option value="TWC" ${pageMaker.cri.type eq 'TWC'?'selected':'' }>제목 or 내용 or 작성자</option>
                            			</select>
                            			<input type="text" name="keyword" class="form-control" value="${pageMaker.cri.keyword}">
                            			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                            			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                            			<button class="btn btn-default">Search</button>
                            			                         			
                            		</form>
                            	</div>
                            </div>
                            <!-- /.table-responsive -->
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
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                            
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
        </div>
    </section>
    <!-- Hero End -->
    
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                처리가 완료되었습니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<form id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	
	
	<input type="hidden" name="boardId" value="${boardInfo.boardId }">
</form>       


<div id="btn_top" style="display:scroll;"><a href="#"  title="Top"><img src="/resources/dist/images/img.png" alt="up"></a>
</div>
<script>
    $("#btn_top").click(function() {  // 버튼 클릭 시
          $('html,body').animate( {  // 애니메이션 적용
              scrollTop : 0  // 스크롤탑이 '0'으로 올라갈 때
          }, 500);  // 800에 걸쳐서 이동
          return false;
      });
</script>



<script>
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	var error = '<c:out value="${error}"/>';
	
	if(error == 'OK'){
		alert("해당게시판이 없습니다.");
		history.go(-1);
	}
	
	//checkModal(result);
	
	//뒤로가기 문제해결
	history.replaceState({}, null, null);
	
	function checkModal(result){
		if(result === ''){
			return;
		}
		
		if(parseInt(result) > 0){
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");		
		}
		
		$("#myModal").modal("show");
	}
	
	$("#regBtn").on("click", function(){
		location.href="/board/register?boardId=${boardInfo.boardId }";
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
	
	//체크박스

	$("#selDel").on("click", function(){
		
		if($(".selBox:checked").length == 0){
			alert("게시글을 먼저 선택하세요.");
			return;
		}		
		
		if(confirm("정말로 삭제하시겠습니까?")){
			$(".selBox").each(function(idx){
				if($(this).is(":checked") == true){
					actionForm.append("<input type='hidden' name='bno' value='"+$(this).val()+"'>");
				}				
			});
			

			actionForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');
			
			
			actionForm.attr("method", "post");
			actionForm.attr("action", "list");
			actionForm.submit();
		}
	});//$("#selDel").on("click", function(){
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){ 
		
		e.preventDefault();
		
		
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return;
		}
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		
		//console.log("검색" + (searchForm.find("option:selected").val() == ''));
		searchForm.submit();		
	});
	
	
	$(".clip").on("click", function(){
		
		let bno = $(this).data('bno');
		let idx = $(this).data('ix');//popover

		$.ajax({
			type : 'get',
			url : '/board/getAttachList',
			data : {bno:bno},
			dataType:'json',
			success : function(result, status, xhr){

				let str = "";
				
				for(let attach of result){
					str += "<div>" + attach.fileName + "</div>";
				}
				
				
				
				let id = $("#dataTables-example > tbody > tr:nth-child("+idx+") > td:nth-child(3) > a.clip").attr("aria-describedby");//popover
				
				$("#"+id+" .popover-content").html(str);//popover
				
			}
		});
		
	});
	
	/* 목록, 갤러리 */
	$(".fa-list").on("click", function(){
		location.href="list";
	});
	
	$(".fa-th").on("click", function(){
		location.href="gallery";	
	});
	
}); //$(document).ready(function(){

$(document).ready(function(){
	  $('[data-toggle="popover"]').popover();
});



</script>


<%@ include file="includes/footer.jsp" %>    
