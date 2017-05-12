<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String challenge_q_sn = f.cstr(request.getParameter("challenge_q_sn")) ;
	String mode = f.cstr(request.getParameter("mode")) ;
	String function_sn = request.getParameter("function_sn") ;
	String function_name = f.get_function_name( function_sn ) ;
	Integer sn = f.cint(request.getParameter("sn")) ;
	Integer is_answer_sn = 0;
	String sql, color;
	
	Boolean allow_insert = false ;
	Boolean allow_update = false ;
	Boolean allow_delete = false ;
	if( f.limit_function( function_sn , "insert" ) ) allow_insert = true ;
	if( f.limit_function( function_sn , "update" ) ) allow_update = true ;
	if( f.limit_function( function_sn , "delete" ) ) allow_delete = true ;
	
	ResultSet rs ;
	ResultSet rs2 ;
	
	if( mode.equals("save") && ( allow_insert || allow_update ) ) // 儲存
	{
		rs = f.query("select * from challenge_a where sn = "+f.cstr(sn)) ;
		
		rs.next();
		
		if( sn == 0 && allow_insert )
		{
			f.employee_log_1( function_name , "新增明細" ) ;
			sn = f.get_sn("challenge_a") ;
			rs.moveToInsertRow() ;
		}
		else
		{
			f.employee_log_1( function_name , "修改明細" ) ;
		}
		
		rs.updateInt("sn",sn) ;
		
		if( f.cint(request.getParameter("is_answer")) == 1) 
		{
			//先將原本的答案改為否
			if(f.cint(request.getParameter("is_answer_sn")) != sn)
			{ 
				//out.print("sn="+sn.toString());
				//out.print("is_answer_sn="+f.cstr(request.getParameter("is_answer_sn")));
				f.execute_sql( "update challenge_a set is_answer = 0 where sn = "+f.cstr(request.getParameter("is_answer_sn"))) ;
			}
			rs.updateBoolean("is_answer",true) ;
		}
		else 
		{
			rs2 = f.query("select * from challenge_a where sn != " + f.cstr(sn) + " and is_answer=1 and challenge_q_sn = '"+f.sql_string(challenge_q_sn)+"'" ) ;
			if(! rs2.next() )
			rs.updateBoolean("is_answer",true) ;
			else rs.updateBoolean("is_answer",false) ;
		}
		
	 	rs.updateInt("sort",f.cint(request.getParameter("sort"))) ;
		rs.updateInt("challenge_q_sn",f.cint(challenge_q_sn)) ;
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
		rs2 = f.query("select * from challenge_a where sn != " + f.cstr(sn) + " and is_answer=1 and challenge_q_sn = '"+f.sql_string(challenge_q_sn)+"'" ) ;
		if(! rs2.next() ){out.print("<script>window.alert('不可刪除，請先設定一個解答!!')</script>");}
		else
		{
			if( f.limit_function( function_sn , "delete" ) )
			{
				f.execute_sql( "delete from challenge_a where sn = "+f.cstr(sn)) ;
			
				f.employee_log_1( function_name , "刪除明細" ) ;
			}
		}
	}
	
	sql  = "select * from challenge_a" ;
	sql += " where challenge_q_sn = '"+f.sql_string(challenge_q_sn)+"'" ;
	sql += " order by sort" ;
 
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
				if( caption.value == "" ) message += "\n☆名稱" ;
			}
			
			if( message != "" ) { window.alert( "以下欄位請勿空白：" + message ) ; ok = false ; }
		}
		
		if( mode == "delete" )
		{
			if( ! confirm("確定要刪除這筆資料？") ) ok = false ;
		}
		
		if( mode == "cancel" )
		{
			form1.submit() ;
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
	<input type="hidden" name="challenge_q_sn" value="<%=challenge_q_sn%>">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">

	<tr style="color:White;background-color:Brown;">
	
		<td align="center">是否為解答</td>
		<td align="center">排序</td>
		<td>答案</td>
		
		<% if( allow_insert || allow_update || allow_delete ) { %>
		<td align="center" width="100">修改/刪除</td>
		<% } %>
		
	</tr>
	
<% if( ! mode.equals("update") && allow_insert && f.cint(challenge_q_sn) != 0 ) { %>
	<tr onMouseOver="this.style.backgroundColor='#CCFFCC'" onMouseOut="this.style.backgroundColor='#f0f0f0'" style="background-Color:'#f0f0f0'">
		
		<td align="center"><input type="checkbox" name="is_answer" value="1"></td>
		<td align="center"><input type="text" size="4" name="sort" value=""></td>
		<td><input type="text" size="50" name="caption" value=""></td>
		
		<td align="center" width="100">[<a href="javascript:to_action('save',0)">新增</a>]</td>
	</tr>
<% } %>

<% while( rs.next() ) { %>
	<% if(rs.getBoolean("is_answer")) { is_answer_sn = rs.getInt("sn") ;} %>
	<% if( rs.getRow() % 2 == 0 ) color = "#ffffff" ; else color = "#f0f0f0" ; %>
	<tr onMouseOver="this.style.backgroundColor='#CCFFCC'" onMouseOut="this.style.backgroundColor='<%=color%>'" style="background-Color:'<%=color%>'">
		
	<% if( mode.equals("update") && sn == rs.getInt("sn") ) { %>
	
		<td align="center"><input type="checkbox" name="is_answer" value="1" <%if(rs.getBoolean("is_answer")){ out.print("checked") ; }%>></td>
		<td align="center"><input type="text" size="4" name="sort" value="<%=f.cstr(rs.getInt("sort"))%>"></td>
		<td><input type="text" size="50" name="caption" value="<%=rs.getString("caption")%>"></td>
		
		<td align="center" width="100">[<a href="javascript:to_action('save',<%=rs.getInt("sn")%>)">儲存</a>][<a href="javascript:to_action('cancel',<%=rs.getInt("sn")%>)">取消</a>]</td>
		
	<% } else { %>
		
		<td align="center"><%if(rs.getBoolean("is_answer")){out.print("○");}else{out.print("╳");}%></td>
		<td align="center"><%=f.cstr(rs.getInt("sort"))%></td>
		<td><%=rs.getString("caption")%></td>
		
		<% if( allow_insert || allow_update || allow_delete ) { %>
		<td align="center" width="100">
		<% if( allow_update ) { %>[<a href="javascript:to_action('update',<%=rs.getInt("sn")%>)">修改</a>]<% } %><% if( allow_delete ) { %>[<a href="javascript:to_action('delete',<%=rs.getInt("sn")%>)">刪除</a>]<% } %>
		</td>
		<% } %>
		
	<% } %>
		
	</tr>
<% } %>
	<input type="hidden" name="is_answer_sn" value="<%=is_answer_sn%>">
</table>
<br>
</form>