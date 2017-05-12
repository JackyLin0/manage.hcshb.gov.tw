<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../library.jsp" %>
<%
	String function_sn = request.getParameter("function_sn") ;
	String function_name = f.get_function_name(function_sn) ;
	String keyword = f.cstr(request.getParameter("keyword")) ;
	String sn_list, sql, color ;
	Integer i, current_page, page_start ;
	
	sql = "select *" ;
	sql += " from school" ;
	sql += " where caption      like '%"+keyword+"%'" ;
	sql += " order by sn" ;
	
	if( f.cstr(request.getParameter("mode")).equals("delete") ) // 刪除
	{
		if( f.limit_function( function_sn , "delete" ) )
		{
			String[] select_sn = request.getParameterValues("select_sn") ;
			sn_list = "0" ;
			for( i = 0 ; i < select_sn.length ; i++ )  sn_list += "," + select_sn[i] ;
			f.execute_sql( "delete from school where sn in("+sn_list+")" ) ;
			
			f.employee_log_1( function_name , "刪除" ) ;
		}
	}
	
	// 請勿變更
	// ***********************************************************
	ResultSet rs = f.query(sql) ;
	rs.last() ;
	Integer record_count = rs.getRow() ;
	rs.beforeFirst() ;
	Integer page_size = Integer.valueOf(f.get_parameter("page_size")) ;
	Integer page_count = record_count / page_size ;
	if( record_count % page_size > 0 ) page_count ++ ;

	if( request.getParameter("page") == null ) current_page = 1 ; else current_page = f.cint(request.getParameter("page")) ;
	if( request.getParameter("page1") != null ) current_page = f.cint(request.getParameter("page1")) ;
	if( current_page < 1 ) current_page = 1 ;
	if( current_page > page_count ) current_page = page_count ;

	page_start = ( current_page - 1 ) * page_size ;
	if( page_start < 0 ) page_start = 0 ;
	rs.absolute(page_start) ;
	// ***********************************************************
	// 請勿變更
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">

<link rel=stylesheet type="text/css" href="../fonran.css">

<script language="javascript">

	function to_delete()
	{
		with( document.form1 )
		{
			var OK = false ;
			
			for( i = 0 ; i < elements.length ; i ++ ) if( elements[i].name == "select_sn" ) if( elements[i].checked ) OK = true ;
			
			if( OK )
			{
				if( confirm("確定要刪除選取的項目？") )
				{
					mode.value = "delete" ;
					submit() ;
				}
			}
			else window.alert("請勾選要刪除的項目") ;
		}
	}
	
	function to_detail( sn )
	{
		window.form1.action = "detail.jsp" ;
		window.form1.sn.value = sn ;
		window.form1.submit() ;
	}
	
	function CheckAll( check )
	{
		with( document.form1 )
		{
			for( i = 0 ; i < elements.length ; i ++ )
				if( elements[i].name == "select_sn" ) elements[i].checked = check ;
		}
	}
	
	function to_change_page(page)
	{
		form1.page1.value = page;
		form1.submit();
	}

</script>

</HEAD>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<center>
<table width="100%" cellspacing="0" cellpadding="0" border="0"> 
<form method="post" action="index.jsp" name="form1">
	<input type="hidden" name="mode" value="">
	<input type="hidden" name="sn" value="">
	<input type="hidden" name="page1" value="">
	<input type="hidden" name="function_sn" value="<%=function_sn%>">
<tr bgcolor="#808080"><td class="title2" background="../images/Title_Background.jpg"><img src="../title.gif" border="0"><font size="3" color="#000080">&nbsp;<%=function_name%></font></td></tr>
<tr bgcolor="#808080"><td class="title2" background="../images/Title_Background.jpg">
<% if( f.limit_function( function_sn , "insert" ) ) { %><a href="javascript:to_detail(0)"><img src="../images/New_1.gif" align="absMiddle" border="0"></a><% } %>
<img src="../images/Line.gif" align="absMiddle">
<input type="text" name="keyword" size="15" value="<%=keyword%>"> <input type="submit" value="查詢">
<%if( current_page > 1){%><a href="javascript:to_change_page(<%=(current_page-1)%>)">上一頁</a> <%}%>
第<select name="page" onchange="form1.submit()"><% for( i = 1 ; i <= page_count ; i ++ ) { %><option <% if( current_page == i ) out.print("selected") ; %>><%=i%></option><% } %></select>頁
<%if( current_page !=  page_count){%> <a href="javascript:to_change_page(<%=(current_page+1)%>)">下一頁</a><%}%>
<img src="../images/Line.gif" align="absMiddle">
<a href="javascript:CheckAll(true)"><img src="../images/AllCheck_1.gif" align="absMiddle" border="0"></a>
<a href="javascript:CheckAll(false)"><img src="../images/AllCancel_1.gif" align="absMiddle" border="0"></a>
<% if( f.limit_function( function_sn , "delete" ) ) { %><a href="javascript:to_delete()"><img src="../images/Delete_1.gif" align="absMiddle" border="0"></a><% } %>
<img src="../images/Line.gif" align="absMiddle">
共 <font color="Red"><%=record_count%></font> 筆資料
</td></tr>
</table>
<table tabindex="9" cellspacing="1" cellpadding="0" bordercolor="Black" border="0" id="DataGrid1" style="color:Black;border-color:Black;border-width:0px;border-style:Solid;font-family:新細明體;font-size:X-Small;height:10px;width:100%;">
	<tr style="color:White;background-color:Brown;">
		<td align="Center" style="width:30px;">選取</td>
		
		<td>鄉鎮</td>
		<td>學校名稱</td>
		<td>電話1</td>
		<td>電話2</td>
		<td>傳真</td>
		
	</tr>
<% for( i = 0 ; i < page_size ; i ++ ) { if( ! rs.next() ) break ; %>
	<% if( rs.getRow() % 2 == 0 ) color = "#ffffff" ; else color = "#f0f0f0" ; %>
	<tr onClick="to_detail(<%=rs.getInt("sn")%>)" onMouseOver="this.style.backgroundColor='#CCFFCC'" onMouseOut="this.style.backgroundColor='<%=color%>'" style="cursor: hand ; background-Color:'<%=color%>'">
		<td align="Center" onClick="window.event.cancelBubble=true" style="width:30px;"><input name="select_sn" type="checkbox" value="<%=rs.getInt("sn")%>"></td>
		
		<td><%=f.get_code("area_2",rs.getString("area_2_code"))%></td>
		<td><%=rs.getString("caption")%></td>
		<td><%=rs.getString("tel_1")%></td>
		<td><%=rs.getString("tel_2")%></td>
		<td><%=rs.getString("fax")%></td>
		
	</tr>
<% } %>
</table>
</form>