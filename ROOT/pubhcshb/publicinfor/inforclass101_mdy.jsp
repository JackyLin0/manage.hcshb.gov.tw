<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：inforclass101_mdy.jsp
說明：公開資訊分類
開發者：chmei
開發日期：99.05.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公開資訊分類</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.mform.action="inforclass101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     document.mform.action = "inforclass101_mdysave.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function del(serno)
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="inforclass101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }

</script>

</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接受查詢條件
  String qclassname = ( String )request.getParameter( "qclassname" );

  //參數  
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String serno = ( String )request.getParameter( "serno" );
  
  PublicInforClassData query = new PublicInforClassData();  
  boolean rtn = query.load(serno,table);
  
%>  

<body>
<form name="mform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="qclassname" value="<%=qclassname%>"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>  
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:del()">刪除</a>	
 <a class="md" href="javascript:window.document.menuform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <%
    if ( rtn ) {  %>
    	<tr class="tr">
    	  <th colspan="4">資料修改</th>
    	</tr>
    	<tr>
    	  <td class="T12b" align="center"><span class="T12red">※</span>分類名稱</td>
    	  <td colspan="3">
    	    <input name="classname" type="text" class="lInput01" value="<%=query.getClassname()%>" size="78" maxlength="50"/>
    	    &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
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

