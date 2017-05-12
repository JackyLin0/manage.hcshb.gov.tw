<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities105.jsp
說明：報名資料維護
開發者：chmei
開發日期：98.10.16
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.mform.action="activities105.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function del(serno)
  {
     document.mform.serno.value = serno;
     document.mform.action = "activities105_del.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
</script>  
  
</head>

<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String msubject = ( String )request.getParameter( "msubject" );
  String[] ary_mdatavalue = SvString.split(msubject,"||");
  
  ActivityExcelData qmrecord = new ActivityExcelData();
  ArrayList qrecords = qmrecord.findByrecord(ary_mdatavalue[0]);
  int rcount1 = qmrecord.getAllrecordCount();
  String fieldserno = "";
  String emailflag = "N";
  if ( qrecords != null ) {
	  for ( int i=0; i<rcount1; i++ ) {
		  ActivityExcelData qrecord = ( ActivityExcelData )qrecords.get( i );
		  if(qrecord != null){
			  if ( qrecord.getFieldserno().equals("200812030001") || qrecord.getFieldserno().equals("200812030002") || qrecord.getFieldserno().equals("200812040009") ) {
				  if ( fieldserno.equals("") )
					  fieldserno = qrecord.getFieldserno();
				  else {
				  	
					  //fieldserno = fieldserno + "||" + qrecord.getFieldserno();
				  }
			  }
			  if ( qrecord.getFieldserno().equals("200812040009") )
				  emailflag = "Y";
		  
		  }

	  }
  }
  
  ActivityExcelData qexcel = new ActivityExcelData();
  qexcel.setExcelfield(fieldserno);
  ArrayList qlists = qexcel.findByexcel(ary_mdatavalue[0],"");
  int rcount = qexcel.getAllrecordCount();
  
%>

<body>
<form name="mform">
<input type="hidden" name="actserno" value="<%=ary_mdatavalue[0]%>"/>
<input type="hidden" name="msubject" value="<%=msubject%>"/>
<input type="hidden" name="serno"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:back()">回上頁</a>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="5"><%=ary_mdatavalue[1]%></th>
  </tr>
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="30%" align="left">姓名</th>
    <th width="30%">生日</th>
    <th width="30%">電子信箱</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		ActivityExcelData qlist = ( ActivityExcelData )qlists.get( i ); %>
    		<tr align="center" onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td width="5%"><%=i+1%></td>
    		  <td width="5%">&nbsp;</td>
    		  <%
    		    String[] ary_data = SvString.split(qlist.getExcelvalue(),"||");
    		    for ( int j=0; j<ary_data.length-1; j++ ) { 
    		    	if ( ary_data[j].equals("") ) { %>
    		    		<td width="30%">&nbsp;</td>
    		    	<%}else{
    		    		if ( j == 0 ){ %>
    		    			<td width="30%" align="left"><a href="javascript:del('<%=ary_data[ary_data.length-1]%>')"><%=ary_data[j]%></a></td>
    		    		<%}else{%>
    		    		   <td width="30%"><%=ary_data[j]%></td>
    		    		<%}  
    		    	}
    		    }
    		    if ( emailflag.equals("N") ) { %>
    		    	<td width="30%">&nbsp;</td>
    		    <%}%>
    		</tr>
    	<%}
    } %>

</table>  
  
</form>  
</body>

</html>
