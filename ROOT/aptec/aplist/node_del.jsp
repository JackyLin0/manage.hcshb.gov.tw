<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_del.jsp
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

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String logincn = ( String )session.getAttribute( "logincn" );
  String loginap = ( String )session.getAttribute( "loginap" );

  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String dn = SvString.right(aplistdn,",");
  
  String parentid = ( String )request.getParameter( "id" );

  ApRootTree obj = new ApRootTree();
  obj.setParentId(parentid);
  boolean rtn = obj.remove();
  
  String showAlert = null; 
  if ( rtn )
	  showAlert = "本應用系統刪除成功！";
  else
	  showAlert = "本應用系統刪除失敗！" + obj.getErrorMsg();

 %>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?aplistdn=<%=dn%>";
  </script>
  
</body>
</html>

