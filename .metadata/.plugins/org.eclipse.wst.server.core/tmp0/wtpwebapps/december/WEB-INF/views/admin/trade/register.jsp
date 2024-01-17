<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>거래명세서 등록</h5>
				<span>거래명세서를 등록합니다.</span>
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
			   <form id="form" role="form" action="/admin/trade/register" method="post">
               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
               <input type="hidden" name="producter" value="${company.companyName}">
               	<div class="form-group">
                	<label>공급받는자</label>
                	<input type="text" name="supplyer" maxlength="100" id="supplyer" class="form-control" required="required">
               		<div id="suggestions"></div>
               	</div>
               
             
               	<div>
               	<table class="table table-striped  table-hover table-bordered">
               	<thead>
               	<tr>
               	<th>년/월/일</th>
               	<th>품목</th>
               	<th>규격</th>
               	<th>수량</th>
               	<th>단가</th>
               	<th>구분</th>
               	<th>금액</th>
               	<th>부가세</th>
               	<th>비고</th>
               	</tr>
               	</thead>
               	<tbody>
               	<c:forEach begin = "0" end = "4" var="i">
	               	<tr>
       					<td><input type="date" name="tradeDetailList[${i}].tradeDate" class="form-control tradeDate"></td>
           				<td>
	           				<input type="text" class="form-control productName" name="tradeDetailList[${i}].productName" data-sid="suggestions${i }">
	           				<div id="suggestions${i }"></div>
	           				<input type="hidden" name="tradeDetailList[${i}].productCode">
           				</td>
           				<td><input type="text" name="tradeDetailList[${i}].spec" class="form-control" readonly="readonly"></td>
           				<td><input type="number" data-taxrate="0.1" name="tradeDetailList[${i}].qty" class="form-control qty"></td>
           				<td><input type="text" name="tradeDetailList[${i}].unitPrice" class="form-control" readonly="readonly"></td>
           				<td><input type="text" name="tradeDetailList[${i}].assortment" class="form-control"></td>
           				<td><input type="text" name="price" class="form-control" readonly="readonly"></td>
           				<td><input type="text" name="tax" class="form-control" readonly="readonly"></td>
           				<td><input type="text" name="tradeDetailList[${i}].remarks" class="form-control"></td>
	               	</tr>
               	</c:forEach>
               	</tbody>
               	</table>
               	</div>
               	  	<div class="form-inline">
	               	<div class="form-group">
                	<label>합계금액</label>
                	<input type="text" name="subAmount" maxlength="200" id="subAmount" class="form-control" readonly="readonly">
                	</div>
                	
                	<div class="form-group">
                	<label>VAT</label>
                	<input type="text" name="totalTax" maxlength="200" id="totalTax" class="form-control" readonly="readonly">
                	</div>
                	
                	<div class="form-group">
                	<label>최종금액</label>
                	<input type="text" name="finalAmount" maxlength="200" id="finalAmount" class="form-control" readonly="readonly">
               		</div>
               	</div>
               	<div class="form-group">
                	<label>영수청구여부</label>
                	<div>
	                	<label><input type="radio" name="receipt" id="receipt" checked="checked">영수</label>
	                	<label><input type="radio" name="receipt" id="claim">청구</label>
                	</div>
               	</div>
               	<button type="submit" class="btn btn-primary btn-sm">거래명세서 등록</button>
               	<button type="reset" class="btn btn-default btn-sm">다시작성</button>
               </form>
           </div>
		</div>
	</div>

</div>
     
<script>
submitChk = false;

$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	

	/*  */
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		if(!isCompanyNameChg){
			 alert('공급받는자를 선택하세요');
			return;
		}
		if(!isProductNameChg){
			 alert('물품을 선택하세요');
			return;
		}
		submitChk = true;
	
		formObj.submit();
	});

	var isCompanyNameChg = false;
	var isProductNameChg = false;
	
	$("#supplyer").on("keyup change", function(){
		if($(this).val().length > 1){
			$.ajax({
				url : "/admin/trade/company/" + $(this).val() + ".json",
				type : "get",
				success : function (result){
					let html = "";
					for(let i = 0; i< result.length; i++){
						html += "<div data-ceo='"+result[i].ceoName+"' data-tel='"+result[i].tel+"' data-id='"+result[i].taxId+"' data-address='"+result[i].address+"' class='container company'>";
						html += result[i].companyName;
						html += "</div>";
					}
					
					$("#suggestions").html(html);
					isCompanyNameChg = false;
				}
			});
		}
	});
	$("#suggestions").on("click", ".company", function(){
		
		$("#supplyer").val($(this).text());
		
		$("#suggestions").html("");
		isCompanyNameChg = true;
	});
	let sid = '';
	$(".productName").on("keyup change", function(){
		sid = $(this).data('sid');
		if($(this).val().length > 1){
			$.ajax({
				url : "/admin/trade/product/" + $(this).val() + ".json",
				type : "get",
				success : function (result){
					let html = "";
					for(let i = 0; i< result.length; i++){
						html += "<div data-code='"+result[i].productCode+"' data-spec='"+result[i].spec+"' data-price='"+result[i].unitPrice+"' class='container product' >";
						html += result[i].productName;
						html += "</div>";
					}
					$("#"+sid).html(html);
					isProductNameChg = false;
				}
			});
		}
	});


	$("table").on("click", ".product", function(){
		
		$(this).parent().prev().val($(this).text());
		$(this).parent().parent().next().children("input").val($(this).data('spec'));
		$(this).parent().parent().next().next().next().children("input").val($(this).data('price'));
		$(this).parent().next().val($(this).data('code'));
		$("#"+sid).html("");
		isProductNameChg = true;
	});
	
	$(".qty").on("keyup change", function(){
		let qty = $(this).val();
		let unitPrice = $(this).parent().next().children("input").val();
		let taxrate = $(this).data('taxrate');
		$(this).parent().next().next().next().children("input").val(qty * unitPrice);
		$(this).parent().next().next().next().next().children("input").val(qty * unitPrice * taxrate);
		subPrice();
	});

});

function subPrice(){
	let price = $("input[name='price']"); //금액
	let tax = $("input[name='tax']"); //부가세
	
	let totalprice = 0;
	let totaltax = 0;

	for(let i = 0; i<price.length; i++){
		totalprice += Number(price[i].value);
		totaltax += Number(tax[i].value);
	}
	let finalamount = totalprice + totaltax ; //부가세 포함 금액 구하기
	

	$("#subAmount").val(totalprice);
	$("#totalTax").val(totaltax);
	$("#finalAmount").val(finalamount);
}

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
