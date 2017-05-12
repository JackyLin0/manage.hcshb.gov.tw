<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../fonran.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
	ResultSet rs = null ;
	Integer i = 0 ;
	rs = f.query("select * from movie where sn = "+ session.getAttribute("sn") ) ;
	rs.next();
	try{     
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
		com.jspsmart.upload.File myFile = null ;
		myFile = mySmartUpload.getFiles().getFile(0);
		if( ! myFile.isMissing() )
		{
			myFile.saveAs(configure.files_path+"movie\\"+myFile.getFileName());
			rs.updateString("pic",myFile.getFileName()) ;
		}
		myFile = mySmartUpload.getFiles().getFile(1);
		if( ! myFile.isMissing() )
		{
			myFile.saveAs(configure.files_path+"movie\\"+myFile.getFileName());
			rs.updateString("file_1",myFile.getFileName()) ;
		}
		rs.updateRow() ;
	}catch(Exception e){}
%>
<script language="javascript">

	function to_save()
	{
		message = "" ;
		
		with( form1 )
		{
			if( FILE1.value == "" && FILE1_str.value == "") message += "\n☆顯示圖" ;
			//if( FILE2.value == "" && FILE2_str.value == "") message += "\n☆影音檔案" ;
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else form1.submit() ;
	}

</script>
<HTML>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<FORM name="form1" METHOD="POST" ACTION="movie_detail_sub.jsp" ENCTYPE="multipart/form-data">
<input type="hidden" name="mode" value="save">
<table tabindex="9" cellspacing="1" cellpadding="0" bordercolor="Black" border="0" id="DataGrid1" style="color:Black;border-color:Black;border-width:0px;border-style:Solid;font-family:新細明體;font-size:X-Small;height:10px;width:100%;">
	<tr style="color:White;background-color:Brown;">
		<td> 顯示圖</td>
		<td> 影音檔案</td>
		<td> 儲 存</td>
	</tr>
	<tr>		
		<td>
			<INPUT TYPE="FILE" NAME="FILE1" SIZE="20">
			<a href="<%=configure.root_path%>/files/movie/<%=f.field(rs,"pic")%>" target="_blank"><%=f.cstr(f.field(rs,"pic"))%></a>
			<INPUT TYPE="hidden" NAME="FILE1_str" value="<%=f.cstr(f.field(rs,"pic"))%>">
		</td>
		<td>
			<INPUT TYPE="FILE" NAME="FILE2" SIZE="20">
			<a href="<%=configure.root_path%>/files/movie/<%=f.field(rs,"file_1")%>" target="_blank"><%=f.cstr(f.field(rs,"file_1"))%></a>
			<INPUT TYPE="hidden" NAME="FILE2_str" value="<%=f.cstr(f.field(rs,"file_1"))%>">
		</td>	
		<td><a href="javascript:to_save()" >儲存</a></td>
	</tr>
</table>

</FORM>

</BODY>
</HTML>
