<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：addatt.jsp
說明：人員組織管理
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%
  String addatt = new String("objectclass=department");
  
  String ou = ( String )request.getParameter( "ou" );
  addatt = addatt + ";ou=" + ou;  
  String ctitle = ( String )request.getParameter( "ctitle" );
  addatt = addatt + ";chinesetitle=" + ctitle; 
  String etitle = ( String )request.getParameter( "etitle" );
  if ( etitle.equals("") )
	  addatt = addatt + ";englishtitle=!";
  else
     addatt = addatt + ";englishtitle=" + etitle;
  
  String jtitle = ( String )request.getParameter( "jtitle" );
  if ( jtitle.equals("") )
	  addatt = addatt + ";japantitle=!";
  else
     addatt = addatt + ";japantitle=" + jtitle;
%>
	