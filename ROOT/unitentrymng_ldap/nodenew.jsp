<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：nodenew.jsp
說明：人員組織管理(新增單位)
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

<html lang="zh-TW" xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>人員組織設定</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script>
  function save()
  {
    if (document.mform.ou.value == '')
    {
       alert( "【局(室)代碼】欄位不能空白，請輸入!! " )
       document.mform.ou.focus(); 
       return;
    }    
    if (document.mform.ctitle.value == '')
    {
        alert( "【局(室)名稱(中文)】欄位不能空白，請輸入!! " )
        document.mform.ctitle.focus(); 
        return;
    }
    
    document.mform.action="nodeadd.jsp";
    document.mform.method="post";
    document.mform.submit();  
  } 

</script>

</head>

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
  
  String dn = ( String )request.getParameter( "dn" );  

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );

  boolean qdata = qou.query( dn, "dn,chinesetitle,objectclass,ou,", SvLdap.QUERYBASE );

%>  

<body>
<form name="mform">
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>人員組織管理</h2>
</div>
<p>

<a class="md" href="javascript:save();">儲存</a>	
<a class="md" href="javascript:window.location.href='javascript:history.go(-1)'">上一頁</a>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
   <%
     if ( qdata ) {
    	 while ( qou.next() ) { 
    		 String ctitle = qou.getString( "chinesetitle" );
    		 if ( dn.equals(ds_root) )
    			 ctitle = "新竹縣政府";  %>
    		 <!-------傳變數--------->
    		 <input type="hidden" name="dn" value="<%=dn%>">
    		 <tr>
    		   <th colspan="4"><%=ctitle%>--下新增組織設定</th>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b" width="42%"><span class="T12red">※</span>局(室)代碼 &nbsp;</td>
    		   <td colspan="3">
    		     <input name="ou" type="text" class="lInput01" size="30">
    		   </td>
    		 </tr>
    		 <tr>
    		   <td class="T12b"><span class="T12red">※</span>局(室)名稱(中文)&nbsp;</td>
    		   <td colspan="3">
    		     <input name="ctitle" type="text" class="lInput01" size="65">
    		   </td>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b">局(室)名稱(英文)</td>
    		   <td colspan="3">
    		     <input name="etitle" type="text" class="lInput01" size="65">
    		   </td>
    		 </tr>
    		 <tr>
    		   <td class="T12b">局(室)名稱(日文)</td>
    		   <td colspan="3">
    		     <input name="jtitle" type="text" class="lInput01" size="65">
    		   </td>
    		 </tr>
    	 <%}%>
    	 <tr class="tr">
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	 </tr>
   <%}%>

</table>

</body>
</html>
