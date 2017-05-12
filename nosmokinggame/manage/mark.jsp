<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="fonran.css">

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#ff0000" vlink="#ff0000" alink="#ff0000">

<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0"> 

<form target="main" action="menu_function.jsp" method="POST">

<tr><td class="title2" background="images/Title_Background.jpg">

<center>
<br><font color="red">
<a href="blank.jsp?time=<%=f.urlencode(f.now())%>" target="main">系統首頁</a><br>
代碼：<input type="text" size="5" name="id"> <input type="submit" value="開啟">
</font>
</center>

</td></tr>

</form>

</table>