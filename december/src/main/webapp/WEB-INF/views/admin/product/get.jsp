<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>납품업체관리</h5>
				<span>납품업체관리 상세보기 및 수정페이지입니다.</span>
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
			   <form id="form" role="form" action="get" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="oriProductImg" value="${product.productImg}">
				
				<div class="form-inline">
	               	<div class="form-group">
	                	<label>물품코드</label>
	                	<input type="text" value="${product.productCode}" name="productCode" id="productCode" maxlength="3" class="form-control" readonly="readonly">
	               	</div>
	               	<div class="form-group">
	                	<label>물품이름</label>
	                	<input type="text" value="${product.productName}" name="productName" id="productName" class="form-control" required="required">
	               	</div>
               		<div class="form-group">
	                	<label>제조업체</label>
	                	<input type="text" value="${product.manufacturer}"  name="manufacturer" id="manufacturer" class="form-control">
	               	</div>
               	</div>
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>규격</label>
	                	<input type="text" value="${product.spec}"name="spec" id="spec" class="form-control">
	               	</div>
	               	<div class="form-group">
	                	<label>단가</label>
	                	<input type="text" value="${product.unitPrice}" name="unitPrice" id="unitPrice" class="form-control">
	               	</div>
               	</div>
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>제품이미지</label>
	                	<div id="image_container">
                       		<c:if test="${product.productImg != null and product.productImg  ne ''}">
                       		<img src="/display?fileName=${fn:replace(product.productImg, '\\', '/')}" alt="직인" style="max-width:100px;">
                       		</c:if>
                       	</div>
                        <i class="fa fa-camera" style="font-size:1.7em;"></i>
                       	<input type="file" style="display:none;" accept="image/*" name="pImg" id="productImg" class="form-control" onchange="setThumbnail(event);">
	               	</div>
               	</div>
               	<button id="modify" type="button" class="btn btn-default btn-sm">수정</button>
	            <button id="remove" type="button" class="btn btn-danger btn-sm">삭제</button>
               	<button id="list" type="button" class="btn btn-primary btn-sm">목록</button>
               </form>
           </div>
		</div>
	</div>

</div>
             
            
<form id="actionForm">
</form>

<script>
$(document).ready(function(){

	$(".fa-camera").on("click", function(){
		$("#productImg").click();
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

<script>
$(document).ready(function(){
	
	var formObj = $("#form");
	var actionFormObj = $("#actionForm");
	 
	$("#modify").on("click", function(e){
		e.preventDefault();
			
		submitChk = true;
	
		formObj.submit();
	});
	
	 
	$("#remove").on("click", function(e){
		e.preventDefault();
			
		if(confirm("정말로 삭제하시겠습니까?")){
			formObj.attr("action", "remove");	
			submitChk = true;
			formObj.submit();
		}
		
	});

	$("#list").on("click", function(e){
		
		submitChk = true;
		
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
		
	});
});


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






<%@ include file="../includes/footer.jsp"%>
