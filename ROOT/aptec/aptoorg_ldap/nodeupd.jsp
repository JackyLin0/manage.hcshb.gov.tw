<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：nodeupd.jsp
說明：系統權限設定
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.SvString" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

<%@ include file="addatt.jsp"%>

<%
  String errMsg="0";

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
  
  int ds_port=Integer.parseInt(port);

  String dn =  ( String )request.getParameter( "dn" );

  SvNetscapeLdap mdy = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean mdata = true;
  
  if ( p==1 )
	  mdata = mdy.modifyDelete( dn, addatt );
  else
	  mdata = mdy.modifyReplace( dn, addatt, attrs );

  if ( mdata == false )
    errMsg="ds addNew error: " + mdy.getErrorMsg();
  else
    errMsg = "權限已修改成功!!";  
%>   

<script>
    alert("<%=errMsg%>")
    parent.treeleft.location.reload();
    window.location.href="node.jsp?dn=<%=dn%>";	
</script>
