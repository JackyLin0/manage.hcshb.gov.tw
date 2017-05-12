<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qsearch101_show.jsp
說明：問題查詢
開發者：hank
開發日期：98.07.31
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
<%@ page import="java.text.SimpleDateFormat"%>
<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  

  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
  QuesresponseData qdata = new QuesresponseData();    
  qdata.load(serno,table);

  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
%>  

<script>
function back(){
	history.go(-1);
}
  
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="punit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=language value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">問題查詢</th>
  </tr>
  <tr class="tr">
    <td width="15%" class="T12b">隸屬單位</td>
    <td align="left" colspan="3"><%= qdata.getPubunitname() %></td>
  </tr>
  <tr class="tr">
    <td width="15%" class="T12b">學校名稱</td>
    <td align="left" colspan="3"><%= qdata.getSchName() %></td>
  </tr>
  
  <tr class="tr">
    <td width="15%" class="T12b">問題內容</td>
    <td align="left" colspan="3">
      <%= qdata.getQuestion().replaceAll("\n","<br>") %>
    </td>
  </tr>
       
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">‧問‧題‧解‧答‧</th>
  </tr>
  <%
    if(qdata.getAnswer() != null && !qdata.getAnswer().equals("")){
  %>
  <tr class="tr">
    <td width="15%" class="T12b">解答內容</td>
    <td align="left" colspan="3">
      <%= qdata.getAnswer().replaceAll("\n","<br>") %>
    </td>
  </tr>
  <%
    }else{
  %>
  <tr class="tr">
    <td width="15%" class="T12b">解答內容</td>
    <td align="left" colspan="3">
    <%= "等待解答中..." %>
    </td>
  </tr>
  <%
    }
  %>
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

