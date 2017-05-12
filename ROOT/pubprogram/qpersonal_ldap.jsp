<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qpersonal.jsp
說明：該單位之人員
開發者：chmei
開發日期：96.11.18
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>雲林縣政府全球資訊網網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>

<%
  String formname = ( String )request.getParameter( "formname" );
  String colname = ( String )request.getParameter( "colname" );
  String pcolname = ( String )request.getParameter( "pcolname" );
  
  String datavalue = ( String )request.getParameter( "datavalue" );
  if ( datavalue == null || datavalue.equals("null") ) 
	  datavalue = "";

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

  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE  );
  
  boolean qdata = entry.query( ds_root, "dn,cn,objectclass,uid,chinesetitle,carlicense,mail", "objectclass=department",  SvLdap.QUERYSUBTREE );
  
%>

<script>
  arry_mpunitdn = new Array(99);
  <%
    String mpersoal = "";
    String mpunitdn = "";
    if ( qdata )
    {
    	SvNetscapeLdap qou = null;
    	boolean qcn = false;
    	while ( entry.next() ) {
    		if ( mpunitdn.equals("") )
     		   mpunitdn = entry.getString("dn");
    		
    		if ( !entry.getString("dn").equals(mpunitdn) ) { %>
    			arry_mpunitdn["<%=mpunitdn%>"] = "<%=mpersoal%>";
    			<%
    			  mpunitdn = entry.getString("dn");
    			  mpersoal = "";
    		}
    		
    		qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE  );    		  
    		qcn = qou.query( mpunitdn, "dn,cn,objectclass,uid,chinesetitle,carlicense,mail", "objectclass=users",  SvLdap.QUERYSUBTREE );
    		
    		while ( qou.next() ) {
    			if ( mpersoal.equals("") ) {
    				mpersoal = qou.getString("dn") + "-" + qou.getString("cn");
    			}else{
    				mpersoal = mpersoal + "||" + qou.getString("dn") + "-" + qou.getString("cn");
    			}
    		}
    		
       }%>
       arry_mpunitdn["<%=mpunitdn%>"] = "<%=mpersoal%>";
    <%}%> 
</script>    

<script for=window event=onload language="JScript">   
   var thisform = "document.<%=formname%>.<%=colname%>";
   var mform = "document.<%=formname%>.punit";
   var mpunit = eval(mform).value;
   eval(thisform).options.length = 1;
   eval(thisform).options[0].value = "";
   eval(thisform).options[0].text = "---請選擇---";        
   ary_mpunit = mpunit.split("||");
   mdata = arry_mpunitdn[ary_mpunit[0]];
   if ( mdata != null )
   {
      array_mdata = mdata.split("||");
      eval(thisform).options.length = array_mdata.length+1;
      
      for ( k=0; k<array_mdata.length; k++ )
      { 
         len = array_mdata[k].indexOf("-");
         arry_boss = array_mdata[k].substr(0,len);
         eval(thisform).options[k+1].value=array_mdata[k];
         eval(thisform).options[k+1].text=array_mdata[k].substr(len+1);
         <%
           if ( !datavalue.equals("") ) { %>
              if ( arry_boss == "<%=datavalue%>" )
                 eval(thisform).options[k+1].selected=true;
           <%}%>
      }
   }

</script>

<script>
  function qrypersonal(fname)
  {
     var thisform = "document.<%=formname%>.<%=colname%>"; 
     var mform = "document.<%=formname%>." + fname;
     var mpunit = eval(mform).value;     
     eval(thisform).options.length = 1;
     eval(thisform).options[0].value = "";
     eval(thisform).options[0].text = "---請選擇---";
     ary_mpunit = mpunit.split("||");
     mdata = arry_mpunitdn[ary_mpunit[0]];
     
     if ( mdata != null ) 
     {
        array_mdata = mdata.split("||");
        eval(thisform).options.length = array_mdata.length+1;
        
        for ( k=0; k<array_mdata.length; k++ )
        { 
           len = array_mdata[k].indexOf("-");
           arry_boss = array_mdata[k].substr(0,len);
           eval(thisform).options[k+1].value=array_mdata[k];
           eval(thisform).options[k+1].text=array_mdata[k].substr(len+1);
        }
     }
  }   
</script>

<select name="<%=colname%>">
   <option value="">---請選擇---</option>
</select>


