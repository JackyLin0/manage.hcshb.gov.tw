<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities105_del.jsp
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
     document.mform.action="activities105_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function send()
  {
     if ( document.mform.mcontent ) 
     {
        if ( document.mform.mcontent.value == '' ) {
           alert("【派送Mail內容】欄位，不可空白，請輸入！");
           document.mform.mcontent.focus();
           return;
        }
     }else{
        x=window.confirm("此筆資料無Mail，無法以Mail通知，仍要刪除此筆資料嗎?");
        if ( !x )
           return;
     }
     
     document.mform.action="activities105_delsave.jsp";
     document.mform.method="post";
     document.mform.submit();
  }  
</script>

</head>

<%@ page import="java.util.*"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String msubject = ( String )request.getParameter( "msubject" );
  String actserno = ( String )request.getParameter( "actserno" );
  String serno = ( String )request.getParameter( "serno" );
  
  ActivityExcelData qmrecord = new ActivityExcelData();
  ArrayList qrecords = qmrecord.findByrecord(actserno);
  int rcount1 = qmrecord.getAllrecordCount();
  String fieldserno = "";
  String emailflag = "N";
  if ( qrecords != null ) {
	  for ( int i=0; i<rcount1; i++ ) {
		  ActivityExcelData qrecord = ( ActivityExcelData )qrecords.get( i );
		  if ( fieldserno.equals("") )
			  fieldserno = qrecord.getFieldserno();
		  else
			  fieldserno = fieldserno + "||" + qrecord.getFieldserno();
		  if ( qrecord.getFieldserno().equals("200812040009") )
			  emailflag = "Y";
	  }
  }
  
  ActivityExcelData qdata = new ActivityExcelData();
  qdata.setExcelfield(fieldserno);
  String[] mdata = qdata.loadexcel(actserno,serno);
  
  String[] ary_fieldserno = SvString.split(fieldserno,"||");

%>

<body>
<form name="mform">
<input type="hidden" name="msubject" value="<%=msubject%>"/>
<input type="hidden" name="actserno" value="<%=actserno%>"/>
<input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>

<a class="md" href="javascript:send()">刪除</a>	
<a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
<a class="md" href="javascript:back()">回上頁</a>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="4">&nbsp;</th>
  </tr>
  <%
    String mflag = "Y";
    for ( int i=0; i<ary_fieldserno.length; i++ ) {    	
    	String mclass = "";
    	if ( i%2 == 0 )
    		mclass = "class='tr'";
    	ActivityExcelData qfname = new ActivityExcelData();
    	qfname.load(ary_fieldserno[i]);
    	if ( ary_fieldserno[i].equals("200812040009") ) {
    		if ( mdata[i] != null && !mdata[i].equals("null") && !mdata[i].equals("") ) {
    			if ( mdata[i].equals("a") )
        			mflag = "N";
    		}
    	} %>
    	<tr <%=mclass%>>
    	  <td class="T12b" width="20%"><%=qfname.getFieldname()%></td>
    	  <%
    	    if ( mdata[i] != null && !mdata[i].equals("null") && !mdata[i].equals("") ) {
    	    	if ( mdata[i].equals("a") ) { %>
    	    		<td colspan="3">&nbsp;</td>
    	    	<%}else{%>
    	    		<td colspan="3"><%=mdata[i]%></td>
    	    	<%}
    	    }%>
    	    
    	</tr>
    <%}
    if ( emailflag.equals("Y") && mflag.equals("Y") ) { %>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">※</span>派送Mail內容</td>
    	  <td><textarea name="mcontent" cols="60" rows="3"></textarea></td>
    	</tr>
    <%}%>
    <input type="hidden" name="mflag" value="<%=mflag%>"/>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
</table>    

</form>
</body>
</html>


