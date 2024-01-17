<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>세금 계산서</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">

.bout {
  font-family:굴림,바탕;
  border: 3px double blue;
}
body, table, tr, td, select{font-family:굴림, verdana, arial; font-size: 12px;color: #000000; border:1px;}
.ttxt {font-family:굴림, verdana, arial; font-size: 12px;color: #0000FF;}
.cborder {border-top-width:1; border-right-width:1; border-bottom-width:1; border-left-width:1; border-color:BLUE; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:solid;}
.ctit {font-size: 22px;color: #0000FF; font-weight:bold;}
.ccmt {font-size: 12px;color: #0000FF;}
.taxidno {font-size: 16px;color: black; font-weight:bold;}

.bout2 {font-family:굴림,바탕;border: 3px double red;}
.ttxt2{font-family:굴림, verdana, arial; font-size: 12px;color: red;}
.cborder2 {border-top-width:1; border-right-width:1; border-bottom-width:1; border-left-width:1; border-color:red; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:solid;}
.ctit2 {font-size: 22px;color:red; font-weight:bold;}
.ccmt2 {font-size: 12px;color:red;}

#command_bar {
  font-size: 10pt;
  background-color: #FEFFD2;
  border: 1px solid #AF9E29;
  padding: 5px;
  margin-bottom: 10px;
}
.sign_area {
  position: relative;
}
.sign_img {
  position: absolute;
  top: 15px;
  left: 230px;
}
</style>
<script type="text/javascript">
window.resizeTo (700, 570);
window.focus();

function printNow() {
  document.getElementById('command_bar').style.display = 'none';
  window.print();
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="command_bar">
  A4용지를 준비하고 인쇄버튼을 클릭하세요. &nbsp; <input type="button" value="인쇄하기" onclick="printNow()" /> <input type="button" value="뒤로" onclick="window.history.go(-1)" />
</div>





<table width="586" border="0" cellspacing="0" cellpadding="0" align="center">
<c:forEach begin="0" end="1" var="idx">

  <tr>
    <td height="10">
      <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="10" class="ttxt${idx == 0?'':'2' }">[별지 제11호 서식]</td>
          <td align="right" class="ttxt${idx == 0?'':'2' }">[${idx == 0?'청색':'적색' }]</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="586">
      <table width="100%" cellpadding="0" cellspacing="0" class="bout${idx == 0?'':'2' }">
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
			  	<td width="20" height="44"></td>
                <td width="359" align="center"><span class="ctit${idx == 0?'':'2' }">세 금 계 산 서</span> <span class="ccmt${idx == 0?'':'2' }">(공급${idx == 0?'받는':'' }자 보관용)</span></td>
                <td width="201"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="25%" class="cborder${idx == 0?'':'2' }" align="center" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">책 번 호</span></td>
                      <td width="33%" align="right" class="cborder${idx == 0?'':'2' }" style="border-top-style:none">1 <span class="ttxt${idx == 0?'':'2' }">권</span> &nbsp;</td>
                      <td width="42%" align="right" class="cborder${idx == 0?'':'2' }" style="border-top-style:none">1 <span class="ttxt${idx == 0?'':'2' }">호</span> &nbsp;</td>
                    </tr>
                    <tr>
                      <td class="cborder${idx == 0?'':'2' }" align="center" style="border-top-style:none;border-bottom-style:none"><span class="ttxt${idx == 0?'':'2' }">일련번호</span></td>
                      <td colspan="2" align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none">${trade.tno }</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" class="cborder${idx == 0?'':'2' }" style="border-left-style:none" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center" class="cborder${idx == 0?'':'2' }" style="border-left-style:none"><span class="ttxt${idx == 0?'':'2' }" style="line-height:35px">공<br>
                        급<br>
                        자</span></td>
                      <td><div class="sign_area"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr height="35"> 
                            <td width="20%" align="center" class="cborder${idx == 0?'':'2' }"><span class="ttxt${idx == 0?'':'2' }">등록번호</span></td>
                            <td width="80%" class="cborder${idx == 0?'':'2' }" align="center"><span class="taxidno">${producter.taxId }</span></td>
                          </tr>
                          <tr height="35"> 
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">상 호<br>
                              (법인명)</span> </td>
                            <td><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${producter.companyName }</td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center" width="15"><span class="ttxt${idx == 0?'':'2' }">성<br>
                                    명</span></td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center" width="100">${producter.ceoName }&nbsp;<span class="ttxt${idx == 0?'':'2' }">(인)
								  <div style="position:relative;">
	                                  <div style="position:absolute;width:50px;height:50px;top:-2em;left:3em">
	                                  	<img src="/display?fileName=${fn:replace(producter.companySeal, '\\', '/')}" style="width:100%;">
	                                  </div>
                                  </div>
								  </td>
                                </tr>
                              </table></td>
                          </tr>
                          <tr height="35"> 
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">사업장<br>
                              주 소</span></td>
                            <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${producter.address }</td>
                          </tr>
                          <tr height="35"> 
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">업 태</span></td>
                            <td><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none; font-size:${fn:length(producter.bizType) gt 5 ? '0.7em':'1em'};" align="center">${producter.bizType }</td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" width="15" align="center"><span class="ttxt${idx == 0?'':'2' }">종<br>목</span></td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none; font-size:${fn:length(producter.bizItem) gt 5 ? '0.7em':'1em'};" align="center">${producter.bizItem }</td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></div></td>
                    </tr>
                  </table></td>
                <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center" class="cborder${idx == 0?'':'2' }" ><span class="ttxt${idx == 0?'':'2' }" style="line-height:20px">공<br>
                        급<br>
                        받<br>
                        는<br>
                        자</span></td>
                      <td><div class="sign_area"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr height="35"> 
                            <td width="20%" align="center" class="cborder${idx == 0?'':'2' }"><span class="ttxt${idx == 0?'':'2' }">등록번호</span></td>
                            <td width="80%" class="cborder${idx == 0?'':'2' }" align="center"><span class="taxidno">${supplyer.taxId }</span></td>
                          </tr>
                          <tr height="35"> 
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">상 호<br>
                              (법인명)</span> </td>
                            <td><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${supplyer.companyName }</td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center" width="15"><span class="ttxt${idx == 0?'':'2' }">성<br>
                                    명</span></td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center" width="100">${supplyer.ceoName }&nbsp;<span class="ttxt${idx == 0?'':'2' }">(인)
								  <div style="position:relative;">
	                                  <div style="position:absolute;width:50px;height:50px;top:-2em;left:3em">
	                                  	<img src="/display?fileName=${fn:replace(supplyer.companySeal, '\\', '/')}" style="width:100%;">
	                                  </div>
                                  </div>
								  </td>
                                </tr>
                              </table></td>
                          </tr>
                          <tr height="35">  
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">사업장<br>
                              주 소</span></td>
                            <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${supplyer.address }</td>
                          </tr>
                          <tr height="35"> 
                            <td align="center" class="cborder${idx == 0?'':'2' }" style="border-top-style:none"><span class="ttxt${idx == 0?'':'2' }">업 태</span></td>
                            <td><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none; font-size:${fn:length(supplyer.bizType) gt 5 ? '0.7em':'1em'};" align="center">${supplyer.bizType }</td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" width="15" align="center"><span class="ttxt${idx == 0?'':'2' }">종<br>목</span></td>
                                  <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none; font-size:${fn:length(supplyer.bizItem) gt 5 ? '0.7em':'1em'};" align="center">${supplyer.bizItem }</td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></div></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none">
              <tr height="20"> 
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">작 성</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">공 &nbsp; &nbsp; 급 
                   &nbsp; &nbsp; 가 &nbsp; &nbsp; 액</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">세 &nbsp; &nbsp; 액</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">비 고</span></td>
              </tr>
              <tr> 
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr height="20"> 
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">년</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">월</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">일</span></td>
                    </tr>
                    <tr height="24"> 
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><fmt:formatDate value="${trade.regdate }" pattern="yy"/></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><fmt:formatDate value="${trade.regdate }" pattern="MM"/></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><fmt:formatDate value="${trade.regdate }" pattern="dd"/></td>
                    </tr>
                  </table></td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr height="20"> 
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">백</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">억</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">천</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">백</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">만</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">천</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">백</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">일</span></td>
                    </tr>
                    <tr height="24"> 
                    <c:set value="${trade.subAmount += ''}" var="amount"/>
                    <c:forEach begin="1" end="${11 - fn:length(amount)}">
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">
                      </td>
                    </c:forEach>
                     
                    <c:forEach begin="1" end="${fn:length(amount)}" var="i">
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">
                      	${fn:substring(amount, (i - 1), i)}
                      </td>
                    </c:forEach>						  
                    </tr>
                  </table></td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr height="20"> 
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">억</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">천</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">백</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">만</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">천</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">백</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">십</span></td>
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">일</span></td>
                    </tr>
                    <tr height="24"> 
                    <fmt:parseNumber var="intAmount" integerOnly="true" value="${trade.totalTax}"/>
                      <c:set value="${intAmount += ''}" var="amount"/>
                    <c:forEach begin="1" end="${10 - fn:length(amount)}">
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">
                      </td>
                    </c:forEach>
                     
                    <c:forEach begin="1" end="${fn:length(amount)}" var="i">
                      <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">
                      	${fn:substring(amount, (i - 1), i)}
                      </td>
                    </c:forEach>			
                    </tr>
                  </table></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none">
              <tr height="20"> 
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">월</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">일</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">품 &nbsp; &nbsp; 목</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">규 격</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">수 량</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">단 가</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">공 급 가 액</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">세 액</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">비 고</span></td>
              </tr>
  <c:forEach items="${tradeDetails}" var="tradeDetail">
              <tr height="24"> 
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><fmt:formatDate value="${tradeDetail.tradeDate }" pattern="MM"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><fmt:formatDate value="${tradeDetail.tradeDate }" pattern="dd"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${tradeDetail.productName }</td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${tradeDetail.spec }</td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><fmt:formatNumber value="${tradeDetail.qty }" pattern="#,###"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="right"><fmt:formatNumber value="${tradeDetail.unitPrice }" pattern="#,###"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="right"><fmt:formatNumber value="${tradeDetail.price }" pattern="#,###"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="right"><fmt:formatNumber value="${tradeDetail.tax}" pattern="#,###"/></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center">${tradeDetail.remarks }</td>
              </tr>
  </c:forEach>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="20"> 
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">합 계 금 액</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">현 금</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">수 표</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">어 음</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none" align="center"><span class="ttxt${idx == 0?'':'2' }">외상미수금</span></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none" rowspan="2" align="center"><span class="ttxt${idx == 0?'':'2' }">이 금액을</span> 
                  <b class="ttxt${idx == 0?'':'2' }">${trade.receipt?'영수':'청구'}</b><span class="ttxt${idx == 0?'':'2' }">함</span></td>
              </tr>
              <tr height="24"> 
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-left-style:none;border-bottom-style:none" align="center"><fmt:formatNumber>${trade.finalAmount}</fmt:formatNumber></td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none" align="center">&nbsp;</td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none" align="center">&nbsp;</td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none" align="center">&nbsp;</td>
                <td class="cborder${idx == 0?'':'2' }" style="border-top-style:none;border-bottom-style:none" align="center">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="right">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td class="ccmt${idx == 0?'':'2' }">[직인과 일련번호가 있어야 유효합니다]</td>
  
          <td align="right"></td>
  
        </tr>
      </table>
    </td>
  </tr>



  <tr height="70"> 
    <td><hr size="1"></td>
  </tr>

</c:forEach>
</table>


<p>&nbsp;</p>
</body>
</html>
