<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：toptree1.jsp
說明：單位網站權限設定
開發者：chmei
開發日期：96.12.30
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>

<html lang="zh-TW">
<head>
<title>系統權限設定</title>
</head>

<font fontface='細明體' size=3>載入資料中，請稍後..... </font>
<table height="500"><td><br></table>
<div id="TreeData"><xmp>

<style type="text/css">
<!--
.w2 {  font-family: "細明體"; font-size: 10pt; }
-->
</style>

<body bgcolor="DBF2E6">

<%     
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
  String ds_ap = ldap.getProperty("ds_ap");
  
  int ds_port=Integer.parseInt(port);

  String websitedn = ( String )request.getParameter( "websitedn" );
  String unitdn = ( String )request.getParameter( "unitdn" );
  String common_websitedn = "ou=common,ou=ap_root,o=hcshb,c=tw";
  
  String sdn = ( String )request.getParameter("sdn");

  if ( sdn == null )
      sdn = ds_ap;
  
  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  
  if ( qou.query( sdn, "dn,sysname,objectclass,ou", "objectclass=aptree", SvLdap.QUERYONELEVEL ) )
  {
  	   while ( qou.next() ) {
  		   String mdn= qou.getString( "dn" );
  		   String[] array_mdn = SvString.split(qou.getString( "dn" ),",");
  		   String tempdn = qou.getString( "dn" );
  		   if ( array_mdn.length > 4 ) {
  			   for ( int i=0; i<array_mdn.length-4; i++ ) {
  				   tempdn = SvString.right(tempdn,",");
  			   }
  		   }
  		   
  		   if ( tempdn.equals(websitedn) || tempdn.equals(common_websitedn) ) {  %>
  			 <span class="w2"><img src='../image/tree.gif'>&nbsp;<a style=text-Decoration:none href='../node.jsp?dn=<%=mdn%>&unitdn=<%=unitdn%>' target='center'><%=qou.getString( "sysname" )%></a></span><!,>toptree1.jsp?sdn=<%=mdn%>&websitedn=<%=websitedn%>&unitdn=<%=unitdn%><!End>       	  
  		   <%}
  	   }
  }%>

<!EndTreeData>
</xmp>
</div>
</body>
 