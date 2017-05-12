<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="tw.com.econcord.ds.ApRootTree" id="UserApRootTree"></jsp:useBean>

<%
  String parentId = "";
  if ( request.getParameter("parentId") != null ) {
	  parentId = request.getParameter("parentId").toString();
  }
  
  String logindn = ( String )session.getAttribute( "logindn" );
  
  String languagetype = ( String )session.getAttribute( "languagetype" );
  if ( languagetype == null || languagetype.equals("null") || languagetype.equals("") )
	  languagetype = "chinese";

  String title = ( String )session.getAttribute( "title" );
  
  UserApRootTree.setParentId(parentId);
  UserApRootTree.setTitle(title);

%>

<%=UserApRootTree.getTreeString()%>

