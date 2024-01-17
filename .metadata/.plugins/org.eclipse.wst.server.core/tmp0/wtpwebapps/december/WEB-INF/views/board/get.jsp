<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="includes/header.jsp" %>

<link href="/resources/dist/css/file.css" rel="stylesheet">

    
    <!-- Hero Start -->
    <section class="board">
        <div class="container">
            <div class="row">
            	<div class="panel panel-default">
                    <div class="panel-heading">
                        <span>${boardInfo.boardName } 읽기</span>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="wrapper">	                        
	                        	      <table class="table table-bordered">
			                            <tr>
			                            <th>작성일</th>
			                            <td><fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			                            <th>갱신일</th>
			                            <td><fmt:formatDate value='${board.updateDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			                            <th>직원명(직책)</th>
			                            <td>${member.userName}(${member.position})</td>
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
		                         	<label>제목</label> 
		                         	<input type="text" name="title" maxlength="200" id="title" class="form-control" readonly="readonly" value="${board.title }">
		                         	
	                        	</div>
	                        	<div class="form-group">
		                         	<label>내용</label>
		                         	<textarea name="content" id="content" class="form-control" style="height:150px;" readonly="readonly">${board.content }</textarea>
		                        
	                        	</div>
	                        	<div class="form-group">
	                        		<sec:authorize access="isAuthenticated()">
		                        	<button data-oper="modify" type="button" class="btn btn-primary">${boardInfo.boardName }수정</button>
		                        	</sec:authorize>
		                        	<button data-oper="list" type="button" class="btn btn-info">List</button>
	                        	</div>
                        <!-- /.panel-heading -->
                        
	                        <div class="form-group">
	                            <label>첨부파일</label>
	                        </div>
                            <div class="uploadResult">
                            	<ul>
                            	</ul>
                            </div>                            
                        </div>
                        <!-- /.panel-body -->
                        <div class="wrapper">
                        	<!-- /.row -->
				            <div class="row">
				                <div class="col-lg-12">
				                    <div class="panel panel-default">
				                        <div class="panel-heading">
				                            <span><i class="fa fa-comments fa-fw"></i> 댓글</span>
				                            <sec:authorize access="isAuthenticated()">
				                            <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
				                            </sec:authorize>
				                        </div>
				                        <!-- /.panel-heading -->
				                        <div class="panel-body">
				                            <ul class="chat">
				                            <!-- start reply -->
				                            	<li class="left clearfix" data-rno="12">
				                            		<div>
				                            			<div class="header">
				                            				<strong class="primary-font">user00</strong>
				                            				<small class="pull-right text-muted">2018-01-01 13:13</small>
				                            			</div>
				                            			<p>Good job!</p>
				                            		</div>
				                            	</li>
				                            <!-- end reply -->
				                            </ul>
				                        </div>
				                        <!-- /.panel-body -->
				                        <div class="panel-footer">
				                        </div>
				                    </div>
				                    <!-- /.panel -->
				                </div>
				                <!-- /.col-lg-12 -->
				            </div>
				            <!-- /.row -->
                        </div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
    </section>
    <!-- Hero End -->
 
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>Reply</label>
                	<textarea class="form-control" name="reply" style="height:80px;">New Reply!!!</textarea>
                </div>
                <div class="form-group">
                	<label>Replyer</label>
                	<input class="form-control" name="replyer" value="replyer">
                </div>
                <div class="form-group">
                	<label>Reply Date</label>
                	<input class="form-control" name="replyDate" value="">
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


            
<form id="operForm" action="modify" method="get">
	<input type="hidden" name="bno" id="bno" value="${board.bno }">
	<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" id="amount" value="${cri.amount }">
	
	<input type="hidden" name="type" id="type" value="${cri.type }">
	<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
	
	<input type="hidden" name="boardId" value="${boardInfo.boardId}">
</form>

<script src="/resources/dist/js/reply.js"></script>

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
	/* 파일관련 */
	
	(function(){
		let bno = '${board.bno}';
		let boardId = '${boardInfo.boardId}';
		
		$.getJSON("/board/getAttachList", 
				{ bno:bno, boardId:boardId},
				function(arr){
					
					
					let str = "";
					
					$(arr).each(function(i, attach){
						//이미지일때
						if(attach.fileType){
							let fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName); 
							
							str += "<li data-path='" +attach.uploadPath+ "' data-uuid='" + attach.uuid + "' data-filename='" +attach.fileName+ "' data-type='" +attach.fileType+ "'>";
							str += "<div>";
							str += "<span>" +attach.fileName+ "</span><br>";
							str += "<img src='/display?fileName=" +fileCallPath+ "'>";
							str += "</div>";
							str += "</li>";
						} else {
							str += "<li data-path='" +attach.uploadPath+ "' data-uuid='" + attach.uuid + "' data-filename='" +attach.fileName+ "' data-type='" +attach.fileType+ "'>";
							str += "<div>";
							str += "<span>" +attach.fileName+ "</span><br>";
							str += "<img src='/resources/images/attach.png'>";
							str += "</div>";
							str += "</li>";
						}
					});
					
					
					$(".uploadResult > ul").html(str);
					
				});
		
	})();
	
	
	$(".uploadResult").on("click", "li", function(){
		let liObj = $(this);
		
		let path = encodeURIComponent(liObj.data('path') + '/' + liObj.data('uuid') + '_' + liObj.data('filename'));
		
		//그림일때
		if(liObj.data('type')){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		} else {
			location.href="/download?fileName=" + path;
		}
	});
	
	$(".bigPictureWrapper").on("click", function(){
		
		$(".bigPicture").animate({width:'0%',height:'0%'}, 1000, '',function(){
			$(".bigPictureWrapper").hide();
		});
		
	});
	
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath +"'>")
		.animate({width:'100%', height: '100%'}, 1000);
	}
	
});
</script>   




