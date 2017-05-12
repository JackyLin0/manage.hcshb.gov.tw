<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：class_mdy.jsp
說明：分類程式(適用單站台)
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接受查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qwebsite = ( String )request.getParameter( "qwebsite" );
  String qclassname = ( String )request.getParameter( "qclassname" );

  //參數  
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );
  
  WebClassData query = new WebClassData();  
  boolean rtn = query.load(serno,table);  
  
%>  

<script>
  function back()
  {
     document.classform.action="class.jsp";
     document.classform.method="post";
     document.classform.submit();
  }
  
  function save()
  {
     if ( document.classform.classname.value == '' )
     {
        alert("【分類名稱】欄位，不可空白，請選擇！");
        document.classform.classname.focus();
        return;
     } 
     
     document.classform.action = "class_mdysave.jsp";
     document.classform.method="post";
     document.classform.submit();
  }
  
  function del(serno)
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.classform.action="class_del.jsp?type=1";
        document.classform.method="post";
        document.classform.submit();
     } 
  }

</script>

<body>
<form name="classform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qwebsite" value="<%=qwebsite%>"/>
  <input type="hidden" name="qclassname" value="<%=qclassname%>"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:del()"><%=lang.getDel()%></a>	
 <a class="md" href="javascript:window.document.classform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <%
    if ( rtn ) {  %>
    	<tr class="tr">
    	  <th colspan="4"><%=lang.getDatamdy()%></th>
    	</tr>
    	<tr>
    	  <td width="27%" class="T12b" align="center"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    	  <td colspan="3"><%=query.getPubunitname()%></td>
    	  <input type="hidden" name="pubunitdn" value="<%=query.getPubunitdn()%>">
    	  <input type="hidden" name="pubunitname" value="<%=query.getPubunitname()%>">
    	</tr>
    	<tr class="tr">
    	  <td width="27%" class="T12b" align="center"><span class="T12red">※</span><%=lang.getWebsitename()%></td>
    	  <td colspan="3"><%=query.getWebsitename()%></td>
    	  <input type="hidden" name="websitedn" value="<%=query.getWebsitedn()%>">
    	  <input type="hidden" name="websitename" value="<%=query.getWebsitename()%>">
    	</tr>
    	<tr>
    	  <td class="T12b" align="center"><span class="T12red">※</span><%=lang.getClassname()%></td>
    	  <td colspan="3">
    	    <input name="classname" type="text" class="lInput01" value="<%=query.getClassname()%>" size="50"/>
    	  </td>
    	</tr>
    <%}%>
  
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<!-- <p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div> -->

</form>
</body>
</html>
