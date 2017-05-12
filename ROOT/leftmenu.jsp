<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="tw.com.econcord.login.LeftMenu" id="LeftMenu"></jsp:useBean>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.login.*" %>

<%
  String parentId = "";
  if ( request.getParameter("parentId") != null ) {
	  parentId = request.getParameter("parentId").toString();
  }
  
  String languagetype = ( String )request.getParameter( "language" );
  if ( languagetype == null || languagetype.equals("null") || languagetype.equals("") )
	  languagetype = "chinese";  
    
  String logindn = ( String )session.getAttribute( "logindn" );
  String passwd = ( String )session.getAttribute( "passwd" );
  String loginap = ( String )session.getAttribute( "loginap" );
  
  //取出登入者角色
  LeftMenu qrole = new LeftMenu();
  qrole.setLogindn(logindn);
  String mrole = qrole.getUserRole();
  session.setAttribute("role",mrole);

  LeftMenu.setParentId(Integer.parseInt(parentId));  
  LeftMenu.setLogindn(logindn);
  LeftMenu.setRole(mrole);
  
%>

  
<%=LeftMenu.getTreeString()%>

