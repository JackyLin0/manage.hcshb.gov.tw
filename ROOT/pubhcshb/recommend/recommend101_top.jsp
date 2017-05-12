<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：recommend101_top.jsp
說明：推薦服務專區
開發者：chmei
開發日期：99.05.27
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推薦服務專區</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function save() {
	  var num = 0;
	  var datavalue = "";
	  if ( parent.frames("mainFrameDown").frames("TreeView1").document.getElementsByName("menu").length == 0 ) {
		  alert("您為勾選任何一項，請勾選！");
		  return;
	  }	  
	  for ( i=0; i<parent.frames("mainFrameDown").frames("TreeView1").document.getElementsByName("menu").length; i++ ) {
		  if ( parent.frames("mainFrameDown").frames("TreeView1").document.getElementsByName("menu")[i].checked ) {
			  num = num + 1;
			  if ( datavalue == '' ) {
				  datavalue = parent.frames("mainFrameDown").frames("TreeView1").document.getElementsByName("menu")[i].value;
			  }else{
				  datavalue = datavalue + "-" + parent.frames("mainFrameDown").frames("TreeView1").document.getElementsByName("menu")[i].value;
			  }
		  }	  
	  }
	  if ( num > 5 ) {
		  alert("最多勾選【5】項功能，您已超過，請重新勾選！");
		  return;
	  }
	  if ( num == 0 ) {
		  alert("您為勾選任何一項，請勾選！");
		  return;
	  }	  
	  document.mform.choicemenu.value = datavalue;
	  document.mform.action = "recommend101_mdysave.jsp";
	  document.mform.method = "post";
	  document.mform.submit();
  }	  
</script>

</head>

<%
  String websitedn = ( String )request.getParameter( "websitedn" );
  String language = ( String )request.getParameter( "language" );
  String table = ( String )request.getParameter( "t" );
%>

<body>
  
<form name="mform">
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="choicemenu" />
<input type="hidden" name="websitedn" value="<%=websitedn%>" />
<input type="hidden" name="language" value="<%=language%>" />
<input type="hidden" name="t" value="<%=table%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>

</form>

</body>
</html>
