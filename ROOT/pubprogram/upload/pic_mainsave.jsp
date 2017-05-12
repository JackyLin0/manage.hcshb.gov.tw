<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：pic_mainsave.jsp
說明：檔案管理(主圖設定儲存)
開發者：chmei
開發日期：97.02.15
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
  String language = ( String )request.getParameter( "language" );

  String mainimage = ( String )request.getParameter( "mainimage" );
  String[] ary_mainimage = SvString.split(mainimage,"||");
  
  UploadData obj = new UploadData();

  boolean rtn = true ;
  String errMsg="0"; 

  obj.setSerno(ary_mainimage[0]);
  obj.setDetailno(Integer.parseInt(ary_mainimage[1]));
  

  //執行動作(修改資料)  
  rtn = obj.storemain(tablename);   
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="pic_list.jsp" method="post">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=ary_mainimage[0]%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>

  
%>