<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qsort.jsp
說明：排序查詢
開發者：chmei
開發日期：96.10.16
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>排序查詢</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String tablename = ( String )request.getParameter( "tablename" );
  String logindn = ( String )request.getParameter( "logindn" );
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  QsortData query = new QsortData();
  ArrayList qlists = query.findBysort(tablename,pubunitdn);
  int rcount = query.getAllrecordCount();
  String message = "";
  if ( rcount > 50 ) {
	  rcount = 50;
	  message = "因資料太多，僅顯示前50筆";
  }
	  
		  
%>

<body>
<form name="mform">

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../img/addedit.png" width="48" height="48" align="middle"/><%=title%> - 排序查詢</h2>
</div>
<p></p>

<%
  if ( !message.equals("") ) { %>
	  <div>
	    <h2>因資料太多，僅顯示前50筆</h2>
	  </div>
  <%}%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th width="20%" align="center">排　序</th>
    <th width="80%" align="left">標　題</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		QsortData qlist = ( QsortData )qlists.get( i );  %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td class="T12b" align="center" valign="top"><%=qlist.getFsort()%></td>
    		  <td class="T12b" align="left"><%=qlist.getSubject()%></td>
    		</tr>
    	<%}
    }else{%>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td class="T12b" align="center" colspan="2">目前查無資料</td>
    	</tr>
    <%}%>
    
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
</table>

<p></p>
<center><a class="md" href="javascript:window.close()">關　閉</a></center>


