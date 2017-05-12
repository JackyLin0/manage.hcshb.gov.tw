<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：pubwebsite.jsp
說明：資料多方發布站台(新增、修改)
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>資料多方發布站台</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

</head>

<%  
  //尋找登入者的單位，設定欲發布之站台 start
  String aplistdn = ( String )request.getParameter( "webdn" );
  String logindn = ( String )session.getAttribute("logindn");
  String table = ( String )request.getParameter("t");
  String table1 = ( String )request.getParameter("t1");
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  //單位網站對照檔
  WebsiteUnitData qweb = new WebsiteUnitData();
  boolean rtnunit = qweb.load(pubunitdn);
  String unitweb = "";
  if ( rtnunit )
	  unitweb = qweb.getWebsitedn();

  PubWebsiteData qpub = new PubWebsiteData();
  ArrayList<Object> qpubwebs = qpub.findByday(table1,unitweb,aplistdn,"P");  
  int rcount = qpub.getAllrecordCount();  
  
  //尋找AP的table
  PubWebsiteData qtable = new PubWebsiteData();
  boolean rtn = qtable.load(table,aplistdn);
  String[] ary_table = null;
  String aptable = "";
  
  if ( rtn ){
	  aptable = qtable.getAplisttable();
	  ary_table = SvString.split(aptable,"||");
  }
  
  //尋找此序號發布之站台
  String serno = ( String )request.getParameter( "serno" );
  if ( serno == null )
	  serno = "";
  
  PubWebsiteData qpubclass = new PubWebsiteData();  
  ArrayList<Object> qclasswebs = qpubclass.findByclass(ary_table[2],serno);
  int webrcount = qpubclass.getAllrecordCount();
  
  String[] ary_mserno = null;
  String[] ary_mwebsitedn = null;
  
  if ( qclasswebs != null ) {
	  String mserno = "";
	  String mwebsitedn = "";
	  for ( int i=0; i<webrcount; i++ ) {
		  PubWebsiteData qclassweb = ( PubWebsiteData )qclasswebs.get( i );
		  if ( mserno.equals("") ) {
			  mserno = qclassweb.getMserno();
			  mwebsitedn = qclassweb.getWebsitedn();
		  }else{
			  mserno = mserno + "||" + qclassweb.getMserno();
			  mwebsitedn = mwebsitedn + "||" + qclassweb.getWebsitedn();
		  }
	  }
	  if ( !mserno.equals("") ) {
		  ary_mserno = SvString.split(mserno,"||");
		  ary_mwebsitedn = SvString.split(mwebsitedn,"||");
	  }
  }
  
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  //判斷OS版本
  String Hsinchu_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Hsinchu_PATH = sysRoot + "\\WEB-INF\\exchange.properties";
  else
	  Hsinchu_PATH = sysRoot + "/WEB-INF/exchange.properties";

  Properties exchange = new Properties();
  exchange.load(new FileInputStream(Hsinchu_PATH) );
  
%>  

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <%
    if ( qpubwebs != null ) {
  	  for ( int w=0; w<rcount; w++ ) {
   		  PubWebsiteData qpubweb = ( PubWebsiteData )qpubwebs.get( w );
   		  String webvalue = qpubweb.getWebsitedn() + "||" + qpubweb.getWebsitename();
   		  
   		  //尋找是否有發布至新竹縣入口網
   		  String mwebsitedn = exchange.getProperty(qpubweb.getWebsitedn());
   		  if ( mwebsitedn == null || mwebsitedn.equals("null") )
   			  mwebsitedn = qpubweb.getWebsitedn();
   		  
   		  //尋找站台類別
   		  PubWebsiteData qclass = new PubWebsiteData();   		  
   		  ArrayList qcnames = qclass.findByday(ary_table[0],mwebsitedn);
   		  int classrcount = qclass.getAllrecordCount(); %>
   		  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">    		    
   		    <%
   		      if ( qcnames != null ) { 
   		    	  String webisSelected = "";
   		    	  if ( SvString.contain(ary_mwebsitedn,qpubweb.getWebsitedn()) )
   		    		webisSelected = "checked";  %>   		    	  
   		    	  <td width="40%" align="left"><input type="checkbox" name=websitedn<%=w%> value=<%=webvalue%> <%=webisSelected%>><%=qpubweb.getWebsitename()%></td>
   		    	  <td align="left">
   		    		<select name=webclass<%=w%>>
   		    		  <!-- <option value="" selected>--請選擇分類--</option> -->
   		    		  <%
   		    		    for ( int c=0; c<classrcount; c++ ) {
   		    		    	PubWebsiteData qcname = ( PubWebsiteData )qcnames.get( c );
   		    		    	String classvalue = qcname.getSerno() + "||" + qcname.getClassname(); 
   		    		    	String isSelected = "";
   		    		    	if ( SvString.contain(ary_mserno,qcname.getSerno()) )
   		    		    		isSelected = "selected";  %>
   		    		    	<option value=<%=classvalue%> <%=isSelected%>><%=qcname.getClassname()%></option>
   		    		    <%}%>
   		    		</select>
   		    	  </td>
   		      <%}%>
   		  </tr>  
   	  <%}
    }else{%>
   	  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
   	    <td align="center">未設定欲發布之站台，請通知管理者設定！</td>
   	  </tr>
    <%}%>
</table> 
<input type="hidden" name="aptable" value="<%=aptable%>" />
<input type="hidden" name="aplistdn" value="<%=aplistdn%>" />
<input type="hidden" name="webdn" value="<%=aplistdn%>" />

</html>



