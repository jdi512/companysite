<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<link href="/resources/dist/css/file.css" rel="stylesheet">

            <div class="row">
               	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>내 정보</h5>
				<span>내 정보 페이지</span>
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
			<div class="card-body">
				<div class="col-lg-12">
                            <form id="form" role="form" action="modify" method="post">
                            <input type="hidden" name="pageNum" value="${cri.pageNum }">
                            <input type="hidden" name="amount" value="${cri.amount }">
							<input type="hidden" name="keyUserName" value="${cri.keyUserName }">
							<input type="hidden" name="keyDepartment" value="${cri.keyDepartment }">
							<input type="hidden" name="keyAuth" value="${cri.keyAuth}">
							<input type="hidden" name="pfImg" value="${member.pfImg}">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            	<div class="form-group">
							<label>프로필사진</label>
							<div>
								<c:if test="${member.pfImg != null and member.pfImg ne ''}">
									<img
										src="/display?fileName=${fn:replace(member.pfImg, '\\', '/')}"
										alt="프로필사진" style="max-width: 300px;">
								</c:if>
							</div>
						</div>
						<div class="form-group">
							<label>아이디</label> <input type="text" name="userid"
								class="form-control" value="${member.userid }"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>부서명</label> <input type="text" name="department"
								id="department" class="form-control"
								value="${member.department }" placeholder="부서명" readonly="readonly">
						</div>
						<div class="form-group">
							<label>직책</label> <input type="text" name="position"
								id="position" class="form-control" value="${member.position }"
								placeholder="직책" readonly="readonly">
						</div>
						<div class="form-group">
							<label>직원이름</label> <input type="text" name="userName"
								id="userName" class="form-control" value="${member.userName }" readonly="readonly">
						</div>
						<div class="form-group">
							<label>이메일</label> <input type="text" name="email" id="email"
								class="form-control" value="${member.email }" placeholder="이메일" readonly="readonly">
						</div>
						<div class="form-group">
							<label>휴대전화번호</label> <input type="text" name="tel" id="tel"
								class="form-control" value="${member.tel }" placeholder="휴대전화번호" readonly="readonly">
						</div>

						<div class="form-group">
							<label>등록일자</label> <input type="text" name="regDate"
								class="form-control"
								value="<fmt:formatDate value="${member.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>마지막수정일시</label> <input type="text" name="updateDate"
								class="form-control"
								value="<fmt:formatDate value="${member.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>로그인여부</label>
							<div>
								<label><input type="checkbox" name="enabled" value="1"
									<c:if test="${member.enabled}">checked="checked"</c:if>>
									로그인허용</label>
							</div>
						</div>
						<div class="form-group">
							<label>권한</label>
							<div>
								<label><input type="checkbox" name="auth"
									value="ROLE_ADMIN"
									<c:if test="${fn:contains(member.authList, 'ROLE_ADMIN')}">checked="checked"</c:if>>ROLE_ADMIN</label>
								<label><input type="checkbox" name="auth"
									value="ROLE_EMPLOYEE"
									<c:if test="${fn:contains(member.authList, 'ROLE_EMPLOYEE')}">checked="checked"</c:if>>ROLE_EMPLOYEE</label>
							</div>
						</div>

	               
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
		</div>             
            
<form id="actionForm">

</form>

<script>
	$(document).ready(function(){
		var formObj = $("#form");
		var actionFormObj = $("#actionForm");
		
		
		$(".button").on("click", function(e){
			
			e.preventDefault();
						
			var operation = $(this).data("oper");
			if(operation === 'list'){
				actionFormObj.attr("action", "list");
				actionFormObj.attr("method", "get");
								
				actionFormObj.submit();
				return;
			}

			formObj.submit();
		});



		
	});//$(document).ready(function(){
		
</script>            

<%@ include file="../includes/footer.jsp" %>