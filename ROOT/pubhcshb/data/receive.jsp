<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：receive.jsp
說明：多網接收維護
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

<script>
  function add(apdn,apname)
  {
     document.mform.aplistdn.value = apdn;
     document.mform.aplistname.value = apname;
     document.mform.action="receive_add.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.filter.qfilterSql" %>

<%
  String table = ( String )request.getParameter( "t" );
  //Sql_Injection
  if ( !table.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(table);
     if ( rtn )
    	 table = qcontentlink.getMcontent();
  }
  String table1 = ( String )request.getParameter( "t1" );
  //Sql_Injection
  if ( !table1.equals("") ) {
  	  qfilterSql qcontentlink = new qfilterSql();
  	  boolean rtn = qcontentlink.filterSql(table1);
  	  if ( rtn )
  		table1 = qcontentlink.getMcontent();
  }
  String website = ( String )request.getParameter( "website" );
  //Sql_Injection
  if ( !website.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(website);
     if ( rtn )
    	 website = qcontentlink.getMcontent();
  }
  PublishData query = new PublishData();    
  ArrayList qlists = query.findByAP(table1,"");
  int rcount = query.getAllrecordCount();

%>

<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="t1" value="<%=table1%>"/>
<input type="hidden" name="website" value="<%=website%>"/>
<input type="hidden" name="aplistdn">
<input type="hidden" name="aplistname">

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<p>

<table width="70%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th><%=lang.getPublishapname()%></th>
  </tr>
  <%
    for ( int i=0; i<rcount; i++ )  {
    	PublishData qlist = ( PublishData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center">
    	    <table border="0" width="30%">
    	      <tr>
    	        <td width="5%"><%=i+1%>.</td>
    	        <td width="30%" align="left"><a href="javascript:add('<%=qlist.getAplistdn()%>','<%=qlist.getAplistname()%>')"><%=qlist.getAplistname()%></a></td>
    	      </tr>
    	    </table>
    	  </td>
    	</tr> 
    <%}%>  
  <tr>
    <th >&nbsp;</th>
  </tr> 
  
</table>

</form>
</body>
</html>