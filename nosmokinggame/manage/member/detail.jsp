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
	
	ResultSet rs = f.query("select * from member where sn = "+String.valueOf(sn)) ;
	
	rs.next();
	
	if( f.cstr(request.getParameter("mode")).equals("save") && ( allow_insert || allow_update ) )
	{
		if( f.cint(request.getParameter("sn")) == 0 && allow_insert )
		{
			f.employee_log_1( function_name , "新增" ) ;
			
			rs.moveToInsertRow() ;
			sn = f.get_sn("member") ;
			rs.updateInt("issue_score1",0) ;
			//rs.updateInt("issue_score2",0) ;
			//rs.updateInt("issue_score3",0) ;
			//rs.updateInt("issue_score4",0) ;
			rs.updateInt("is_update",0) ;
		}
		else
		{
			f.employee_log_1( function_name , "修改" ) ;
		}
		
		rs.updateInt("sn",sn) ;
		
		rs.updateString("name",request.getParameter("name")) ;
		rs.updateString("school_sn",request.getParameter("school_sn")) ;
		rs.updateString("year_code",request.getParameter("year_code")) ;
		rs.updateString("id",request.getParameter("id")) ;
		rs.updateString("pwd",request.getParameter("pwd")) ;
		rs.updateString("birthday",request.getParameter("birthday")) ;
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
<script language="javascript" src="../../fonran.js"></script>
<script language="javascript">

	function isDateString(sDate)
	{ 
		var iaMonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]
		var iaDate = new Array(3)
		var year, month, day
		
		if (arguments.length != 1) return false
		iaDate = sDate.toString().split("/")
		if (iaDate.length != 3) return false
		if (iaDate[1].length > 2 || iaDate[2].length > 2) return false
		
		year = parseFloat(iaDate[0])
		month = parseFloat(iaDate[1])
		day=parseFloat(iaDate[2])
		
		if (year < 1930 || year > <%=new SimpleDateFormat("yyyy").format(new Date())%>) return false
		if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1]=29;
		if (month < 1 || month > 12) return false
		if (day < 1 || day > iaMonthDays[month - 1]) return false
		return true
	}
	
	function to_save()
	{
		message = "" ;
		message2 = "" ;
		with( form1 )
		{
			if( name.value == "" ) message += "\n☆姓名" ;
			if( id.value == "" ) message += "\n☆帳號" ;
			if( pwd.value == "" ) message += "\n☆密碼" ;
			if( birthday.value == "" ) message += "\n☆出生日期" ;
			//if( indo.value == "" ) message += "\n☆身份證字號" ;
			//if( email.value == "" ) message += "\n☆Email" ;
			
			/*
			str = email.value ;
			email_error = "true";
			atPos = str.indexOf("@",1)
			if (atPos == -1) 
	        {email_error = "false";}
	        else
	        { 	if (str.indexOf("@",atPos+1) != -1) 
	   			{email_error = "false";}
	   			else
	   			{	
	   				periodPos = str.indexOf(".",atPos);
		    		if (periodPos == -1){email_error = "false";}else{email_error = "true";}
		    	}
		    	invalidChars = " /:,;"
	        	for (i=0; i<invalidChars.length; i++)
	        	{	
	        		badChar = invalidChars.charAt(i);
	            	if (str.indexOf(badChar,0) != -1){email_error = "false";}else{email_error = "true";}
	            }
	         }
	        if( email.value != "" && email_error == "false") message2 +="\n☆電子郵件號"; */
		    if( birthday.value != "" && !isDateString(birthday.value)) message2 +="\n☆出生日期";
			//if( CheckPID(indo.value) != "正確" ) message2 +="\n☆身份證字號";
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else if( message2 != "" ) window.alert( "以下欄位格式錯誤：" + message2 ) ;
		else form1.submit() ;
	}
	
	function to_index()
	{
		form1.action = "index.jsp" ;
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
		<td width="80"><font color="red">*</font>姓名：</td>
		<td><input type="text" name="name" size="30" value="<%=f.field(rs,"name")%>"></td>
	</tr>
	<tr>
		<td width="80"><font color="red">*</font>學校：</td>
		<td><%=f.select_sn("school_sn","school","caption",f.cint(f.field(rs,"school_sn")))%></td>
	</tr>
	<tr>
		<td width="80"><font color="red">*</font>年級：</td>
		<td><%=f.select_code("year_code","year",f.cstr(f.field(rs,"year_code")),false,"")%></td>
	</tr>
	<tr>
		<td width="80"><font color="red">*</font>帳號：</td>
		<td><input type="text" name="id" size="30" value="<%=f.field(rs,"id")%>"></td>
	</tr>
	<tr>
		<td width="80"><font color="red">*</font>密碼：</td>
		<td><input type="password" name="pwd" size="30" value="<%=f.field(rs,"pwd")%>"></td>
	</tr>
	<tr>
		<td width="80">出生日期：</td>
		<td><%=f.date_picker("birthday",f.cdate(f.field(rs,"birthday"),"yyyy/MM/dd"))%></td>
	</tr>
	<!--tr>
		<td width="80"><%=f.get_code("issue","01")%>：</td>
		<td><%if(f.field(rs,"issue_score1")==""){out.print("&nbsp;");}else{out.print(f.field(rs,"issue_score1") + " 分");}%></td>
	</tr>
	<tr>
		<td width="80"><%=f.get_code("issue","02")%>：</td>
		<td><%if(f.field(rs,"issue_score2")==""){out.print("&nbsp;");}else{out.print(f.field(rs,"issue_score2") + " 分");}%></td>
	</tr>
	<tr>
		<td width="80"><%=f.get_code("issue","03")%>：</td>
		<td><%if(f.field(rs,"issue_score3")==""){out.print("&nbsp;");}else{out.print(f.field(rs,"issue_score3") + " 分");}%></td>
	</tr>
	<tr>
		<td width="80"><%=f.get_code("issue","04")%>：</td>
		<td><%if(f.field(rs,"issue_score4")==""){out.print("&nbsp;");}else{out.print(f.field(rs,"issue_score4") + " 分");}%></td>
	</tr-->
	<tr>
		<td width="80">總分：</td>
		<td><%if(f.field(rs,"issue_score1")==""){out.print("&nbsp;");}else{out.print(f.field(rs,"issue_score1") + " 分");}%></td>
	</tr>
</form>
</table>
</center>