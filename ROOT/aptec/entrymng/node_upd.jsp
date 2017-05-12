<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_upd.jsp
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
	  if ( document.treeform.chinesetitle.value == '' ) {
		  alert( "【局(室)名稱(中文)】欄位不能空白，請輸入!! " );
		  document.treeform.chinesetitle.focus();
		  return;
	  }
	  
	  document.treeform.action = "node_updsave.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }

  function del() {
	  x = window.confirm("確定刪除該單位資料嗎?");
	  if ( x ) {
		  document.treeform.action = "node_del.jsp";
		  document.treeform.method = "post";
		  document.treeform.submit();
	  }	  		  
  }
  
  function addunit() {
	  document.treeform.action = "node_add.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }

  function addusers() {
	  document.treeform.action = "leaf_add.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Locale" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String rootnode = PropertiesBean.getBundle("tw.com.econcord.properties.project", "rootnode", Locale.TAIWAN);

  String mdn = ( String )request.getParameter( "mdn" );
  
  DepartmentTree query = new DepartmentTree();
  query.setUnitdn(mdn);
  ArrayList<DSItem> qlists = query.getDepartment();  

  String loginrole = ( String )session.getAttribute( "userrole" );
  if ( loginrole == null || loginrole.equals("null") )
	  loginrole = "";
  
  String title = ( String )session.getAttribute( "title" );
  
%>


<form name="treeform">
<input type="hidden" name="mdn" value="<%=mdn%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>人員組織設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <%
    if ( !mdn.equals(rootnode) || ( mdn.equals(rootnode) && loginrole.equals("super") )) { %>
    	<input type="button" class="btn" value=" 儲存 " onclick="javascript:save()">
    	<input type="button" class="btn" value=" 刪除 " onclick="javascript:del()">
    	<input type="button" class="btn" value=" 重填 " onclick="javascript:window.document.treeform.reset()">
    <%}%>  
  <input type="button" class="btn" value=" 新增單位 " onclick="javascript:addunit()">
  <input type="button" class="btn" value=" 新增成員 " onclick="javascript:addusers()">
</div>

<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <%
    if ( qlists != null && qlists.size() > 0 ) {
    	DSItem qlist = ( DSItem )qlists.get(0);  %>
    	<tr align="center">
    	  <th colspan="2"><%=qlist.getChinesetitle()%>--組織設定【<%=qlist.getUnitdn()%>】</th>
    	</tr>
    	<tr class="tr">
    	  <td width="30%" class="T12b"><span class="T12red">※</span>局(室)代碼</td>
    	  <td width="70%">
    	    <input type="text" name="ou" size="30" value="<%=qlist.getOu()%>" readonly />    	    
    	    <input type="hidden" id="id" name="id" value="<%=qlist.getId()%>" />
    	    <input type="hidden" id="parentid" name="parentid" value="<%=qlist.getParentid()%>" />    	    
    	    <input type="hidden" id="parentpath" name="parentpath" value="<%=qlist.getParentpath()%>" />
    	  </td>
    	</tr>
    	<tr>
    	  <td class="T12b"><span class="T12red">※</span>局(室)名稱(中文)</td>
    	  <td><input type="text" name="chinesetitle" size="60" value="<%=qlist.getChinesetitle()%>" /></td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>局(室)名稱(英文)</td>
    	  <td><input type="text" name="englishtitle" size="60" value="<%=qlist.getEnglishtitle()%>" /></td>
    	</tr>
    	<tr>
    	  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>局(室)名稱(日文)</td>
    	  <td><input type="text" name="japantitle" size="60" value="<%=qlist.getJapantitle()%>" /></td>
    	</tr>
    <%}%>
  
</table>

</form>
</body>
</html>

