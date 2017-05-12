<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：indextry.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：2017.03.01
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>新竹縣衛生局服務網後端管理系統</title>
</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="tw.com.econcord.login.*" %>

<%
  if ( request.getQueryString() == null || request.getQueryString().equals("") ) {
	  String loginap = ( String )session.getAttribute("loginap");
	  
	  String murl = ( String )request.getParameter( "murl" );
	  LoginCheck qdata = new LoginCheck();
	  qdata.setLoginap(loginap);
	  ArrayList<DSItem> qlists = qdata.getUserData();
	  
	  if ( qlists != null && qlists.size() > 0 ) {
		  DSItem qlist = ( DSItem )qlists.get(0);
		  //將登錄者存入session
		  session.setAttribute("unitname",qlist.getChinesetitle());
		  session.setAttribute("logindn",qlist.getDn());
	      session.setAttribute("logincn",qlist.getCn());
	      session.setAttribute("loginap",loginap); %>
	      
	      <frameset rows="92,*" framespacing="0" frameborder="no" border="0">
	        <frame name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" src="top.jsp"/>
	        <frameset id="menuFram" name="menuFram" cols="250,*" framespacing="0" frameborder="no" border="0">
	          <frame id="leftFrame" name="leftFrame" noresize="noresize" id="leftFrame" title="leftFrame" src="left.jsp?personalap=0,1,18"/>
	          <frame id="mainFrame" name="mainFrame" title="mainFrame" src="main.jsp"/>
	        </frameset>
	      </frameset>
	  <%}else{%>
		  <script type="text/javascript">
		     alert("登入失敗，請洽系統管理者，謝謝您！");
		     window.location.href = "http://gip.shinchu.gov.tw";
		  </script>
	  <%}
  }else{%>
	  <script>
	    window.location.href="http://gip.shinchu.gov.tw";
	  </script>
  <%}%>

</html>