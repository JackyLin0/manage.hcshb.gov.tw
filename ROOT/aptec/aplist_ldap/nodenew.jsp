<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：nodenew.jsp
說明：應用系統管理(新增)
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
<%@ page import="sysview.zhiren.function.*" %>

<html lang="zh-TW" xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>人員組織設定</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script>
  function chg()
  {
     for ( var i=0;i<document.all.website.length;i++ )
     {
        if ( document.all.website[i].checked )
        {
           var mflag_value = document.all.website[i].value;
           switch(mflag_value)
           {
              case "Y":  
                   window.type0.style.display='block';
                   break;
              case "N":  //動態網頁
                   window.type0.style.display='none';
                   break;
           }
        }
     }
  }               
         
  function save()
  {
     if (document.mform.sysname.value == ''){
        alert("【應用系統名稱】欄位不能空白，請輸入!!");
        document.mform.sysname.focus();
        return;
     }   
        
     if (document.mform.ou.value == ''){
        alert("【應用系統代碼】欄位不能空白，請輸入!!");
        document.mform.ou.focus();
        return; 
     }   

     document.mform.action="nodeadd.jsp";
     document.mform.method="post"
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

  String dn =  ( String )request.getParameter( "dn" );  
  
  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE  );
  boolean qdata = entry.query( dn, "dn,ou,sysname", SvLdap.QUERYBASE );
  
  String[] ary_dn = SvString.split(dn,",");

%>  

<body>
<form name="mform">
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>應用系統設定</h2>
</div>
<p></p>

<a class="md" href="javascript:save();">儲存</a>	
<a class="md" href="javascript:window.location.href='javascript:history.go(-1)'">上一頁</a>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
   <%
     if ( qdata ) {
    	 while ( entry.next() ) {  %>
    		 <tr>
    		   <th colspan="4"><%=entry.getString( "sysname" )%>&nbsp;&nbsp;下新增應用系統設定</th>
    		 </tr>
    		 <tr>
    		   <td class="T12b" width="30%">父系統DN</td>
    		   <td colspan="3">
    		     <input name="dn" type="text" class="lInput01" size="80" value="<%=dn%>" readonly />
    		   </td>
    		   <input type="hidden" name="dn" value="<%=dn%>" />
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b"><span class="T12red">※</span>應用系統名稱&nbsp;</td>
    		   <td colspan="3">
    		     <input name="sysname" type="text" class="lInput01" size="80" />
    		   </td>
    		 </tr>
    		 <tr>
    		   <td class="T12b"><span class="T12red">※</span>應用系統代碼&nbsp;</td>
    		   <td colspan="3">
    		     <input name="ou" type="text" class="lInput01" size="80" />
    		   </td>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b">ＵＲＬ</td>
    		   <td colspan="3">
    		     <input name="url" type="text" class="lInput01" size="80" value="http://" />
    		   </td>
    		 </tr>
    		 <%
    		   SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    		   boolean qtitle = qou.query( ds_root, "dn,chinesetitle", "objectclass=department", SvLdap.QUERYONELEVEL );
    		 %>
    		 <tr>
    		   <td class="T12b">主要負責局室</td>
    		   <td colspan="3">
    		     <select name="punit" size="5" multiple>
    		     <%
    		       if ( qtitle ) {
    		    	   while ( qou.next() )  {
    		    		   String munitdn = (qou.getString( "dn" )).replace(',','*');  %>
    		    		   <option value=<%=munitdn%>><%=qou.getString( "chinesetitle" )%></option>
    		    	   <%}
    		       }%>
    		     </select><br />&nbsp;
    		     <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    		   </td>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b">顯示筆數</td>
    		   <td colspan="3">
    		     <%
    		       String num = qou.getString( "number" );
    		       if ( num == null )
    		    	   num = "15";
    		     %>
    		     <input name="num" type="text" class="lInput01" size="20" value="<%=num%>" />
    		   </td>
    		 </tr>
    		 <%
    		   if ( ary_dn.length == 3 ) { %>
    			   <tr>
    			     <td class="T12b">WebSite</td>
    			     <td colspan="3">
    			       <input type="radio" name="website" value="Y" onclick="chg()" />是&nbsp;&nbsp;
    			       <input type="radio" name="website" value="N" onclick="chg()" checked />否&nbsp;&nbsp;
    			     </td>
    			   </tr>
    			   <%
    			     SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    			     boolean qweb = qou1.query( ds_root, "dn,chinesetitle", "objectclass=department", SvLdap.QUERYONELEVEL );
    			   %>
    			   <tr id='type0' style="display:none">
    			     <td class="T12b">網站對應局室</td>
    			     <td>
    			       <select name="punitweb" size="5" multiple>
    			         <%
    			           if ( qweb ) {
    			        	   while ( qou1.next() )  {
    			        		   String munitdn = (qou1.getString( "dn" )).replace(',','*');
    			        		   String datavalue = munitdn + "||" + qou1.getString( "chinesetitle" ); %>
    			        		   <option value=<%=datavalue%>><%=qou1.getString( "chinesetitle" )%></option>
    			        	   <%}
    			          }%>
    			       </select><br />&nbsp;
    			       <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>  			     
    			     </td>
    			   </tr>
    			   <tr class="tr">
    			     <td class="T12b">Language</td>
    			     <td colspan="3">
    			       <input type="radio" name="islanguage" value="Chinese" />中文版&nbsp;&nbsp;
    			       <input type="radio" name="islanguage" value="English" />英文版&nbsp;&nbsp;
    			       <input type="radio" name="islanguage" value="Japan" />日文版&nbsp;&nbsp;
    			       <input type="radio" name="islanguage" value="" checked />無
    			     </td>
    			   </tr>
    			   <tr>
    			     <td class="T12b">是否啟用</td>
    			     <td colspan="3">
    			       <input type="radio" name="startusing" value="Y" />是&nbsp;&nbsp;
    			       <input type="radio" name="startusing" value="N" checked />否&nbsp;&nbsp;
    			       <span class="T10">(此站台是否有建站)</span>
    			     </td>
    			   </tr>
    		   <%}
    	 }%>
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
