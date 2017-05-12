<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：entrymng.jsp
說明：單位管理者人員組織設定
開發者：chmei
開發日期：2017.03.08
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>單位管理者人員組織設定</title>
</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");

  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  String role = ( String )session.getAttribute("role");
  if ( !role.equals("") ) {
	  logindn = "";
	  String munitdn = ( String )request.getParameter( "unitdn" );
	  pubunitdn = munitdn;
  }

  //尋找login者是否為管理者
  UnitManagerData query = new UnitManagerData();
  boolean rtn = query.load(pubunitdn,logindn);
  
  String title = ( String )request.getParameter( "title" );

  if ( !rtn && role.equals("") ) {%>
	  <div id="title">
	    <h2><img src="../img/addedit.png" width="48" height="48" align="middle"/>人員組織管理</h2>
	  </div>
	  <p></p>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr>
	      <td class="T12b" align="center">抱歉！您非單位網站管理者，無權使用【人員組織管理】；若有任何問題請洽系統管理者</td>
	    </tr>
	  </table>
  <%}else{%>
	  <frameset cols="25%,75%" framespacing="0" frameborder="no" border="1">
	    <frame src="entrymng_tree.jsp?title=<%=title%>&pubunitdn=<%=pubunitdn%>" id="treeleft" name="treeleft" scrolling="No">
	    <frame src="blank.html" id="right" name="right">
	  </frameset>
  <%}%>

</html>
