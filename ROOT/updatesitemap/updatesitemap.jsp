<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<style type="text/css">
<!--
-->
</style>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath(""); 
  //判斷OS版本
  String Sitemap_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Sitemap_PATH = sysRoot+ "\\WEB-INF\\menu.properties";
  else
	  Sitemap_PATH = sysRoot+ "/WEB-INF/menu.properties";

  Properties sitemap = new Properties();  
  sitemap.load(new FileInputStream(Sitemap_PATH ) );
  String menuimgpath = sitemap.getProperty("menuimgpath");

  String menudata = ( String )request.getParameter( "menudata" );
  tw.com.sysview.dba.MenuItemTree mt = tw.com.sysview.dba.MenuItemTree.getInstance(menudata);  
  mt.update(menudata,menuimgpath);
%>