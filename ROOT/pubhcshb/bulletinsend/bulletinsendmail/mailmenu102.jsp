<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manual102.jsp
說明：手動派送電子報
開發者：chmei
開發日期：97.03.22
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>
<%
String serno = ( String )request.getParameter( "serno" );
String path = ( String )request.getParameter( "path" );
//參數
String logindn = ( String )session.getAttribute("logindn");
String table = ( String )request.getParameter( "t" );
String table1 = ( String )request.getParameter( "t1" );
String table2 = ( String )request.getParameter( "t2" );

String keyword = ( String )request.getParameter( "keyword" );
String qpunit = ( String )request.getParameter( "qpunit" );
String qclass = ( String )request.getParameter( "qclass" );
String qptdate = ( String )request.getParameter( "qptdate" );
String qdldate = ( String )request.getParameter( "qdldate" );


%>
<script>
    
  
  function send()
  {
     if ( document.mform.emails.value == '' ) {
        alert("【欲寄送之信件】欄位，不可空白，請選擇");
        document.mform.periodical.focus();
        return;
     }
     document.mform.action = "mailmenu102_send.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
  
</script>

<%@ page import="tw.com.sysview.dba.*" %>

<body>
<form name="mform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="qptdate" value="<%=qptdate%>"/>
  <input type="hidden" name="qdldate" value="<%=qdldate%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:send()">確定</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">新聞稿寄送</th>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>欲寄送之信件輸入</td>
    <td colspan="3">
      <table border="0">
        <tr align="center">
          <td rowspan="2" align="center">
            <input name="emails" type="text" class="lInput01" size="50" />多個信件請用【;】隔開
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

</form>
</body>
</html>

