<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：left.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：97.02.13
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(images/leftbt_bg.jpg);
	background-repeat: repeat-y;
}
-->
</style>

<link href="css/scrollbar.css" rel="stylesheet" type="text/css" />
<link href="css/text1.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
.md2 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
}
.md21 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
}
.md22 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
}
.md23 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
}
.md24 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
}
-->
</style>

<script>
  function go(para)
  {
     document.show4.action="indexreload.jsp?mydn="+para;
     document.show4.target="leftFrame";
     document.show4.method="post"
     document.show4.submit();
  }  
  
  function run(murl,mpunit,mnum)
  {
     document.show4.mpunit.value=mpunit;
     document.show4.pagesize.value=mnum;
     document.show4.murl.value=murl;
     document.show4.action=murl;
     document.show4.target="mainFrame";
     document.show4.method="post";
     document.show4.submit();
  }  
  
  var mLeftbarWidth = "38";
  var mLeftbarOpenWidth = "190";
  
  function fCloseFrame()
  {
     top.menuFram.cols = mLeftbarWidth + ",*";
  }
  
  function fOpenFrame()
  {
     top.menuFram.cols = mLeftbarOpenWidth + ",*";
  }
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.SvString" %>

<%
  String murl = ( String )request.getParameter( "murl" );
  if ( murl == null || murl.equals("null") )
	  murl = "";
  String flag = ( String )request.getParameter( "flag" );
  if ( flag == null || flag.equals("null") )
	  flag = "";
  
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
  
  int ds_port=Integer.parseInt(port);

  //自session取得登入者的資料
  String logindn = ( String )session.getAttribute("logindn");
  String passwd = ( String )session.getAttribute("passwd");
      
  //判斷登入者是否為系統管理者
  //查詢系統功能數
  SvNetscapeLdap qall = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean qallno = qall.query( ds_ap, "dn,sysname,url,punit,number", SvLdap.QUERYONELEVEL );  
  
  //傳回qall search 的結果總共有幾筆資料
  int arcount = qall.getRecordCount();
  
  SvNetscapeLdap qap4 = new SvNetscapeLdap( ds_server, ds_port, logindn, passwd, SvLdap.ENCODEUNICODE );
  boolean quser4 = qap4.query( ds_ap, "dn,sysname,url,punit,number", SvLdap.QUERYONELEVEL );
  int ucount = qap4.getRecordCount();
  if ( arcount == ucount )
	  session.setAttribute("role","admin");
  else
	  session.setAttribute("role","");

  //查詢使用者權限
  SvNetscapeLdap quser = new SvNetscapeLdap( ds_server, ds_port, logindn, passwd, SvLdap.ENCODEUNICODE );
  boolean qlogin = quser.query( ds_ap, "dn,sysname,url,punit,number", SvLdap.QUERYSUBTREE );  
  
  //傳回quser search 的結果總共有幾筆資料
  int urcount = 0;
  if ( qlogin )
     urcount = quser.getRecordCount();
    
  //宣告陣列
  String len_udn[] = new String[urcount]; 
  String ary_udn[] = new String[urcount];
  String ary_uname[] = new String[urcount];
  String ary_uurl[] = new String[urcount];
  String ary_upunit[] = new String[urcount];
  String ary_unumber[] = new String[urcount];
  int ary_ulevel[] = new int[urcount];
  
  //宣告變數
  String string_udn = "";
  String string_uname = "";
  String string_uurl = "";
  String string_upunit = "";
  String string_unumber = "";

  //使用者權限寫入陣列
  int unumber = 0;
  while ( quser.next() )
  {
	  len_udn = SvString.split(quser.getString( "dn" ),',');
	  ary_udn[unumber] = quser.getString( "dn" );
	  ary_uname[unumber] = quser.getString( "sysname" );
	  ary_uurl[unumber] = quser.getString( "url" );
	  ary_upunit[unumber] = quser.getString( "punit" );
	  ary_unumber[unumber] = quser.getString( "numbrt" );
	  ary_ulevel[unumber] = len_udn.length;
	  unumber = unumber + 1;
  }
   
  //找尋使用者所擁有功能的第一層AP，及DN的長度等於4
  String dsap[] = SvString.split( ds_ap,',' );
  int dsap_len = dsap.length;
  int fun_count = ary_udn.length;
  String ary_udn4[] = new String[fun_count];  
  String ary_uname4[] = new String[fun_count];
  String ary_uurl4[] = new String[fun_count];
  String ary_upunit4[] = new String[fun_count];
  String ary_unumber4[] = new String[fun_count];
  String dn4 = "";
  int index = 0;
  
  for ( int k=0; k<fun_count; k++ )
  {
	  String aryudn[] = SvString.split( ary_udn[k],',' );
	  int lendn = aryudn.length - dsap_len;
	  if ( lendn >= 1 )
	  {
		  String newudn = aryudn[lendn-1] + "," + ds_ap;
		  SvNetscapeLdap qdn4 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
		  boolean rtn = qdn4.query( newudn, "dn,sysname,url,punit,number", "startusing=Y", SvLdap.QUERYBASE ); 
		  
		  if ( rtn )
		  {
			  while ( qdn4.next() )
			  {
				  String ary_dn4[] = SvString.split( dn4,'&' );
				  boolean find_dn = SvString.contain(ary_dn4,newudn);
				  if ( find_dn == false )
				  {
					  ary_udn4[index] = qdn4.getString( "dn" );
					  ary_uname4[index] = qdn4.getString( "sysname" );
					  ary_uurl4[index] = qdn4.getString( "url" );
					  ary_upunit4[index] = qdn4.getString( "punit" );
					  ary_unumber4[index] = qdn4.getString( "number" );
					  if ( dn4.equals("") )
						  dn4 = qdn4.getString( "dn" );
					  else
						  dn4 = dn4 + "&" + qdn4.getString( "dn" );
					  
					  //將使用者的第一層AP組成變數傳至下一個網頁
					  if ( string_udn.equals("") )
	   	                string_udn = qdn4.getString( "dn" );
	   	              else
	   	                string_udn = string_udn + "&" + qdn4.getString( "dn" );
					  
	   	              if ( string_uname.equals("") )
	   	                string_uname = qdn4.getString( "sysname" );
	   	              else
	   	                string_uname = string_uname + "&" + qdn4.getString( "sysname" );
	   	              
	   	              if ( string_uurl.equals("") )
	   	                string_uurl = qdn4.getString( "url" );
	   	              else
	   	                string_uurl = string_uurl + "&" + qdn4.getString( "url" ); 
	   	              
	   	              String mpunit = qdn4.getString( "punit" );
	   	              
	   	              if ( (mpunit == null) || mpunit.equals("") )
	   	            	  mpunit = "a";
	   	              if ( string_upunit.equals("") )
	   	            	  string_upunit = mpunit;
	   	              else
	   	            	  string_upunit = string_upunit + "&" + mpunit;
	   	              
	   	              String mnum = qdn4.getString( "number" );
	   	              if ( mnum == null )
	   	            	  mnum = "15";
	   	              if ( string_unumber.equals("") )
	   	            	string_unumber = mnum;
	   	              else
	   	            	string_unumber = string_unumber + "&" + mnum;
	   	              index = index + 1;  
	   	          }                 	  	
	          }
		  }		    
      }
  }	
  
