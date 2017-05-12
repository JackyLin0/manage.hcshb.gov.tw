<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：leaf_del.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.03.08
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
<%@ page import="sysview.zhiren.function.*"%>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String userdn = ( String )request.getParameter( "userdn" );
  String mdn = SvString.right(userdn,",");
  
  UsersTree obj = new UsersTree();
  boolean rtn = obj.remove(userdn);

  String showAlert = null;
  if ( rtn )
	  showAlert = "本人員刪除成功!!";
  else
	  showAlert = "本人員刪除失敗!!" + obj.getErrorMsg();
  
%>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?mdn=<%=mdn%>";
  </script> 

</body>
</html>

