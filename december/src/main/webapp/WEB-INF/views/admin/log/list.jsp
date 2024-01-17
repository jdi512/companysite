<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>메이저 정보 관리</h5>
				<span>금융정보 생성</span>
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

							<button id="regBtn" type="button"
								class="btn btn-primary btn-xs pull-right">Register New
								Log</button>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<table width="100%"
								class="table table-striped table-bordered table-hover"
								id="dataTables-example">
								<thead>
									<tr>
										<th>선택</th>
										<th>#번호</th>
										<th>업무일지</th>
										<th>작성자</th>
										<th>수정일</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${list}" var="log">
										<c:set var="total" value="${total -1}" />
										<c:set var="ix" value="${ix +1}" />
										<!-- //popover -->
										<tr class="even">
											<td><input type="checkbox" class="selBox"
												value="${log.bno }"></td>
											<td>${total}</td>
											<td><a class="move" href="${log.bno }"><fmt:formatDate
														value="${log.title}" pattern="yyyy-MM-dd" /></a></td>
											<td>${log.writer }</td>
											<td class="center"><fmt:formatDate
													value="${log.updateDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
							<div class="row">
								<div class="col-md-1">
									<button id="selDel" class="btn btn-xs btn-danger">선택삭제</button>
								</div>
								<div class="col-md-9 text-right">
									<form id="searchForm" class="form-inline">
										<select name="type" class="form-control">
											<option value=""
												<c:if test="${pageMaker.cri.type == null}">selected</c:if>>선택</option>
											<option value="T" ${pageMaker.cri.type eq 'T'?'selected':'' }>제목</option>
											<option value="C" ${pageMaker.cri.type eq 'C'?'selected':'' }>내용</option>
											<option value="W" ${pageMaker.cri.type eq 'W'?'selected':'' }>작성자</option>
											<option value="TC"
												${pageMaker.cri.type eq 'TC'?'selected':'' }>제목 or
												내용</option>
											<option value="TW"
												${pageMaker.cri.type eq 'TW'?'selected':'' }>제목 or
												작성자</option>
											<option value="TWC"
												${pageMaker.cri.type eq 'TWC'?'selected':'' }>제목 or
												내용 or 작성자</option>
										</select> <input type="text" name="keyword" class="form-control"
											value="${pageMaker.cri.keyword}"> <input
											type="hidden" name="pageNum"
											value="${pageMaker.cri.pageNum }"> <input
											type="hidden" name="amount" value="${pageMaker.cri.amount }">
										<button class="btn btn-default">Search</button>

									</form>
								</div>
							</div>
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

	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>


<script>
	$(document)
			.ready(
					function() {
						var result = '<c:out value="${result}"/>';

						checkModal(result);

						//뒤로가기 문제해결
						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result === '') {
								return;
							}

							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}

							$("#myModal").modal("show");
						}

						$("#regBtn").on("click", function() {
							location.href = "/admin/log/register";
						});

						var actionForm = $("#actionForm");

						//페이징 번호 링크
						$(".page-item a").on(
								"click",
								function(e) {

									e.preventDefault();
									//1. actionForm에  bno삭제
									$("input[name='bno']").remove();
									//2.  get 대신에 list <== <form action 값수정
									actionForm.attr("action", "list");

									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));

									actionForm.submit();
								});

						//게시글 제목 링크
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											//삭제
											$("input[name='bno']").remove();
											//등록
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action", "get");
											actionForm.submit();
										});

						//체크박스

						$("#selDel")
								.on(
										"click",
										function() {

											if ($(".selBox:checked").length == 0) {
												alert("게시글을 먼저 선택하세요.");
												return;
											}

											if (confirm("정말로 삭제하시겠습니까?")) {
												$(".selBox")
														.each(
																function(idx) {
																	if ($(this)
																			.is(
																					":checked") == true) {
																		actionForm
																				.append("<input type='hidden' name='bno' value='"
																						+ $(
																								this)
																								.val()
																						+ "'>");
																	}
																});

												actionForm
														.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');

												actionForm.attr("method",
														"post");
												actionForm.attr("action",
														"list");
												actionForm.submit();
											}
										});//$("#selDel").on("click", function(){

						var searchForm = $("#searchForm");

						$("#searchForm button").on(
								"click",
								function(e) {

									e.preventDefault();

									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색종류를 선택하세요");
										return;
									}

									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요");
										return;
									}

									searchForm.find("input[name='pageNum']")
											.val("1");

									//console.log("검색" + (searchForm.find("option:selected").val() == ''));
									searchForm.submit();
								});

					}); //$(document).ready(function(){
</script>

<%@ include file="../includes/footer.jsp"%>