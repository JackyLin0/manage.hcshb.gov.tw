<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_updsave.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.02.23
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

  String mdn = ( String )request.getParameter( "mdn" );
  String ou = ( String )request.getParameter( "ou" );
  String chinesetitle = ( String )request.getParameter( "chinesetitle" );
  String englishtitle = ( String )request.getParameter( "englishtitle" );
  String japantitle = ( String )request.getParameter( "japantitle" );

  ArrayList<DSItem> result = new ArrayList<DSItem>();
  DSItem setdata = new DSItem();
  setdata.setOu(ou);
  setdata.setChinesetitle(chinesetitle);
  setdata.setEnglishtitle(englishtitle);
  setdata.setJapantitle(japantitle);
  setdata.setUnitdn(mdn);
  setdata.setLogincn(logincn);
  setdata.setLoginap(loginap);
  
  result.add(setdata);  
  
  DepartmentTree obj = new DepartmentTree();
  obj.setMdydata(result);
  
  boolean rtn = obj.store();
  
  String showAlert = null; 
  if ( rtn )
	  showAlert = "本單位修改成功！";
  else
	  showAlert = "本單位修改失敗！" + obj.getErrorMsg();
 
 %>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?mdn=<%=mdn%>";
  </script>  


</body>
</html>

