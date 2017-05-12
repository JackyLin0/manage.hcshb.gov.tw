<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String function_sn = f.cstr(request.getParameter("function_sn")) ;
	String function_name = f.get_function_name(function_sn) ;
	String id = f.cstr(request.getParameter("id")) ;
	String table = f.cstr(request.getParameter("table")) ;
	
	String menu_collection_sn = f.cstr(request.getParameter("menu_collection_sn")) ;
	String menu_subsystem_sn = f.cstr(request.getParameter("menu_subsystem_sn")) ;
	String icon_file_name = f.cstr(request.getParameter("icon_file_name")) ;
	
	String caption = f.cstr(request.getParameter("caption")) ;
	String sort = f.cstr(f.cint(request.getParameter("sort"))) ;
	String url = f.cstr(request.getParameter("url")) ;
	String mode = f.cstr(request.getParameter("mode")) ;
	String sn = f.cstr(request.getParameter("sn")) ;
	
	Boolean limit_insert = false ;
	Boolean limit_update = false ;
	Boolean limit_delete = false ;
	if( f.limit_function( function_sn , "insert" ) ) limit_insert = true ;
	if( f.limit_function( function_sn , "update" ) ) limit_update = true ;
	if( f.limit_function( function_sn , "delete" ) ) limit_delete = true ;
	
	if( mode.equals("save") )
	{
		if( f.cint(sn) > 0 )
		{
			f.employee_log_1( function_name , "修改 " + table ) ;
		}
		else
		{
			f.employee_log_1( function_name , "新增 " + table ) ;
		}
		
		if( table.equals("menu_subsystem") )
		{
			if( f.cint(sn) > 0 ) f.execute_sql("UPDATE menu_subsystem SET caption = '"+f.sql_string(caption)+"' , sort = "+sort+" WHERE sn = " + sn ) ;
			else f.execute_sql("INSERT INTO menu_subsystem ( sn, caption , sort ) VALUES ( " + f.get_sn("menu_subsystem") + ", '"+f.sql_string(caption)+"' , "+sort+" )" ) ;
		}
		
		if( table.equals("menu_collection") )
		{
			if( f.cint(sn) > 0 ) f.execute_sql("UPDATE menu_collection SET caption = '"+f.sql_string(caption)+"' , icon_file_name = '"+f.sql_string(icon_file_name)+"' , sort = "+sort+" WHERE sn = "+sn) ;
			else f.execute_sql("INSERT INTO menu_collection ( sn, caption , icon_file_name , sort , menu_subsystem_sn ) VALUES ( " + f.get_sn("menu_collection") + ", '"+f.sql_string(caption)+"' , '"+f.sql_string(icon_file_name)+"' , "+sort+" , "+menu_subsystem_sn+" )" ) ;
		}
		
		if( table.equals("menu_function") )
		{
			if( f.cint(sn) > 0 ) f.execute_sql("UPDATE menu_function SET id = '"+f.sql_string(id)+"' , caption = '"+f.sql_string(caption)+"' , url = '"+f.sql_string(url)+"' , sort = "+sort+" WHERE sn = "+sn) ;
			else f.execute_sql("INSERT INTO menu_function ( sn, id , caption , url , sort , menu_collection_sn ) VALUES ( " + f.get_sn("menu_function") + ", '"+f.sql_string(id)+"' , '"+f.sql_string(caption)+"' , '"+f.sql_string(url)+"' , "+sort+" , "+menu_collection_sn+" )" ) ;
		}
	}
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="../fonran.css">

<script language="javascript">

	function to_delete( table , sn )
	{
		if( confirm("確定要刪除這個項目？") )
		{
			window.open("delete.jsp?function_sn=<%=function_sn%>&table=" + table + "&sn=" + sn , "_self") ;
		}
	}

