<%@page import="tw.com.sysview.function.Datestr"%>
<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@page import="sysview.zhiren.function.SvString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：place101_visit.jsp
說明：場地預約
開發者：yclai
開發日期：103.08.26
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
  String logindn = ( String )request.getParameter( "logindn" );
  String qwebsite = ( String )request.getParameter( "qwebsite" );
  String table = ( String )request.getParameter( "t" );
  String scheduledate = (String)request.getParameter( "scheduledate" );
  String place = (String)request.getParameter( "place" );
  String username = (String)session.getAttribute("logincn");
%>  

<script>
  function back()
  {
     document.mform.action="place101.jsp";
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
     if ( document.mform.place.value == '' )
     {
        alert("【場地名稱】欄位，不可空白，請選擇！");
        document.mform.placename.focus();
        return;
     } 
     if( document.mform.stime.value >= document.mform.etime.value) {
     	alert("預定時間(起)不得大於預定時間(迄)");
     	return
     }
     document.mform.action = "place101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
<%--   <input type="hidden" name="logindn" value="<%=logindn%>"/> --%>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%-- <%@ include file="../../pubprogram/language.jsp"%> --%>


<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>活動名稱</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="30"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>場地名稱</td>
    <td colspan="3">
    <%
    PlaceData query = new PlaceData();
    boolean rtn = query.load(place, table);
    %>
    
    <input name="placename" type="text" class="textarea" value="<%=query.getPlacename()%>" readonly size="20"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>申請單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit1.jsp">
      	<jsp:param name="colname" value="punit"/>
      	<jsp:param name="qwebsite" value="<%=qwebsite%>"/>
      	<jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>連絡人</td>
    <td colspan="3">
      <input name="liaisonPer" type="text" class="lInput01" value="<%=username%>" size="10"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>連絡電話</td>
    <td colspan="3">
      <input name="liaisonTel" type="text" class="lInput01" size="12"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>預定人數</td>
    <td colspan="3">
      <input name="schedulnum" type="text" class="lInput01" size="5"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>預定日期</td>
    <td colspan="3">
      <input name="scheduldate" value="<%=Datestr.date_chinese(scheduledate, "")%>" type="text" class="textarea" size="15" readonly/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>預定時間</td>
    <td colspan="3">
      <select name="stime" class="select">
         <option value="0800">08:00</option>
         <option value="0830">08:30</option>
         <option value="0900">09:00</option>
         <option value="0930">09:30</option>
         <option value="1000">10:00</option>
         <option value="1030">10:30</option>
         <option value="1100">11:00</option>
         <option value="1130">11:30</option>
         <option value="1200">12:00</option>
         <option value="1230">12:30</option>
         <option value="1300">13:00</option>
         <option value="1330">13:30</option>
         <option value="1400">14:00</option>
         <option value="1430">14:30</option>
         <option value="1500">15:00</option>
         <option value="1530">15:30</option>
         <option value="1600">16:00</option>
         <option value="1630">16:30</option>
         <option value="1700">17:00</option>
      </select>(起)
                  至
      <select name="etime" class="select">
         <option value="0800">08:00</option>
         <option value="0830">08:30</option>
         <option value="0900">09:00</option>
         <option value="0930">09:30</option>
         <option value="1000">10:00</option>
         <option value="1030">10:30</option>
         <option value="1100">11:00</option>
         <option value="1130">11:30</option>
         <option value="1200">12:00</option>
         <option value="1230">12:30</option>
         <option value="1300">13:00</option>
         <option value="1330">13:30</option>
         <option value="1400">14:00</option>
         <option value="1430">14:30</option>
         <option value="1500">15:00</option>
         <option value="1530">15:30</option>
         <option value="1600">16:00</option>
         <option value="1630">16:30</option>
         <option value="1700">17:00</option>
      </select>(迄)
                  止
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

