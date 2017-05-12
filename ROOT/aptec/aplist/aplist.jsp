<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：aplist.jsp
說明：應用系統設定(客戶管理者使用)
開發者：chmei
開發日期：2013.06.22
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>應用系統設定</title>
<link rel="stylesheet" type="text/css" href="../css/ext-tree.css" />
<script type="text/javascript" src="../../js/ext-base.js"></script>
<script type="text/javascript" src="../../js/ext-all.js"></script>

<script type="text/javascript" src="../js/aptree.js" charset="UTF-8"></script>

<style type="text/css">
<!--
.x-tree-node-expanded .x-tree-node-icon{
	background-image:url(../images/tree/tree2.gif);
}

.x-tree-node-leaf .x-tree-node-icon{
	background-image:url(../images/tree/ap.gif);
}

.x-tree-node-collapsed .x-tree-node-icon{
	background-image:url(../images/tree/tree2.gif);
}

.x-tree-node-expanded .x-tree-node-icon1{
	background-image:url(../images/tree/world.gif);
}

-->
</style>

</head>

<%
  String title = ( String )request.getParameter( "title" );
  session.setAttribute("title",title);
%>

<body>

<div id="tree-panel" style="overflow:auto; autoHeight:true; width:220px; border:2px solid #c3daf9;"></div>

</body>

</html>
