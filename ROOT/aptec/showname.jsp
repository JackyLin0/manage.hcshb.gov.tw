<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

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
  //String ds_ap = ldap.getProperty("ds_ap");
  String ds_ap = "ou=emei,ou=ap_root,o=hcshb,c=tw";
  
  int ds_port=Integer.parseInt(port);

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  String attrib="dn,ou,sysname,url,punit,number,tablename,startusing,acitarget,acitargetattr,aciname,aciallowuserdn,aciuserdn";
  boolean qdata = qou.query( ds_ap, attrib, "objectclass=aptree", SvLdap.QUERYSUBTREE );
  
  if ( qdata ) {
	  while ( qou.next() ) {
		  out.println(qou.getString( "sysname" ));
		  out.println("<br>");
		  out.println(qou.getString( "ou" ));
		  out.println("<br>");
		  out.println(qou.getString( "url" ));
		  out.println("<br>");
	  }
  }
 	 
  
%>  