<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.login.*" %>

<%
  String loginap = ( String )request.getParameter( "loginap" );
  String passwd = ( String )request.getParameter( "passwd" );
  String menudn = ( String )request.getParameter( "menudn" );

  LoginCheck qcheck = new LoginCheck();
  qcheck.setLoginap(loginap);
  qcheck.setPasswd(passwd);
  boolean rtn = qcheck.getCheckPower(menudn);
  
  String xmlmessage = "";
  if ( rtn ) {
	  xmlmessage = "||true||";
  }else{
	  xmlmessage = "||false||" + qcheck.getErrorMsg() + "||";
  }
  
  response.setContentType("text/plain; charset=UTF-8");
  response.getWriter().print(xmlmessage);
  response.getWriter().flush();
  response.getWriter().close();
  
%>