<script>
$(document).ready(function(){
	/* 댓글관련 */
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<div class='container-fluid'><ul class='pagination pull-right'>";
		if(prev) {
			str += "<li class='page-item'><a class='page-link' href='"+(startNum -1) + "'>Previous</a></li>";
		}
		console.log(pageNum);
		for(var i = startNum ; i <= endNum; i++){
			var active = pageNum == i ? "active":"";
			
			str += "<li class='page-item " +active+ "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
		}
		
		if(next) {
			str += "<li class='page-item'><a class='page-link' href='" +(endNum +1) + "'>Next</a></li>";
		}
		
		str += "</ul></div>";
		
		replyPageFooter.html(str);
	}
	
	
	
	replyPageFooter.on("click", "li a", function(e){
		
		e.preventDefault();
		
		let targetPageNum = $(this).attr("href");
		
		showList(targetPageNum);
	});
	
	

	var bnoValue = '${board.bno}';
	var boardIdValue = '${boardInfo.boardId}';
	var replyUL = $(".chat");
	
	showList(1);
	/*  */
	function showList(page){
		replyService.getList({bno:bnoValue, page:page || 1}, 
				function(replyCnt, list){
					//새로운 댓글을 작성하면 마지막페이지로 이동.
					if(page == -1){
						pageNum = Math.ceil(replyCnt / 10.0);
						showList(pageNum);
						return;
					} else {
						pageNum = page;	
					}				
					
			
					/* 댓글이 없을때 */
					if(list == null || list.length == 0){
						replyUL.html("");
						return;
					}
					
					var str = '';
					for(var i = 0; i < list.length; i++){
						str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
						str += '<div>';
						str += '<div class="header">';
						str += '<strong class="primary-font">' + list[i].replyer + '</strong>';
						str += '<small class="pull-right text-muted">' + replyService.displayTime(list[i].replyDate) + '</small>';
						str += '</div>';
						str += '<p>' + replyService.displayBr(list[i].reply) + '</p>';
						str += '</div>';
						str += '</li>';					
					}
					
					replyUL.html(str);
					
					showReplyPage(replyCnt);
				}
		);
	}
	
	/*  */
	var modal = $(".modal");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	var modalInputReply = modal.find("textarea[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");

	var modalRegisterBtn = $("#modalRegisterBtn");//등록버튼
	var modalRemoveBtn = $("#modalRemoveBtn");//삭제버튼
	var modalModBtn = $("#modalModBtn");//수정버튼
	
	var replyer = null;
	
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	$("#modalRemoveBtn").on("click", function(){
		
		//!replyer
		if(replyer == null){
			alert("로그인후 삭제가 가능합니다.");
			$(".modal").modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			$(".modal").modal("hide");
			return;
		}
		
		//return;//아래 명령어를 수행하지 않는다.
		
		
		replyService.remove(
			modal.data('rno'),
			originalReplyer,
			function(result){
				alert("RESULT: " + result);
				
				$(".modal").modal("hide");
				
				showList(pageNum);
			}
		);
	});
	
	$("#modalModBtn").on("click", function(){

		//!replyer
		if(replyer == null){
			alert("로그인후 수정이 가능합니다.");
			$(".modal").modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			$(".modal").modal("hide");
			return;
		}
		
		
		replyService.update(
				{
					rno: modal.data('rno'), 
					reply:modalInputReply.val(), 
					replyer:originalReplyer,
					bno:bnoValue
				},
				function(result){
					alert("RESULT: " + result);
					
					$(".modal").modal("hide");

					showList(pageNum);
				}
		);
	});
	
	
	$(".chat").on("click", "li", function(){
		var rno = $(this).data('rno');
		
		modalInputReplyDate.closest("div").show();
		
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
			modalInputReplyDate.attr("readonly","readonly");
			
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			<sec:authentication property="principal" var="pinfo"/>
          	<sec:authorize access="isAuthenticated()">
          		if("${pinfo.username }" == reply.replyer){
	          		modalRemoveBtn.show();
	    			modalModBtn.show();
          		}
      		</sec:authorize>
           		
			
			$(".modal").modal("show");
		});
	});
	
	
	
	$("#modalRegisterBtn").on("click", function(){
		
		if(modalInputReply.val() == ''){
			alert("댓글을 작성하셔야합니다.");
			modalInputReply.focus();
			return;
		}
		
		
		var reply = {
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue,
				boardId:boardIdValue
				};
		replyService.add(
				reply,
				function(result){
					alert("RESULT: " + result);
					
					modal.find("textarea").val("");
					modal.find("input").val("");
					$(".modal").modal("hide");
					
					showList(-1);
				}
			);
		
	});
	
	$("#addReplyBtn").on("click", function(){
		
		modal.find("textarea").val("");
		modal.find("input[name='replyer']").val(replyer);
		//modal.find("input[name='replyer']").attr("readonly","readonly");
		modal.find("input[name='replyer']").prop("readonly",true);
		
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");/* 모달창 띄우기 */
	});
	
	
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(){		
		operForm.find("#bno").remove();
		operForm.append("<input type='hidden' name='bno' id='bno' value='${board.bno}'>");

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

<%@ include file="includes/footer.jsp" %>    
