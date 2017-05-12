<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<HTML>
	<HEAD>
		<TITLE><%=f.get_parameter("system_title")%></TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script language="javascript">
	<!--
		window.name = 'Index';
	//-->
	</script>
		<NOFRAMES>
			請使用提供frames功能的瀏覽器!!</NOFRAMES>
	</HEAD>
	<frameset id="allpage" frameSpacing="0" frameBorder="0" cols="125,*">
		<noframes>
			請使用提供frames功能的瀏覽器!!</noframes>
			<frameset frameborder="0" border="0" framespacing="0" rows="60,*">
       			<frame name="mark" src="mark.jsp?time=<%=f.urlencode(f.now())%>" scrolling="NO">
				<frame name="menu" marginWidth="0" marginHeight="0" src="menu.jsp?time=<%=f.urlencode(f.now())%>" scrolling="yes" leftmargin="0" noresize topmargin="0">
			</frameset>
			<frameset frameborder="0" border="0" framespacing="0" rows="0,*">
       			<frame name="top" src="top.jsp?time=<%=f.urlencode(f.now())%>" scrolling="NO">
				<frame name="main" marginWidth="0" marginHeight="0" src="blank.jsp?Time=<%=f.urlencode(f.now())%>" scrolling="yes" leftmargin="0" noresize topmargin="0">
			</frameset>	
	</frameset>
</HTML>
