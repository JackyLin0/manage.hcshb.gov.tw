<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities103.jsp
說明：欄位維護
開發者：chmei
開發日期：98.10.15
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
  function mdy(serno)
  {
     document.mform.serno.value = serno;
     document.mform.action = "activities103_mdy.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
  
</script>

</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //尋找目前現有欄位
  ActivityColumnData qcolumn = new ActivityColumnData();
  ArrayList qfields = qcolumn.findByField("");
  int frcount = qcolumn.getAllrecordCount();

%>

<body>
<form name="mform">
<input type="hidden" name="serno" />

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="3%">&nbsp;</th>
    <th width="3%">&nbsp;</th>
    <th width="25%" align="left">欄位名稱</th>
    <th width="35%" align="left">欄位值</th>
    <th width="15%" align="center">狀態</th>
    <th width="15%">更新日期</th>
  </tr>
  <%
    if ( qfields != null ) {
    	for ( int i=0; i<frcount; i++ ) {
    		ActivityColumnData qfield = ( ActivityColumnData )qfields.get( i ); %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=i+1%></td>
    		    <td align="center">&nbsp;</td>
    		    <td align="left">
    		      <%
    		        if ( qfield.getSerno().equals("200812030001") || qfield.getSerno().equals("200812030003") ) {
//     		        	qfield.getSerno().equals("200812030002") ||
              %>
    		        	<%=qfield.getFieldname()%>
    		        <%}else{%>
    		        	<a href="javascript:mdy('<%=qfield.getSerno()%>')"><%=qfield.getFieldname()%></a>
    		        <%}%>
    		    </td>
    		    <td align="left"><%=qfield.getFieldvalue()%></td>
    		    <%
    		      String mupdate = "";
    		      if ( qfield.getUpdatedate() != null && !qfield.getUpdatedate().equals("null") )
    		    	  mupdate = qfield.getUpdatedate().substring(0,4) + "." + qfield.getUpdatedate().substring(4,6) + "." + qfield.getUpdatedate().substring(6,8);
    		      String mflag = "";
    		      if ( qfield.getFieldflag().equals("Y") )
    		    	  mflag = "啟用";
    		      else if ( qfield.getFieldflag().equals("N") )
    		    	  mflag = "停用";
    		    	  
    		    %>
    		    <td align="center"><%=mflag%></td>
    		    <td align="center"><%=mupdate%></td>
    		</tr>
    	<%}
    }%>
</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>

</html>  
  
