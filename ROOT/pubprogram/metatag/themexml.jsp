<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：themexml.jsp.jsp
說明：產生主題分類 xml檔
開發者：chmei
開發日期：99.06.26
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>產生主題分類 xml檔</title>
</head>

<%@ page import="tw.com.sysview.metatag.*" %>

<body>

<%
  //取設定檔路徑
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
  
  ThemeXml query = new ThemeXml();
  query.createfile(sysRoot);
  
%>
</body>
</html>