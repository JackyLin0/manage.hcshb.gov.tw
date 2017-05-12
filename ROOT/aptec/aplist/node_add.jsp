<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_upd.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.02.25
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>應用系統設定</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  function save() {
	  if ( document.treeform.sysname.value == '' ) {
		  alert( "【應用系統名稱】欄位不能空白，請輸入!! " );
		  document.treeform.sysname.focus();
		  return;
	  }
	  if ( document.treeform.ou.value == '' ) {
		  alert("【應用系統代碼】欄位不能空白，請輸入!!");
		  document.treeform.ou.focus();
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
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String[] ary_aplistdn = SvString.split(aplistdn, ",");

  String parentid = ( String )request.getParameter( "id" );
  String parentpath = ( String )request.getParameter( "parentpath" ) + "," + parentid;

  ApRootTree query = new ApRootTree();
  ArrayList<DSItem> qlists = query.getAptree(aplistdn);
  String sysname = "";
  if ( qlists != null ) {
	  for ( int i=0; i<qlists.size(); i++ ) {
		  DSItem qlist = ( DSItem )qlists.get( i );
		  sysname = qlist.getSysname();
	  }
  }
  
  String title = ( String )session.getAttribute( "title" );
  String languagetype = ( String )request.getParameter( "languagetype" );

  //尋找單位
  DepartmentTree quserunit = new DepartmentTree();  
  quserunit.setParentId("1");
  ArrayList<DSItem> qunits = quserunit.getDepartment();
  
%>

<body>

<form name="treeform">
<input type="hidden" name="parentid" value="<%=parentid%>" />
<input type="hidden" name="parentpath" value="<%=parentpath%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>應用系統設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <input type="button" class="btn" value=" 儲存  " onclick="javascript:save()">
  <input type="button" class="btn" value=" 重填  " onclick="javascript:window.document.treeform.reset()">
  <input type="button" class="btn" value=" 上一頁  " onclick="javascript:window.location.href='javascript:history.go(-1)'">
</div>

<div>
<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <tr align="center">
    <th colspan="2"><%=sysname%>--下新增應用系統設定</th>
  </tr>
  <tr class="tr">
    <td width="25%" class="T12b"><span class="T12red">※</span>父系統DN</td>
    <td width="75%"><input type="text" name="parentdn" class="lInput01" size="58" value="<%=aplistdn%>" readonly /></td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>應用系統名稱</td>
    <td><input type="text" name="sysname" class="lInput01" size="50" /></td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>應用系統代碼</td>
    <td>
      <input type="text" name="ou" class="lInput01" size="20" onkeyup="value=value.replace(/[^-_a-zA-Z0-9]/g,'')" />
      &nbsp;&nbsp;&nbsp;<span class="T12red">※<font size="2">&nbsp;請輸入英數字</font></span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>URL</td>
    <td><input type="text" name="aplisturl" class="lInput01" size="50" value="http://" /></td>
  </tr>
  <tr class="tr">
    <td class="T12b">主要負責局室</td>
    <td>
      <select name="punit" size="5" multiple>
        <%
          if ( qunits != null && qunits.size() > 0 ) {
        	  for ( int u=0; u<qunits.size(); u++ ) {
        		  DSItem qunit = ( DSItem )qunits.get( u );
        		  String[] ary_unitdn = SvString.split(qunit.getUnitdn(),",");
        		  if ( ary_unitdn.length > 3 ) {  %>
        			  <option value="<%=qunit.getUnitdn()%>"><%=qunit.getChinesetitle()%></option>
        		  <%}
        	  }
          }%>
      </select><br />
      <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    </td>
  </tr>    	
  <tr>
    <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>每頁顯示筆數</td>
    <td><input type="text" name="pagenumber" class="lInput01" size="20" value="15" /></td>
  </tr>
  <%
    if ( ary_aplistdn.length == 3 ) {
    	WebSiteData qwebsite = new WebSiteData();
    	boolean rtn = qwebsite.load(aplistdn); %>
    	<tr class="tr">
    	  <td class="T12b">WebSite</td>
    	  <td>
    	    <input type="radio" name="website" value="Y" onclick="chg()" />是&nbsp;&nbsp;
    	    <input type="radio" name="website" value="N" onclick="chg()" />否
    	  </td>
    	</tr>
    	<tr id='type0' style="display:none">
    	  <td class="T12b">網站對應局室</td>
    	  <td>
    	    <select name="punitweb" size="5" multiple>
    	      <%
    	        if ( qunits != null && qunits.size() > 0 ) {
    	        	for ( int wu=0; wu<qunits.size(); wu++ ) {
    	        		DSItem qunit = ( DSItem )qunits.get( wu );
    	        		String munitdn = (qunit.getUnitdn()).replace(',','*');
    	        		String datavalue = munitdn + "||" + qunit.getChinesetitle(); %>
    	        		<option value=<%=datavalue%>><%=qunit.getChinesetitle()%></option>
    	        	<%}
    	        }%>
    	    </select><br />&nbsp;
    	    <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    	  </td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b">Language</td>
    	  <td colspan="3">
    	    <input type="radio" name="islanguage" value="Chinese" checked />中文版&nbsp;&nbsp;
    	    <input type="radio" name="islanguage" value="English" />英文版&nbsp;&nbsp;
    	    <input type="radio" name="islanguage" value="Japan" />日文版&nbsp;&nbsp;
    	    <input type="radio" name="islanguage" value="" />無
    	  </td>
    	</tr>
    	<tr>
    	  <td class="T12b">是否啟用</td>
    	  <td colspan="3">
    	    <input type="radio" name="startusing" value="Y" />是&nbsp;&nbsp;
    	    <input type="radio" name="startusing" value="N" checked />否&nbsp;&nbsp;
    	    <span class="T10">(此站台是否有建站)</span>
    	  </td>
    	</tr>
    <%}
  %>
</table>
</div>

</form>

</body>
</html>
