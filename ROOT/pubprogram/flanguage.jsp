<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：flanguage.jsp
說明：語系選用程式(文件檔案、圖片檔案、media擋使用)
開發者：chmei
開發日期：96.03.23
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.lang.FLanguage" %>
<%@ page import="tw.com.sysview.lang.FLangFactory" %>

<%
  String sysRoot = (String) application.getRealPath("");
  String language = ( String )request.getParameter( "language" );
  
  FLanguage lang = FLangFactory.getInstance(sysRoot).getFLanguage(language);   

%>  

<input type="hidden" name="language" value="<%=language%>">