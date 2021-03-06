<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prevention101_add.jsp
說明：各機構查核紀錄表
開發者：chmei
開發日期：97.03.08
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
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  String organization = ( String )request.getParameter( "o" );

%>  

<script>
  function back()
  {
     document.mform.action="prevention101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

  function save()
  {
     if ( document.mform.punit.value == '' )
     {
        alert("【發布單位】欄位，不可空白，請選擇！");
        document.mform.punit.focus();
        return;
     }
     if ( document.mform.stdate.value == '' )
     {
        alert("【查核日期】欄位，不可空白，請選擇！");
        document.mform.date1.focus();
        return;     
     }
     if ( document.mform.subject.value == '' )
     {
        alert("【園所名稱】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     
     document.mform.action = "prevention101_addsave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="o" value="<%=organization%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  
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
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>  
  <tr>
    <td class="T12b" width="20%"><span class="T12red">※</span>查核日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
      </jsp:include>  
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>園所名稱</td>
    <td colspan="3">
    <%
      PreventionData qname1 = new PreventionData();
      ArrayList qnames = qname1.findByday(organization);
      int namercount = qname1.getAllrecordCount(); %>
      <select name="subject">
         <option value="">---請選擇---</option>
         <%
           if ( qnames != null ) {
        	   for ( int i=0; i<namercount; i++ ) {
        		   PreventionData qname = ( PreventionData )qnames.get( i );
        		   String datavalue = qname.getSerno() + "||" + qname.getSubject(); %>
        		   <option value="<%=datavalue%>"><%=qname.getSubject()%></option>
        	   <%}
           }%>
      </select>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>查核</td>
    <td colspan="3">
      <select name="ischeck">
         <option value="1">初查</option>
         <option value="2">複查</option>
      </select>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>洗手設備</td>
    <td colspan="3">
                合格&nbsp;&nbsp;
      <input name="equipmentqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;&nbsp;不合格
      <input name="equipmentnoqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
    </td>
  </tr>  
  <tr>
    <td class="T12b"><span class="T12red">※</span>正確洗手時機</td>
    <td colspan="3">
                合格&nbsp;&nbsp;
      <input name="opportunityqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;&nbsp;不合格
      <input name="opportunitynoqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />         
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>正確洗手動作</td>
    <td colspan="3">
      合格&nbsp;&nbsp;
      <input name="movementqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;&nbsp;不合格
      <input name="movementnoqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />         
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>健康篩檢</td>
    <td colspan="3">
                合格&nbsp;&nbsp;
      <input name="healthsiftqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;&nbsp;不合格
      <input name="healthsiftnoqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />         
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>納入課程</td>
    <td colspan="3">
                合格&nbsp;&nbsp;
      <input name="coursequal" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;&nbsp;不合格
      <input name="coursenoqual" type="text" class="lInput01" size="10" value="0" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />         
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

