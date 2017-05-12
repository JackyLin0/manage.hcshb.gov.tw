<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="tw.com.econcord.ds.DepartmentTree" id="DepartmentTree"></jsp:useBean>

<%
    String parentId = "";
    if ( request.getParameter("parentId") != null ) {
        parentId = request.getParameter("parentId").toString();
    }
    
    String title = ( String )session.getAttribute( "title" );
    String pubunitdn = ( String )request.getParameter( "pubunitdn" );
    
    DepartmentTree.setParentId(parentId);    
    DepartmentTree.setTitle(title);
    DepartmentTree.setUnitdn(pubunitdn);
    
%>

<%=DepartmentTree.getTreeString()%>
