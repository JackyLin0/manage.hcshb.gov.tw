<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities103_mdy.jsp
說明：欄位維護
開發者：chmei
開發日期：98.10.15
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.mform.action="activities103.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     document.mform.action = "activities103_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
</script>  
  
</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String serno = ( String )request.getParameter( "serno" );
  //尋找目前現有欄位
  ActivityColumnData qcolumn = new ActivityColumnData();
  boolean rtn = qcolumn.loadfield(serno);
  
%>  

<body>
<form name="mform">
<input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>

<br/>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">  
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <%
    if ( rtn ) { %>
    	<tr class="tr">
    	  <td class="T12b" width="25%"><span class="T12red">※</span>欄位名稱</td>
    	  <td colspan="3"><%=qcolumn.getFieldname()%></td>
    	</tr>
    	<tr>
    	  <td class="T12b" width="25%"><span class="T12red">※</span>欄位值</td>
    	  <td colspan="3"><%=qcolumn.getFieldvalue()%></td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b" width="25%"><span class="T12red">※</span>啟用</td>
    	  <td colspan="3">
    	    <input type="radio" name="fieldflag" value="Y" <%=qcolumn.getFieldflag().equals("Y") ? "checked" : ""%> />啟用&nbsp;&nbsp;&nbsp;
    	    <input type="radio" name="fieldflag" value="N" <%=qcolumn.getFieldflag().equals("N") ? "checked" : ""%> />停用
    	  </td>
    	</tr>
    <%}%>
  
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
  
</table>    

</form>
</body>
</html>

