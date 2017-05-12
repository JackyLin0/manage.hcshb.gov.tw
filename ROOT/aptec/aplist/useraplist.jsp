<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：useraplist.jsp
說明：應用系統設定
開發者：chmei
開發日期：2017.02.24
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>應用系統設定</title>

<link href="../../css/css.css" rel="stylesheet" type="text/css" />
<link href="../../css/scrollbar.css" rel="stylesheet" type="text/css" />

</head>

<%@ page import="java.util.Locale" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>


<%
  String loginap = ( String )session.getAttribute( "loginap" );
  if ( loginap == null || loginap.equals("null") ) 
	  loginap = ( String )request.getParameter( "loginap" );
  
  String title = ( String )request.getParameter( "title" );
  
  if ( loginap != null && !loginap.equals("null") ) { %>
	  <frameset cols="25%,75%" framespacing="0" frameborder="no">
	    <frame src="aplist.jsp?title=<%=title%>" id="treeleft" name="treeleft"  scrolling="No">
	    <frame src="blank.html" id="right" name="right">
	  </frameset>
  <%}%>
  
</html>

