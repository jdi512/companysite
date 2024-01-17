<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>




<!-- /.row -->
<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>직원 정보</h5>
				<span>직원 정보를 보여주는 페이지</span>
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
					<div class="panel panel-default">
						<div class="panel-heading">
							정규직원
							<button id="regBtn" type="button"
								class="btn btn-primary btn-xs pull-right">직원등록</button>
							<div class="card-body">
								<form id="searchForm" class="form-inline">
									<input type="hidden" name="pageNum"
										value="${pageMaker.cri.pageNum }"> <input
										type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<div class="form-group">
										<label>직원이름</label> <input name="keyUserName"
											class="form-control" value="${pageMaker.cri.keyUserName }">
									</div>
									<div class="form-group">
										<label>부서</label> <input name="keyDepartment"
											class="form-control" value="${pageMaker.cri.keyDepartment }">
									</div>
									<div class="form-group">
										<label>권한</label> <select name="keyAuth" class="form-control">
											<option value="">선택</option>
											<option value="ROLE_ADMIN"
												<c:if test="${pageMaker.cri.keyAuth eq 'ROLE_ADMIN' }">selected="selected"</c:if>>관리자</option>
											<option value="ROLE_MEMBER"
												<c:if test="${pageMaker.cri.keyAuth eq 'ROLE_MEMBER' }">selected="selected"</c:if>>운영자</option>
											<option value="ROLE_USER"
												<c:if test="${pageMaker.cri.keyAuth eq 'ROLE_USER' }">selected="selected"</c:if>>사용자</option>
										</select>
									</div>
									
									
									<button class="btn btn-primary">검색</button>
								</form>
							</div>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<table width="100%"
								class="table table-striped table-bordered table-hover"
								id="dataTables-example">
								<thead>
									<tr>
										<th>#</th>
										<th>성명</th>
										<th>직책</th>
										<th>아이디</th>
										<th>부서명</th>
										<th>등록일자</th>
										<th>권한</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${list}" var="member">
										<c:set var="total" value="${total -1}" />
										<tr class="even">
											<td>${total}</td>
											<td>${member.userName }</td>
											<td>${member.position }</td>
											<td><a class="move" href="${member.userid }">${member.userid }</a></td>
											<td>${member.department }</td>
											<td class="center"><fmt:formatDate
													value="${member.regDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td><c:forEach items="${member.authList}" var="auths">
                                        ${auths.auth }
                                        </c:forEach></td>
											<td><i class="fa fa-pencil"></i> <i
												class="fa fa-trash-o"></i></td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
							<!-- /.table-responsive -->

							<div class="pull-right">
								<nav aria-label="Page navigation example">
									<ul class="pagination">

										<c:if test="${pageMaker.prev }">
											<li class="page-item"><a class="page-link"
												href="${pageMaker.startPage -1 }">Previous</a></li>
										</c:if>
										<c:forEach var="num" begin="${pageMaker.startPage }"
											end="${pageMaker.endPage }" step="1">

											<c:choose>
												<c:when test="${num ne pageMaker.cri.pageNum }">
													<li class="page-item"><a class="page-link"
														href="${num}">${num}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item active" aria-current="page"><span
														class="page-link">${num}</span></li>
												</c:otherwise>
											</c:choose>

										</c:forEach>
										<c:if test="${pageMaker.next }">
											<li class="page-item"><a class="page-link"
												href="${pageMaker.endPage +1 }">Next</a></li>
										</c:if>
									</ul>
								</nav>
							</div>




							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Modal title</h4>
										</div>
										<div class="modal-body">처리가 완료되었습니다.</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Save
												changes</button>
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
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</div>
	</div>
</div>

<form id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">

	<input type="hidden" name="keyUserName" value="${pageMaker.cri.keyUserName }"> 
	<input type="hidden" name="keyDepartment" value="${pageMaker.cri.keyDepartment }">
	<input type="hidden" name="keyAuth" value="${pageMaker.cri.keyAuth }">
</form>



<script>
	$(document)
			.ready(
					function() {

						var actionForm = $("#actionForm");

						//회원 아이디 링크
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											//삭제
											$("input[name='userid']").remove();
											//등록
											actionForm.append("<input type='hidden' name='userid' value='"
															+ $(this).attr("href")+ "'>");
											actionForm.attr("action", "modify");
											actionForm.submit();
										});

						//페이징 번호 링크
						$(".page-item a").on(
								"click",
								function(e) {

									e.preventDefault();
									//1. actionForm에  bno삭제
									$("input[name='userid']").remove();
									//2.  get 대신에 list <== <form action 값수정
									actionForm.attr("action", "list");

									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));

									actionForm.submit();
								});

						$("#regBtn").on("click", function() {
							location.href = "/admin/member/register";
						});

						var searchForm = $("#searchForm");

						$("#searchForm button").on("click", function(e) {

							e.preventDefault();

							searchForm.find("input[name='pageNum']").val("1");

							searchForm.submit();
						});

					});
</script>


<%@ include file="../includes/footer.jsp"%>