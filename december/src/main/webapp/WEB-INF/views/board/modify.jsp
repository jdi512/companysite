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
                        <span>${boardInfo.boardName }수정</span>
                        <div class="pull-right">
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="wrapper">
                        	<form id="form" role="form" action="modify" method="post">
                            <input type="hidden" name="pageNum" value="${cri.pageNum }">
                            <input type="hidden" name="amount" value="${cri.amount }">
							<input type="hidden" name="type" value="${cri.type }">
							<input type="hidden" name="keyword" value="${cri.keyword }">
							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                    
	                        <input type="hidden" name="bno" id="bno" value="${board.bno }">							
							<input type="hidden" name="boardId" value="${boardInfo.boardId}">
							
	                        	<div class="form-group">
		                         	<label>제목</label> 
		                         	<input type="text" name="title" maxlength="200" id="title" class="form-control" required="required" value="${board.title }">
		                         	
	                        	</div>
	                        	<div class="form-group">
		                         	<label>내용</label>
		                         	<textarea name="content" id="content" class="form-control" style="height:150px;" required="required">${board.content }</textarea>
		                        
	                        	</div>
	                           	<div class="form-group">
	                            	<label>작성자</label>
	                            	<input type="text" name="writer" class="form-control" value="${board.writer }" readonly="readonly">
	                           	</div>
	                        	<div class="form-group">
	                        		<sec:authorize access="isAuthenticated()">
		                        	<button data-oper="modify" type="button" class="btn btn-danger button">${boardInfo.boardName }수정</button>
	                           		<button data-oper="remove" type="button" class="btn btn-danger button">${boardInfo.boardName }삭제</button>
		                        	</sec:authorize>
		                        	<button data-oper="list" type="button" class="btn btn-info">List</button>
	                        	</div>
	                        </form>
                        <!-- /.panel-heading -->
                        
	                        <div class="form-group">
	                            <label>첨부파일</label>
	                        </div>
                            <div class="form-group uploadDiv">
                            	<input type="file" name="uploadFile" multiple class="form-control">
                            </div>
                            <div class="uploadResult">
                            	<ul>
                            	</ul>
                            </div>                            
                        </div>
                        <!-- /.panel-body -->
                        
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
    </section>
    <!-- Hero End -->


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
	
	let cloneObj = $(".uploadDiv").clone();
	
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
							str += "<button class='btn btn-warning btn-circle' data-file='" + fileCallPath + "' data-type='image'><i class='fa fa-times'></i></button>";
							str += "<img src='/display?fileName=" +fileCallPath+ "'>";
							str += "</div>";
							str += "</li>";
						} else {
							let fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
							
							str += "<li data-path='" +attach.uploadPath+ "' data-uuid='" + attach.uuid + "' data-filename='" +attach.fileName+ "' data-type='" +attach.fileType+ "'>";
							str += "<div>";
							str += "<span>" +attach.fileName+ "</span><br>";
							str += "<button class='btn btn-warning btn-circle' data-file='" + fileCallPath + "' data-type='image'><i class='fa fa-times'></i></button>";
							str += "<img src='/resources/images/attach.png'>";
							str += "</div>";
							str += "</li>";
						}
					});
					
					
					$(".uploadResult > ul").html(str);
					
				});
		
	})();
	/* End */
	
	$(".uploadResult").on("click", "button", function(){
		if(confirm("Remove this file?")){
			$(this).closest("li").remove();
		}
	});
	/* End */
	
	
	/*  */
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	let maxSize = 52428800;//50MB
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;
	}
	/* End */
	
	/*  */
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(".uploadDiv").on("change", "input[type='file']", function(){
					
		let formData = new FormData();
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;
					
		for(let i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData:false,
			contentType:false,
			dataType:'json',//json, html, text ...
			data:formData,
			type:'POST',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(result){
				console.log(result);
				
				showUploadResult(result);
				
				$(".uploadDiv").html(cloneObj.html());

			}
		});
	});
	/* End */
	
	
	function showUploadResult(uploadResultArr){
		//배열이 없거나 배열의 길이가 0이면 리턴하세요.
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		
		let uploadUL = $(".uploadResult ul");
		
		let str = "";
		$(uploadResultArr).each(function(i, obj){

			//이미지 일떄
			if(obj.image){
				let fileCallPath 
					= encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				let originPath =  obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g), '/');
				
				str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
				str += "<div><span>" + obj.fileName + "</span>";
				str += "<button class='btn btn-warning btn-circle' data-file='" + fileCallPath + "' data-type='image'><i class='fa fa-times'></i></button><br>";
				str += "<a href='javascript:showImage(\"" + originPath + "\");'><img src='/display?fileName=" + fileCallPath + "'></a>";
				str += "</div></li>";
			} else {
				let fileCallPath 
							= encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
				str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
				str += "<div><span>" + obj.fileName + "</span>";
				str += "<button class='btn btn-warning btn-circle' data-file='" + fileCallPath + "' data-type='file'><i class='fa fa-times'></i></button><br>";
				str += "<a href='/download?fileName=" + fileCallPath + "'><img src='/resources/images/attach.png'></a>";
				str += "</div></li>";
			}
			
			
		});

		uploadUL.append(str);
	}
});
</script>                
            
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
			} else if(operation === 'modify'){
				let str = "";
				
				$(".uploadResult > ul > li").each(function(i, obj){
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + $(obj).data('filename') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + $(obj).data('uuid') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + $(obj).data('path') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + $(obj).data('type') + "'>";
				});
				
				formObj.append(str);
				
			}

			formObj.submit();
		});
	});
</script>            

<%@ include file="includes/footer.jsp" %>    
