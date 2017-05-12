<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qtitle.jsp
說明：尋找系統名稱
開發者：chmei
開發日期：96.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

<%
  String templogindn = ( String )session.getAttribute("logindn");
  String murl = ( String )request.getParameter( "murl" );
  String title = "";
  
  if ( (templogindn == null) || (templogindn.equals("null")) ) { %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("index.jsp","_parent");
	  </script>
  <%}else{
	  //取系統路徑
	  String sysRoot3 = (String) application.getRealPath("");
	  //判斷OS版本
	  String Ldap_PATH = "";
	  if ( sysRoot3.indexOf("/") == -1 )
		  Ldap_PATH = sysRoot3 + "\\WEB-INF\\ldap.properties";
	  else
		  Ldap_PATH = sysRoot3 + "/WEB-INF/ldap.properties";

	  Properties ldap = new Properties();
	  ldap.load(new FileInputStream(Ldap_PATH) );
	  String qds_server1 = ldap.getProperty("ds_server");
	  String qport1 = ldap.getProperty("ds_port");
	  String ds_user1 = ldap.getProperty("ds_user");
	  String ds_pwd1 = ldap.getProperty("ds_pwd");
	  String qds_ap1 = ldap.getProperty("ds_ap");
	  
	  int qds_port1 = Integer.parseInt(qport1);
	  
	  if ( murl == null || murl.equals("null") )
		  murl = ( String )session.getAttribute( "murl" );
	  
	  String webdn = "";
	  SvNetscapeLdap qname = new SvNetscapeLdap( qds_server1, qds_port1, ds_user1, ds_pwd1, SvLdap.ENCODEUNICODE );
	  boolean qrtn = qname.query( qds_ap1, "dn,sysname,url,punit,number", "url=" + murl, SvLdap.QUERYSUBTREE );
	  
	  if ( qrtn ){
		  while ( qname.next() ) {
			  title = qname.getString( "sysname" );
			  webdn = qname.getString( "dn" );
		  }
	  }
	  
	  session.setAttribute("webdn",webdn);
	  session.setAttribute("murl",murl);

	%>

	<input type="hidden" name="murl" value="<%=murl%>"/>
	<input type="hidden" name="webdn" value="<%=webdn%>"/>
	<input type="hidden" name="title" value="<%=title%>"/>

  <%}%>

  