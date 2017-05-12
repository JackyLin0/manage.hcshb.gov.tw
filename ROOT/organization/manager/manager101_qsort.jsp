<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager_qsort.jsp
說明：主管簡介
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

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

<%

  String pubunitdn = ( String )request.getParameter( "pubunitdn" );

  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  //判斷OS版本
  String Ldap_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Ldap_PATH = sysRoot + "\\WEB-INF\\ldap.properties";
  else
	  Ldap_PATH = sysRoot + "/WEB-INF/ldap.properties";

  Properties ldap = new Properties();
  ldap.load(new FileInputStream(Ldap_PATH) );
  String ds_server = ldap.getProperty("ds_server");
  String port = ldap.getProperty("ds_port");
  String ds_user = ldap.getProperty("ds_user");
  String ds_pwd = ldap.getProperty("ds_pwd");
  String ds_root = ldap.getProperty("ds_root");
  
  int ds_port=Integer.parseInt(port); 

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  
  boolean qdata = qou.query( pubunitdn, "dn,chinesetitle,cn,uid,objectclass,ou", "objectclass=department", SvLdap.QUERYBASE );
  
  String mpubunitname = "";

  if ( qdata ) {
	  while ( qou.next() ) {
		  mpubunitname = qou.getString("chinesetitle");
	  }
  }


  ManagerData query = new ManagerData();     
  ArrayList qlists = query.findBysort(pubunitdn);  
  int rcount = query.getAllrecordCount();

%> 

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=mpubunitname%></h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr" align="center">
    <th width="20%">排序</th>
    <th width="40%">姓名</th>
    <th width="40%">職稱</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		ManagerData qlist = ( ManagerData )qlists.get( i );  %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td class="T12b" align="center"><%=qlist.getFsort()%></td>
    		  <td><%=qlist.getName()%></td>
    		  <td><%=qlist.getProftitle()%></td>
    		</tr>
    	<%}
    }%>
    
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
</table>

<p></p>
<center><a class="md" href="javascript:window.close()">關　閉</a></center>
