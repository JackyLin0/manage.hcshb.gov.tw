<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu_del.jsp
說明：選單目錄管理
開發者：chmei
開發日期：97.02.18
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String language = ( String )request.getParameter( "language" );
  String murl = ( String )request.getParameter( "murl" );
  String title = ( String )request.getParameter( "title" );

  String type = ( String )request.getParameter( "type" );
  String delserno = ( String )request.getParameter("serno");
  
  //先查詢之下是否還有資料
  MenuData query = new MenuData();
  ArrayList qlists = query.findBydata(table,delserno);  
  int rcount = query.getAllrecordCount();
  
  if ( qlists != null ) { %>
	  <script>
	     alert(" 因本系統尚有子系統,故不得刪除.請先將系統位所屬子系統刪除!");
	     history.go(-1);
	  </script>	
  <%}else{	  
	  //取設定檔路徑
	  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
	  //判斷OS版本
	  String Siiemap_PATH = "";
	  if ( sysRoot.indexOf("/") == -1 )
		  Siiemap_PATH = sysRoot + "\\WEB-INF\\updatesitemap.properties";
	  else
		  Siiemap_PATH = sysRoot + "/WEB-INF/updatesitemap.properties";
	  
	  Properties sitemap = new Properties();
	  sitemap.load(new FileInputStream(Siiemap_PATH) );
	  String sitemappath = sitemap.getProperty("updatepath");

	  MenuData obj = new MenuData();  
	  
	  boolean rtn = true ;
	  String errMsg="0";   
	  
	  obj.setSerno(delserno);
	  
	  //執行動作(修改資料)  
	  rtn = obj.remove(table,sysRoot);	  

	  String showAlert = null;  
	  if ( rtn == false ) {
		  errMsg = obj.getErrorMsg();
		  showAlert = "刪除失敗！" + errMsg;
	  }else{
		  showAlert="刪除成功！";
	  }

	%>

	<form name="mform" action="menu.jsp" method="post">
	  <input type="hidden" name="t" value="<%=table%>"/>
	  <input type="hidden" name="logindn" value="<%=logindn%>"/>
	  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
	  <input type="hidden" name="language" value="<%=language%>"/>
	  <input type="hidden" name="murl" value="<%=murl%>"/>
	  <input type="hidden" name="title" value="<%=title%>"/>
	</form>

	 
	<script>
	   newwin=window.open('../../updatesitemap/updatesitemap.jsp?menudata=<%=table%>','','width=10,height=10,scrollbars=yes,left=10000,top=10000');
	   window.newwin.close();
	   newwin=window.open('<%=sitemappath%>/updatesitemap/updatesitemap.jsp?menudata=<%=table%>','','width=10,height=10,scrollbars=yes,left=10000,top=10000');
	   window.newwin.close();
	   alert("<%=showAlert%>");
	   document.mform.submit();
	</script>  

  <%}%>
 