0<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<link href="/resources/css/file.css" rel="stylesheet">

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify Page</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form id="form" role="form" action="modify" method="post">
                            <input type="hidden" name="pageNum" value="${cri.pageNum }">
                            <input type="hidden" name="amount" value="${cri.amount }">
							<input type="hidden" name="type" value="${cri.type }">
							<input type="hidden" name="keyword" value="${cri.keyword }">
							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            
	                          	<div class="form-group">
	                            	<label>Bno</label>
	                            	<input type="text" name="bno" class="form-control" value="${board.bno }" readonly="readonly">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>Title</label>
	                            	<input type="text" name="title" class="form-control" value="${board.title }" required="required">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>Text Area</label>
	                            	<textarea name="content" class="form-control" style="height:150px;" required="required">${board.content }</textarea>
	                           	</div>
	                           	<div class="form-group">
	                            	<label>Writer</label>
	                            	<input type="text" name="writer" class="form-control" value="${board.writer }" readonly="readonly">
	                           	</div>
	                           	<sec:authentication property="principal" var="pinfo"/>
	                           	<sec:authorize access="isAuthenticated()">
	                           		<c:if test="${pinfo.username eq board.writer }">
	                           	<button data-oper="modify" type="button" class="btn btn-default button">Modify</button>
	                           	<button data-oper="remove" type="button" class="btn btn-danger button">Remove</button>
	                           		</c:if>
                           		</sec:authorize>
	                           	<button data-oper="list" type="button" class="btn btn-info button">List</button>
	                            
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

			<!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-file"></i> Files
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div class="form-group uploadDiv">
                            	<input type="file" name="uploadFile" multiple>
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
<script>
$(document).ready(function(){
	
	let cloneObj = $(".uploadDiv").clone();
	
	(function(){
		let bno = '${board.bno}';
		
		$.getJSON("/admin/board/getAttachList", 
				{ bno:bno },
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


<%@ include file="../includes/footer.jsp" %>