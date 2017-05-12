<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：inforclass101_add.jsp
說明：公開資訊分類
開發者：chmei
開發日期：99.05.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公開資訊分類</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.mform.action="inforclass101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     if ( document.mform.classname.value == '' )
     {
        alert("【分類名稱】欄位，不可空白，請選擇！");
        document.mform.classname.focus();
        return;
     } 
     
     document.mform.action = "inforclass101_addsave.jsp";
     document.mform.method="post";
     document.mform.submit();
  }    
</script>

</head>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );

%>  

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>  
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.menuform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料新增</th>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>分類名稱</td>
    <td colspan="3">
      <input name="classname" type="text" class="lInput01" size="78" maxlength="50"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
    </td>
  </tr>

  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

</form>

</body>
</html>
