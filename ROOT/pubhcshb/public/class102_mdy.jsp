<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：class102_mdy.jsp
說明：分類程式(適用主題網站)
開發者：chmei
開發日期：99.03.30
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.mform.action="class102.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
	  if ( document.mform.classname.value == '' ) {
		  alert("【分類名稱】欄位，不可空白，請選擇！");
		  document.mform.classname.focus();
		  return;
	  }

	  document.mform.action = "class102_mdysave.jsp";
	  document.mform.method="post";
	  document.mform.submit();
  }
  
  function del(serno)
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="class102_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }

</script>

</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接受查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclassname = ( String )request.getParameter( "qclassname" );

  //參數
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );
  
  String websitedn = ( String )request.getParameter( "websitedn" );
  
  TopicClassData query = new TopicClassData();
  query.setWebsitedn(websitedn);
  boolean rtn = query.load(serno,table);  
  
%>  

<body>
<form name="mform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
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
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <%
    if ( rtn ) {  %>
    	<tr class="tr">
    	  <th colspan="4"><%=lang.getDatamdy()%></th>
    	</tr>
    	<tr class="tr">
    	  <td width="27%" class="T12b" align="center"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    	  <td colspan="3"><%=query.getPubunitname()%></td>
    	  <input type="hidden" name="pubunitdn" value="<%=query.getPubunitdn()%>">
    	  <input type="hidden" name="pubunitname" value="<%=query.getPubunitname()%>">
    	</tr>
    	<tr>
    	  <td class="T12b" align="center"><span class="T12red">※</span><%=lang.getClassname()%></td>
    	  <td colspan="3">
    	    <input name="classname" type="text" class="lInput01" value="<%=query.getClassname()%>" size="50"/>
    	    &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
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

</form>

</body>
</html>


