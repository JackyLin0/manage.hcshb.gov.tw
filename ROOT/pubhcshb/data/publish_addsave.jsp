<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：publish_addsave.jsp
說明：動態程式發布設定
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
  
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String aplistname = ( String )request.getParameter( "aplistname" );
  String website = ( String )request.getParameter( "website" );
  
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

  String[] chk = request.getParameterValues("check");
  if ( chk == null ) { %>
	  <script>
	    alert("【您未勾選任何一項】");
	    window.history.go(-1);
	  </script>
  <%}else{
	  for ( int i=0; i<chk.length; i++ ) {
		  String[] ary_chk = SvString.split(chk[i],"||");
		  if ( websitedn.equals("") ) {
			  websitedn = ary_chk[0];
			  websitename = ary_chk[1];
		  }else{
			  websitedn = websitedn + "||" + ary_chk[0];
			  websitename = websitename + "||" + ary_chk[1];
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
  obj.setFlag("P");
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

<form name="mform" action="publish.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="website" value="<%=website%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 