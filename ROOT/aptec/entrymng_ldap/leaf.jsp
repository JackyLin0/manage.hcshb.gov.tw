<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：leaf.jsp
說明：人員組織管理(修改人員)
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
    if (document.mform.cn.value == '')
    {
       alert( "【姓名】欄位不能空白，請輸入!! " )
       document.mform.cn.focus(); 
       return;
    }
    if ( document.mform.carlicense.value != '' )
    {
       if ( !id_check(document.mform.carlicense) ) 
       {
          document.mform.carlicense.focus();
          return;
       }
    }
    
    document.mform.action="leafupd.jsp";
    document.mform.method="post";
    document.mform.submit();  
  } 
    
   function del()
   {
      x=window.confirm("確定刪除嗎?");
      if (x)
        {
         document.mform.action="leafdel.jsp"
         document.mform.method="post";
         document.mform.submit();
        }       
    }  

  //檢核輸入的身分證號
  function id_check(obj)
  {
	var pid=obj.value;
	pid = pid.toUpperCase();
	   
	if(pid.length!=10){
		alert("【身分證號】長度錯誤，請重新輸入！");
		return false;
	}
	   	   
	var arr = new Array('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','X','Y','W','Z','I','O');	
	sum= new Number(0);
	for(var i=0;i<=25;i++){		
		if (pid.substring(0,1)==arr[i]){
			sum=parseInt(sum+((10+i)%10)*9+(10+i)/10, 10);
		}
	}
	for (var i=2;i<=9;i++){
		n=new Number(pid.substring(i-1,i));
	 	sum=parseInt(sum+n*(10-i),10);
	}
	sum=10-parseInt(sum%10);
	c = new String(sum);
	sum2=c.substring(c.length-1,c.length);
	sum3=pid.substring(pid.length-1,pid.length);
	if(sum2!=sum3){
		alert("【身分證號】編碼錯誤，請重新輸入！");
		return false;
	}
	return true;	
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
  int ds_port=Integer.parseInt(port);
  String dn =  ( String )request.getParameter( "dn" );
  
  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE  );
  
  boolean qdata = entry.query( dn, "dn,cn,objectclass,uid,chinesetitle,employno,carlicense,mail", SvLdap.QUERYBASE );
  
%>  

<body>
<form name="mform">
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>人員組織管理</h2>
</div>
<p>

<a class="md" href="javascript:save();">儲存</a>	
<a class="md" href="javascript:del();">刪除</a>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
   <%
     if ( qdata ) {
    	 while ( entry.next() ) {
    		 String carlicense = entry.getString( "carlicense" );
    		 if ( carlicense == null || carlicense.equals("!") )
    			 carlicense = "";
    		 String email = entry.getString( "mail" );
    		 if ( email == null || email.equals("!") )
    			 email = "";  %>
    		 <!-------傳變數--------->
    		 <input type="hidden" name="dn"  value="<%=entry.getString( "dn" )%>">
             <input type="hidden" name="uid" value="<%=entry.getString( "uid" )%>">
             <input type="hidden" name="flag" value="old"> 
    		 <tr>
    		   <th colspan="4"><%=entry.getString( "cn" )%>--基本資料設定--<%=entry.getString( "dn" )%></th>
    		 </tr>    		 
    		 <tr class="tr">
    		   <td class="T12b"><span class="T12red">※</span>使用者帳號&nbsp;</td>
    		   <td colspan="3">
    		     <input name="uid" type="text" class="lInput01" size="20" value="<%=entry.getString( "uid" )%>" readonly>
    		   </td>
    		 </tr>
    		 <tr>
    		   <td class="T12b" width="25%"><span class="T12red">※</span>姓　　　名&nbsp;</td>
    		   <td colspan="3">
    		     <input name="cn" type="text" class="lInput01" size="15" value="<%=entry.getString( "cn" )%>">
    		   </td>
    		 </tr>
    		 <tr>
    		   <td class="T12b">身分證字號</td>
    		   <td colspan="3">
    		     <input name="carlicense" type="text" class="lInput01" size="20" value="<%=carlicense%>">
    		   </td>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b">E-mail</td>
    		   <td colspan="3">
    		     <input name="email" type="text" class="lInput01" size="30" value="<%=email%>">
    		   </td>
    		 </tr>
    	 <%}%>
    	 <tr>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	 </tr>
   <%}%>

</table>

</body>
</html>
