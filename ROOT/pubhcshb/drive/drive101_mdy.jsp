<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 駕駛人員維護 - 新增
Programming File: drive101_add.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-06
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
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );

  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String mlanguage = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );

  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  DriveData query = new DriveData(); 
  boolean rtn = query.loadDriver(serno, table);

%>  

<script> 
  function back() {
     document.mform.action="drive101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function del() {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x) {
        document.mform.action="drive101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
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
			name: {
				required: true,
				maxlength: 50
			},
			tel: {
				required: true,
				maxlength: 20
			},
			mobile: {
				maxlength: 11
			},
			email: {
				required: true,
				email: true,
				maxlength: 30
			},
			address: {
				maxlength: 100
			},
			notes: {
				maxlength: 100
			}
		},
		messages: {
			punit: {
				required: "請選擇發佈單位"
			},
			name: {
				required: "請輸入姓名",
				maxlength: "姓名欄位長度，不可超過50字"
			},
			tel: {
				required: "請輸入聯絡電話",
				maxlength: "聯絡電話欄位長度，不可超過20字"
			},
			mobile: {
				maxlength: "行動電話欄位長度，不可超過11字"
			},
			email: {
				required: "請輸入電子信箱",
				email: "Email格式不正確",
				maxlength: "電子信箱欄位長度，不可超過30字"
			},
			address: {
				maxlength: "住址欄位長度，不可超過100位數"
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
<form id="mform" name="mform" method="post" action="drive101_mdysave.jsp">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno %>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p>
 <input type="submit" class="button_add" value="<%=lang.getMdy() %>"/>
 <input type="button" class="button_cancel" value="<%=lang.getCancel()%>" onclick="javascript:window.document.mform.reset()"/>
 <input type="button" class="button_del" value="<%=lang.getDel()%>" onclick="javascript:del()"/>
 <input type="button" class="button_default" value="<%=lang.getBack() %>" onclick="javascript:back()"/>
</p>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value="<%=query.getPubunitdn()%>"/>
    <input type="hidden" name="pubunitname" value="<%=query.getPubunitname()%>"/> 
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>姓名</td>
    <td colspan="3">
      <input id="name" name="name" type="text" class="lInput01" size="30" value="<%=query.getName() %>"/>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">性別</td>
    <td colspan="3">
      <select id="sex" name="sex">
        <option value="M" <% if ( query.getSex().equals("M") ) out.print("selected"); %>>男</option>
        <option value="F" <% if ( query.getSex().equals("F") ) out.print("selected"); %>>女</option>
      </select>
    </td>
  </tr>  
  <tr>
    <td class="T12b"><span class="T12red">※</span>聯絡電話</td>
    <td colspan="3">
      <input id="tel" name="tel" type="text" class="lInput01" size="30" value="<%=query.getTel() %>"/>
      &nbsp;&nbsp;<span class="T10">(例如：03-1234567#123）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">行動電話</td>
    <td colspan="3">
      <input id="mobile" name="mobile" type="text" class="lInput01" size="30" value="<%=query.getMobile() %>"/>
      &nbsp;&nbsp;<span class="T10">(例如：0910-123123）</span>
    </td>
  </tr> 
  <tr>
    <td class="T12b"><span class="T12red">※</span>電子信箱</td>
    <td colspan="3">
      <input id="email" name="email" type="text" class="lInput01" size="30" value="<%=query.getEmail() %>"/>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">住址</td>
    <td colspan="3">
      <input id="address" name="address" type="text" class="lInput01" size="85" value="<%=query.getAddress() %>"/>
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">備註</td>
    <td colspan="3">
      <textarea id="note" name="note" cols="65" rows="6"><%=query.getNote() %></textarea>
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


