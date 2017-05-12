<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manual101_send.jsp
說明：手動派送電子報
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

<form name="mform" action="manual101.jsp" method="post" />

<%
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Upload_PATH = sysRoot + "\\WEB-INF\\epaper.properties";
  else
	  Upload_PATH = sysRoot + "/WEB-INF/epaper.properties";

  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String syspath = upload.getProperty("epaperpreview");

  String periodical = ( String )request.getParameter( "periodical" );  
  String[] ary_emails1 = request.getParameterValues( "emails1" );
  String sendemail = "";
  for ( int i=0; i<ary_emails1.length; i++ ) {
	  if ( sendemail.equals("") )
		  sendemail = ary_emails1[i].trim();
	  else
		  sendemail = sendemail + "||" + ary_emails1[i].trim();
  }
  
  if ( !sendemail.equals("") ) {%>
	  <script>
	     window.open('<%=syspath%>/epapersend/sendepaper.jsp?periodical=<%=periodical%>&sendemail=<%=sendemail%>','','width=300,height=200,scrollbars=yes,resizable=yes,left=90,top=90');
	     document.mform.submit();
	  </script>
  <%}%>
  
</html>
