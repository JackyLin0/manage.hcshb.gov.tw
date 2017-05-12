<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：examine101_save.jsp
說明：問卷調查資料審核
開發者：chmei
開發日期：98.02.11
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String keyword = ( String )request.getParameter( "keyword" );
  String qexamine = ( String )request.getParameter( "qexamine" );
  
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
    
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  
  String table = ( String )request.getParameter( "t" );

  String logincn = ( String )session.getAttribute( "logincn" );
   
  String serno = ( String )request.getParameter( "serno" );
  String examine = ( String )request.getParameter( "examine" );
  
  QuestionExamineData obj = new QuestionExamineData();
    
  boolean rtn = true ;
  String errMsg="0"; 
  String showAlert = null; 
  
  obj.setExamine(examine);
  obj.setExaminename(logincn);
  obj.setSerno(serno);

  //執行動作(修改資料)  
  rtn = obj.store();
  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "審核失敗！" + errMsg;
  }else{
	  showAlert="審核成功！";
  }

%>  

<form name="mform" action="examine101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qexamine" value="<%=qexamine%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

