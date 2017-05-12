<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_excel.jsp
說明：線上報名表
開發者：chmei
開發日期：97.12.05
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<!-- 產生word檔 -->
<!-- %@ page contentType="application/msword;charset=UTF-8" % -->
<!-- 產生Excel檔 -->
<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>

<%
  String mdatavalue = ( String )request.getParameter( "msubject" );
  String[] ary_mdatavalue = SvString.split(mdatavalue,"||");
 
  String fsort = ( String )request.getParameter( "qsort" );
  if ( fsort == null || fsort.equals("null") )
	  fsort = "";
  String[] mfieldserno = request.getParameterValues( "field" );
  
  String fieldserno = "";
 
  for ( int i=0; i<mfieldserno.length; i++ ) {
  	  //欄位代碼	
 
	  if ( fieldserno.equals("") )
		  fieldserno = mfieldserno[i];
	  else{
		  fieldserno = fieldserno + "||" + mfieldserno[i];
		}
  }
  
  String[] ary_fieldserno = SvString.split(fieldserno,"||");
  
  
  String sign = ( String )request.getParameter( "sign" );
  
  int fieldlength = ary_fieldserno.length;
  //加印簽名欄
  if ( sign.equals("Y") )
	  fieldlength = fieldlength + 1;
 
  //產生word檔
  //response.setHeader("Content-disposition","inline; filename=aa.doc");
  //產生Excel檔
  response.setHeader("Content-disposition", "attachment; filename=activity.xls");
 
  ActivityExcelData qexcel = new ActivityExcelData();
  qexcel.setExcelfield(fieldserno);
  ArrayList qlists = qexcel.findByexcel(ary_mdatavalue[0],fsort);
  int rcount = qexcel.getAllrecordCount();
 
%>


<body>
 

<table width="97%" border="0" cellpadding="0" cellspacing="0">
  <tr align="center">
    <td colspan="<%=fieldlength%>"><font size="4"><%=ary_mdatavalue[1]%></font></td>
  </tr>
</table>

<table width="97%" border="1" cellpadding="0" cellspacing="0">
  <tr height="24" align="center" valign="center">

    <%
		  
      //for ( int t=0; t<ary_fieldserno.length; t++ ) 
      for ( int t=0; t<1; t++ ) {
    	  ActivityExcelData qdata = new ActivityExcelData();
    	  boolean rtn = qdata.load(ary_fieldserno[t]);
    	  if ( rtn ) { %>
    		  <td><%=qdata.getFieldname()%></td>
    	  <%}
      }
      if ( sign.equals("Y") ) {%>
    	  <td>簽　　名</td>
      <%}%>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		ActivityExcelData qlist = ( ActivityExcelData )qlists.get( i ); %>
    		<tr height="24" align="center" valign="center">
    		  <%
    		    String[] ary_data = SvString.split(qlist.getExcelvalue(),"||");
    		    System.out.print("value:"+qlist.getExcelvalue());
    		    //System.out.print("length:"+ary_data.length);
    		    for ( int j=0; j<ary_data.length; j++ ) { 
    		    	String mdata = ary_data[j];
    		    	if ( mdata.equals("a") )
    		    		mdata = ""; %>
    		    	<td><%=mdata%></td>
    		    <%}
    		    if ( sign.equals("Y") ) {%>
    		    	<td>&nbsp;</td>
    		    <%}%>
    		</tr>
    	<%}
    }else{%>
    	<tr height="24" align="center" valign="center">
    	  <td colspan="<%=fieldlength%>">目前尚無任何報名資料！</td>
    	</tr>
    <%}%>
</table>
