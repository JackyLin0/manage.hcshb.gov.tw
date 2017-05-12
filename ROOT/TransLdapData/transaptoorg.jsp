<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：transaptoorg.jsp
說明：轉權限
開發者：chmei
開發日期：2017.02.26
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>轉權限</title>

</head>

<body>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.TransLdapData.*" %>

<%
  TransApRootData query = new TransApRootData();
  List<Map<String,String>> qlists = query.getApRoot();
  if ( qlists != null && qlists.size() > 0 ) {
	  for ( int i=0; i<qlists.size(); i++ ) {
		  Map<String,String> qlist = qlists.get( i );
		  if ( qlist.get("aciuserdn") != null && !qlist.get("aciuserdn").equals("null") && !qlist.get("aciuserdn").equals("") ) {
			  TransAptoorgData createpower = new TransAptoorgData();			  
			  createpower.setAplistdn(qlist.get("entrydn"));
			  createpower.setAciuserdn(qlist.get("aciuserdn"));
			  boolean rtn = createpower.TransPower();
			  if ( !rtn ) {
				  out.println("entrydn="+qlist.get("entrydn"));
				  out.println("aciuserdn="+qlist.get("aciuserdn"));
				  out.println("<br>");
			  }
		  }
	  }
  }
%>

</body>
</html>