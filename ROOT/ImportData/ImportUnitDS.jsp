<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：ImportUnitDS.jsp
說明：自DB匯入DS
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
  
  DSData query = new DSData();
  ArrayList qlists = query.findByunit();  
  int rcount = query.getAllrecordCount();
  out.println("rcount="+rcount);
  //匯入單位  
  if ( qlists != null ) {
	  for ( int i=0; i<rcount; i++ ) {
		  String addatt = new String("objectclass=department");
		  DSData qlist = ( DSData )qlists.get( i );
		  String mdepid = qlist.getDepid().trim();
		  String mdn1 = qlist.getDn().trim();
		  
		  DSData qunit = new DSData();
		  boolean rtn = qunit.load(mdepid,mdn1);
		  out.println("ctitle="+qunit.getName());
		  out.println("mdepid="+mdepid);
		  out.println("mdn1="+mdn1);
		  if ( rtn ) {
			  out.println("rtn="+rtn);
			  out.println("<br>");
			  String ou = qunit.getOu();
			  addatt = addatt + ";ou=" + ou;  
			  String ctitle = qunit.getName();
			  addatt = addatt + ";chinesetitle=" + ctitle; 
			  
			  String mdn =  qunit.getDn();

			  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );

			  if ( entry.query( mdn, "dn,ou", SvLdap.QUERYSUBTREE )) {
				  boolean mdata = entry.modifyReplace( mdn, addatt );
			  }else{ 
				  boolean idata = entry.add( mdn, addatt );
			  }   
		  }
	  }
  }
  
%>  
  
