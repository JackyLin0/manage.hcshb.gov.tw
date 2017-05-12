<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：entrymng.jsp
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

</head>

<%@ page import="java.util.Locale" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>

<%
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )session.getAttribute( "logindn" );
  if ( logindn == null || logindn.equals("") ) {
	  logindn = ( String )request.getParameter( "logindn" );
  }
  
  if ( logindn!= null && !logindn.equals("null") ) {  %>
	  <frameset cols="25%,75%" framespacing="0" frameborder="no" border="1">
	    <frame src="entrymng_tree.jsp?title=<%=title%>" id="treeleft" name="treeleft" scrolling="No">
	    <frame src="blank.html" id="right" name="right">
	  </frameset>
  <%}%>

</html>
