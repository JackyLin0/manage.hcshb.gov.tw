<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu_qsort.jsp
說明：選單目錄管理
開發者：chmei
開發日期：96.02.12
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  int mlevel = Integer.parseInt(( String )request.getParameter( "mlevel" ));
  String table = ( String )request.getParameter( "t" );
  
  MenuData query = new MenuData();    
  ArrayList qlists = query.findBysort(table,mlevel);
  int rcount = query.getAllrecordCount();
%> 

<!-- 欄位名稱(語系)，每支程式需include -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>第&nbsp;<%=mlevel%>&nbsp;層&nbsp;<%=lang.getIslevelcontent()%></h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th width="20%" align="center"><%=lang.getFsort()%></th>
    <th width="80%" align="left"><%=lang.getIslevelcontent()%></th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		MenuData qlist = ( MenuData )qlists.get( i );  %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td class="T12b" align="center"><%=qlist.getFsort()%></td>
    		  <td><%=qlist.getIslevelcontent()%></td>
    		</tr>
    	<%}
    }%>
    
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
</table>

<p></p>
<center><a class="md" href="javascript:window.close()">關　閉</a></center>
