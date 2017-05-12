<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<%
	Integer i ;
	
	ResultSet rs = f.query("select * from menu_subsystem , limit_menu where limit_menu.menu_sn = menu_subsystem.sn and limit_menu.menu_type = 'menu_subsystem' and limit_menu.limit_group_sn = " + session.getAttribute("session_limit_group_sn") + " order by menu_subsystem.sort") ;
	
	rs.last() ;
	Integer total_subsystem = rs.getRow() ;
	rs.beforeFirst() ;
	
	String rows = "*" ;
	for( i = 1 ; i < total_subsystem ; i ++ ) rows += ",22" ;
%>

<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=big5">
	</HEAD>
	<frameset id="frm1" rows="<%=rows%>" frameborder="no" border="-1" frameSpacing="-1">

		<% while( rs.next() ){ %>

			<frame name="Subsystem<%=(rs.getRow()-1)%>"
				src='menu_subsystem.jsp?sn=<%=rs.getInt("sn")%>&total_subsystem=<%=total_subsystem%>&order=<%=(rs.getRow()-1)%>&Time=<%=f.urlencode(f.now())%>'
				noresize scrolling="no">

		<% } %>
		
		<frame name="Subsystem<%=(total_subsystem-1)%>"
				src='logout.jsp?Time=<%=f.urlencode(f.now())%>'
				noresize scrolling="no">

	</frameset>
</HTML>
