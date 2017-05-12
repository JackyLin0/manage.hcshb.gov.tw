<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String function_sn = f.cstr(request.getParameter("function_sn")) ;
	String sn = f.cstr(request.getParameter("sn")) ;
	String table = f.cstr(request.getParameter("table")) ;
	
	if( f.limit_function( function_sn , "delete" ) )
	{
		f.execute_sql("DELETE FROM " + table + " WHERE sn = "+sn) ;
	
		f.employee_log_2( function_sn , "刪除 " + table ) ;
	}
	
	response.sendRedirect("index.jsp?function_sn="+function_sn+"&time=" + f.urlencode(f.now())) ;
%>