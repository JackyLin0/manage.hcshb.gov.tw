<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：nodedel.jsp
說明：應用系統管理(刪除)
開發者：chmei
開發日期：97.02.11
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
  String ds_ap = ldap.getProperty("ds_ap");
  
  int ds_port=Integer.parseInt(port);

  String mdn =  ( String )request.getParameter( "dn" );

  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  
  if ( entry.query( mdn, "dn", SvLdap.QUERYONELEVEL ))
  {  %>
	  <script>
	     alert(" 因本系統尚有子系統,故不得刪除.請先將系統位所屬子系統刪除!");
	     history.go(-1);
	  </script>	
  <%}else{  
	  if ( !entry.delete( mdn )) {
		  errMsg = "ds del errMsg:" + entry.getErrorMsg();
	  }else{
		  errMsg = "本應用系統刪除成功!!";
		  WebSiteData uweb = new WebSiteData();
    	  uweb.setWebsitedn(mdn);
    	  uweb.remove();
	  }	  
	  
    } %>

<script>
    alert("<%=errMsg%>")
    parent.treeleft.location.reload();
    window.location.href="node.jsp?dn=<%=ds_ap%>";		
</script>
    