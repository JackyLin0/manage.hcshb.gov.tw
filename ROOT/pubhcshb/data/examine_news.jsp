<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：examine.jsp
說明：接收資料審核
開發者：chmei
開發日期：97.03.08
修改者：chmei
修改日期：96.12.19
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function back()
  {
     document.mform.action = "examine.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  function save()
  {
     document.mform.action = "examine_save.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
</script>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //查詢條件
  String qap = ( String )request.getParameter( "qap" );
  String qexamine = ( String )request.getParameter( "qexamine" );

  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  
  String mserno = ( String )request.getParameter( "mserno" );
  String tablename = ( String )request.getParameter( "tablename" );
  String poster = ( String )request.getParameter( "poster" );
  String website = ( String )request.getParameter( "website" );

  ExamineData qnews = new ExamineData();
  boolean newsrtn = qnews.loadnews(tablename,mserno);
  
%>  

  
<body>
<form name="mform">
  <input type="hidden" name="website" value="<%=website%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="mserno" value="<%=mserno%>"/>
  <input type="hidden" name="tablename" value="<%=tablename%>"/>
  <input type="hidden" name="poster" value="<%=poster%>"/>
  <input type="hidden" name="qap" value="<%=qap%>"/>
  <input type="hidden" name="qexamine" value="<%=qexamine%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()"><%=lang.getSave()%></a>		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>

<%
  if ( newsrtn ) { %>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	  <tr class="tr">
	    <th colspan="4"><%=lang.getDataexamine()%></th>
	  </tr>
	  <tr>
	    <td class="T12b" width="15%"><%=lang.getPosterdate()%></td>
	    <td colspan="3"><%=qnews.getPosterdate().substring(0,4)%>.<%=qnews.getPosterdate().substring(4,6)%>.<%=qnews.getPosterdate().substring(6,8)%></td>
	  </tr>
	  <%
	    if ( qnews.getStartusing().equals("0") ) { %>
	    	<tr class="tr">
	    	  <td class="T12b" width="15%"><%=lang.getClosedate()%></td>	    	    
	    	  <td colspan="3"><%=qnews.getClosedate().substring(0,4)%>.<%=qnews.getClosedate().substring(4,6)%>.<%=qnews.getClosedate().substring(6,8)%></td>
	    	</tr>
	    <%}else{%>
	    	<tr class="tr">
	    	  <td class="T12b" width="15%"><%=lang.getClosedate()%></td>	    	    
	    	  <td colspan="3">永久有效</td>
	    	</tr>
	    <%}%>
	  <tr>
	    <td class="T12b"><%=lang.getSubject()%></td>
	    <td colspan="3"><%=qnews.getSubject()%></td>
	  </tr>
	  <tr class="tr">
	    <td class="T12b"><%=lang.getSecsubject()%></td>
	    <td colspan="3"><%=qnews.getSecsubject()%></td>
	  </tr>
	  <tr>
	    <td class="T12b"><%=lang.getPubunitname()%></td>
	    <td colspan="3"><%=qnews.getPubunitname()%></td>
	  </tr>
	  <tr class="tr">
	    <td valign="top" class="T12b"><%=lang.getContent()%></td>
	    <td colspan="3"><%=qnews.getContent()%></td>
	  </tr>
	  <%
	    if ( !qnews.getRelateurl().equals("http://") ) { %>
	    	<tr>
	    	  <td class="T12b"><%=lang.getRelateurl()%></td>
	    	  <td colspan="3">&nbsp;<%=qnews.getRelateurl()%>
	    	    <span class="T12b">網站名稱</span>&nbsp;<%=qnews.getRelatename()%>
	    	  </td>
	    	</tr>
	    <%}%>
	  <tr>
	    <td valign="top" class="T12b"><%=lang.getDataexamine()%><span class="T12red">※</span></td>
	    <td colspan="3">
	      <input type="radio" name="examine" value="Y" checked><%=lang.getAgree()%>&nbsp;&nbsp;
	      <input type="radio" name="examine" value="N"><%=lang.getNoagree()%>
	    </td>
	  </tr>  
	  <tr>
	    <th >&nbsp;</th>
	    <th >&nbsp;</th>
	    <th >&nbsp;</th>
	    <th >&nbsp;</th>
	  </tr>
	</table>
	
  <%}%> 	


<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

