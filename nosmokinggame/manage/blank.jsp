<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<%
	String system_title = f.get_parameter("system_title") ;
	String sql , Color ;
	
	sql = "select top " + f.get_parameter("menu_function_frequently_count") + " menu_function.* , menu_function_frequently.counter from menu_function , limit_menu , menu_function_frequently" ;
	sql += " where limit_menu.menu_sn = menu_function.sn" ;
	sql += " and limit_menu.menu_type = 'menu_function'" ;
	sql += " and limit_menu.limit_group_sn = " + session.getAttribute("session_limit_group_sn") ;
	sql += " and menu_function.sn = menu_function_frequently.menu_function_sn" ;
	sql += " and menu_function_frequently.employee_sn = " + session.getAttribute("session_employee_sn") ;
	sql += " order by menu_function_frequently.counter desc" ;
	
	ResultSet rs = f.query(sql) ;
%>
<HEAD>
	<TITLE><%=system_title%></TITLE>
	
<link rel=stylesheet type="text/css" href="fonran.css">

</HEAD>
<body bottomMargin="0" bgColor="#ffffff" leftMargin="0" topMargin="0" rightMargin="0" style="BACKGROUND-COLOR: #ffffff">

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="100%">
  <tr>
    <td width="100%">
    <p align="center"><font size="6" face="標楷體" color="Navy"><u><%=system_title%></u></font>
    <br>
    <FONT size="2">本系統由<a href="http://www.fonran.com.tw" target="_blank">風然資訊有限公司</a>開發設計</FONT>
    </td>
  </tr>
    <tr>
    <td width="100%" valign="bottom" height=10><div align="center">
    <font color="#ff0000" size="2">※ 請選擇左列功能進行作業 ※<br>
    ( 請使用 IE 5.5 以上瀏覽器，最佳流覽解析度 800*600 )</font>
     </div></td>
  </tr>
  <tr height="40%" bgcolor="#ffcc00" valign="top">
    <td width="100%">

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr style="padding-top:3px;padding-bottom:0px;">
<td class="title2" align="left" bgcolor="#c0c0c0">　常用項目</td>
</tr>

<% while( rs.next() ) { %>
	<%
		if( ( rs.getRow() % 2 ) != 0 ) Color = "bgcolor=\"#f0f0f0\"" ;
		else Color = "bgcolor=\"#ffffff\"" ;
	%>
	<tr <%=Color%> onclick="window.open('menu_function.jsp?sn=<%=rs.getInt("sn")%>&Time=<%=f.urlencode(f.now())%>','_self')" onmouseover="this.className='blueon'" onmouseout="this.className='blueoff'" align="left" height="20"><td>　<% if( rs.getString("id") != "" ) out.print(rs.getString("id")+" - ") ; %><%=rs.getString("caption")%></td></tr>
<% } %>

</table>
    
    </td>
  </tr>
</table>