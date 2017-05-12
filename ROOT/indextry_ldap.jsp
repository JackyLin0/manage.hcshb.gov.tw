<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：indextry.jsp
說明：管理端登入畫面
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
<%@ page import="tw.com.sysview.filter.qfilterSql"%>

<html lang="zh-TW">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新竹縣衛生局服務網後端管理系統</title>

<style type="text/css">
<!--
body {
	background-color: #afdfb7;
	background-image: url(images/bg.jpg);
	background-repeat: repeat-x;
	background-position: left top;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

</head>

<%
  String murl = ( String )request.getParameter( "murl" );
  if ( murl == null || murl.equals("null") )
	  murl = "";
  String flag = ( String )request.getParameter( "flag" );
  if ( flag == null || flag.equals("null") ) {
	  flag = "";
  } else {
	  //Sql_Injection
	  qfilterSql qcontentlink = new qfilterSql();
	  boolean rtn = qcontentlink.filterSql(flag);
	  if ( rtn )
	     flag = qcontentlink.getMcontent();
  }
  
  String loginap = ( String )session.getAttribute("loginap");
  String passwd = ( String )session.getAttribute("passwd");

  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  //department

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
  String ds_ap = ldap.getProperty("ds_ap");
  
  int ds_port=Integer.parseInt(port);

  SvNetscapeLdap prelogin = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean qdata = prelogin.query( ds_root, "dn,cn", "uid=" + loginap, SvLdap.QUERYSUBTREE );
  if ( !qdata )
  {%>
      <script>
        window.location="error.html";
      </script>
  <%}else{ 
      while ( prelogin.next() )
      {
          String userdn = prelogin.getString( "dn" );
          String usercn = prelogin.getString( "cn" );         
          SvNetscapeLdap login1 = new SvNetscapeLdap( ds_server, ds_port, userdn, passwd, SvLdap.ENCODEUNICODE );
          boolean qlogin = login1.query( userdn, "uid,carlicense", SvLdap.QUERYBASE );
          if ( !qlogin ) { %>
        	  <script>
                window.location="error.html";
              </script>
          <%}else{
        	  SvNetscapeLdap login = new SvNetscapeLdap( ds_server, ds_port, userdn, passwd, SvLdap.ENCODEUNICODE );
        	  boolean qap = login.query( ds_ap, "dn,sysname,url", SvLdap.QUERYSUBTREE );       
        	  if ( !qap ) {%>
                  <script>
                    alert("您目前尚無權限使用本系統，\n有任何疑問請連絡系統管理者，\n謝謝您！");
                    window.location.href="login.jsp";
                  </script>
              <%}else{
                  //尋找login者的單位名稱
                  String mdn = SvString.right(userdn,",");
                  String[] ary_mdn = SvString.split(mdn,",");
                  String unit_title = "";
                  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    	          boolean qunit = qou.query( mdn, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
    	          if ( qunit )
    	          {	  
    	        	  while ( qou.next() )
    	        	  {
    	        		  String mdn1 = mdn;
    	        		  String unitname = "";
    	        		  if ( ary_mdn.length > 4 ) {
    	        			  for ( int i=0; i<ary_mdn.length-4; i++ ) {
    	        				  mdn1 = SvString.right(mdn1,",");
    	        			  }
    	        			  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
    	        	          boolean qunit1 = qou1.query( mdn1, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
    	        	          if ( qunit1 ) {
    	        	        	  while ( qou1.next() ) {
    	        	        		  unitname = qou1.getString( "chinesetitle" );
    	        	        	  }
    	        	          }    	        	        	  
    	        		  }
    	        		  if ( !unitname.equals("") )
    	        			  unit_title = unitname + "&nbsp;" + qou.getString( "chinesetitle" );
    	        		  else
    	        			  unit_title = qou.getString( "chinesetitle" );    	        		  
      		          }
    	          }
                  //將登錄者存入session
                  session.setAttribute("uname",unit_title);
                  session.setAttribute("logindn",userdn);
                  session.setAttribute("passwd",passwd);
                  session.setAttribute("logincn",usercn);
                  session.setAttribute("loginap",loginap); 
              } 
          }
      }
  }
%>


<html lang="zh-TW">
<head>
<title>新竹縣衛生局服務網後端管理系統</title>
<meta HTTP-EQUIV="Expires" CONTENT="01-MAR-94 00:00:01 GMT">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      
</head>

<frameset rows="92,*" framespacing="0" frameborder="no" border="0">  
  <frame name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" src="top.jsp"/>
  
  <frameset id="menuFram" name="menuFram" cols="190,*" framespacing="0" frameborder="no" border="0">
		<frame id="leftFrame" name="leftFrame" noresize="noresize" id="leftFrame" title="leftFrame" src="left.jsp?murl=<%=murl%>&flag=<%=flag%>"/>
		<frame id="mainFrame" name="mainFrame" title="mainFrame" src="main.jsp"/>
  </frameset>
</frameset>

<noframes><body></body></noframes>

</html>
