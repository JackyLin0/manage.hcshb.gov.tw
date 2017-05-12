<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：website_detail.jsp
說明：網站維運統計 
開發者：chmei
開發日期：97.02.21
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
    function back()
  {
     document.mform.action="website.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件  
  String qpunit = ( String )request.getParameter( "qpunit" );

  String qptdate = ( String )request.getParameter( "qptdate" );
  String sdate1 = qptdate;
  if ( qptdate == null || qptdate.equals("") )
  {	  
	  qptdate = "";
	  sdate1 = "00000000";
  }	  
   
  String qdldate = ( String )request.getParameter( "qdldate" ); 
  String sdate2 = qdldate;
  if ( qdldate == null || qdldate.equals("") )
  {
	  qdldate = "";
	  sdate2 = "99999999";
  }    
  
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String mpunit = ( String )request.getParameter( "mpunit" );
  String totnum = ( String )request.getParameter( "totnum" );

  WebSiteLogData query = new WebSiteLogData();    
  ArrayList qlists = query.findBydata(mpunit,sdate1,sdate2,table);  
  int rcount = query.getAllrecordCount();
  
%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="qpunit value="<%=qpunit%>"/>
<input type="hidden" name="qptdate value="<%=qptdate%>"/>
<input type="hidden" name="qdldate value="<%=qdldate%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

 <a class="md" href="javascript:back()">回上頁</a>

<%
  if ( qlists != null ) {
	  String unitname = "";
	  for ( int i=0; i<rcount; i++ ) {
		  WebSiteLogData qlist = ( WebSiteLogData )qlists.get( i );
		  if ( i == 0 ) {  %>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			      <td width="30%">單位：<%=qlist.getPubunitname()%></td>
			      <td>總筆數：<%=totnum%></td>
			    </tr>
			  </table>
		  <%}
		  if ( unitname.equals("") || !qlist.getUnitname().equals(unitname) )  {   %>
			  </table>
			  <br><br>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			      <td width="50%">維護單元名稱：<%=qlist.getUnitname()%></td>
			      <td>Table 名稱：<%=qlist.getTablename()%>e
			    </tr>
			  </table>
			  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
			    <tr align="center">
			      <th width="12%">序　號</th>
			      <th width="28%">標　題</th>
			      <th width="18%">最近維護人員</th>
			      <th width="12%">登錄IP</th>
			      <th width="18%">最近維護日期</th>
			      <th width="12%">狀　態</th>
			    </tr>
    		<%}%>    		
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td><%=qlist.getSerno()%></td>
    		  <td align="left"><%=qlist.getSubject()%></td>
    		  <td align="center"><%=qlist.getPostname()%></td>
    		  <td align="center"><%=qlist.getWebip()%></td>
    		  <td align="center"><%=qlist.getUpdatedate().substring(0,4)%>.<%=qlist.getUpdatedate().substring(4,6)%>.<%=qlist.getUpdatedate().substring(6,8)%></td>
    		  <%
    		    String mstatus = "";
    		    if ( qlist.getStatus().equals("A") )
    		    	mstatus = "新增";
    		    else if ( qlist.getStatus().equals("U") )
    		    	mstatus = "修改";
    		    else if ( qlist.getStatus().equals("D") )
    		    	mstatus = "刪除";
    		    %>
    		    <td align="center"><%=mstatus%></td>
    		</tr>
    		<%
    		  unitname = qlist.getUnitname().trim();
    	}
    }%>

</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>