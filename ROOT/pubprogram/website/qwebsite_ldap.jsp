<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qwebsite.jsp
說明：找尋登入者可發布站台
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登入者可發布站台</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

</head>

<%
  //取系統路徑
  String sysRoot2 = (String) application.getRealPath("");
  //判斷OS版本
  String Ldap_PATH = "";
  if ( sysRoot2.indexOf("/") == -1 )
	  Ldap_PATH = sysRoot2 + "\\WEB-INF\\ldap.properties";
  else
	  Ldap_PATH = sysRoot2 + "/WEB-INF/ldap.properties";

  Properties ldap = new Properties();
  ldap.load(new FileInputStream(Ldap_PATH) );
  String ds_server = ldap.getProperty("ds_server");
  String port = ldap.getProperty("ds_port");
  String ds_ap = ldap.getProperty("ds_ap");
  
  int ds_port=Integer.parseInt(port);
  
  String colname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String webdata = "";
  if ( datavalue != null && !datavalue.equals("") ) {
	  String[] ary_website = SvString.split(datavalue,"||");
	  webdata = ary_website[0];
  }
  
  //自session取得登入者的資料
  String login1 = ( String )session.getAttribute("logindn");
  String passwd1 = ( String )session.getAttribute("passwd");

  SvNetscapeLdap qap4 = new SvNetscapeLdap( ds_server, ds_port, login1, passwd1, SvLdap.ENCODEUNICODE );
  boolean quser4 = qap4.query( ds_ap, "dn,sysname,url,punit,number", SvLdap.QUERYONELEVEL );

  if ( quser4 ) {  %>
      <select name="<%=colname%>" class="select">
        <%
          //自session找出角色
          String role1 = ( String )session.getAttribute("role");
          if ( !role1.equals("") )  { %>
        	  <option value="" selected>請選擇站台</option>        	          	  
          <%}
          String mlanguage = "";
          while ( qap4.next() ) {
        	  WebSiteData query = new WebSiteData();
        	  
        	  if ( language.equals("ch") )
        		  mlanguage = "chinese";
			  else if ( language.equals("en") )
				  mlanguage = "english";
			  else if ( language.equals("jp") )
				  mlanguage = "japan";
        	  
        	  boolean rtn = query.load(qap4.getString( "dn" ),mlanguage);
        	  out.println(rtn);
        	  if ( rtn ) {
        		  String isSelected = "";
        		  if ( qap4.getString( "dn" ).equals(webdata) )
      		    	isSelected = "selected";
        		  String mweb = qap4.getString( "dn" ) + "||" + qap4.getString( "sysname" ); %>
        		  <option value="<%=mweb%>" <%=isSelected%>><%=qap4.getString( "sysname" )%></option>
        	  <%}  
          }%>
      </select>  
  <%}%>
</html>

