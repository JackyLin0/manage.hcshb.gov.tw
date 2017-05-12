<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String function_sn = request.getParameter("function_sn") ;
	String function_name = f.get_function_name( function_sn ) ;
	Integer sn = f.cint(request.getParameter("sn")) ;
	Integer i ;
	String message = "" ;
	String sql ;
	
	Boolean show_save ;
	Boolean allow_insert = false ;
	Boolean allow_update = false ;
	Boolean allow_delete = false ;
	if( f.limit_function( function_sn , "insert" ) ) allow_insert = true ;
	if( f.limit_function( function_sn , "update" ) ) allow_update = true ;
	if( f.limit_function( function_sn , "delete" ) ) allow_delete = true ;
	
	ResultSet rs = f.query("select * from limit_group where sn = "+String.valueOf(sn)) ;
	
	rs.next();
	
	if( f.cstr(request.getParameter("mode")).equals("save") && ( allow_insert || allow_update ) )
	{
		if( f.cint(request.getParameter("sn")) == 0 && allow_insert )
		{
			f.employee_log_1( function_name , "新增" ) ;
			
			rs.moveToInsertRow() ;
			sn = f.get_sn("limit_group") ;
		}
		else
		{
			f.employee_log_1( function_name , "修改" ) ;
		}
		
		rs.updateInt("sn",sn) ;
		
		rs.updateString("caption",request.getParameter("caption")) ;
		
		rs.updateString("update_user",(String)session.getAttribute("session_update_user")) ;
		rs.updateDate("update_time",f.sql_date()) ;
		
		if( f.cint(request.getParameter("sn")) == 0 )
		{
			rs.insertRow() ;
			rs.first() ;
		}
		else rs.updateRow() ;
		
		String[] menu_subsystem_sn = request.getParameterValues("menu_subsystem_sn") ;
		String[] menu_collection_sn = request.getParameterValues("menu_collection_sn") ;
		String[] menu_function_sn = request.getParameterValues("menu_function_sn") ;
		String[] insert = request.getParameterValues("insert") ;
		String[] update = request.getParameterValues("update") ;
		String[] delete = request.getParameterValues("delete") ;
		
		// 儲存權限設定
		
		f.execute_sql("delete from limit_menu where limit_group_sn = "+String.valueOf(sn)) ;
		if( menu_subsystem_sn != null ) for( i = 0 ; i < menu_subsystem_sn.length ; i++ ) f.execute_sql("insert into limit_menu ( sn, menu_type , menu_sn , limit_group_sn ) values ( " + f.get_sn("limit_menu") + ", 'menu_subsystem' , "+menu_subsystem_sn[i]+" , "+f.cstr(sn)+" )") ;
		if( menu_collection_sn != null ) for( i = 0 ; i < menu_collection_sn.length ; i++ ) f.execute_sql("insert into limit_menu ( sn, menu_type , menu_sn , limit_group_sn ) values ( " + f.get_sn("limit_menu") + ", 'menu_collection' , "+menu_collection_sn[i]+" , "+f.cstr(sn)+" )") ;
		if( menu_function_sn != null ) for( i = 0 ; i < menu_function_sn.length ; i++ ) f.execute_sql("insert into limit_menu ( sn, menu_type , menu_sn , limit_group_sn ) values ( " + f.get_sn("limit_menu") + ", 'menu_function' , "+menu_function_sn[i]+" , "+f.cstr(sn)+" )") ;
		f.execute_sql("delete from limit_function where limit_group_sn = "+String.valueOf(sn)) ;
		if( insert != null ) for( i = 0 ; i < insert.length ; i++ ) f.execute_sql("insert into limit_function ( sn, limit_type , function_sn , limit_group_sn ) values ( " + f.get_sn("limit_function") + ", 'insert' , '"+insert[i]+"' , "+f.cstr(sn)+" )") ;
		if( update != null ) for( i = 0 ; i < update.length ; i++ ) f.execute_sql("insert into limit_function ( sn, limit_type , function_sn , limit_group_sn ) values ( " + f.get_sn("limit_function") + ", 'update' , '"+update[i]+"' , "+f.cstr(sn)+" )") ;
		if( delete != null ) for( i = 0 ; i < delete.length ; i++ ) f.execute_sql("insert into limit_function ( sn, limit_type , function_sn , limit_group_sn ) values ( " + f.get_sn("limit_function") + ", 'delete' , '"+delete[i]+"' , "+f.cstr(sn)+" )") ;
		
		message = "儲存完畢" ;
	}
	
	show_save = false ;
	if( sn == 0 && allow_insert ) show_save = true ;
	if( sn != 0 && allow_update ) show_save = true ;
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<link rel=stylesheet type="text/css" href="../fonran.css">

