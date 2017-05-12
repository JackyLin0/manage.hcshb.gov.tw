<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：entrymng_tree.jsp
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

<link rel="stylesheet" type="text/css" href="css/ext-tree.css" />
<script type="text/javascript" src="../js/ext-base.js"></script>
<script type="text/javascript" src="../js/ext-all.js"></script>
<script type="text/javascript" src="js/department.js" charset="UTF-8"></script>

<style type="text/css">
<!--
.x-tree-node-expanded .x-tree-node-icon{
	background-image:url(../images/tree/folder-open.gif);
}

.x-tree-node-leaf .x-tree-node-icon{
	background-image:url(../images/tree/leaf.gif);
}

.x-tree-node-collapsed .x-tree-node-icon{
	background-image:url(../images/tree/folder.gif);
}
.x-tree-node-expanded .x-tree-node-icon1{
	background-image:url(../images/tree/chart_organisation.gif);
}

-->
</style>

</head>

<%
  String title = ( String )request.getParameter( "title" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  session.setAttribute("title",title);
%>

<body>
<input type="hidden" id="pubunitdn" name="pubunitdn" value="<%=pubunitdn%>" />

<div id="tree-panel" style="overflow:auto; autoHeight:true; width:220; border:2px solid #c3daf9;"></div>

</body>
</html>