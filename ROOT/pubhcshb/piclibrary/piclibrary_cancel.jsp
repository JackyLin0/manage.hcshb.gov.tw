<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：piclibrary101_save.jsp
說明：圖庫管理
開發者：chmei
開發日期：97.06.07
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>

<%@ page import="tw.com.sysview.upload.*" %>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String table = ( String )request.getParameter( "table" );
  String path = ( String )request.getParameter( "path" );
  String language = ( String )request.getParameter( "language" );
  String dataserno = ( String )request.getParameter( "dataserno" );
  
  String logincn = ( String )session.getAttribute("logincn");
  
  PicLibraryFileData obj = new PicLibraryFileData();
  obj.setPostname(logincn);
  
  obj.cancel(table,dataserno);  

  boolean rtn = true ;
  String errMsg="0";   
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "取消引用失敗！" + errMsg;
  }else{
	  showAlert="取消引用成功！";
  }

 %>

<form name="mform" action="piclibrary_list.jsp" method="post">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=dataserno%>"/>
  <input type="hidden" name="table" value="<%=table%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script> 