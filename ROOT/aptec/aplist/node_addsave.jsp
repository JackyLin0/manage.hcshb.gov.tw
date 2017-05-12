<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_addsave.jsp
說明：應用系統設定
開發者：chmei
開發日期：2017.02.26
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>應用系統設定</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  String logincn = ( String )session.getAttribute( "logincn" );
  if ( logincn == null || logincn.equals("null") )
	  logincn = "sysviewtg2";
  String loginap = ( String )session.getAttribute( "loginap" );

  String parentid = ( String )request.getParameter( "parentid" );
  String parentpath = ( String )request.getParameter( "parentpath" );

  String parentdn = ( String )request.getParameter( "parentdn" );
  String sysname = ( String )request.getParameter( "sysname" );
  String ou = ( String )request.getParameter( "ou" );
  String aplistdn = "ou=" + ou + "," + parentdn;
  
  String aplisturl = ( String )request.getParameter( "aplisturl" );
  if ( aplisturl == null || aplisturl.equals("null") || aplisturl.equals("") ) {
	  aplisturl = "http://";
  }

  String userunit = "";
  if ( request.getParameterValues( "punit" ) != null ) {
	  String ary_punit[] = request.getParameterValues( "punit" );
	  for ( int i=0; i<ary_punit.length; i++ ) {
		  String mpunit = ary_punit[i].replace('*',',');
		  if ( userunit.equals("") ) {
			  userunit = mpunit;
		  }else{
			  userunit = userunit + "||" + mpunit;
		  }
	  }
  }
  
  String pagenumber = ( String )request.getParameter( "pagenumber" );

  String startusing = ( String )request.getParameter( "startusing" );
  if ( startusing == null || startusing.equals("null") )
	  startusing = "";
  String islanguage = ( String )request.getParameter( "islanguage" );

  ArrayList<DSItem> result = new ArrayList<DSItem>();
  DSItem setdata = new DSItem();
  
  setdata.setLogincn(logincn);
  setdata.setLoginap(loginap);
  setdata.setAplistdn(aplistdn);
  setdata.setOu(ou);
  setdata.setSysname(sysname);
  setdata.setAplisturl(aplisturl);
  setdata.setPagenumber(pagenumber);
  setdata.setParentid(Integer.parseInt(parentid));
  setdata.setParentpath(parentpath);
  setdata.setStartusing(startusing);
  setdata.setUserunit(userunit);

  result.add(setdata);

  ApRootTree obj = new ApRootTree();  
  obj.setAdddata(result);

  boolean rtn  = obj.create();

  String website = ( String )request.getParameter( "website" );
  String showAlert = null; 
  if ( rtn ) {
	  showAlert = "本應用系統新增成功！";
	  if ( website != null && !website.equals("null") ) {
		  if ( website.equals("Y") ) {
			  WebSiteData iweb = new WebSiteData();           		  
    		  iweb.setWebsitedn(aplistdn);
    		  iweb.setWebsitename(sysname);        		  
    		  iweb.setIslanguage(islanguage);
    		  iweb.setStartusing(startusing); 
    		  boolean webrtn = iweb.create();
    		  if ( webrtn ) {
    			  String punitweb = "";
    			  if ( request.getParameterValues( "punitweb" ) != null ) {
        			  String ary_punitweb[] = request.getParameterValues( "punitweb" );
        			  for ( int i=0; i<ary_punitweb.length; i++ ) {
        				  String mpunitweb = ary_punitweb[i].replace('*',',');
        				  if ( punitweb.equals("") )
        					  punitweb = mpunitweb;
        				  else
        					  punitweb = punitweb + "&" + mpunitweb;
        			  }
        			  WebSiteData unitweb = new WebSiteData();
        			  unitweb.setWebsitedn(aplistdn);
        			  unitweb.setWebsitename(sysname);
        			  unitweb.setPostname(logincn);
        			  unitweb.createweb(punitweb);
        		  }
    		  }
		  }
	  }
  }else{
	  showAlert = "本應用系統新增失敗！" + obj.getErrorMsg();
  }
  
 %>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?aplistdn=<%=parentdn%>";
  </script>


</body>
</html>

