<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>檔案複製</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="java.text.SimpleDateFormat"%>

<div id="title">
  <h2><img src="../img/addedit.png" width="48" height="48" align="middle" />檔案複製中.......請稍後</h2>
</div>

<p></p>
<center><img src="../img/loading.gif" alt="loading" width="214" height="15" /></center>

<%
  //取設定檔路徑
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
  //判斷OS版本
  String Menu_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Menu_PATH = sysRoot + "\\WEB-INF\\menu.properties";
  else
	  Menu_PATH = sysRoot + "/WEB-INF/menu.properties";

  Properties menu = new Properties();
  menu.load(new FileInputStream(Menu_PATH) );
  String templatepath = menu.getProperty("templatepath");
  String targetpath = menu.getProperty("targetpath");
  out.println("templatepath="+templatepath);
out.println("targetpath="+targetpath);
  String fpath = ( String )request.getParameter( "fpath" );
  
  String[] ary_fpath = SvString.split(fpath,"/"); 

    
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  
  String sourcefile = templatepath + "//" + ary_fpath[2];
  String targetfile = targetpath + "//" + ary_fpath[0] + "//" + ary_fpath[1] + "//" + ndate + ".jsp";
out.println("sourcefile="+sourcefile);
out.println("targetfile ="+targetfile );
  String islevellink = ary_fpath[0] + "/" + ary_fpath[1] + "/" + ndate + ".jsp";

  boolean filecopy = false;
  try{
	  FileInputStream fis  = new FileInputStream(sourcefile);
	  FileOutputStream fos = new FileOutputStream(targetfile);
	  byte[] buf = new byte[1024];
	  int i = 0;
	  while((i=fis.read(buf))!=-1) {
		  fos.write(buf, 0, i);
	  }
	  fis.close();
	  fos.close();
	  filecopy = true;
  }catch(Exception e){
	  System.out.println("false");
  }

  if ( filecopy ){ %>
	  <script>
	     window.opener.menuform.islevellink1.value = "<%=islevellink%>";
	     alert("檔案複製成功！！");
	     window.close();	     
	  </script>   
  <%}else{%>
	  <div id="title">
	     <h2>檔案複製失敗</h2>
	  </div>
  <%}%>



