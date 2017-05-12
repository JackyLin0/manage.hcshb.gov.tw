<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：addattlf.jsp
說明：人員組織管理(組人員attribute變數)
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%
  String addatt = new String("objectclass=top,users");
  
  String uid = ( String )request.getParameter( "uid" );
  addatt = addatt + ";uid=" + uid;
  
  String carlicense = ( String )request.getParameter( "carlicense" );
  addatt = addatt + ";carlicense=" + carlicense.toUpperCase();

  String flag =  ( String )request.getParameter( "flag" );
  if (flag.equals("new"))
     addatt = addatt + ";userpassword=" + uid;
  
  String cn = ( String )request.getParameter( "cn" );
  addatt =addatt + ";cn=" + cn;   

  String email = ( String )request.getParameter( "email" );
  if ( email.equals("") )
     addatt = addatt + ";mail=!";
  else
     addatt = addatt + ";mail=" + email;
%>