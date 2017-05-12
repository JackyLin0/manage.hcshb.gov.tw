<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：website.jsp
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
  function qry()
  {
    document.mform.action="website.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function clean()
  {
     document.mform.punit1.value = "";
     document.mform.qptdate.value = "";
     document.mform.qdldate.value = "";
     document.mform.pview.value = "";
     document.mform.dview.value = "";
  }  
  
  function view(mpunit,totnum) 
  {
     document.mform.mpunit.value = mpunit;
     document.mform.totnum.value = totnum;
     document.mform.action = "website_detail.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );

  //接收查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  if ( qpunit == null )
	  qpunit = "";
  
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

  WebSiteLogData query = new WebSiteLogData();  
  ArrayList qlists = query.findBylog(qpunit,sdate1,sdate2,table);  
  int rcount = query.getAllrecordCount();

%>


<body>
<form name="mform">

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="mpunit"/>
<input type="hidden" name="totnum"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>
  <span class="T11b">發布單位</span>
  <jsp:include page="../../pubprogram/qunit.jsp">
      <jsp:param name="colname" value="qpunit"/>
      <jsp:param name="language" value="ch"/>
      <jsp:param name="datavalue" value="<%=qpunit%>"/>
  </jsp:include>&nbsp;
  &nbsp;&nbsp;<span class="T11b">更新日期</span>
  <jsp:include page="../../pubprogram/bdate.jsp" >
      <jsp:param name="sdatevalue" value="<%=qptdate%>" />
      <jsp:param name="edatevalue" value="<%=qdldate%>" />
  </jsp:include>  
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p>


<%
  if ( qlists != null ) {
	  String unitname = "";
	  for ( int i=0; i<rcount; i++ ) {
		  WebSiteLogData qlist = ( WebSiteLogData )qlists.get( i );
		  if ( unitname.equals("") || !qlist.getPubunitname().equals(unitname) )  { 
			  //計算單位總筆數
			  WebSiteLogData qnum = new WebSiteLogData();
			  boolean rtn = qnum.load(qlist.getPubunitdn(),sdate1,sdate2,table);  %>
			  </table>
			  <br><br>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			      <td width="30%">單位：<a href="javascript:view('<%=qlist.getPubunitdn()%>','<%=qnum.getTotnum()%>')"><%=qlist.getPubunitname()%></a></td>
			      <td>總筆數：<%=qnum.getTotnum()%></td>
			    </tr>
			  </table>
			  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
			    <tr align="center">
			      <th width="10%">&nbsp;</th>
			      <th align="left" width="50%">維護單元名稱</th>
			      <th width="40%">維護次數</th>
			    </tr>
		  <%}%>
		  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
		    <td width="10%">&nbsp;</td>
		    <td align="left"><%=qlist.getUnitname()%></td>
		    <td align="center"><%=qlist.getNum()%></td>
		  </tr>
		  <%
		    unitname = qlist.getPubunitname();
      }
  }else{%>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
	      <td colspan="3" align="center">&nbsp;</td>
	    </tr>
	    <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
	      <td colspan="3" align="center">目前查無資料</td>
	    </tr>
	    <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
	      <td colspan="3" align="center">&nbsp;</td>
	    </tr>
	  </table>
  <%}%>

</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>