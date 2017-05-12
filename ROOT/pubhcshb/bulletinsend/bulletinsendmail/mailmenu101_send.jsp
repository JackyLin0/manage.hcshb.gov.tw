<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manual101_send.jsp
說明：手動派送新聞稿
開發者：chmei
開發日期：97.03.22
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 

<form name="mform" action="mailmenu101.jsp" method="post" >

<%
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  String serno = ( String )request.getParameter( "serno" ); 
  String path = request.getParameter( "path" );
  String sendemail = request.getParameter( "emails" );
  
  if ( !sendemail.equals("") ) {%>
	  <script>
	     window.open('../sendbulletin.jsp?sendemail=<%=sendemail%>&serno=<%=serno%>&path=<%=path%>','','width=300,height=200,scrollbars=yes,resizable=yes,left=90,top=90');
	     document.mform.submit();
	  </script>
  <%}%>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  </form>
</html>
