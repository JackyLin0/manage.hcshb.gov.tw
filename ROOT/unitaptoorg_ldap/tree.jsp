<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：tree.jsp
說明：單位網站權限設定
開發者：chmei
開發日期：96.12.30
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局全球資訊網網站後端管理</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String websitedn = ( String )request.getParameter( "websitedn" );
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
//   out.println("1." + websitedn);
  //尋找login者是否為管理者
  UnitManagerData query = new UnitManagerData();
  boolean rtn = query.load(pubunitdn,logindn);
  if ( !rtn && role.equals("") ) { %>
	  <div id="title">
	    <h2><img src="../img/addedit.png" width="48" height="48" align="middle"/>網站權限設定</h2>
	  </div>
	  <p></p>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr>
	      <td class="T12b" align="center">抱歉！您非單位網站管理者，無權使用【網站權限設定】；若有任何問題請洽系統管理者</td>
	    </tr>
	  </table>
  <%}else{%>
	  <frameset cols="18%,68%,19%" frameborder=0>  
	    <frame src="aplist/jstree1.jsp?pubunitdn=<%=pubunitdn%>&websitedn=<%=websitedn%>" name="treeleft"  scrolling="NO"> 
	    <frame src="blank.html" name="center">    
	    <frame src="entrymng/jstree.jsp?pubunitdn=<%=pubunitdn%>" name="treeright"  scrolling="NO">
	  </frameset>	    
  <%}%>


</html>