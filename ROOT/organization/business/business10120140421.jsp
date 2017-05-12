<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：business101.jsp
說明：業務簡介
開發者：chmei
開發日期：97.02.21
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function qrynum()
  {
     document.mform.action="business101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     document.mform.action="business101_save.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.filter.qfilterSql"%>

<%
  String language = ( String )request.getParameter( "language" );
  //Sql_Injection
  if ( !language.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(language);
     if ( rtn )
    	 language = qcontentlink.getMcontent();
  }
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  //Sql_Injection
  if ( !pubunitdn.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(pubunitdn);
     if ( rtn )
    	 pubunitdn = qcontentlink.getMcontent();
  }
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  //判斷OS版本
  String Ldap_PATH1 = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Ldap_PATH1 = sysRoot + "\\WEB-INF\\ldap.properties";
  else
	  Ldap_PATH1 = sysRoot + "/WEB-INF/ldap.properties";

  Properties ldap1 = new Properties();
  ldap1.load(new FileInputStream(Ldap_PATH1) );
  
  String ds_server = ldap1.getProperty("ds_server");
  String port = ldap1.getProperty("ds_port");
  String ds_user = ldap1.getProperty("ds_user");
  String ds_pwd = ldap1.getProperty("ds_pwd");
  
  int ds_port=Integer.parseInt(port); 
  
  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean qdata1 = qou1.query( pubunitdn, "dn,chinesetitle,cn,uid,objectclass,ou", "objectclass=department", SvLdap.QUERYBASE );
  String pubunitname = "";
  if ( qdata1 ) {
	  while ( qou1.next() ) {
		  pubunitname = qou1.getString("chinesetitle");
	  }
  }

  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean qdata = qou.query( pubunitdn, "dn,chinesetitle,cn,uid,objectclass,ou", "objectclass=department", SvLdap.QUERYONELEVEL );
  
  //業務簡介
  BusinessData qcon = new BusinessData();  
  boolean rtn = qcon.load(pubunitdn);
  String mcontent = "";
  String mserno = "";
  if ( rtn ) {
	  mserno = qcon.getSerno();
	  mcontent = qcon.getContent();
  }

%>


<body>
<form name="mform">
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
<input type="hidden" name="pubunitname" value="<%=pubunitname%>"/>
<input type="hidden" name="mserno" value="<%=mserno%>"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<a class="md" href="javascript:save()">儲   存</a>

<br><br>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th colspan="2">業務簡介</th>
  </tr>
  <%
    String temp_mcontent = ( String )request.getParameter( "content" );
  
    if ( temp_mcontent != null && !temp_mcontent.equals("null") && !temp_mcontent.equals("") )
    	mcontent = temp_mcontent;
  %>
  <tr>
    <td>詳細內容</td>
    <td>
      <textarea name="content" cols="80" rows="8"><%=mcontent%></textarea>
      <br><span class="T10">    (至多500個中文字）</span>
    </td>
  </tr>

</table>  
<p>　</p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th colspan="2">業務職掌</th>
  </tr>
  <%
    int i=0;
    if ( qdata ) {
    	while ( qou.next() ) {
    		i = i + 1;
    		String num = ( String )request.getParameter( "num"+i );
    		if ( num == null || num.equals("null") )
    			num = "0";
    		String mcolor = "";
    		if ( i%2 == 0 ) {
    			mcolor = "class='tr'";
    		} %>
      		<tr <%=mcolor%>>
      		  <td width="20%" valign="top"><%=qou.getString("chinesetitle")%></td>
      		  <input type="hidden" name="unitdn<%=i%>" value=<%=qou.getString("dn")%>>
      		  <input type="hidden" name="unitname<%=i%>" value=<%=qou.getString("chinesetitle")%>>
      		  <td>
      		    <table border="0">
      		      <%
      		        if ( !num.equals("") ) {
      		        	//業務執掌
      		        	BusinessData query = new BusinessData();
      		        	ArrayList qlists = query.findByday(pubunitdn,qou.getString("dn"));
      		        	int rcount = query.getAllrecordCount();      		        	
      		        	if ( qlists == null )
      		        		rcount = Integer.parseInt(num); %>
      		        	
      		        	<tr>
      		        	  <td align="left">
      		        	    <select name="num<%=i%>" onchange="qrynum()">
      		        	       <option value="0">--請選擇--</option>
      		        	       <%
      		        	         if ( num.equals("0") )
      		        	        	 num = String.valueOf(rcount);
      		        	         for ( int k=1; k<21; k++ ) {
      		        	        	 String isSelected = "";
      		        	        	 if ( k == Integer.parseInt(num) )
      		        	        		 isSelected = "selected";  %>
      		        	        	 <option value="<%=k%>" <%=isSelected%>><%=k%></option>
      		        	         <%}%>
      		        	    </select>
      		        	  </td>
      		        	</tr>
      		        	<%
      		        	  if ( qlists == null ) {
      		        		  for ( int j=0; j<rcount; j++ ) { %>
      		        			  <tr>
      		        			    <td><%=j+1%>、標題</td>
      		        			    <%
      		        			      String msubject = ( String )request.getParameter( "subject"+i+j );
      		        			      if ( msubject == null || msubject.equals("null") )
      		        			    	  msubject = "";
      		        			    %>
      		        			    <td>
      		        			      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=msubject%>">
      		        			      <br><span class="T10">    (至多100個中文字）</span>
      		        			    </td>
      		        			  </tr>      		        		 
      		        			  <tr>
      		        			    <td>內容</td>
      		        			    <%
      		        			      String mcontent1 = ( String )request.getParameter( "content1"+i+j );
      		        			      if ( mcontent1 == null || mcontent1.equals("null") )
      		        			    	  mcontent1 = "";
      		        			    %>
      		        			    <td>
      		        			      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=mcontent1%></textarea>
      		        			      <br><span class="T10">    (至多500個中文字）</span>
      		        			    </td>
      		        			  </tr>
        		        	  <%}
      		        	  }else{
      		        		  if ( rcount > Integer.parseInt(num) )
      		        			  rcount = Integer.parseInt(num);
      		        		  for ( int j=0; j<rcount; j++ ) {
      		        			  BusinessData qlist = ( BusinessData )qlists.get( j );  %>
      		        			  <tr>
      		        			    <td><%=j+1%>、標題</td>
      		        			    <%
      		        			      String bsubject = ( String )request.getParameter( "subject"+i+j );
      		        			      if ( bsubject == null || bsubject.equals("null") )
      		        			    	  bsubject = qlist.getSubject();  
      		        			    %>
      		        			    <td>
      		        			      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=bsubject%>">
      		        			      <br><span class="T10">    (至多100個中文字）</span>
      		        			    </td>
      		        			  </tr>
      		        			  <tr>
      		        			    <td>內容</td>
      		        			    <%
      		        			      String bcontent = ( String )request.getParameter( "content1"+i+j );
      		        			      if ( bcontent == null || bcontent.equals("null") )
      		        			    	  bcontent = qlist.getContent();  %>
      		        			    <td>
      		        			      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=bcontent%></textarea>
      		        			      <br><span class="T10">    (至多500個中文字）</span>
      		        			    </td>
      		        			  </tr>
      		        		  <%}
      		        		  
      		        		  if ( Integer.parseInt(num) > rcount ) {   
      		        			  for ( int j=rcount; j<Integer.parseInt(num); j++ ) {  %>
      		        				  <tr>
      		        				    <td><%=j+1%>、標題</td>
      		        				    <%
      		        				      String msubject = ( String )request.getParameter( "subject"+i+j );
      		        				      if ( msubject == null || msubject.equals("null") )
      		        				    	  msubject = "";
      		        				    %>
      		        				    <td>
      		        				      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=msubject%>">
      		        				      <br><span class="T10">    (至多100個中文字）</span>
      		        				    </td>
      		        				  </tr>      		        		 
      		        				  <tr>
      		        				    <td>內容</td>
      		        				    <%
      		        				      String mcontent1 = ( String )request.getParameter( "content1"+i+j );
      		        				      if ( mcontent1 == null || mcontent1.equals("null") )
      		        				    	  mcontent1 = "";
      		        				    %>
      		        				    <td>
      		        				      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=mcontent1%></textarea>
      		        				      <br><span class="T10">    (至多500個中文字）</span>
      		        				    </td>
      		        				  </tr>
      		        			  <%} 
      		        		  }
      		        	 }%>
      		        	 <input type="hidden" name="rcount<%=i%>" value="<%=rcount%>">
      		        	 <input type="hidden" name="unitcount" value="<%=qou.getRecordCount()%>">
      		         <%}%>      		       
      		    </table>
      		  </td>
      		</tr>
    	<%}      		
    }%>    
</table>  

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>