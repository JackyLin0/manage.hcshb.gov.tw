<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：leaf_updsave.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.02.24
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人員組織設定</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String logincn = ( String )session.getAttribute( "logincn" );
  String loginap = ( String )session.getAttribute( "loginap" );

  String userdn = ( String )request.getParameter( "userdn" );
  String muid = ( String )request.getParameter( "muid" );
  String cn = ( String )request.getParameter( "cn" );
  String carlicense = ( String )request.getParameter( "carlicense" );
  String email = ( String )request.getParameter( "email" );

  ArrayList<DSItem> result = new ArrayList<DSItem>();
  DSItem setdata = new DSItem();

  setdata.setCn(cn);
  setdata.setDn(userdn);
  setdata.setPid(carlicense);
  setdata.setEmail(email);
  setdata.setLoginap(loginap);
  setdata.setLogincn(logincn);

  result.add(setdata);

  UsersTree obj = new UsersTree();
  obj.setMdydata(result);

  boolean rtn  = obj.store();
  
  String showAlert = null; 
  if ( rtn )
	  showAlert = "本人員修改成功!!";	 
  else
	  showAlert = "本人員修改失敗！" + obj.getErrorMsg();
  
%>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="leaf_upd.jsp?userdn=<%=userdn%>&muid=<%=muid%>";
  </script>

</body>
</html>

