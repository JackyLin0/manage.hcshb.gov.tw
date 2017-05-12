<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_upd.jsp
說明：系統權限設定
開發者：chmei
開發日期：2017.02.26
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系統權限設定</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  function save() {
	  if ( document.treeform.aciuserdn.value == '' ) {
		  alert( "【您未新增任何權限資料，不需更新權限！】 " );
		  return;
	  }	  
	  
	  document.treeform.action = "node_updsave.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }	  
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String apdn = ( String )request.getParameter( "apdn" );
  String orgdn = ( String )request.getParameter( "orgdn" );
  if ( apdn != null ) {
	  //新的應用系統將session釋放
	  session.removeAttribute("session_orgdn");
	  session.setAttribute("apdn1",String.valueOf(apdn));
  }else{
	  apdn = ( String )session.getAttribute("apdn1");
  }
  
  String purviewtable = ( String )request.getParameter( "purviewtable" ); 
  String unitpurview = ( String )session.getAttribute("unitpurview");
    
  //取出該系統名稱
  String sysname = "";
  String langflag = "";
  String language = "";
  ApRootTree qmapname = new ApRootTree();
  ArrayList<DSItem> qapnames = qmapname.getAptree(apdn);
  if ( qapnames != null && qapnames.size() > 0 ) {
	  DSItem qapname = ( DSItem )qapnames.get(0);
	  sysname = qapname.getSysname();
  }

  //取出該系統權限(資料庫)  
  String aciuserdn = "";  
  AptoorgTree query = new AptoorgTree();
  query.setUnitpurview(unitpurview);
  ArrayList<DSItem> qlists = query.getAptoorg(apdn);
  if ( qlists != null && qlists.size() > 0 ) {
	  for ( int i=0; i<qlists.size(); i++ ) {
		  DSItem qlist = ( DSItem )qlists.get( i );
		  if ( aciuserdn.equals("") ) {
			  aciuserdn = qlist.getAciuserdn();
		  }else{
			  aciuserdn = aciuserdn + "$" + qlist.getAciuserdn();
		  }
	  }
  }
  
  String session_orgdn = ( String )session.getAttribute("session_orgdn");
  if ( session_orgdn != null && !session_orgdn.equals("null") ) {
	  if ( aciuserdn.equals("") ) {
		  aciuserdn = session_orgdn;
	  }else{
		  aciuserdn = aciuserdn + "$" + session_orgdn;
	  }
  }
 
  if ( orgdn != null && !orgdn.equals("null") && !orgdn.equals("") ) {
	  if ( orgdn.indexOf("uid") < 0 )
		  orgdn = "uid=*," + orgdn;
	  if ( aciuserdn.equals("") ) {
		  aciuserdn = orgdn;
		  session_orgdn = orgdn;
	  }else{
		  String[] ary_aciuserdn = SvString.split(aciuserdn,"$");
		  if ( !SvString.contain(ary_aciuserdn,orgdn) ) {
			  aciuserdn = aciuserdn + "$" + orgdn;
			  session_orgdn = session_orgdn + "$" + orgdn;
		  }
	  }
	  session.setAttribute("session_orgdn",String.valueOf(session_orgdn));
  }
  
  AptoorgTree qdata = new AptoorgTree();  
  ArrayList<DSItem> qusers = qdata.getAptoorgUsers(aciuserdn);
  
  String title = ( String )session.getAttribute( "title" );
%>


<form name="treeform">
<input type="hidden" name="aplistdn" value="<%=apdn%>" />
<input type="hidden" name="aciuserdn" value="<%=aciuserdn%>" />
<input type="hidden" name="language" value="<%=language%>" />
<input type="hidden" name="purviewtable" value="<%=purviewtable%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>系統權限設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <input type="button" class="btn" value=" 更新權限設定  " onclick="javascript:save()">
</div>

<table width="100%" align="center" cellpadding="0" cellspacing="0" class="table02">
  <tr bgcolor="#c6d5e1">
    <th>系統名稱</th>
  </tr>
  <tr>
    <td><div align="center"><%=sysname%></div></td>
  </tr>
</table>

<p>&nbsp;</p>		  

<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <tr align="center" bgcolor="#c6d5e1">
    <th width="4%">#</th>
    <th width="28%"><img src="../../img/users.png" alt="USER"/>使用者姓名</th>
    <th width="14%">帳 號</th>
    <th width="25%">單 位</th>
	<th width="17%">權 限 設 定</th>
  </tr>
  <%
    if ( qusers != null ) {
    	for ( int p=0; p<qusers.size(); p++ ) {
    		DSItem quser = ( DSItem )qusers.get( p );
    		String mallow = "allow";
    		if ( ( quser.getMuid() == null || quser.getMuid().equals("null") || quser.getMuid().equals("") ) && ( quser.getCn() == null || quser.getCn().equals("null") || quser.getCn().equals("")) ) {
    			mallow = "delete";
    		}%>
    		<tr class="tr01" onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=p+1%></td>
    		  <td align="left"><%=quser.getCn()%></td>
    		  <td align="center"><%=quser.getMuid()%>&nbsp;</td>
    		  <td align="left"><%=quser.getChinesetitle()%></td>
    		  <td align="center">
    		    <input type="radio" name="ad<%=p%>" value="allow" <%=mallow.equals("allow") ? "checked" : ""%> />
    		    <img src="../../img/allow.png" alt="許可" align="middle" />&nbsp;
    		    <input type="radio" name="ad<%=p%>" value="delete" <%=mallow.equals("delete") ? "checked" : ""%> />
    		    <img src="../../img/del.png" alt="刪除" align="middle" />
    		  </td>
    		</tr>
    	<%}
    }%>

</table>

<br>
<div style="padding-left:12px;height:30px">
  <input type="button" class="btn" value=" 更新權限設定  " onclick="javascript:save()">
</div>


</form>
</body>
</html>

