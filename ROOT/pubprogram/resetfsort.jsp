<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：resetfsort.jsp
說明：排序重整
開發者：chmei
開發日期：97.01.06
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>排序重整</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<div id="title">
  <h2><img src="../img/addedit.png" width="48" height="48" align="middle" />排序重整中.......請稍後</h2>
</div>

<p></p>
<center><img src="../img/loading.gif" alt="loading" width="214" height="15" /></center>


<%
  String tablename = ( String )request.getParameter( "tablename" );
  
  QsortData query = new QsortData();
  ArrayList qlists = query.findByday(tablename);
  int rcount = query.getAllrecordCount();
  
  String showAlert = "無資料排序";
  if ( qlists != null ) {
	  int fsort = 1;
	  for ( int i=0; i<rcount; i++ ) {
		  QsortData qlist = ( QsortData )qlists.get( i );
		  
		  QsortData obj = new QsortData();
		  boolean rtn = true ;
		  String errMsg="0";
		  
		  fsort = fsort + 1;
		  obj.setSerno(qlist.getSerno());
		  obj.setFsort(fsort);
		  obj.setPubunitdn(qlist.getPubunitdn());
		  rtn = obj.store(tablename);
		   
		  if ( rtn == false ) {
			  errMsg = obj.getErrorMsg();
			  showAlert = "重整排序失敗！" + errMsg;
			  break;
		  }else{
			  showAlert="重整排序成功！";
		  }
	  }
  }%>

  <script>
     alert("<%=showAlert%>");
     window.close();
  </script>
  
  
