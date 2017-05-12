<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@ include file="../library.jsp" %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="../fonran.css">

<script language="javascript">

	function pick(filename)
	{
		window.opener.form1.icon_file_name.value = filename ;
		window.close() ;
	}

</script>

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table width="100%" cellspacing="0" cellpadding="0" border="0"> 
<tr bgcolor="#808080"><td class="title2" background="images/Title_Background.jpg"><img src="../title.gif" border="0"><font size="3" color="#000080">&nbsp;請選擇適合的圖示</font></td></tr>
</table>

<%
	Integer i ;
	File f1 = new File(application.getRealPath("/manage/icon")) ;
	String[] list = f1.list() ;
%>

<table width="100%">
<tr>
<% for( i = 0 ; i < list.length ; i ++ ) { %>
	<% if( i % 4 == 0 && i > 0 ) out.print("</tr><tr>") ; %>
	<td align="center"><a href="javascript:pick('<%=list[i]%>')"><img src="../icon/<%=list[i]%>" border="0"></a></td>
<% } %>
</tr>
</table>