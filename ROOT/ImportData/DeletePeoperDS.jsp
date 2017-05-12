<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：DeletePeoperDS.jsp
說明：刪除DS離職人員
開發者：chmei
開發日期：96.07.18
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

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
  String ds_root = ldap.getProperty("ds_root");
  
  int ds_port=Integer.parseInt(port);
  
  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  
  boolean qdata = entry.query( ds_root, "dn,cn,objectclass,uid", "objectclass=users", SvLdap.QUERYSUBTREE );
  
  if ( qdata ) {
	  while ( entry.next() ) {
		  String unitdn = SvString.right(entry.getString("dn"),",");
		  
		  DSData qdn = new DSData();
		  boolean rtn = qdn.loadp(unitdn,entry.getString("uid"));
		  out.println("rtn="+rtn);
		  out.println("unitdn="+unitdn);
		  out.println("uid="+entry.getString("uid"));
		  out.println("sql="+qdn.getId());
		  out.println("<br>");
		  //if ( !rtn ) {
			//  if ( qdn.getDn() != null && !qdn.getDn().equals("null") ) {
			//	  out.println("dn="+qdn.getDn());
			//	  out.println("name="+qdn.getName());
			//	  out.println("<br>");
			//	  boolean ddata = entry.delete( entry.getString("dn") );
			//	  out.println("ddata="+ddata);
			//  }
		  //}
	  }
  }
 	 
%>  
  
  
  
  