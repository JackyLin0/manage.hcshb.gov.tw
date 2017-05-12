<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../fonran.jsp" %>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="fonran.css">
		<SCRIPT language="javascript">
		
			function logout()
			{
				if( confirm("確定要登出系統？") ) window.open("login.jsp?PHPSESSID=<?=$PHPSESSID?>","_top") ;
			}
		
		</SCRIPT>
	</head>
	<body onclick="logout()" STYLE="margin-top:0pt ; margin-left:0pt ; margin-right:0pt ; background-Color: gray">
		<center>
			<div id="title" class="icon" style="background:'#c0c0c0';color:'#000000'">
				登出系統
			</div>
	</body>
</html>
