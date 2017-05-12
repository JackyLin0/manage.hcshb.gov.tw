<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../fonran.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
	ResultSet rs = null ;
	Integer i = 0 ;
	rs = f.query("select * from challenge_q where sn = "+ session.getAttribute("sn3") ) ;
	//out.print(session.getAttribute("sn2"));
	
	rs.next();
	try{  
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
		if( f.cstr(mySmartUpload.getRequest().getParameter("mode")).equals("save"))
		{   
			com.jspsmart.upload.File myFile = null ;
			myFile = mySmartUpload.getFiles().getFile(0);
			if( ! myFile.isMissing() )
			{
				
				myFile.saveAs(configure.files_path+"challenge\\"+myFile.getFileName());
				rs.updateString("pic",myFile.getFileName()) ;
			}
			rs.updateString("place_code",mySmartUpload.getRequest().getParameter("place_code")) ;
			rs.updateRow() ;
		}
		if( f.cstr(mySmartUpload.getRequest().getParameter("mode")).equals("delete"))
		{
			rs.updateString("pic","") ;
			rs.updateRow() ;
		}
		
	}catch(Exception e){}
%>
<script language="javascript">

	function to_save()
	{
		message = "" ;
		
		with( form1 )
		{
			if( pic.value == "" && pic_str.value == "") message += "\n☆圖形" ;
		}
		
		if( message != "" ) window.alert( "以下欄位請勿空白：" + message ) ;
		else form1.submit() ;
	}
	function to_delete()
	{
		form1.mode.value = "delete";
		form1.submit() ;
	}

</script>
<HTML>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" text="#000000" link="#0787df" vlink="#0737ef" alink="#ff872f">
<FORM name="form1" METHOD="POST" ACTION="detail_sub2.jsp" ENCTYPE="multipart/form-data">
<input type="hidden" name="mode" value="save">
<table tabindex="9" cellspacing="1" cellpadding="0" bordercolor="Black" border="0" id="DataGrid1" style="color:Black;border-color:Black;border-width:0px;border-style:Solid;font-family:新細明體;font-size:X-Small;height:10px;width:100%;">
	<tr style="color:White;background-color:Brown;">
		<td> 顯示位置</td>
		<td> 圖 形</td>
		<td> 儲 存</td>
	</tr>
	<tr>
		<td><%=f.select_code("place_code","place",f.field(rs,"place_code"), false ,"")%></td>		
		<td>
			<INPUT TYPE="FILE" NAME="pic" SIZE="20">
			<a href="<%=configure.root_path%>/files/challenge/<%=f.field(rs,"pic")%>" target="_blank"><%=f.cstr(f.field(rs,"pic"))%></a>  <%if(f.cstr(f.field(rs,"pic"))!=""){%><a href="javascript:to_delete()" >刪除</a><%}%>
			<INPUT TYPE="hidden" NAME="pic_str" value="<%=f.cstr(f.field(rs,"pic"))%>">
		</td>
		
		<td><a href="javascript:to_save()" >儲存</a></td>
	</tr>
</table>

</FORM>

</BODY>
</HTML>