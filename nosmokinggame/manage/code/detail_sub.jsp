<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String code_type_sn = f.cstr(request.getParameter("code_type_sn")) ;
	String mode = f.cstr(request.getParameter("mode")) ;
	String function_sn = request.getParameter("function_sn") ;
	String function_name = f.get_function_name( function_sn ) ;
	Integer sn = f.cint(request.getParameter("sn")) ;
	String sql, color;
	
	Boolean allow_insert = false ;
	Boolean allow_update = false ;
	Boolean allow_delete = false ;
	if( f.limit_function( function_sn , "insert" ) ) allow_insert = true ;
	if( f.limit_function( function_sn , "update" ) ) allow_update = true ;
	if( f.limit_function( function_sn , "delete" ) ) allow_delete = true ;
	
	ResultSet rs ;
	
	if( mode.equals("save") && ( allow_insert || allow_update ) ) // 儲存
	{
		rs = f.query("select * from code where sn = "+f.cstr(sn)) ;
		
		rs.next();
		
		if( sn == 0 && allow_insert )
		{
			f.employee_log_1( function_name , "新增明細" ) ;
			sn = f.get_sn("code") ;
			rs.moveToInsertRow() ;
		}
		else
		{
			f.employee_log_1( function_name , "修改明細" ) ;
		}
		
		rs.updateInt("sn",sn) ;
		
		if( f.cint(request.getParameter("is_show")) == 1) rs.updateBoolean("is_show",true) ;
		else rs.updateBoolean("is_show",false) ;
	 
		rs.updateString("id",request.getParameter("id")) ;
		rs.updateInt("code_type_sn",f.cint(code_type_sn)) ;
		rs.updateString("caption",request.getParameter("caption")) ;
		
		rs.updateString("update_user",(String)session.getAttribute("session_update_user")) ;
		rs.updateDate("update_time",f.sql_date()) ;
		
		if( f.cint(request.getParameter("sn")) == 0 )
		{
			rs.insertRow() ;
			rs.first() ;
		}
		else rs.updateRow() ;
	}
	
	if( mode.equals("delete") && allow_delete ) // 刪除
	{
		if( f.limit_function( function_sn , "delete" ) )
		{
			f.execute_sql( "delete from code where sn = "+f.cstr(sn)) ;
			
			f.employee_log_1( function_name , "刪除明細" ) ;
		}
	}
	
	sql  = "select * from code" ;
	sql += " where code_type_sn = '"+f.sql_string(code_type_sn)+"'" ;
	sql += " order by id" ;
 
	rs = f.query(sql) ;
	
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="../fonran.css">

<script language="javascript">

	function to_action( mode , sn )
	{
		ok = true ;
		
		if( mode == "save" )
		{
			message = "" ;
		
			with( form1 )
			{
				if( id.value == "" ) message += "\n☆代碼" ;
				if( caption.value == "" ) message += "\n☆名稱" ;
			}
			
			if( message != "" ) { window.alert( "以下欄位請勿空白：" + message ) ; ok = false ; }
		}
		
		if( mode == "delete" )
		{
			if( ! confirm("確定要刪除這筆資料？") ) ok = false ;
		}

		if( ok )
		{
			form1.mode.value = mode ;
			form1.sn.value = sn ;
			form1.submit() ;
		}
	}

</script>

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table tabindex="9" cellspacing="1" cellpadding="0" bordercolor="Black" border="0" id="DataGrid1" style="color:Black;border-color:Black;border-width:0px;border-style:Solid;font-family:新細明體;font-size:X-Small;height:10px;width:100%;">

<form method="post" name="form1">

	<input type="hidden" name="mode" value="">
	<input type="hidden" name="sn" value="">
	<input type="hidden" name="code_type_sn" value="<%=code_type_sn%>">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">

	<tr style="color:White;background-color:Brown;">
		
		<td align="center">顯示</td>
		<td>代碼</td>
		<td>名稱</td>
		
		<% if( allow_insert || allow_update || allow_delete ) { %>
		<td align="center" width="100">修改/刪除</td>
		<% } %>
		
	</tr>
	
<% if( ! mode.equals("update") && allow_insert && f.cint(code_type_sn) != 0 ) { %>
	<tr onMouseOver="this.style.backgroundColor='#CCFFCC'" onMouseOut="this.style.backgroundColor='#f0f0f0'" style="background-Color:'#f0f0f0'">
		
		<td align="center"><input type="checkbox" name="is_show" value="1" checked></td>
		<td><input type="text" size="5" name="id" value=""></td>
		<td><input type="text" size="20" name="caption" value=""></td>
		
		<td align="center" width="100">[<a href="javascript:to_action('save',0)">新增</a>]</td>
	</tr>
<% } %>

<% while( rs.next() ) { %>
	<% if( rs.getRow() % 2 == 0 ) color = "#ffffff" ; else color = "#f0f0f0" ; %>
	<tr onMouseOver="this.style.backgroundColor='#CCFFCC'" onMouseOut="this.style.backgroundColor='<%=color%>'" style="background-Color:'<%=color%>'">
		
	<% if( mode.equals("update") && sn == rs.getInt("sn") ) { %>
	
		<td align="center"><input type="checkbox" name="is_show" value="1" <%if(rs.getBoolean("is_show")){ out.print("checked") ; }%>></td>
		<td><input type="text" size="5" name="id" value="<%=rs.getString("id")%>"></td>
		<td><input type="text" size="20" name="caption" value="<%=rs.getString("caption")%>"></td>
		
		<td align="center" width="100">[<a href="javascript:to_action('save',<%=rs.getInt("sn")%>)">儲存</a>]</td>
		
	<% } else { %>
		
		<td align="center"><%if(rs.getBoolean("is_show")){out.print("○");}else{out.print("╳");}%></td>
		<td><%=rs.getString("id")%></td>
		<td><%=rs.getString("caption")%></td>
		
		<% if( allow_insert || allow_update || allow_delete ) { %>
		<td align="center" width="100">
		<% if( allow_update ) { %>[<a href="javascript:to_action('update',<%=rs.getInt("sn")%>)">修改</a>]<% } %><% if( allow_delete ) { %>[<a href="javascript:to_action('delete',<%=rs.getInt("sn")%>)">刪除</a>]<% } %>
		</td>
		<% } %>
		
	<% } %>
		
	</tr>
<% } %>
	
</table>
<br>
</form>