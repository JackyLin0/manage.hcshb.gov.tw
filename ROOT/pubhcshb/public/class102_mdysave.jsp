<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：class102_mdysave.jsp
說明：分類程式(適用主題網站)
開發者：chmei
開發日期：99.03.30
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

</head>

<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  //接受查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclassname = ( String )request.getParameter( "qclassname" );

  //參數
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  
  //form值
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  String classname = ( String )request.getParameter( "classname" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  //取得修改者IP
  String hostIP = request.getRemoteHost();

  String websitedn = ( String )request.getParameter( "websitedn" );
  WebSiteData qdata = new WebSiteData();
  qdata.load(websitedn);
  
  TopicClassData obj = new TopicClassData();  
  
  boolean rtn = true ;
  String errMsg="0";     
  
  obj.setClassname(classname);
  obj.setWebsitedn(websitedn);

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);                 //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(classname);           //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("U");                  //狀態
  
  //執行動作(修改資料)  
  rtn = obj.store();
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="class102.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclassname" value="<%=qclassname%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>


</body>
</html>

