<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_del.jsp
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
  String mdn = ( String )request.getParameter( "mdn" );
  String id = ( String )request.getParameter( "id" );
  String upmdn = SvString.right(mdn,",");

  DepartmentTree obj = new DepartmentTree();
  obj.setParentId(id);
  boolean rtn = obj.remove(mdn);

  String showAlert = null;
  if ( rtn )
	  showAlert = "本單位已刪除成功!!";
  else
	  showAlert = "本單位刪除失敗!!" + obj.getErrorMsg();
  
%>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?mdn=<%=upmdn%>";
  </script>  


</body>
</html>

