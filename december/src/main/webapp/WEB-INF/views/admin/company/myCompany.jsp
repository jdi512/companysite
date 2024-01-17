<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
				<h5>회사정보</h5>
				<span>회사기본정보화면입니다.</span>
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
			   <form id="form" role="form" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="oriCompanySeal" value="${company.companySeal }">
				
				<div class="form-inline">
	               	<div class="form-group">
	                	<label>사업자등록번호</label>
	                	<input type="text" name="taxId" id="taxId" class="form-control" value="${company.taxId}">
	               	</div>
	               	<div class="form-group">
	                	<label>상호(법인명)</label>
	                	<input type="text" name="companyName" id="companyName" class="form-control" readonly="readonly" value="${company.companyName}">
	               	</div>
	               	<div class="form-group">
	                	<label>성명</label>
	                	<input type="text" name="ceoName" id="ceoName" class="form-control" required="required" value="${company.ceoName}">
               		</div>
               	</div>
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>사업장주소</label>
	                	<div class="input-group">
							<input type="text" name="address" id="address" class="form-control" value="${company.address}">
							<div class="input-group-append">
								<button class="btn btn-secondary" type="button" onclick="sample3_execDaumPostcode()">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
	               	</div>
               	</div>               	
               	
               	<div class="form-group">
	               	<div id="wrap" style="display:none;border:1px solid;width:100%;height:300px;margin:5px 0;position:relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
               	</div>
               	
               	
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>전화번호</label>
	                	<input type="text" name="tel" id="tel" class="form-control" required="required" value="${company.tel}">
	               	</div>
               	</div>
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>업태</label>
	                	<select name="bizType" id="bizType" class="form-control">
	                	<option value="">선택</option>
	                	<c:forEach items="${bizTypes }" var="bizType">
	                	<option value="${bizType.subCode }" 
	                	${bizType.subCode == company.bizType?"selected":"" }>${bizType.middleName } > ${bizType.subName }</option>
	                	</c:forEach>
	                	</select>
	               	</div>
	               	<div class="form-group">
	                	<label>종목</label>
	                	<select name="bizItem" id="bizItem" class="form-control">
	                	</select>
	               	</div>
               	</div>
               	<div class="form-inline">
	               	<div class="form-group">
	                	<label>직인</label>
	                	<div id="image_container">
                       		<c:if test="${company.companySeal != null and company.companySeal ne ''}">
                       		<img src="/display?fileName=${fn:replace(company.companySeal, '\\', '/')}" alt="직인" style="max-width:100px;">
                       		</c:if>
                       	</div>
                        <i class="fa fa-camera" style="font-size:1.7em;"></i>
                       	<input type="file" style="display:none;" accept="image/*" name="compSeal" id="companySeal" class="form-control" onchange="setThumbnail(event);">
	               	</div>
               	</div>
               	<button id="modify" type="button" class="btn btn-default btn-sm">수정</button>
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
	
	var bizType = $("#bizType option:selected").val();
	
	$("#bizType").on("change", function(){

		let bizType = $("#bizType option:selected").val();
		
		bizTypeSelect(bizType);
	});
	
	function bizTypeSelect(bizType){
		$.ajax({
			type:'get',
			url:'/admin/master/codes/' + bizType + '.json',
			success:function(data){
				let html = '';
				
				for(let i = 0; i < data.length; i++){
					//company에 있는 bizItem값이랑 ajax에서 불러온 detailedCode값이랑 같으면.
					if(data[i].detailedCode == '${company.bizItem}'){
						html += '<option value="' + data[i].detailedCode + '" selected>' + data[i].detailedName + '</option>';
					} else {
						html += '<option value="' + data[i].detailedCode + '">' + data[i].detailedName + '</option>';
					}
				}
				$("#bizItem").html(html);
			}
		});
	}
	
	bizTypeSelect(bizType);
	
	

	$(".fa-camera").on("click", function(){
		$("#companySeal").click();
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



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample3_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample3_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample3_postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>


<%@ include file="../includes/footer.jsp"%>
