<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<link href="/resources/dist/css/file.css" rel="stylesheet">

<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>직원 관리</h5>
				<span>직원 정보 수정페이지</span>
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
					<form id="form" role="form" action="modify" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="pageNum" value="${cri.pageNum }">
						<input type="hidden" name="amount" value="${cri.amount }">
						<input type="hidden" name="keyUserName"
							value="${cri.keyUserName }"> <input type="hidden"
							name="keyDepartment" value="${cri.keyDepartment }"> <input
							type="hidden" name="keyAuth" value="${cri.keyAuth }"> <input
							type="hidden" name="oriPfImg" value="${member.pfImg }"> <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<div class="form-group">
							<label>프로필사진</label>
							<div>
								<c:if test="${member.pfImg != null and member.pfImg ne ''}">
									<img
										src="/display?fileName=${fn:replace(member.pfImg, '\\', '/')}"
										alt="프로필사진" style="max-width: 300px;">
								</c:if>
							</div>
							<i class="fa fa-camera" style="font-size:1.7em;"></i>
                       	<input type="file" style="display:none;" accept="image/*" name="profileImg" id="profileImg" class="form-control" onchange="setThumbnail(event);">
						</div>
						<div class="form-group">
							<label>아이디</label> <input type="text" name="userid"
								class="form-control" value="${member.userid }"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>부서명</label> <input type="text" name="department"
								id="department" class="form-control"
								value="${member.department }" placeholder="부서명">
						</div>
						<div class="form-group">
							<label>직책</label> <input type="text" name="position"
								id="position" class="form-control" value="${member.position }"
								placeholder="직책">
						</div>
						<div class="form-group">
							<label>직원이름</label> <input type="text" name="userName"
								id="userName" class="form-control" value="${member.userName }">
						</div>
						<div class="form-group">
							<label>이메일</label> <input type="text" name="email" id="email"
								class="form-control" value="${member.email }" placeholder="이메일">
						</div>
						<div class="form-group">
							<label>휴대전화번호</label> <input type="text" name="tel" id="tel"
								class="form-control" value="${member.tel }" placeholder="휴대전화번호">
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

						<sec:authorize access="isAuthenticated()">
							<button data-oper="modify" type="button"
								class="btn btn-default button">Modify</button>
							<button data-oper="remove" type="button"
								class="btn btn-danger button">Remove</button>
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

</div>
<form id="actionForm"></form>

<script>
	$(document).ready(
			function() {
				var formObj = $("#form");
				var actionFormObj = $("#actionForm");

				/* 클래스(button)을 클릭했을때 data-oper값으로 이벤트 처리 */
				$(".button").on("click",function(e) {

							e.preventDefault();

							var operation = $(this).data("oper");

							if (operation === 'remove') {
								if (confirm("정말로 삭제하시겠습니까?")) {
									formObj.attr("action", "remove");
								} else {
									return;
								}
							} else if (operation === 'modify') {
								if ($("#department").val() == '') {
									alert("부서명을 입력하세요");
									return;
								}
								if ($("#position").val() == '') {
									alert("직책을 입력하세요");
									return;
								}
								if ($("#userName").val() == '') {
									alert("직원이름을 입력하세요");
									return;
								}
								if ($("#email").val() == '') {
									alert("이메일을 입력하세요");
									return;
								}
								if ($("#tel").val() == '') {
									alert("휴대전화번호를 입력하세요");
									return;
								}
								
							} else if (operation === 'list') {
								actionFormObj.attr("action", "list");
								actionFormObj.attr("method", "get");

								var pageNumTag = $("input[name='pageNum']").clone();//태그복사
								var amountTag = $("input[name='amount']").clone();//태그복사

								var keyUserNameTag = $("input[name='keyUserName']").clone();//태그복사
								var keyDepartmentTag = $("input[name='keyDepartment']").clone();//태그복사
								var keyAuthTag = $("input[name='keyAuth']").clone();//태그복사

								// 폼안의 요소를 삭제
								actionFormObj.empty();
								actionFormObj.append(pageNumTag);
								actionFormObj.append(amountTag);
								actionFormObj.append(keyUserNameTag);
								actionFormObj.append(keyDepartmentTag);
								actionFormObj.append(keyAuthTag);

								actionFormObj.submit();
								return;
							}

							formObj.submit();
							
				});

							$(".fa-camera").on("click", function(){
								$("#profileImg").click();
							});
							
						});//$(document).ready(function(){
							
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


<%@ include file="../includes/footer.jsp"%>