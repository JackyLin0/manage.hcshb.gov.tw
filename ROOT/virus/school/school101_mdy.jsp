<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：school101_mdy.jsp
說明：學校資料維護
開發者：chmei
開發日期：98.07.27
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
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
  SchoolData qdata = new SchoolData();    
  qdata.load(serno,table);

%>  

<script>
  function back()
  {
     document.mform.action="school101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function rpass()
  {
     document.mform.action="school101_returnpwd.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     if ( document.mform.schoolname.value == '' )
     {
        alert("【學校名稱】欄位，不可空白，請輸入！");
        document.mform.schoolname.focus();
        return;
     }
     if ( document.mform.punit.value == '' )
     {
        alert("【隸屬單位】欄位，不可空白，請選擇！");
        document.mform.punit.focus();
        return;
     }
     if ( document.mform.uid.value == '' )
     {
        alert("【 帳號】欄位，不可空白，請輸入！");
        document.mform.uid.focus();
        return;
     }
     
     document.mform.action = "school101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="school101_del.jsp?type=1";
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
  <input type="hidden" name=language value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>
 <a class="md" href="javascript:rpass()">密碼回複</a>
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>學校名稱</td>
    <td colspan="3">
      <input name="schoolname" type="text" class="lInput01" size="70" maxlength="50" value="<%=qdata.getSchoolname()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <%
    String datavalue = qdata.getPubunitdn() + "||" + qdata.getPubunitname();
  %>
  <tr>
    <td class="T12b"><span class="T12red">※</span>隸屬單位</td>
    <td colspan="3">
      <jsp:include page="../qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
          <jsp:param name="datavalue" value="<%=datavalue%>"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>帳號</td>
    <td colspan="3">
      <input name="uid" type="text" class="lInput01" size="20" maxlength="10" value="<%=qdata.getUid()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過10個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">聯絡人</td>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="20" maxlength="20" value="<%=qdata.getLiaisonper()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個中文字）</span>
    </td>
  </tr>    
  <tr class="tr">
    <td class="T12b">聯絡電話</td>
    <td colspan="3">
      <input name="liaisontel" type="text" class="lInput01" size="20" maxlength="20" value="<%=qdata.getLiaisontel()%>"/>
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