<script language="javascript">

	function to_save()
	{
		message = "" ;
		
		with( form1 )
		{
			if( caption.value == "" ) message += "\n☆群組名稱" ;
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else form1.submit() ;
	}
	
	function to_index()
	{
		form1.action = "index.jsp" ;
		form1.submit() ;
	}
	
	function limit_menu_all( obj )
	{
		for( i = 0 ; i < document.form1.elements.length ; i ++ )
		{
			if( document.form1.elements[i].type == "checkbox" ) document.form1.elements[i].checked = obj.checked ;
		}
	}

</script>

</HEAD>
<form name="form1" method="post" action="detail.jsp">
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table width="100%" cellspacing="0" cellpadding="0" border="0"> 
<tr bgcolor="#808080"><td class="title2" background="../images/Title_Background.jpg"><img src="../title.gif" border="0"><font size="3" color="#000080">&nbsp;<%=function_name%></font></td></tr>
<tr bgcolor="#808080"><td class="title2" background="../images/Title_Background.jpg">
<% if( show_save ) { %><a href="javascript:to_save()"><img src="../images/Save_1.gif" align="absMiddle" border="0"></a><% } %>
<a href="javascript:to_index()"><img src="../images/Return_1.gif" align="absMiddle" border="0"></a>
<% if( message != "" ) { %><font color="Red"><%=message%></font><% } %>
</td></tr>
</table>
<table width="100%" cellspacing="0" cellpadding="2" border="1" align="center">

	<input type="hidden" name="mode" value="save">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">
	<input type="hidden" name="keyword" value="<%=request.getParameter("keyword")%>">
	<input type="hidden" name="page" value="<%=request.getParameter("page")%>">
	<input type="hidden" name="sn" value="<%=sn%>">
	
	<tr>
		<td width="70">群組名稱：</td>
		<td><input type="text" name="caption" size="30" value="<%=f.field(rs,"caption")%>"></td>
	</tr>
	
	<tr>
		<td width="70" valign="top">選單權限：</td>
		<td>
		<input type=checkbox onclick="limit_menu_all(this)"> 全部<br>
		<% ResultSet menu_subsystem = f.query("select menu_subsystem.* , isnull(limit_menu.sn,0) as is_limit from menu_subsystem left join limit_menu on menu_subsystem.sn = limit_menu.menu_sn and limit_menu.menu_type = 'menu_subsystem' and limit_menu.limit_group_sn = "+f.cstr(sn)) ; %>
		<% while( menu_subsystem.next() ) { %>
		<input type="checkbox" name="menu_subsystem_sn" value="<%=menu_subsystem.getInt("sn")%>" <% if( menu_subsystem.getInt("is_limit") != 0 ) out.print("checked"); %>> <%=menu_subsystem.getString("caption")%><br>
			<% ResultSet menu_collection = f.query("select menu_collection.* , isnull(limit_menu.sn,0) as is_limit from menu_collection left join limit_menu on menu_collection.sn = limit_menu.menu_sn and limit_menu.menu_type = 'menu_collection' and limit_menu.limit_group_sn = "+f.cstr(sn)+" where menu_subsystem_sn = " + menu_subsystem.getString("sn") ) ; %>
			<% while( menu_collection.next() ) { %>　　
			<input type="checkbox" name="menu_collection_sn" value="<%=menu_collection.getInt("sn")%>" <% if( menu_collection.getInt("is_limit") != 0 ) out.print("checked"); %>> <%=menu_collection.getString("caption")%><br>
				<%
					sql = "select menu_function.* , isnull(limit_menu.sn,0) as is_limit , isnull(a.sn,0) as is_insert , isnull(b.sn,0) as is_update , isnull(c.sn,0) as is_delete" ;
					sql += " from menu_function" ;
					sql += " left join limit_menu on menu_function.sn = limit_menu.menu_sn and limit_menu.menu_type = 'menu_function' and limit_menu.limit_group_sn = "+f.cstr(sn) ;
					sql += " left join limit_function AS a on menu_function.sn = a.function_sn and a.limit_type = 'insert' and a.limit_group_sn = "+f.cstr(sn) ;
					sql += " left join limit_function AS b on menu_function.sn = b.function_sn and b.limit_type = 'update' and b.limit_group_sn = "+f.cstr(sn) ;
					sql += " left join limit_function AS c on menu_function.sn = c.function_sn and c.limit_type = 'delete' and c.limit_group_sn = "+f.cstr(sn) ;
					sql += " where menu_collection_sn = " + menu_collection.getString("sn") ;
					ResultSet menu_function = f.query( sql ) ;
				%>
				<% while( menu_function.next() ) { %>　　　　
				<input type="checkbox" name="menu_function_sn" value="<%=menu_function.getInt("sn")%>" <% if( menu_function.getInt("is_limit") != 0 ) out.print("checked"); %>>
				<%=menu_function.getString("caption")%>
				(<input type="checkbox" name="insert" value="<%=menu_function.getInt("sn")%>" <% if( menu_function.getInt("is_insert") != 0 ) out.print("checked"); %>>新增
				 <input type="checkbox" name="update" value="<%=menu_function.getInt("sn")%>" <% if( menu_function.getInt("is_update") != 0 ) out.print("checked"); %>>修改
				 <input type="checkbox" name="delete" value="<%=menu_function.getInt("sn")%>" <% if( menu_function.getInt("is_delete") != 0 ) out.print("checked"); %>>刪除)<br>
				<% } %>
			<% } %>
		<% } %>
		</td>
	</tr>

</form>
</table>
</center>