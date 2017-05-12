<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：recommend_mdy.jsp
說明：推薦服務專區
開發者：chmei
開發日期：99.05.27
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<title>推薦服務專區</title>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<font fontface='細明體' size=3>載入資料中，請稍後..... </font>
<table height="500"><td><br></table>

<div id="TreeData";><xmp>

<style type="text/css">
<!--
.w2 {  font-family: "細明體"; font-size: 11pt; }
-->
</style>

</head>

<body>
<form name="checkform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

</form>

<%
  int islevel = Integer.parseInt(request.getParameter( "islevel" ));
  String websitedn = ( String )request.getParameter( "websitedn" );
  //取tablemenu
  String[] ary_websitedn = SvString.split(websitedn,",");
  String table1 = SvString.right(ary_websitedn[0],"=");
  String menutable = table1.substring(0,1).toUpperCase() + table1.substring(1) + "Menu";
  String language = ( String )request.getParameter( "language" );
  String topserno = ( String )request.getParameter( "topserno" );
  if ( topserno == null || topserno.equals("null") )
	  topserno = "";
  
  String table = ( String )request.getParameter( "t" );
  RecommendData query = new RecommendData();
  ArrayList<Object> qlists = query.findBysort(menutable,islevel,topserno);
  int rcount = query.getAllrecordCount();
  
  if ( qlists != null ) {
	  for ( int i=0; i<rcount; i++ ) {
		  RecommendData qlist = ( RecommendData )qlists.get( i );
		  //尋找是否有下層
		  RecommendData query1 = new RecommendData();
		  ArrayList<Object> qlists1 = query1.findBysort(menutable,islevel+1,qlist.getSerno());
		  int rcount1 = query1.getAllrecordCount();
		  //找尋已設定
		  String isSelected = "";
		  RecommendData qdata = new RecommendData();
		  boolean rtn = qdata.load(qlist.getSerno(),table,websitedn);		  
		  if ( rtn ) 
			  isSelected = "checked";  %>
		  <span class="w2">
		    <%
		      if ( qlist.getIslevel() == 1 ) {
		    	  if ( rcount1 > 0 ) { %>
		    		  <img src="image/open.jpg" alt="*" />
		    	  <%}else{%>
		    		  <img src="image/open.jpg" alt="*" /><input type="checkbox" name="menu" value="<%=qlist.getSerno()%>" <%=isSelected%> />
		    	  <%}
		      }else{%>
		    	  <img src="image/file1.gif" alt="*" /><input type="checkbox" name="menu" value="<%=qlist.getSerno()%>" <%=isSelected%> />
		      <%}%>
		    
		    <span style="text-Decoration:none"><%=qlist.getIslevelcontent()%></span></span><!,>recommend101_mdy.jsp?islevel=<%=qlist.getIslevel()+1%>&topserno=<%=qlist.getSerno()%>&websitedn=<%=websitedn%>&language=<%=language%>&t=<%=table%><!End>
	  <%}
  } %>

<!EndTreeData>
</xmp>

</body>
</html>

