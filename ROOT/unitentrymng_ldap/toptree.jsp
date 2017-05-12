<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：toptree.jsp
說明：人員組織管理
開發者：chmei
開發日期：96.10.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.SvString"%>
<html lang="zh-TW">
<head>
<title>人員組織設定</title>
</head>

<font fontface='細明體' size=3>載入資料中，請稍後..... </font>
<table height="600"><td><br><br><img src="image/loading.gif"></table>
<div id="TreeData"><xmp>

<style type="text/css">
<!--
.w2 {  font-family: "細明體"; font-size: 10pt; }
.GA{filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff,EndColorStr=#f4f4f4);}
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
  String ds_root = ldap.getProperty("ds_root");
  
  int ds_port=Integer.parseInt(port);
  
  String sdn = ( String )request.getParameter("sdn");
  if ( sdn == null)
     sdn = ds_root;

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  
  if ( qou.query( sdn, "dn,chinesetitle,cn,uid,objectclass,ou", SvLdap.QUERYONELEVEL ) )
    { 
  	  while ( qou.next())
  	   {
  	     String mdn = qou.getString( "dn" ); 
  	     String tobj = qou.getString( "objectclass" );
  	     
  	     //objectclass如果是單位取出的值是【department,top】；如果是人員取出的值是【top,users】，因此切陣列
  	     String[] obj = SvString.split(tobj,",");
         
  	     if ( (obj[0].equals("department")) || (obj[1].equals("department")) ) 
  	       {%>
  	         <span class="w2"><img src='image/org.gif'>&nbsp;<a style=text-Decoration:none href='node.jsp?dn=<%=mdn%>' target='right'><%=qou.getString( "chinesetitle" )%></a></span><!,>toptree.jsp?sdn=<%=mdn%><!End>
  	     <%}else if ( (obj[0].equals("users")) || (obj[1].equals("users")) ) { %>
  	         <span class="w2"><img src='image/user.gif'>&nbsp;<a style=text-Decoration:none href='leaf.jsp?dn=<%=mdn%>' target='right'><%=qou.getString( "cn" )%></a></span><!,>toptree.jsp?sdn=<%=mdn%><!End>
  	     <%}     
  	   }     
  	}%>
<!EndTreeData>
</xmp>
</div>
</body>
</html>