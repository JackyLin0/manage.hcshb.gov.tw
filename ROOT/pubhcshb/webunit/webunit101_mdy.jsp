<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：webunit101_mdy.jsp
說明：單位資料維護
開發者：chmei
開發日期：97.02.27
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
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  
  //參數
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  WebUnitData query = new WebUnitData();    
  boolean rtn = query.load(serno,table);

%>  

<script>
  function back()
  {
     document.mform.action="webunit101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function qsort(tablename)
  {
     newwnd = window.open('../../pubprogram/qsort.jsp?tablename='+tablename,'','width=600,height=400,scrollbars=yes,left=300,top=150');
  }
  
  function save()
  {
     if ( document.mform.subject.value == '' )
     {
        alert("【標題】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.mclass.value == '' )
     {
        alert("【分類名稱】欄位，不可空白，請選擇！");
        document.mform.mclass.focus();
        return;
     }
     if ( document.mform.relateurl.value == 'http://' )
     {
        alert("【相關資訊連結】欄位，不可空白，請輸入！");
        document.mform.relateurl.focus();
        return;
     } 
     if ( document.mform.relatename.value == '' )
     {
        alert("【網站名稱】欄位，不可空白，請輸入！");
        document.mform.relatename.focus();
        return;
     } 
     
     document.mform.action = "webunit101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="webunit101_del.jsp?type=1";
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
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
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
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="70" maxlength="50" value="<%=query.getSubject()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value=<%=query.getPubunitdn()%>>
    <input type="hidden" name="pubunitname" value=<%=query.getPubunitname()%>>
  </tr>  
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>分類</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qclass.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="tablename" value="WebUnitClass"/>
          <jsp:param name="colname" value="mclass"/>
          <jsp:param name="pcolname" value="punit"/>
          <jsp:param name="datavalue" value="<%=query.getMserno()%>"/>
      </jsp:include>            
    </td>
  </tr>
  <tr>
    <td class="T12b">相關資訊連結</td>
    <%
      String mrelaturl = query.getRelateurl();
      String mrelatname = query.getRelatename();
      if ( mrelaturl == null || mrelaturl.equals("null") )
    	  mrelaturl = "http://";
      if ( mrelatname == null || mrelatname.equals("null") )
    	  mrelatname = "";
    %>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" size="50" maxlength="170" value="<%=mrelaturl%>" />&nbsp;
      <span class="T12b">請輸入網站名稱</span>&nbsp;<input name="relatename" type="text" class="lInput01" size="28" value=<%=mrelatname%>>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">啟　用</td>
    <%
      String mstartusing = query.getStartusing();
      if ( mstartusing == null || mstartusing.equals("null") )
    	  mstartusing = "0";
    %>
    <td colspan="3">
      <input name="startusing" type="radio" value="1" <%=(mstartusing.equals("1") ? "checked" : "")%>/>是&nbsp;&nbsp;
      <input name="startusing" type="radio" value="0" <%=(mstartusing.equals("0") ? "checked" : "")%>/>否&nbsp;&nbsp;<span class="T10">(是否於民眾端顯示)</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" value="<%=query.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="查 詢" onclick="qsort('<%=table%>')" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(輸入數值同目前有數值，系統自動將現有該數值往後遞延）</span>
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

