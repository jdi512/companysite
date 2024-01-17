<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<link href="/resources/dist/css/file.css" rel="stylesheet">

<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>직원 관리</h5>
				<span>직원 등록페이지입니다.</span>
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
                            <form id="form" role="form" action="register" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="userpw" value="" >
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<input type="hidden" name="tel" id="tel" value="">
                            	<div class="form-group">
	                            	<label>프로필사진</label>
	                            	<div id="image_container"></div>
	                            	<i class="fa fa-camera" style="font-size:1.7em;"></i>
	                            	<input type="file" style="display:none;" accept="image/*" name="profileImg" id="pfImg" class="form-control" value="" placeholder="프로필사진"  onchange="setThumbnail(event);">	                            	
	                           	</div>							    
	                          	<div class="form-group">
	                            	<label>아이디</label>
	                            	<div>
		                            	<input type="text" name="userid" id="userId" class="form-control" placeholder="아이디" value=""  style="display:inline-block; width:auto;">
		                            	<button type="button" id="idDuplicateChk" class="btn btn-default">아이디중복체크</button>
	                            	</div>
	                           	</div>
	                           	<div class="form-group">
	                            	<label>비밀번호</label>
	                            	<input type="password" id="userpw1" class="form-control" value="" placeholder="비밀번호" >
	                           	</div>
	                           	<div class="form-group">
	                            	<label>비밀번호확인</label>
	                            	<input type="password" id="userpw2" class="form-control" value="" placeholder="비밀번호확인" >
	                           	</div>
	                           	<div class="form-group">
	                            	<label>부서명</label>
	                            	<input type="text" name="department" id="department" class="form-control" value=""  placeholder="부서명">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>직책</label>
	                            	<input type="text" name="position" id="position" class="form-control" value=""  placeholder="직책">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>직원이름</label>
	                            	<input type="text" name="userName" id="userName" class="form-control" value=""  placeholder="직원이름">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>이메일</label>
	                            	<input type="text" name="email" id="email" class="form-control" value=""  placeholder="이메일">
	                           	</div>
	                           	<div class="form-group">
	                            	<label>휴대전화번호</label>
	                            	<div class="form-inline">
		                            	<select id="tel1" class="form-control">
		                            	<option value="010">010</option>
		                            	</select>
		                            	-<input type="text" id="tel2" class="form-control" value=""  placeholder="0000">
		                            	-<input type="text" id="tel3" class="form-control" value=""  placeholder="0000">
	                            	</div>
	                           	</div>
	                           	
	                           	<div class="form-group">
	                            	<label>권한</label>
	                            	<div>
		                            	<label><input type="checkbox" name="auth" value="ROLE_ADMIN" >ROLE_ADMIN</label>
		                            	<label><input type="checkbox" name="auth" value="ROLE_EMPLOYEE" >ROLE_EMPLOYEE</label>
	                            	</div>
	                           	</div>
	                           	
	                           	<button data-oper="register" type="button" class="btn btn-default button">직원등록</button>	                           	
	                           	<button data-oper="list" type="button" class="btn btn-info button">목록</button>
	                            
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
             
            
<form id="actionForm">

</form>


<script>
	$(document).ready(function(){
		var formObj = $("#form");
		var actionFormObj = $("#actionForm");
		
		
		$(".button").on("click", function(e){
			
			e.preventDefault();
						
			var operation = $(this).data("oper");
			
			if(operation === 'register') {				
				
				
				
				//폼 필수항목값 체크
				if($("#userId").val() == ''){
					alert("아이디를 입력하세요");
					return;
				}
				
				if(!idDuplicateChk){
					alert("아이디중복체크를 하세요");
					return;					
				}
				
				if(!passwdChk()){
					return;
				} 
				
				$("input[name='userpw']").val($("#userpw1").val());
				
				if($("#department").val() == ''){
					alert("부서명을 입력하세요");
					return;
				}
				
				if($("#position").val() == ''){
					alert("직책을 입력하세요");
					return;
				}
				
				if($("#userName").val() == ''){
					alert("직원이름을 입력하세요");
					return;
				}
				
				if($("#email").val() == ''){
					alert("이메일을 입력하세요");
					return;
				}
				
				if($("#tel2").val() == '' || $("#tel3").val() == ''){
					alert("휴대전화번호를 입력하세요");
					return;
				}
				
				$("#tel").val($("#tel1").val() + "-" + $("#tel2").val() + "-" + $("#tel3").val());
				

			} else if(operation === 'list'){
				actionFormObj.attr("action", "list");
				actionFormObj.attr("method", "get");
				
				
				actionFormObj.submit();
				return;
			}

			formObj.submit();
		});
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		var idDuplicateChk = false;
		
		
		$("#idDuplicateChk").on("click", function(){
			
			//id="userId" value값을 가지고 온다.
			let userid = $("#userId").val();
			//가져온 value값을 REST API를 이용하여 아이디 중복체크를 한다.
			// /admin/member/idValue 으로 중복되지 않으면 success 그렇지 않으면 없지뭐?
			//중복체크를 했는지여부를 변수또는 input에 저장한다.
			
			if(userid == ''){
				alert("아이디를 입력하세요");
				return;
			}
			
			$.ajax({
				url : "/admin/member/"+userid,
				type : "post",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function (result){
					if(result == 'success'){
						alert("이미 있는 아이디입니다.");
						$("#userId").select();
					} else {
						if(confirm("사용가능한 아이디입니다.\n사용하실려면 확인을 눌러주세요.")){
							$("#userId").attr("readonly", "readonly");
							idDuplicateChk = true;
						} else {
							$("#userId").select();
						}
					}
				}
			});
			
			
		});
		
		$("#userpw2").on("blur", function(){
			
			passwdChk();
		});

		function passwdChk(){
			let pw1 = $("#userpw1").val();
			let pw2 = $("#userpw2").val();
			//비밀번호의 입력여부체크
			if(pw1 == '' || pw2 == ''){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			//비밀번호랑 비밀번호 확인이랑 값이 일치하는 지 체크
			if(pw1 != pw2){
				alert("비밀번호값이 일치하지 않습니다.");
				return false;
			}
			
			return true;
		}
		
		$(".fa-camera").on("click", function(){
			$("#pfImg").click();
		});
		
	});
</script>            
<script>
  function setThumbnail(event) {
    var reader = new FileReader();
	document.querySelector("div#image_container").innerHTML = '';

    reader.onload = function(event) {
      var img = document.createElement("img");
      img.setAttribute("src", event.target.result);
      img.setAttribute("width", 300);
      document.querySelector("div#image_container").appendChild(img);
    };

    reader.readAsDataURL(event.target.files[0]);
  }
</script>

<%@ include file="../includes/footer.jsp" %>
