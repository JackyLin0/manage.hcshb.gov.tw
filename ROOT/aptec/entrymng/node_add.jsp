<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_add.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.02.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人員組織設定</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../js/jquery-1.4.2.js"></script>

<script type="text/javascript" src="../../js/jquery.min.js"></script>

<script type="text/javascript" src="../../js/jquery.blockUI.js"></script>
<script type="text/javascript" src="../../js/jquery.form.js"></script>

<script>
  function save() {
	  if ( document.treeform.ou.value == '' ) {
		  alert( "【局(室)代碼】欄位不能空白，請輸入!! " );
		  document.treeform.ou.focus();
		  return;
	  }	
	  if ( document.treeform.chinesetitle.value == '' ) {
		  alert( "【局(室)名稱(中文)】欄位不能空白，請輸入!! " );
		  document.treeform.chinesetitle.focus();
		  return;
	  }
	  
	  document.treeform.action = "node_addsave.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }
  
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String title = ( String )session.getAttribute( "title" );

  String mdn = ( String )request.getParameter( "mdn" );
  String id = ( String )request.getParameter( "id" );
  String parentid = ( String )request.getParameter( "parentid" );
  String parentpath = ( String )request.getParameter( "parentpath" );

  DepartmentTree query = new DepartmentTree();
  query.setUnitdn(mdn);
  ArrayList<DSItem> qlists = query.getDepartment();
  String chinesetitle = "";
  if ( qlists != null && qlists.size() > 0 ) {
	  DSItem qlist = ( DSItem )qlists.get(0);
	  chinesetitle = qlist.getChinesetitle();
  }

%>

<form name="treeform">
<input type="hidden" name="mdn" value="<%=mdn%>" />
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="parentid" value="<%=parentid%>" />
<input type="hidden" name="parentpath" value="<%=parentpath%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>人員組織設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <input type="button" class="btn" value=" 儲存  " onclick="javascript:save()">
  <input type="button" class="btn" value=" 重填  " onclick="javascript:window.document.treeform.reset()">
  <input type="button" class="btn" value=" 上一頁  " onclick="javascript:window.location.href='javascript:history.go(-1)'">
</div>

<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <tr align="center">
    <th colspan="2"><%=chinesetitle%>--下新增組織設定</th>
  </tr>
  <tr class="tr">
    <td width="30%" class="T12b"><span class="T12red">※</span>局(室)代碼</td>
    <td width="70%">
      <input type="text" name="ou" class="lInput01" size="30"/>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>局(室)名稱(中文)</td>
    <td><input type="text" name="chinesetitle" class="lInput01" size="60" /></td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>局(室)名稱(英文)</td>
    <td><input type="text" name="englishtitle" class="lInput01" size="60" /></td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>局(室)名稱(日文)</td>
    <td><input type="text" name="japantitle" class="lInput01" size="60" /></td>
  </tr>
</table>

</form>

</body>
</html>
