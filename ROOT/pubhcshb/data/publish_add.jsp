<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：publish_add.jsp
說明：動態程式發布設定
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<script>

  function back()
  {
     document.mform.action="publish.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     document.mform.action = "publish_addsave.jsp";
     document.mform.method="post";
     document.mform.submit();
  }    
</script>

</head>

<%
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String logindn = ( String )session.getAttribute("logindn");

  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String aplistname = ( String )request.getParameter( "aplistname" );
  String website = ( String )request.getParameter( "website" );

  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }

%>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="aplistdn" value="<%=aplistdn%>"/> 
  <input type="hidden" name="aplistname" value="<%=aplistname%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="website" value="<%=website%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<%
  String mlanguage = "";
  if ( language.equals("ch") )
	  mlanguage = "chinese";
  else if( language.equals("en") )
	  mlanguage = "english";
  else if ( language.equals("jp") )
	  mlanguage = "japan";
  
  //尋找該動態程式資料是否須發布至縣府主網
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  //判斷OS版本
  String aplist_PATH = "";
  if ( sysRoot1.indexOf("/") == -1 )
	  aplist_PATH = sysRoot1 + "\\WEB-INF\\exchange.properties";
  else
	  aplist_PATH = sysRoot1 + "/WEB-INF/exchange.properties";

  Properties aplist = new Properties();
  aplist.load(new FileInputStream(aplist_PATH) );
  String own = aplist.getProperty(aplistdn);
  
  if ( own == null || own.equals("null") )
	  own = "";
  
  //尋找所有站台
  WebSiteData qwebsite = new WebSiteData();
  ArrayList<Object> qwebs = qwebsite.findByday(mlanguage,own,"");  
  int webrcount = qwebsite.getAllrecordCount();
  
  //尋找已設定的發布站台
  PublishData query = new PublishData();  
  ArrayList<Object> qownwebs = query.findByday(table,aplistdn,"P");
  int ownrcount = query.getAllrecordCount();
  
  String ownwebsite = "";
  if ( qownwebs != null ) {
	  for ( int o=0; o<ownrcount; o++ ) {
		  PublishData qownweb = ( PublishData )qownwebs.get( o );
		  if ( qownweb.getPubwebsitedn().equals(website) ) {
			  if ( ownwebsite.equals("") )
				  ownwebsite = qownweb.getWebsitedn();
			  else
				  ownwebsite = ownwebsite + "||" + qownweb.getWebsitedn();
		  }
	  }	  
  }
  
  String[] ary_ownwebsite = null;
  if ( !ownwebsite.equals("") ) 
	  ary_ownwebsite = SvString.split(ownwebsite,"||");
  
%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.mform.reset()"><%=lang.getReset()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=aplistname%>-<%=title%></th>
  </tr>
  <%
    if ( qwebs != null ) {
    	for ( int w=0; w<webrcount; w++ ) {
    		WebSiteData qweb = ( WebSiteData )qwebs.get( w ); %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td><%=w+1%></td>
    		  <%
    		    String datavalue = qweb.getWebsitedn() + "||" + qweb.getWebsitename();
    		    String isSelected = "";
    		    if ( SvString.contain(ary_ownwebsite,qweb.getWebsitedn()) )
    		    	isSelected = "checked";
    		  %>
    		  <td><input type="checkbox" name="check" value=<%=datavalue%> <%=isSelected%>></td>
    		  <td><%=qweb.getWebsitename()%></td>
    		</tr>
    	<%}    	
    }%>
  
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p></p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div>

</form>
</body>
</html>
