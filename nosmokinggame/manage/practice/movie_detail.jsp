<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%@ include file="../library.jsp" %>
<%
	
	String function_sn = request.getParameter("function_sn") ;
	//String function_name = f.get_function_name(function_sn) ;
	String function_name = "影片管理" ;
	ResultSet rs = null ;
	Integer sn = 0 ;
	Integer i ;
	String message = "" ;
	String sql ;
	Integer count = 0 ; 
	Boolean show_save ;
	Boolean allow_insert = false ;
	Boolean allow_update = false ;
	Boolean allow_delete = false ;
	if( f.limit_function( function_sn , "insert" ) ) allow_insert = true ;
	if( f.limit_function( function_sn , "update" ) ) allow_update = true ;
	if( f.limit_function( function_sn , "delete" ) ) allow_delete = true ;
	
	if( f.cint(request.getParameter("sn")) == 0 && allow_insert )
	{
		f.employee_log_1( function_name , "新增" ) ;
		rs = f.query("select * from movie where sn = 0") ;
		rs.moveToInsertRow() ;
		sn = f.get_sn("movie") ;
		rs.updateInt("sn",sn) ;
		rs.updateString("practice_sn",request.getParameter("practice_sn")) ;
		rs.updateString("caption","") ;
		//rs.updateString("content","") ;
		rs.updateString("update_user",(String)session.getAttribute("session_update_user")) ;
		rs.updateString("link","") ;
		rs.updateDate("update_time",f.sql_date()) ;
		rs.insertRow() ;
		rs.first() ;
	}
	else
	{
		sn = f.cint(request.getParameter("sn")) ;
	}
	session.setAttribute("sn" , sn) ;
	
	rs = f.query("select * from movie where sn = "+String.valueOf(sn)) ;
	
	rs.next();
	if( f.cstr(request.getParameter("mode")).equals("save") && ( allow_insert || allow_update ) )
	{
		f.employee_log_1( function_name , "修改" ) ;
		rs.updateInt("sn",sn) ;
		rs.updateString("practice_sn",request.getParameter("practice_sn")) ;
		rs.updateString("caption",request.getParameter("caption")) ;
		//rs.updateString("content",request.getParameter("content")) ;
		//rs.updateString("pic",request.getParameter("pic")) ;
		//rs.updateString("file_1",request.getParameter("file_1")) ;
		rs.updateString("link",request.getParameter("link")) ;
		rs.updateString("update_user",(String)session.getAttribute("session_update_user")) ;
		rs.updateDate("update_time",f.sql_date()) ;
		rs.updateRow() ;
		
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
			if( caption.value == "" ) message += "\n☆名稱" ;
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else form1.submit() ;
	}
	
	function to_index()
	{
		form1.sn.value = form1.practice_sn.value ;
		form1.action = "movie_index.jsp" ;
		form1.submit() ;
	}

</script>

</HEAD>
<form name="form1" method="post" action="movie_detail.jsp">
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
	<input type="hidden" name="practice_sn" value="<%=request.getParameter("practice_sn")%>">
	<input type="hidden" name="issue_code" value="<%=request.getParameter("issue_code")%>">
	
	<tr>
		<td width="100"><font color="red">*</font>名稱：</td>
		<td><input type="text" name="caption" size="30" value="<%=f.field(rs,"caption")%>"></td>
	</tr>
	
	<tr>
		<td width="100" rowspsn="2">相關檔案：</td>
		<td>
			<iframe src="movie_detail_sub.jsp?sn="<%=sn%>" width="600" height="70"></iframe>
		</td>
	</tr>
	<tr>
		<td width="100">影片連結：</td>
		<td><input type="text" name="link" size="70" value="<%=f.field(rs,"link")%>"></td>
	</tr>

</form>
</table>
</center>