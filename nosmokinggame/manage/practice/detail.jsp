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
	
	String issue_code_str = "" ;
	if(request.getParameter("issue_code") == null )
	{
		issue_code_str = "01" ;
	}else{
		issue_code_str = request.getParameter("issue_code") ;
	}
	
	ResultSet rs = f.query("select * from practice where issue_code = '" + issue_code_str + "'") ;
	
	rs.next();
	
	if( f.cstr(request.getParameter("mode")).equals("save") && ( allow_insert || allow_update ) )
	{
		if( f.cint(request.getParameter("sn")) == 0 && allow_insert )
		{
			f.employee_log_1( function_name , "新增" ) ;
			
			rs.moveToInsertRow() ;
			sn = f.get_sn("practice") ;
		}
		else
		{
			f.employee_log_1( function_name , "修改" ) ;
		}
		
		rs.updateInt("sn",sn) ;
		
		rs.updateString("issue_code",request.getParameter("issue_code")) ;
		rs.updateString("content",request.getParameter("content")) ;
		rs.updateString("source",request.getParameter("source")) ;
		
		rs.updateString("update_user",(String)session.getAttribute("session_update_user")) ;
		rs.updateDate("update_time",f.sql_date()) ;
		
		if( f.cint(request.getParameter("sn")) == 0 )
		{
			rs.insertRow() ;
			rs.first() ;
		}
		else rs.updateRow() ;
		
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
			if( content.value == "" ) message += "\n☆內容" ;
			if( source.value == "" ) message += "\n☆資料來源" ;
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else form1.submit() ;
	}
	
	function change_practice()
	{
		form1.mode.value = "" ;
		form1.submit() ;
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
<% if( f.field(rs,"sn") != "0" ) { %>
<a href="movie_index.jsp?sn=<%=f.field(rs,"sn")%>&function_sn=<%=function_sn%>&issue_code=<%=issue_code_str%>">影片管理</a> 
<a href="game_index.jsp?sn=<%=f.field(rs,"sn")%>&function_sn=<%=function_sn%>&issue_code=<%=issue_code_str%>">遊戲管理</a>
<% } %>
<% if( message != "" ) { %><font color="Red"><%=message%></font><% } %>
</td></tr>
</table>
<table width="100%" cellspacing="0" cellpadding="2" border="1" align="center">

	<input type="hidden" name="mode" value="save">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">
	<input type="hidden" name="sn" value="<%=f.field(rs,"sn")%>">
	
	<tr>
		<td width="70">類型：</td>
		<td colspan="3"><%=f.select_code("issue_code","issue",issue_code_str, false ,"").replaceAll("<select ","<select onchange='change_practice();'")%></td>
	</tr>
	
	<tr>
		<td valign="top"><font color="red">*</font>內容：</td>
		<td colspan="3"><textarea name="content" cols=100 rows=20><%=f.field(rs,"content").replaceAll("<", "&lt;") %></textarea></td>
	</tr>
	
	<tr>
		<td valign="top"><font color="red">*</font>資料來源：</td>
		<td colspan="3"><input name="source" value="<%=f.field(rs,"source")%>" style="width:600px;" ></input></td>
	</tr>
</form>
</table>
</center>