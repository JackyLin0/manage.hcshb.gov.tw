<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：ImportPeoperDS.jsp
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
  ArrayList qlists = query.findBypersonal();
  int rcount = query.getAllrecordCount();
  out.println("rcount="+rcount);
  //匯入人員
  if ( qlists != null ) {
	  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
	  for ( int i=0; i<rcount; i++ ) {
		  DSData qlist = ( DSData )qlists.get( i );
		  
		  String addatt = new String("objectclass=top,users");
		  String mdn = "uid=" + qlist.getUid() + "," + qlist.getDn();
		  addatt = addatt + ";uid=" + qlist.getUid();
		  addatt = addatt + ";userpassword=" + qlist.getUid();			  
		  addatt = addatt + ";carlicense=" + qlist.getId();			  
		  addatt = addatt + ";cn=" + qlist.getName();
		  addatt = addatt + ";mail=" + qlist.getEipemail();
		  
		  boolean qunitdn = qou.query( qlist.getDn(), "dn", SvLdap.QUERYBASE );
		  out.println("qunitdn="+qunitdn);
		  if ( qunitdn ) {			  
			 
			  if ( qou.query( qlist.getDn(), "uid", "uid=" + qlist.getUid(), SvLdap.QUERYSUBTREE ) ) {
				  boolean mdata = qou.modifyReplace( mdn, addatt );
				  out.println("mdata="+mdata);
			  }else{ 
				  boolean idata = qou.add( mdn, addatt );
				  out.println("idata="+idata);
			  }			  
		  }

	  }
  }
  
%>  