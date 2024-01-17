<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>거래명세서 조회</h5>
				<span>거래 명세서 조회</span>
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
			   <form id="form" role="form" action="modify" method="post">
	            <input type="hidden" name="pageNum" value="${cri.pageNum }">
	            <input type="hidden" name="amount" value="${cri.amount }">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="hidden" name="tno" value="${trade.tno }">            
           		<div class="form-group">
                	<label>공급자</label>
                	<input type="text" name="producter" maxlength="100" value="${trade.producter}" class="form-control">
               	</div>
               	<!-- 	공급자 -->
               	<table id="productComp" class="table table-striped  table-hover table-bordered">
               	<thead>
               	<tr>
               	<th>상호명</th>
               	<th>사업자등록번호</th>
               	<th>성명</th>
               	<th>전화번호</th>
               	<th>주소</th>
               	</tr>
               	</thead>
               	<tbody>
               	<tr>
             	<td>${producter.companyName}</td>
               	<td>${producter.taxId}</td>
               	<td>${producter.ceoName}</td>
               	<td>${producter.tel}</td>
               	<td>${producter.address}</td>
               	</tr>
               	</tbody>
               	</table>
               	<div class="form-group">
                	<label>공급받는자</label>
                	<input type="text" name="supplyer" maxlength="100" value="${trade.supplyer}" class="form-control">
               	</div>
               <!-- 	피공급자 -->
               	<table id="supplyComp" class="table table-striped  table-hover table-bordered">
               	<thead>
               	<tr>
               	<th>상호명</th>
               	<th>사업자등록번호</th>
               	<th>성명</th>
               	<th>전화번호</th>
               	<th>주소</th>
               	</tr>
               	</thead>
               	<tbody>
               	<tr>
                <td>${supplyer.companyName}</td>
               	<td>${supplyer.taxId}</td>
               	<td>${supplyer.ceoName}</td>
               	<td>${supplyer.tel}</td>
               	<td>${supplyer.address}</td>
               	</tr>
               	</tbody>
               	</table>
     
               	
               	<div>
				<!-- 	거래 -->
               	<table id="deal" class="table table-striped  table-hover table-bordered">
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
               		<c:set value="0" var="i"/>
                  	<c:forEach items="${tradeDetails}" var="tradeDetail">
	               	<tr>
       					<td><input type="date" name="tradeDetailList[${i}].tradeDate" class="form-control tradeDate" value="<fmt:formatDate value='${tradeDetail.tradeDate}' pattern="yyyy-MM-dd"/>" ></td>
           				<td>
	           				<input type="text" class="form-control productName" name="tradeDetailList[${i}].productName" value="${tradeDetail.productName}"  data-sid="suggestions${i }">
	           				<div id="suggestions${i }"></div>
	           				<input type="hidden" name="tradeDetailList[${i}].productCode" value="${tradeDetail.productCode}" >
           				</td>
           				<td><input type="text" name="tradeDetailList[${i}].spec" class="form-control" value="${tradeDetail.productCode}" readonly="readonly"></td>
           				<td><input type="number" name="tradeDetailList[${i}].qty" class="form-control qty" value="${tradeDetail.qty}" ></td>
           				<td><input type="text" name="tradeDetailList[${i}].unitPrice" class="form-control" value="${tradeDetail.unitPrice}" readonly="readonly"></td>
           				<td><input type="text" name="tradeDetailList[${i}].assortment" class="form-control" value="${tradeDetail.assortment}" ></td>
           				<td><input type="text" name="price" class="form-control" readonly="readonly" value="${tradeDetail.price}"></td>
           				<td><input type="text" name="tax" class="form-control" readonly="readonly" value="${tradeDetail.tax}"></td>
           				<td><input type="text" name="tradeDetailList[${i}].remarks" class="form-control" value="${tradeDetail.remarks}"></td>
	               	</tr>
	               	<c:set value="${i+1}" var="i"/>
               
               	</c:forEach>
               	<c:forEach begin="${i}" end="4" var="i">
               	 	<tr>
       					<td><input type="date" name="tradeDetailList[${i}].tradeDate" class="form-control tradeDate" value="" ></td>
           				<td>
	           				<input type="text" class="form-control productName" name="tradeDetailList[${i}].productName" value=""  data-sid="suggestions${i }" >
	           				<div id="suggestions${i }"></div>
	           				<input type="hidden" name="tradeDetailList[${i}].productCode" value="" >
           				</td>
           				<td><input type="text" name="tradeDetailList[${i}].spec" class="form-control" value="" readonly="readonly"></td>
           				<td><input type="number" name="tradeDetailList[${i}].qty" class="form-control qty" value="" ></td>
           				<td><input type="text" name="tradeDetailList[${i}].unitPrice" class="form-control" value="" readonly="readonly"></td>
           				<td><input type="text" name="tradeDetailList[${i}].assortment" class="form-control" value="" ></td>
           				<td><input type="text" name="price" class="form-control" readonly="readonly" value=""></td>
           				<td><input type="text" name="tax" class="form-control" readonly="readonly" value=""></td>
           				<td><input type="text" name="tradeDetailList[${i}].remarks" class="form-control"  value=""></td>
	               	</tr>
               	</c:forEach>
               	</tbody>
               	</table>
               	</div>
				<div class="form-inline">
	               	<div class="form-group">
                	<label>합계금액</label>
                	<input type="text" name="subAmount" maxlength="200" id="subAmount" value="${trade.subAmount}" class="form-control" readonly="readonly">
                	</div>
                	
                	<div class="form-group">
                	<label>VAT</label>
                	<input type="text" name="totalTax" maxlength="200" id="totalTax" value="${trade.totalTax}" class="form-control" readonly="readonly">
                	</div>
                	
                	<div class="form-group">
                	<label>최종금액</label>
                	<input type="text" name="finalAmount" maxlength="200" id="finalAmount" value="${trade.finalAmount}" class="form-control" readonly="readonly">
               		</div>
               	</div>
               	<div class="form-group">
                	<label>영수청구여부</label>
                	<div>
	                	<label><input type="radio" name="receipt" id="receipt" value="1" ${trade.receipt?"checked":"" }>영수</label>
	                	<label><input type="radio" name="receipt" id="claim" value="0" ${trade.receipt?"":"checked" }>청구</label>
                	</div>
               	</div>               	
               	<button type="submit" class="btn btn-default btn-sm">명세서 수정</button>
               	<button type="reset" class="btn btn-default btn-sm">다시 작성</button>
               	<button id="list" type="button" class="btn btn-primary btn-sm">목록</button>
                 	<button type="button" id="btnPrintTrade" class="btn btn-primary btn-sm"><i class="ti-printer"></i>거래명세서출력</button>
               	<button type="button" id="btnPrintTax" class="btn btn-primary btn-sm"><i class="ti-printer"></i>세금계산서출력</button>
               </form>
           </div>
		</div>
	</div>

</div>
             
            
<form id="actionForm">
</form>

<script>
$(document).ready(function(){
	
	var formObj = $("#form");
	var actionFormObj = $("#actionForm");
	 
	$("#list").on("click", function(e){
		
		submitChk = true;
		
		actionFormObj.attr("action", "list");
		actionFormObj.attr("method", "get");
		
		var pageNumTag = $("input[name='pageNum']").clone();//태그복사
		var amountTag = $("input[name='amount']").clone();//태그복사

		
		// 폼안의 요소를 삭제
		actionFormObj.empty();
		actionFormObj.append(pageNumTag);
		actionFormObj.append(amountTag);
		
		actionFormObj.submit();
		
	});
	$("#btnPrintTrade").on("click", function(){
		let tno = $("input[name='tno']").val();
		window.open("tradePopup?tno="+tno,"trade","width=464 height=600");
	});
	$("#btnPrintTax").on("click", function(){
		let tno = $("input[name='tno']").val();
		window.open("taxPopup?tno="+tno,"tax","width=464 height=600");
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
               