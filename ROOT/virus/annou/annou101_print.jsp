<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：annou101_print.jsp
說明：通報資料
開發者：hank
開發日期：98.07.29
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局腸病毒通報系統</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
function back(){
	document.mform.method = "post";
	document.mform.action = "annou101.jsp";
	document.mform.submit();
}

function excel(){
	if(document.mform.qptdate.value > document.mform.qdldate.value){
    	alert("查詢條件之發布日期【起】不可大於【迄】，請重新選擇！");
       	document.mform.dview.focus();
       	return;
    }
    
	document.mform.action="annou101_excel.jsp";
	document.mform.method="post";
	document.mform.submit();
}

function cha(){
	document.mform.action="annou101_print.jsp";
    document.mform.method="post";
    document.mform.submit();
}
</script>

<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="java.io.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));

  String schoolname = ( String )session.getAttribute("schoolname");
  
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  
  String Ldap_PATH1 = sysRoot1 + "/WEB-INF/ldap.properties";
  Properties ldap1 = new Properties();
  ldap1.load(new FileInputStream(Ldap_PATH1) );
  String hcshb = ldap1.getProperty("hcshb");
  
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  if ( pubunitdn.equals(hcshb) )
	  pubunitdn = "";
  
  //接收查詢條件
  String schName = ( String )request.getParameter( "mschName" );
  if ( schName == null || schName.equals("") )
	  schName = "";
  
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("請輸入") != -1 )
	  keyword = "";
  
  String qpunit = ( String )request.getParameter( "mqpunit" );
  if ( qpunit == null )
	  qpunit = pubunitdn;
  
  String qptdate = ( String )request.getParameter( "qptdate" );
  String sdate1 = qptdate;
  if(qptdate == null || qptdate.equals("")){	  
	  qptdate = "";
	  sdate1 = "00000000";
  }
  
  String qdldate = ( String )request.getParameter( "qdldate" ); 
  String sdate2 = qdldate;
  if(qdldate == null || qdldate.equals("")){
	  qdldate = "";
	  sdate2 = "99999999";
  }

%>


<body>
<form name="mform">
<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="serno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>通報資料</h2>
</div>

<p>

<a class="md" href="javascript:excel()">Excel檔</a>
<a class="md" href="javascript:back()">回上頁</a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">報表</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%">隸屬單位</td>
    <td colspan="3">
      <jsp:include page="../qunit.jsp">
        <jsp:param name="colname" value="mqpunit"/>
        <jsp:param name="language" value="ch"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="onchange" value="cha"/>
      </jsp:include>&nbsp;&nbsp;
  
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%">學校名稱</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qschool.jsp">
        <jsp:param name="colname" value="mschName"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="schName" value="<%=schName%>"/>
      </jsp:include>&nbsp;&nbsp;
    </td>
  </tr>

  <tr class="tr">
    <td class="T12b" width="15%">班級名稱</td>
    <td colspan="3">
      <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%">通報日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/bdate.jsp" >
        <jsp:param name="sdatevalue" value="<%=qptdate%>" />
        <jsp:param name="edatevalue" value="<%=qdldate%>" />
      </jsp:include>
    </td>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<p>
<a class="md" href="#top">回頁首</a>
</form>
</body>
</html>