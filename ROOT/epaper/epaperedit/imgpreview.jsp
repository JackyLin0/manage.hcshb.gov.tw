<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="tw.com.sysview.upload.*" %>

<%
  String serno = ( String )request.getParameter( "serno" );
  
  EpaperUploadData qexp = new EpaperUploadData();
  boolean rtn = qexp.load(serno);
  String mserverfile = "";
  String mexpfile = "";
  if ( rtn ) {
	  mserverfile = qexp.getServerfile();
	  mexpfile = qexp.getExpfile();
  }
  
%>
<html lang="zh-TW">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>圖片預覽</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>


<body>
<form name="epaper">

<a class="md" href="javascript:window.close()">關閉視窗</a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th>圖片預覽</th>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center"><img src="../../uploaddowndoc?file=/<%=mserverfile%>&flag=epaper" alt="<%=mexpfile%>" border="0"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th >&nbsp;</th>
  </tr>
</table>

</form>
</body>
</html>