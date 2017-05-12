<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qunit.jsp
說明：發佈單位
開發者：chmei
開發日期：96.03.14
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發佈單位</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>

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
  String ds_ap = ldap.getProperty("ds_ap");
  String ds_root = ldap.getProperty("ds_root");
  
  int ds_port=Integer.parseInt(port);

  String onchange = ( String )request.getParameter( "onchange" );
  if ( onchange == null )
	  onchange = "";
  String logindn1 = ( String )session.getAttribute("logindn");
  String mpunit1 = ( String )request.getParameter( "mpunit" );
  if ( mpunit1 != null && !mpunit1.equals("null") )
	  session.setAttribute("mpunit",mpunit1);
  if ( mpunit1 == null || mpunit1.equals("null") )
	  mpunit1 = ( String )session.getAttribute("mpunit");
  
  String colname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String punitdata = "";
  if ( datavalue != null && !datavalue.equals("") ) {
	  String[] ary_punit = SvString.split(datavalue,"||");
	  punitdata = ary_punit[0];
  }	  
  
  if ( (logindn1 == null) || (logindn1.equals("null")) ) {  %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("index.jsp","_parent");
	  </script>
  <%}else{
	  String[] ary_logindn = SvString.split(logindn1,",");
	  String mlogindn = logindn1;
	  if ( ary_logindn.length > 4 ) {
		  for ( int i=0; i<ary_logindn.length-4; i++ ) {
			  mlogindn = SvString.right(mlogindn,",");
		  }
	  }
	  //此AP負責局室
	  String[] apunit = SvString.split(mpunit1,"||");
	  boolean find_dn = SvString.contain(apunit,mlogindn);
	  //自session找出角色
	  String role1 = ( String )session.getAttribute("role");
	  
	  if ( !find_dn && role1.equals("") ) {
		  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
		  String uname = "";
		  if ( qou1.query( mlogindn, "dn,chinesetitle,cn,uid,objectclass,ou", "objectclass=department", SvLdap.QUERYBASE ) ) {
			  while ( qou1.next() ) {
				  if ( language.equals("ch") )
					  uname = qou1.getString( "chinesetitle" );
				  else if ( language.equals("en") )
					  uname = qou1.getString( "englishtitle" );
				  else if ( language.equals("jp") )
					  uname = qou1.getString( "japantitle" );
				  String punit1 = mlogindn + "||" + uname;  %>
				  <input type="text" class="textarea" name="punit1" value=<%=uname%> size="20" readonly >
				  <input type="hidden" name="<%=colname%>" value="<%=punit1%>">
			  <%}
		  }
	  }else{
		  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
		  
		  if ( qou.query( ds_root, "dn,chinesetitle,cn,uid,objectclass,ou", "objectclass=department", SvLdap.QUERYONELEVEL ) ) { %>
			  <select name="<%=colname%>" class="select" <%=onchange%>>
			     <option value="" selected>請選擇單位</option>
			     <%
			       while ( qou.next()) {
			    	   String mdn = qou.getString( "dn" ); 
			    	   String[] ary_mdn = SvString.split(mdn,",");
			    	   String uname = "";
			    	   if ( ary_mdn.length == 4 ) {
			    		   if ( language.equals("ch") )
			    			   uname = qou.getString( "chinesetitle" );
			    		   else if ( language.equals("en") )
			    			   uname = qou.getString( "englishtitle" );
			    		   else if ( language.equals("jp") )
			    			   uname = qou.getString( "japantitle" );
			    		   
			    		   String unitvalue = qou.getString( "dn" ) + "||" + uname;  %>
			    		   <option value="<%=unitvalue%>" <%=(qou.getString( "dn" ).equals(punitdata) ? "selected" : "")%>><%=uname%></option>
			    		<%}
			       }%>
			  </select>     
		  <%}
	  }
  }%>

</html>

