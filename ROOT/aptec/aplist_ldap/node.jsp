<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：node.jsp
說明：應用系統管理(修改)
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
<%@ page import="tw.com.sysview.dba.*" %>

<html>
<head>

<title>應用系統設定</title>
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
        return 0
     }
              
     document.mform.action="nodeupd.jsp";
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

  String dn = ( String )request.getParameter( "dn" );  

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  String attrib="dn,ou,sysname,url,punit,number,startusing,acitarget,acitargetattr,aciname,aciallowuserdn,aciuserdn";
  boolean qdata = qou.query( dn, attrib, "objectclass=aptree", SvLdap.QUERYBASE );
  
  String[] ary_dn = SvString.split(dn,",");

%>  

<body>
<form name="mform">
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>應用系統設定</h2>
</div>
<p></p>

<a class="md" href="javascript:save();">儲存</a>	
<a class="md" href="javascript:window.location='nodedel.jsp?dn=<%=dn%>'">刪除</a>
<a class="md" href="javascript:window.location='nodenew.jsp?dn=<%=dn%>'">新增系統</a>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
   <%
     if ( qdata == false ) {  %>
    	 <h1>ERROR:<%=qou.getErrorMsg()%></h1> <%
    	 return;
     }
     if ( qdata ) {
    	 while ( qou.next() ) { %>
    		 <!-------傳變數--------->
    		 <input type="hidden" name="dn" value="<%=dn%>" />
    		 <input type="hidden" name="ou" value="<%=qou.getString( "ou" )%>" />
    		 <tr>
    		   <th colspan="4"><%=qou.getString( "sysname" )%>&nbsp;&nbsp;應用系統設定</th>
    		 </tr>
    		 <tr>
    		   <td class="T12b" width="30%">應用系統 DN</td>
    		   <td colspan="3">
    		     <input name="dn" type="text" class="lInput01" size="80" value="<%=qou.getString( "dn" )%>" readonly />
    		   </td>
    		   <input type="hidden" name="dn" value="<%=qou.getString( "dn" )%>" />
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b"><span class="T12red">※</span>應用系統名稱</td>
    		   <td colspan="3">
    		     <input name="sysname" type="text" class="lInput01" size="80" value="<%=qou.getString( "sysname" )%>" />
    		   </td>
    		 </tr>
    		 <tr >
    		   <td class="T12b"><span class="T12red">※</span>應用系統代碼</td>
    		   <td colspan="3">
    		     <input name="ou" type="text" class="lInput01" size="70" value="<%=qou.getString( "ou" )%>" />
    		   </td>
    		 </tr>
    		 <tr class="tr">
    		   <td class="T12b">ＵＲＬ</td>
    		   <td colspan="3">
    		     <input name="url" type="text" class="lInput01" size="80" value="<%=qou.getString( "url" )%>" />
    		   </td>
    		 </tr>
    		 <%
    		   SvNetscapeLdap qunit = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    		   boolean qtitle = qunit.query( ds_root, "dn,chinesetitle", "objectclass=department", SvLdap.QUERYONELEVEL );
    		 %>
    		 <tr>
    		   <td class="T12b">主要負責局室</td>
    		   <td colspan="3">
    		     <select name="punit" size="5" multiple>
    		     <%
    		       if ( qtitle ) {
    		    	   while ( qunit.next() )  {
    		    		   String ounitdn = qou.getString( "punit" );
    		    		   String[] ary_ounitdn = SvString.split(ounitdn,"||");
    		    		   String isSelected = "";
    		    		   boolean find_dn = SvString.contain(ary_ounitdn,qunit.getString( "dn" ));
    		    		   if ( find_dn )
    		    			   isSelected = "selected";
    		    		   String[] ary_mdn = SvString.split(qunit.getString( "dn" ),",");
    		    		   String mdn1 = qunit.getString( "dn" );
    		    		   String munitdn = (qunit.getString( "dn" )).replace(',','*');  %>
    		    		   <option value=<%=munitdn%> <%=isSelected%>><%=qunit.getString( "chinesetitle" )%></option>
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
    		   if ( ary_dn.length == 4 ) {
    			   WebSiteData query = new WebSiteData();    			   
    			   boolean rtn = query.load(dn);  %>
    			   <tr>
    			     <td class="T12b">WebSite</td>
    			     <td colspan="3">
    			       <input type="radio" name="website" value="Y" onclick="chg()" <%=((rtn) ? "checked" : "")%> />是&nbsp;&nbsp;
    			       <input type="radio" name="website" value="N" onclick="chg()" <%=((!rtn) ? "checked" : "")%> />否
    			     </td>
    			   </tr>
    			   <%
    			     SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    			     boolean qweb = qou1.query( ds_root, "dn,chinesetitle", "objectclass=department", SvLdap.QUERYONELEVEL );
    			     WebSiteData qwebunit = new WebSiteData();
    			     ArrayList<Object> qwebs = qwebunit.findByweb(dn);
    			     int rcount = qwebunit.getAllrecordCount();
    			     String[] ary_website = null;
    			     String mwebsite = "";
    			     if ( qwebs != null ) {    			    	 
    			    	 for ( int i=0; i<rcount; i++ ) {
    			    		 WebSiteData qweb1 = ( WebSiteData )qwebs.get( i );
    			    		 if ( mwebsite.equals("") ) 
    			    			 mwebsite = qweb1.getPubunitdn();
    			    		 else
    			    			 mwebsite = mwebsite + "||" + qweb1.getPubunitdn();
    			    	 }
    			    	 if ( !mwebsite.equals("") )
    			    		 ary_website = SvString.split(mwebsite,"||");
    			     }	 
    			     String style = "style='display:none'";
    			     if ( rtn )
    			    	 style = "style='display:block'";
    			   %>
    			   <tr id='type0' <%=style%>>
    			     <td class="T12b">網站對應局室</td>
    			     <td>
    			       <select name="punitweb" size="5" multiple>
    			         <%
    			           if ( qweb ) {
    			        	   while ( qou1.next() )  {
    			        		   String munitdn = (qou1.getString( "dn" )).replace(',','*');
    			        		   String datavalue = munitdn + "||" + qou1.getString( "chinesetitle" );
    			        		   String isSelected = "";
    			        		   if ( SvString.contain(ary_website,qou1.getString( "dn" )) )
    			        			   isSelected = "selected"; %>
    			        		   <option value=<%=datavalue%> <%=isSelected%>><%=qou1.getString( "chinesetitle" )%></option>
    			        	   <%}
    			           }%>
    			       </select><br />&nbsp;
    			       <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    			     </td>
    			   </tr>
    			   <%
    			     if ( rtn ) {  %>
    			    	 <tr class="tr">
        			       <td class="T12b">Language</td>
        			       <td colspan="3">
        			         <input type="radio" name="islanguage" value="Chinese" <%=((query.getIslanguage().equals("Chinese")) ? "checked" : "")%> />中文版&nbsp;&nbsp;
        			         <input type="radio" name="islanguage" value="English" <%=((query.getIslanguage().equals("English")) ? "checked" : "")%> />英文版&nbsp;&nbsp;
        			         <input type="radio" name="islanguage" value="Japan" <%=((query.getIslanguage().equals("Japan")) ? "checked" : "")%> />日文版&nbsp;&nbsp;
        			         <input type="radio" name="islanguage" value="" />無
        			       </td>
        			     </tr>
    			     <%}else{%>
    			    	 <tr class="tr">
    			    	   <td class="T12b">Language</td>
    			    	   <td colspan="3">
    			    	     <input type="radio" name="islanguage" value="Chinese" checked />中文版&nbsp;&nbsp;
    			    	     <input type="radio" name="islanguage" value="English" />英文版&nbsp;&nbsp;
    			    	     <input type="radio" name="islanguage" value="Japan" />日文版&nbsp;&nbsp;
    			    	     <input type="radio" name="islanguage" value="" />無
    			    	   </td>
    			    	 </tr>
    			     <%}
    			   String mstartusing = "N";
    			   if ( qou.getString("startusing") != null && !qou.getString("startusing").equals("null") && !qou.getString("startusing").equals("") )
    				   mstartusing = qou.getString("startusing");
    			   %>
    			   <tr>
    			     <td class="T12b">是否啟用</td>
    			     <td colspan="3">
    			       <input type="radio" name="startusing" value="Y" <%=(mstartusing.equals("Y") ? "checked" : "")%> />是&nbsp;&nbsp;
    			       <input type="radio" name="startusing" value="N" <%=(mstartusing.equals("N") ? "checked" : "")%> />否&nbsp;&nbsp;
    			       <span class="T10">(此站台是否有建站)</span>
    			     </td>
    			   </tr>
    		   <%}
    	 }%>
    	 <tr class="tr01">
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	   <th>&nbsp;</th>
    	 </tr>
   <%}%>

</table>

</body>
</html>
