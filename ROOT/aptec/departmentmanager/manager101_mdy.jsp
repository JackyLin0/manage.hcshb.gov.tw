<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101_mdy.jsp
說明：單位管理者維護
開發者：chmei
開發日期：96.12.20
修改者：
修改日期：
版本：ver1.0
-->


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>雲林縣政府全球資訊網網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  
  //參數
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  DepartmentManagerData query = new DepartmentManagerData();    
  boolean rtn = query.load(serno);

%>  

<script>
  function back()
  {
     document.mform.action="manager101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  
  function save()
  {
     if ( document.mform.name.value == '' )
     {
        alert("【管理者姓名】欄位，不可空白，請選擇！");
        document.mform.name.focus();
        return;
     }
     
     document.mform.action = "manager101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="manager101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }           
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>管理者單位</td>
    <td colspan="3"><%=query.getManagerunitname()%></td>
    <input type="hidden" name="punit" value="<%=query.getManagerunitdn()%>"/>
    <input type="hidden" name="punitname" value="<%=query.getManagerunitname()%>"/>
  </tr>  
  <tr>
    <td class="T12b"><span class="T12red">※</span>管理者姓名</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qpersonal.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="colname" value="name"/>
          <jsp:param name="pcolname" value="<%=query.getManagerunitdn()%>"/>
          <jsp:param name="datavalue" value="<%=query.getManagerperdn()%>"/>
      </jsp:include>            
    </td>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<!-- <p><div align="left"><a class="md" href="#top">回頁首</a></div> -->

</form>
</body>
</html>

