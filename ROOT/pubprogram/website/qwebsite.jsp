<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qwebsite.jsp
說明：找尋登入者可發布站台
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登入者可發布站台</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.newdba.*" %>

</head>

<%
  String colname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String webdata = "";
  if ( datavalue != null && !datavalue.equals("") ) {
	  String[] ary_website = SvString.split(datavalue,"||");
	  webdata = ary_website[0];
  }
  
  //自session取得登入者的資料
  String login1 = ( String )session.getAttribute("logindn");
  String passwd1 = ( String )session.getAttribute("passwd");

  String userrole = ( String )session.getAttribute( "role" );
  
  NewWebSiteUnitData query = new NewWebSiteUnitData();  
  ArrayList<Object> qlists = query.findByData(login1,language,userrole);
  
  if ( qlists != null && qlists.size() > 0 ) {  %>
      <select name="<%=colname%>" class="select">
        <%
          if ( userrole.equals("admin") ) {%>
        	  <option value="" selected>請選擇站台</option>
          <%}
          for ( int i=0; i<qlists.size(); i++ ) {
        	  NewWebSiteUnitData qlist = ( NewWebSiteUnitData )qlists.get( i );
        	  String isSelected = "";
        	  if ( datavalue != null && !datavalue.equals("null") && !datavalue.equals("") ) {
        		  if ( qlist.getWebsitedn().equals(datavalue) )
        			  isSelected = "selected";
        	  }
        	  String mweb = qlist.getWebsitedn() + "||" + qlist.getWebsitename();
        	  %>
        	  <option value="<%=mweb%>" <%=isSelected%>><%=qlist.getWebsitename()%></option>
          <%}%>
	  </select>  
  <%}%>
</html>

