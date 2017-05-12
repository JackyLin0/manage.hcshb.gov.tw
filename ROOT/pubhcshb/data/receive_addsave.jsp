<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：receive_addsave.jsp
說明：多網接收維護
開發者：chmei
開發日期：97.02.16
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

  //參數
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String language = ( String )request.getParameter( "language" );
  
  String logindn = ( String )request.getParameter( "logindn" );
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String website = ( String )request.getParameter( "website" );
  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String aplistname = ( String )request.getParameter( "aplistname" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  
  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  String pubwebsitedn = "";
  String pubwebsitename = "";
  if ( qou1.query( website, "dn,sysname", "objectclass=aptree", SvLdap.QUERYBASE ) ) {
	  while ( qou1.next() ) {
		  pubwebsitedn = qou1.getString( "dn" );
		  pubwebsitename = qou1.getString( "sysname" );
	  }
  }
  
  String logincn = ( String )session.getAttribute( "logincn" );

  String websitedn = "";
  String websitename = "";
  String isexamine = "";
  
  int rcount = Integer.parseInt(( String )request.getParameter( "rcount" ));
  for ( int i=0; i<rcount; i++ ) {
	  String check = ( String )request.getParameter( "check"+i );
	  if ( check != null ) {
		  String[] ary_check = SvString.split(check,"||");
		  String misexamine = ( String )request.getParameter( "isexamine"+i );
		  if ( websitedn.equals("") ) {
			  websitedn = ary_check[0];
			  websitename = ary_check[1];
			  isexamine = misexamine;
		  }else{
			  websitedn = websitedn + "||" + ary_check[0];
			  websitename = websitename + "||" + ary_check[1];
			  isexamine = isexamine + "||" + misexamine;
		  }
	  }
  }

  PublishData obj = new PublishData();  
  
  boolean rtn = true ;
  String errMsg="0";   

  obj.setAplistdn(aplistdn);
  obj.setAplistname(aplistname);
  obj.setPubwebsitedn(pubwebsitedn);
  obj.setPubwebsitename(pubwebsitename);
  obj.setWebsitedn(websitedn);
  obj.setWebsitename(websitename);
  obj.setIsexamine(isexamine);
  obj.setFlag("R");
  obj.setPostname(logincn);
  
  //執行動作
  rtn = obj.createpub(table);    

  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "設定失敗！" + errMsg;
  }else{
	  showAlert="設定成功！";
  }

%>

<form name="mform" action="receive.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="website" value="<%=website%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
