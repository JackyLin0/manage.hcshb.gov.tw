<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="tw.com.econcord.ds.AptoorgTree" id="AptoorgTree"></jsp:useBean>

<%
    String parentId = "";

    if ( request.getParameter("parentId") != null ) {
        parentId = request.getParameter("parentId").toString();
    }

    String title = ( String )session.getAttribute( "title" );
    
    AptoorgTree.setParentId(parentId);
    AptoorgTree.setTitle(title);
    
%>

<%=AptoorgTree.getTreeString()%>

