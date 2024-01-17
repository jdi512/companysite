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
                        <span>${boardInfo.boardName }등록</span>
                        <div class="pull-right">
                         <div class="btn-group" role="group" aria-label="Basic example">
                          <button id="regTmpBtn" type="button" class="btn btn-primary btn-xs">임시저장</button>
                          <button id="regTmpListBtn" type="button" class="btn btn-primary btn-xs">임시저장목록</button>
                         </div>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="wrapper">
	                        <form id="form" role="form" action="/board/register" method="post">
	                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	                        <input type="hidden" name="writer" id="writer" value='<sec:authentication property="principal.member.userid"/>'>
	                        <input type="hidden" name="boardId" value="${boardInfo.boardId}">
	                        
	                        	<div class="form-group">
		                         	<label>Title</label>
		                         	<input type="text" name="title" maxlength="200" id="title" class="form-control" required="required">
		                         	
	                        	</div>
	                        	<div class="form-group">
		                         	<label>Text Area</label>
		                         	<textarea name="content" id="content" class="form-control" style="height:150px;" required="required"></textarea>
		                        
	                        	</div>
	                        	<div class="form-group">
		                        	<button type="submit" class="btn btn-primary">${boardInfo.boardName }등록</button>
		                        	<button type="reset" class="btn btn-default">다시작성</button>
	                        	</div>
	                        </form>
                        <!-- /.panel-heading -->
                        
	                        <div class="form-group">
	                            <label>File Attach</label>
	                        </div>
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
        </div>
    </section>
    <!-- Hero End -->
 
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Temp Modal</h4>
            </div>
            <div class="modal-body">
                <div class="tmp">
                	<div class="row">
	                	<div class="col-md-6">제목</div>
	                	<div class="col-md-3">작성일</div>
	                	<div class="col-md-3">삭제버튼</div>
                	</div>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>

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
		
		
		var formObj = $("form[role='form']");
		/*  */
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			
			let str = "";
			
			$(".uploadResult > ul > li").each(function(i, obj){
				str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + $(obj).data('filename') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + $(obj).data('uuid') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + $(obj).data('path') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + $(obj).data('type') + "'>";
			});
		
			submitChk = true;
			
			formObj.append(str);
			formObj.submit();
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
		
		/*  */
		
		$(".uploadResult").on("click", "button", function(){
			
			let targetFile = $(this).data('file');
			let type = $(this).data('type');
			let targetLi = $(this).closest("li");
			$.ajax({
				url:'/deleteFile',
				data:{
					fileName:targetFile,
					type:type
				},
				dataType:'text',
				type:'post',
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success:function(result){
					
					if(result == 'deleted'){
						targetLi.remove();
					}
				}
				
			});
			
			
		});
		
		/*
		임시저장버튼을 클릭했을때 이벤트처리
		*/
		
		// localStorage에 저장할 배열
        var boardArr = new Array();
     	// getItem
        let tmpStr = window.localStorage.getItem('arrs');
		
     	// JSON 문자열을 객체, 배열로 변환
        boardArr = JSON.parse(tmpStr);
     	
     	
		$("#regTmpBtn").on("click", function(){
			let title = $("#title").val();
			let content = $("#content").val();
			let writer = $("#writer").val();
			
			 // localStorage에 저장할 객체
	        let obj = {
		        title : title,
		        content : content,
		        writer : writer
	        }
			 
	     	
			// 배열에 Object저장
	        boardArr.push(obj);
			
	     	// 객체, 배열을 JSON 문자열로 변환
	        const arrString = JSON.stringify(boardArr);
	     
			// setItem
			window.localStorage.setItem('arrs', arrString);
			
		});
		/*
		임시저장버튼을 클릭했을때 이벤트처리 끝
		*/
		function showList(){
			$.getJSON("/board/pages.json",
				function(list){
					let str = '';
					for(let i = 0; i < list.length; i++){
						str += '<div class="row">';
						str += '<div class="col-md-8 selList" data-bno="' + list[i].bno + '">' + ((list[i].title == '')?'제목 없음':list[i].title) + '</div>';
						str += '<div class="col-md-3">' + replyService.displayTime(list[i].regdate) + '</div>';
						str += '<div class="col-md-1"><i class="fa fa-trash-o selDel" aria-hidden="true" data-bno="' + list[i].bno + '"></i></div>';
						str += '</div>';
					}
					
					$(".tmp").html(str);
				
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				}//fail
			);
		}
		
		$("#regTmpListBtn").on("click", function(){
			
			// getItem
	        let arrStr = window.localStorage.getItem('arrs');
			
	     	// JSON 문자열을 객체, 배열로 변환
	        const boardArr = JSON.parse(arrStr);
	     	
	        let str = '';
			
	     	for(let [index, board] of boardArr.entries()){
	     		
	     		str += '<div class="row">';
				str += '<div class="col-md-11 selList" data-bno="' + index + '">' + ((board.title == '')?'제목 없음':board.title) + '</div>';
				str += '<div class="col-md-1"><i class="fa fa-save selTmp" aria-hidden="true" data-ix="' + index + '"></i></div>';
				str += '</div>';
	     	}
	     	
	     	$(".tmp").html(str);
	     	
			$(".modal").modal("show");/* 모달창 띄우기 */
			
		});
		/* End */
		
		$(".tmp").on("click", ".selTmp", function(){
			let idx = $(this).data('ix');
			// getItem
	        let boardString = window.localStorage.getItem('arrs');
	        
	        // JSON 문자열을 객체, 배열로 변환
	        boardArr = JSON.parse(boardString);
	        
	        $("#title").val(boardArr[idx].title);
	        $("#content").val(boardArr[idx].content);
	        $("#writer").val(boardArr[idx].writer);
	        
	        $(this).parent().parent().remove();
	       	
	        boardArr.splice(idx,1); //삭제할 idx를 처리

	        localStorage.setItem("arrs", JSON.stringify(boardArr)); 
	        
	        $(".modal").modal("hide");
		});
		
		
		
		$(".tmp").on("click", ".selList", function(){
			let bno = $(this).data('bno');
			
			$.get('/board/' + bno + '.json', 
				function(data, status, xhr){
					$("#title").val(data.title);
					$("#content").val(data.content);
					$("#writer").val(data.writer);

					$("input[name='bno']").remove();
					
					$("#form").append("<input type='hidden' name='bno' value='" + data.bno + "'>");
					
					$(".modal").modal("hide");
				})
				.fail(function(xhr, status, err){
					if(error){
						error();
					}
				}
			);
			
			
		});
		
		$(".tmp").on("click",".selDel",function(){
			let bno = $(this).data('bno');
			
			$.ajax({
				type : 'delete',
				url : '/board/' + bno,
				success : function(result, status, xhr){
					if(result == 'success'){
						alert("삭제되었습니다.");
						showList();
					}
				}
			});
		});	
	});//$(documnet).ready();
	
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath +"'>")
		.animate({width:'100%', height: '100%'}, 1000);
	}
	
	
</script>
<script type="text/javascript">
	submitChk = false;
    window.addEventListener('beforeunload', (event) => {
    	if(!submitChk){
	        // 명세에 따라 preventDefault는 호출해야하며, 기본 동작을 방지합니다.
	        event.preventDefault();
	
	        // 대표적으로 Chrome에서는 returnValue 설정이 필요합니다.
	        event.returnValue = '';
    	}
    });
</script>


<%@ include file="includes/footer.jsp" %>    
