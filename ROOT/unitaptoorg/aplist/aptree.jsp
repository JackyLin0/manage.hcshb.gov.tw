<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="tw.com.econcord.ds.AptoorgTree" id="AptoorgTree"></jsp:useBean>

<%
  String parentId = "";
  if ( request.getParameter("parentId") != null ) {
	  parentId = request.getParameter("parentId").toString();
  }

  String logindn = ( String )session.getAttribute( "logindn" );
  String loginap = ( String )session.getAttribute( "loginap" );
  
  String title = ( String )session.getAttribute( "title" );
  String websitedn = ( String )request.getParameter( "websitedn" );
  
  AptoorgTree.setParentId(parentId);
  AptoorgTree.setLoginap(loginap);
  AptoorgTree.setTitle(title);
  AptoorgTree.setWebsitedn(websitedn);
    
%>

<%=AptoorgTree.getApTreeString()%>