</script>

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table width="100%" cellspacing="0" cellpadding="0" border="0"> 
<tr bgcolor="#808080"><td class="title2" background="../images/Title_Background.jpg"><img src="../title.gif" border="0"><font size="3" color="#000080">&nbsp;選單管理</font></td></tr>
</table>
<table width="100%">
<form method="POST" action="index.jsp" name="form1">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">
<tr>
	<td valign="top">
		<table>
			<% ResultSet menu_subsystem = f.query("SELECT sn , caption , sort FROM menu_subsystem ORDER BY sort") ; %>
			<% while( menu_subsystem.next() ) { %>
			<tr><td>
			<span style="background-color: #ff0000">
			<% if( mode.equals("edit") && table.equals("menu_subsystem") && f.cint(sn) == menu_subsystem.getInt("sn") ) { %>
			順序：<input type="text" name="sort" size="3" value="<%=f.field(menu_subsystem,"sort")%>">
			名稱：<input type="text" name="caption" size="20" value="<%=f.field(menu_subsystem,"caption")%>">
			<input type="submit" value="儲存">
			<input type="hidden" name="mode" value="save">
			<input type="hidden" name="function_sn" value="<%=function_sn%>">
			<input type="hidden" name="table" value="menu_subsystem">
			<input type="hidden" name="sn" value="<%=f.field(menu_subsystem,"sn")%>">
			<% } else { %>
			<font color="#ffffff" size=4>[<%=f.field(menu_subsystem,"sort")%>] <%=f.field(menu_subsystem,"caption")%></font></span>
			<% if( limit_update ) { %><a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_subsystem&sn=<%=f.field(menu_subsystem,"sn")%>">[修改]</a><% } %>
			<% if( limit_delete ) { %><a href="javascript:to_delete('menu_subsystem','<%=f.field(menu_subsystem,"sn")%>')">[刪除]</a><% } %>
			<% } %>
			</span>
			</td></tr>
			
				<% ResultSet menu_collection = f.query("SELECT sn , caption , icon_file_name , sort FROM menu_collection WHERE menu_subsystem_sn = " + menu_subsystem.getString("sn") + " ORDER BY sort") ; %>
				<% while( menu_collection.next() ) { %>
				<tr><td>　　
				<img src="../icon/<%=f.field(menu_collection,"icon_file_name")%>">
				<span style="background-color: #FFFF00">
				
				<% if( mode.equals("edit") && table.equals("menu_collection") && f.cint(sn) == menu_collection.getInt("sn") ) { %>
				順序：<input type="text" name="sort" size="3" value="<%=f.field(menu_collection,"sort")%>">
				圖示：<input type="text" name="icon_file_name" size="5" value="<%=f.field(menu_collection,"icon_file_name")%>">
				<input type="button" value="..." onclick="window.open('picker_icon.jsp','_blank','width=250,height=300,scrollbars=1')">
				名稱：<input type="text" name="caption" size="20" value="<%=f.field(menu_collection,"caption")%>">
				<input type="submit" value="儲存">
				<input type="hidden" name="mode" value="save">
				<input type="hidden" name="table" value="menu_collection">
				<input type="hidden" name="sn" value="<%=f.field(menu_collection,"sn")%>">
				<% } else { %>
				<font size=3>[<%=f.field(menu_collection,"sort")%>] <%=f.field(menu_collection,"caption")%></font></span>
				<% if( limit_update ) { %><a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_collection&sn=<%=f.field(menu_collection,"sn")%>">[修改]</a><% } %>
				<% if( limit_delete ) { %><a href="javascript:to_delete('menu_collection','<%=f.field(menu_collection,"sn")%>')">[刪除]</a><% } %>
				<% } %>
				</span>
				</td></tr>
				
					<% ResultSet menu_function = f.query("SELECT * FROM menu_function WHERE menu_collection_sn = " + menu_collection.getString("sn") + " ORDER BY sort") ; %>
					<% while( menu_function.next() ) { %>
					<tr><td valign="middle">　　　　<img src="bos.gif">
					<% if( mode.equals("edit") && table.equals("menu_function") && f.cint(sn) == menu_function.getInt("sn") ) { %>
					順序：<input type="text" name="sort" size="3" value="<%=f.field(menu_function,"sort")%>">
					代碼：<input type="text" name="id" size="5" value="<%=f.field(menu_function,"id")%>">
					名稱：<input type="text" name="caption" size="15" value="<%=f.field(menu_function,"caption")%>">
					網址：<input type="text" name="url" size="20" value="<%=f.field(menu_function,"url")%>">
					<input type="submit" value="儲存">
					<input type="hidden" name="mode" value="save">
					<input type="hidden" name="table" value="menu_function">
					<input type="hidden" name="sn" value="<%=f.field(menu_function,"sn")%>">
					<% } else { %>
					[<%=f.field(menu_function,"sort")%>] <%=f.field(menu_function,"id")%> - <%=f.field(menu_function,"caption")%> (<%=f.field(menu_function,"url")%>)
					<% if( limit_update ) { %><a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_function&sn=<%=f.field(menu_function,"sn")%>">[修改]</a><% } %>
					<% if( limit_delete ) { %><a href="javascript:to_delete('menu_function','<%=f.field(menu_function,"sn")%>')">[刪除]</a><% } %>
					<% } %>
					</td></tr>
					<% } %>
					<tr><td valign="middle">
					<% if( mode.equals("edit") && table.equals("menu_function") && f.cint(sn) == 0 && f.cint(menu_collection_sn) == menu_collection.getInt("sn") ) { %>
					　　　　<img src="bos.gif">
					順序：<input type="text" name="sort" size="3" value="">
					代碼：<input type="text" name="id" size="5" value="">
					名稱：<input type="text" name="caption" size="15" value="">
					網址：<input type="text" name="url" size="20" value="">
					<input type="submit" value="儲存">
					<input type="hidden" name="mode" value="save">
					<input type="hidden" name="table" value="menu_function">
					<input type="hidden" name="sn" value="0">
					<input type="hidden" name="menu_collection_sn" value="<%=menu_collection_sn%>">
					<% } else if( limit_insert ) { %>
					　　　　<img src="bos.gif">
					<a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_function&sn=0&menu_collection_sn=<%=f.field(menu_collection,"sn")%>">新增...</a>
					<% } %>
					</td></tr>
					
				<% } %>
				<tr><td>
				<% if( mode.equals("edit") && table.equals("menu_collection") && f.cint(sn) == 0 && f.cint(menu_subsystem_sn) == menu_subsystem.getInt("sn") ) { %>
				　　<img src="../icon/13.gif"><span style="background-color: #FFFF00">
				順序：<input type="text" name="sort" size="3" value="">
				圖示：<input type="text" name="icon_file_name" size="5" value="">
				<input type="button" value="..." onclick="window.open('picker_icon.jsp','_blank','width=250,height=300,scrollbars=1')">
				名稱：<input type="text" name="caption" size="20" value="">
				<input type="submit" value="儲存">
				<input type="hidden" name="mode" value="save">
				<input type="hidden" name="table" value="menu_collection">
				<input type="hidden" name="sn" value="0">
				<input type="hidden" name="menu_subsystem_sn" value="<%=menu_subsystem_sn%>">
				</span>
				<% } else if( limit_insert ) { %>
				　　<img src="../icon/13.gif"><span style="background-color: #FFFF00">
				<a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_collection&sn=0&menu_subsystem_sn=<%=f.field(menu_subsystem,"sn")%>"><font size=3>新增...</font></a>
				</span>
				<% } %>
				</td></tr>
				
			<% } %>
			<tr><td><span style="background-color: #ff0000">
			<% if( mode.equals("edit") && table.equals("menu_subsystem") && f.cint(sn) == 0 ) { %>
			順序：<input type="text" name="sort" size="3" value="">
			名稱：<input type="text" name="caption" size="20" value="">
			<input type="submit" value="儲存">
			<input type="hidden" name="mode" value="save">
			<input type="hidden" name="table" value="menu_subsystem">
			<input type="hidden" name="sn" value="0">
			<% } else if( limit_insert ) { %>
			<a href="index.jsp?mode=edit&function_sn=<%=function_sn%>&table=menu_subsystem&sn=0"><font color="#ffffff" size=4>新增...</font></a>
			<% } %>
			</span></td></tr>
		</table>
	</td>
</tr>
</form>
</table>