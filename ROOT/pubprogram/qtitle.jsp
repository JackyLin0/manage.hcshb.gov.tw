<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qtitle.jsp
說明：尋找系統名稱
開發者：chmei
開發日期：2017.03.03
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<%
  String templogindn = ( String )session.getAttribute("logindn");
  String title = ( String )request.getParameter( "title" );
  String webdn = ( String )request.getParameter( "aplistdn" );
  
  //此AP負責局室
  ApRootTree qaptree = new ApRootTree();
  ArrayList<DSItem> qaptrees = qaptree.getAptree(webdn);
  String mpunit = "";
  
  if ( qaptrees != null && qaptrees.size() > 0 ) {
	  DSItem quserunit = ( DSItem )qaptrees.get(0);
	  mpunit = quserunit.getUserunit();
  }
  
	  session.setAttribute("webdn",webdn);
%>

<input type="hidden" name="webdn" value="<%=webdn%>"/>
<input type="hidden" name="title" value="<%=title%>"/>
<input type="hidden" name="mpunit" value="<%=mpunit%>"/>


  