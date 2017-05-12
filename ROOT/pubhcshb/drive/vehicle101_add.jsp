<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 車輛管理 - 新增
Programming File: vehicle101_add.jsp
Copyright © SYSTEX B17E By Peilun 2012-05-06
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String mlanguage = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );

  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }


%>  

<script>
  function back()
  {
     document.mform.action="vehicle101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
</script>
<style type="text/css">
<!--
label.error { color: red; font-size: 0.8em;}
input:focus { border: 1px dotted black; }
input.error { border: 1px dotted red; }
-->
</style>
<script type="text/javascript" src="../../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../../js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#mform").validate({
		rules: {
			punit: {
				required: true
			},
			factory: {
				maxlength: 50
			},
			model: {
				maxlength: 50
			},
			licenseplate: {
				required: true,
				maxlength: 10
			},
			exhaust: {
				number: true,
				maxlength: 30
			},
			carcolor: {
				maxlength: 50
			},
			ride: {
				required:true,
				number: true,
				maxlength: 2
			},
			caryear: {
				number: true,
				maxlength: 4
			},
			notes: {
				maxlength: 100
			}
		},
		messages: {
			punit: {
				required: "請選擇發佈單位"
			},
			factory: {
				maxlength: "廠牌欄位長度，不可超過50字"
			},
			model: {
				maxlength: "型號欄位長度，不可超過50字"
			},
			licenseplate: {
				required: "請輸入車號",
				maxlength: "車號欄位長度，不可超過10字"
			},
			exhaust: {
				number: "請輸入數字",
				maxlength: "排氣量欄位長度，不可超過5字"
			},
			carcolor: {
				maxlength: "顏色欄位長度，不可超過50位數"
			},
			ride: {
				required: "請輸入乘坐人數",
				number: "請輸入數字",
				maxlength: "乘坐人數欄位長度，不可超過2位數"
			},
			caryear: {
				number: "請輸入數字",
				maxlength: "乘坐人數欄位長度，不可超過4位數"
			},
			notes: {
				maxlength: "備註欄位長度，不可超過100字"
			}
		},
		errorPlacement: function(error, element) {
		       error.appendTo( element.parent());
		}
	});
});
</script>

<body>
<form id="mform" name="mform" method="post" action="vehicle101_addsave.jsp">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p>
 <input type="submit" class="button_add" value="<%=lang.getSave() %>"/>
 <input type="button" class="button_cancel" value="<%=lang.getCancel()%>" onclick="javascript:window.document.mform.reset()"/>
 <input type="button" class="button_default" value="<%=lang.getBack() %>" onclick="javascript:back()"/>
</p>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr>
    <td class="T12b">廠牌</td>
    <td colspan="3">
      <input id="factory" name="factory" type="text" class="lInput01" size="30" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">型號</td>
    <td colspan="3">
      <input id="model" name="model" type="text" class="lInput01" size="30" />
    </td>
  </tr>  
  <tr>
    <td class="T12b"><span class="T12red">※</span>車號</td>
    <td colspan="3">
      <input id="licenseplate" name="licenseplate" type="text" class="lInput01" size="30" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">排氣量</td>
    <td colspan="3">
      <input id="exhaust" name="exhaust" type="text" class="lInput01" size="10" />
      &nbsp;&nbsp;<span class="T10">cc</span>
    </td>
  </tr> 
  <tr>
    <td class="T12b">顏色</td>
    <td colspan="3">
      <input id="carcolor" name="carcolor" type="text" class="lInput01" size="30" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>乘坐人數</td>
    <td colspan="3">
      <input id="ride" name="ride" type="text" class="lInput01" size="10" />
      &nbsp;&nbsp;<span class="T10">人</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">車輛年份</td>
    <td colspan="3">
      <input id="caryear" name="caryear" type="text" class="lInput01" size="15" />
      &nbsp;&nbsp;<span class="T10">年 (如：1999)</span>
    </td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">備註</td>
    <td colspan="3">
      <textarea id="note" name="note" cols="65" rows="6"></textarea>
    </td>
  </tr>

  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p>
<input type="button" class="button_default" value="回頁首" onclick="location.href='#top'"/>
</p>

</form>
</body>
</html>


