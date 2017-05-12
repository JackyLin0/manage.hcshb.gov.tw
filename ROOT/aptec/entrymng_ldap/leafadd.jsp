<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：leafadd.jsp
說明：人員組織管理(新增人員)
開發者：chmei
開發日期：97.02.12
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

<%@ include file="addattlf.jsp"%>

<%
  String dn = ( String )request.getParameter( "dn" );
  String mdn = "uid=" + uid + "," + dn;
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
  
  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );

  if ( entry.query( dn, "uid", "uid=" + uid, SvLdap.QUERYSUBTREE ))
  {%>
     <script>
        alert( " 此使用者帳號已存在,請修正 !! " )
        history.go(-1)
     </script>
  <%}else{
      if ( !entry.add( mdn, addatt ) ) {
    	  errMsg = "ds addNew errMsg:" + entry.getErrorMsg();
      }else{
    	  errMsg = "本人員已新增成功!!";
      }
  } 

%>

<script>
    alert("<%=errMsg%>")
    parent.treeleft.location.reload();
    window.location.href="leaf.jsp?dn=<%=mdn%>";
</script>
