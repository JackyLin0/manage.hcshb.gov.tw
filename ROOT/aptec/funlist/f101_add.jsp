<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!--
程式名稱：f101_add.jsp
說明：網站功能維護
開發者：tswenyaw
開發日期：96.08.06
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String mpunit = ( String )request.getParameter( "mpunit" );
  String table = ( String )request.getParameter( "t" );

%>  

<script>
  function back()
  {
     document.mform.action="f101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
   function save()
   {     
      if( document.mform.page_name.value == '' ) {
    	  alert("【功能名稱】欄位，不可空白，請輸入！");
    	  document.mform.page_name.focus();
    	  return;
      }
      if( document.mform.page_name.value.length>100) {
    	  alert("【功能名稱】欄位，不可超過100個中文字，請重新輸入！");
    	  document.mform.page_name.focus();
    	  return;
      }    
      if( document.mform.uppage_url.value == '' ) {
    	  alert("【功能頁面】欄位，不可空白，請輸入！");
    	  document.mform.uppage_url.focus();
    	  return;
      }
      if( document.mform.uppage_url.value.length>50) {
    	  alert("【功能頁面】欄位，不可超過50個中文字，請重新輸入！");
    	  document.mform.uppage_url.focus();
    	  return;
      }
      if( document.mform.tblname.value == '' ) {
    	  alert("【功能資料表名稱】欄位，不可空白，請輸入！");
    	  document.mform.tblname.focus();
    	  return;
      }
      if( document.mform.tblname.value.length>50) {
    	  alert("【功能資料表名稱】欄位，不可超過50個中文字，請重新輸入！");
    	  document.mform.tblname.focus();
    	  return;
      }
      
      document.mform.action="f101_addsave.jsp"
      document.mform.method="post"
      document.mform.submit();
    }

</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="mpunit" value="<%=mpunit%>"/>
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料新增</th>
  </tr>
  
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>功能名稱</td>
    <td colspan="3">
      <input name="page_name" type="text" class="lInput01"  size="50" /><span class="T8-5">(至多10英數字)</span>
    </td>
    
  </tr>
    
  <tr>
    <td class="T12b"><span class="T12red">※</span>功能頁面</td>
    <td colspan="3">
       <input name="uppage_url" type="text" class="lInput01" size="50" /><span class="T8-5">(至多50中文字)</span>
    </td>
  </tr>
<tr>
    <td class="T12b">單筆顯示頁面</td>
    <td colspan="3">
       <input name="page_url" type="text" class="lInput01" size="50" /><span class="T8-5">(至多50中文字)</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>功能資料表名稱</td>
    <td colspan="3">
       <input name="tblname" type="text" class="lInput01" size="50" /><span class="T8-5">(至多50中文字)</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">類別資料表名稱</td>
    <td colspan="3">
       <input name="tblclassname" type="text" class="lInput01" size="50" /><span class="T8-5">(至多50中文字)</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">發布站台資料表名稱</td>
    <td colspan="3">
       <input name="tblposname" type="text" class="lInput01" size="50" /><span class="T8-5">(至多50中文字)</span>
    </td>
  </tr>

  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

