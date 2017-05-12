<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：tree.jsp
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

</head>

<%@ page import="java.util.Locale" %>

<%
  String title = ( String )request.getParameter( "title" );
  
  String logindn = ( String )session.getAttribute( "logindn" );
  if ( logindn == null || logindn.equals("") ) {
	  logindn = ( String )request.getParameter( "logindn" );
  }
  
  if ( logindn!= null && !logindn.equals("null") ) {%>
	  <frameset cols="22%,56%,22%" frameborder="no">
	     <frame src="aplist/aplist.jsp?title=<%=title%>" name="treeleft" scrolling="NO">
	     <frame src="blank.html" name="center">
	     <frame src="entrymng/entrymng.jsp?title=<%=title%>" name="treeright" scrolling="NO">
	  </frameset>
  <%}else{%>
	  <script type="text/javascript">
	      window.location.href = "/index.jsp";
	      window.location.target = "_top";
	  </script>
  <%}%>

</html>