%>

<body>
<form name="show4">
<input type="hidden" name="string_udn" value="<%=string_udn%>">
<input type="hidden" name="string_uname" value="<%=string_uname%>">
<input type="hidden" name="string_uurl" value="<%=string_uurl%>">
<input type="hidden" name="string_upunit" value="<%=string_upunit%>">
<input type="hidden" name="string_unumber" value="<%=string_unumber%>">
<input type="hidden" name="urcount" value="<%=urcount%>">
<input type="hidden" name="mpunit">
<input type="hidden" name="pagesize">
<input type="hidden" name="murl">

<td>
  <table width="10%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="100%" colspan="2" align="left">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><img src="images/left2.jpg" alt="" width="199" height="34"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="left" valign="top" >
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="left" valign="top" class="left_bg">
              <table width="100%" border="0">
                <tr>
                  <td><img src="images/d.gif" alt="" width="16" height="5"></td>
                </tr>
                <tr>
                  <td><a href="javascript:fOpenFrame()"><img src="images/left_over1.gif" alt="*" width="14" height="15" border="0"></a></td>
                </tr>
                <tr>
                  <td><a href="javascript:fCloseFrame()"><img src="images/left_bu2.gif" alt="*" width="14" height="15" border="0"></a></td>
                </tr>
              </table>
            </td>
            <td align="left" valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <%
                  for ( int i=0; i<index; i++ )  {
                	  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
                	  boolean qrtn = entry.query( ary_udn4[i], "dn,sysname,url", SvLdap.QUERYSUBTREE );
                	  if ( qrtn ) {
                		  if ( entry.getRecordCount() == 1 ) { %>
                			  <tr>
                			    <td valign="middle" class="butonbg">
                			      <a href="javascript:run('<%=ary_uurl4[i]%>','<%=ary_upunit4[i]%>','<%=ary_unumber4[i]%>')" class="link-title"><%=ary_uname4[i]%></a> 
                			    </td>
                			  </tr>
                		  <%}else{%>
                			  <tr>
                			    <td valign="middle" class="butonbg">
                			      <a href="javascript:go('<%=ary_udn4[i]%>')" class="link-title"><%=ary_uname4[i]%></a>
                			    </td>
                			  </tr>
                		  <%}
                	  }
                  }%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</td>

</form>
</body>
</html>

<%
  if ( !murl.equals("") ) {
	  if ( flag.equals("run") ) {
		  boolean find_aci = SvString.contain(ary_uurl,murl);
		  if ( find_aci ) { %>
			  <script>
			     run('<%=murl%>','','15');
			  </script>
		  <%}else{%>
			  <script>
			     alert("您目前無此功能權限，若有任何問題請與系統管理者連絡！");
			     top.location.href="login.jsp";
			  </script>
		  <%}
	  }else{%>
		  <script>
		     go('<%=murl%>');
		  </script>
	  <%}
  }%>
