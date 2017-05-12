<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：recommend101.jsp
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


</head>

<form name="mform">
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<%
  String language = ( String )request.getParameter( "language" );
  if ( language.equals("ch") )
	  language = "chinese";
  else if ( language.equals("en") )
	  language = "english";
  else if ( language.equals("jp") )
	  language = "japan";

  String websitedn = ( String )request.getParameter( "websitedn" );
  String table = ( String )request.getParameter( "t" );
  
%>  

</form>

<frameset id="frameset" rows="130,*" cols="*" frameborder=no>
   <frame id="mainFrameTop" name="mainFrameTop" src="recommend101_top.jsp?websitedn=<%=websitedn%>&language=<%=language%>&t=<%=table%>" Scrolling=no>
   <frame id="mainFrameDown" name="mainFrameDown" src="recommend101_data.jsp?websitedn=<%=websitedn%>&language=<%=language%>&t=<%=table%>">
</frameset>

</html>

