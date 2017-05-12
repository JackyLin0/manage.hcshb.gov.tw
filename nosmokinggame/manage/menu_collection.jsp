<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<%
	ResultSet rs ;
	Integer i ;
	String Color ;
	
	rs = f.query("select caption from menu_collection where sn = "+f.sql_string(request.getParameter("sn"))) ;
 	String caption = "" ;
 	if(rs.next())
 	{
 		caption = rs.getString("caption");
 	}

	rs = f.query("select menu_function.* from menu_function , limit_menu where limit_menu.menu_sn = menu_function.sn and limit_menu.menu_type = 'menu_function' and limit_menu.limit_group_sn = " + session.getAttribute("session_limit_group_sn") + " and menu_function.menu_collection_sn = "+f.sql_string(request.getParameter("sn"))+" order by menu_function.sort") ;
	
	rs.last() ;
	Integer record_count = rs.getRow() ;
	rs.beforeFirst() ;
	
	if( record_count == 1 )
	{
		rs.next();
		response.sendRedirect("menu_function.jsp?sn=" + rs.getInt("sn") + "&time=" + f.urlencode(f.now()));
	}
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="fonran.css">

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table width="100%" cellspacing="0" cellpadding="0" border="0"> 
<tr bgcolor="#808080"><td class="title2" background="images/Title_Background.jpg"><img src="title.gif" border="0"><font size="3" color="#000080">&nbsp;<%=caption%></font></td></tr>
</table>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr style="padding-top:3px;padding-bottom:0px;">
<td class="title2" align="left" bgcolor="#c0c0c0">　作業名稱</td>
</tr>

<% i = 0 ; %>

<% while( rs.next() ) { %>
	<%
		if( ( rs.getRow() % 2 ) != 0 ) Color = "bgcolor=\"#f0f0f0\"" ;
		else Color = "bgcolor=\"#ffffff\"" ;
	%>
	<tr <%=Color%> onclick="window.open('menu_function.jsp?sn=<%=rs.getInt("sn")%>&Time=<%=f.urlencode(f.now())%>','_self')" onmouseover="this.className='blueon'" onmouseout="this.className='blueoff'" align="left" height="20"><td>　<% if( rs.getString("id") != "" ) out.print(rs.getString("id")+" - ") ; %><%=rs.getString("caption")%></td></tr>
<% } %>

</table>

</BODY>
</HTML>
