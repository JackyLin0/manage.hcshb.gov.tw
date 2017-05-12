<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@page import="tw.com.sysview.function.Datestr"%>
<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@page import="sysview.zhiren.function.SvString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：placevisit201_add.jsp
說明：會議室預約
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
  String logindn = (String) session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn, ",");
  if (ary_pubunitdn.length > 5) {
   for (int i = 0; i < ary_pubunitdn.length - 5; i++) {
    pubunitdn = SvString.right(pubunitdn, ",");
   }
  }
  String qwebsite = ( String )request.getParameter( "qwebsite" );
  //場地資料表
  String table = ( String )request.getParameter( "t" );
  //會議室預約資料表
  String table1 = ( String )request.getParameter( "t1" );
  String scheduledate = (String)request.getParameter( "scheduledate" );
  String place = (String)request.getParameter( "place" );
  String username = (String)session.getAttribute("logincn");
  String y1 = (String) request.getParameter("y1");
  String m1 = (String) request.getParameter("m1");
  
  MeetingData query1 = new MeetingData();
  ArrayList meetings = query1.findByday(table1, place, scheduledate,"");
  String seartTime ="";
  String endTime ="";
  String boundTime ="";
  if(query1.getAllrecordCount()>0){
   for(int i=0 ; i<query1.getAllrecordCount() ; i++){
    if(i!=0)
    	boundTime = boundTime +"||";
 	 MeetingData meeting = (MeetingData)meetings.get(i);
 	 seartTime = meeting.getSchedulSTime();
 	 endTime = meeting.getSchedulETime();
 	 boundTime = boundTime + seartTime+ "~" + endTime+ "";
    
   }
  }
%>  

<script>
  function back()
  {
     document.mform.action="place.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save(times)
  {
     if ( document.mform.subject.value == '' )
     {
        alert("【活動名稱】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.punit.value == '' )
     {
        alert("【申請單位】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.liaisonPer.value == '' )
     {
        alert("【連絡人】欄位，不可空白，請選擇！");
        document.mform.liaisonPer.focus();
        return;
     }
     if ( document.mform.liaisonTel.value == '' )
     {
        alert("【分機號碼】欄位，不可空白，請選擇！");
        document.mform.liaisonTel.focus();
        return;
     }
     if ( document.mform.schedulnum.value == '' )
     {
        alert("【預定人數】欄位，不可空白，請選擇！");
        document.mform.schedulnum.focus();
        return;
     }
     if( document.mform.stime.value >= document.mform.etime.value) {
     	alert("預定時間(起)不得大於預定時間(迄)");
     	return
     }
     var boundTimes = ""+times; 
	 var boundTime = boundTimes.split("||");
	 for (var i = 0; i < boundTime.length; i++) {
	  var time = ""+boundTime[i];
	  var setime = time.split("~");
	  var stime = setime[0];
	  var etime = setime[1];
	  if(document.mform.stime.value >= stime && document.mform.stime.value < etime){
	     alert("預定時間(起)" + document.mform.stime.value +" ，" + stime + "~" + etime +"時段已被租借。");
	     return;   
	  }
	  if(document.mform.etime.value > stime && document.mform.etime.value <= etime){
		 alert("預定時間(迄)" + document.mform.etime.value +" ，" + stime + "~" + etime +"時段已被租借。");
		 return;   
	  }
	 }
     
     document.mform.action = "placevisit201_addsave.jsp";
     document.mform.method="post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="y1" value="<%=y1%>"/>
  <input type="hidden" name="m1" value="<%=m1%>"/>
  <input type="hidden" name="place" value="<%=place%>"/>
<%--   <input type="hidden" name="logindn" value="<%=logindn%>"/> --%>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%-- <%@ include file="../../pubprogram/language.jsp"%> --%>


<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=boundTime%>')">儲存</a>	
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
    <input name="placeSerno" type="hidden" value="<%=place%>"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>申請單位</td>
    <td colspan="3">
      <jsp:include page="qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
          <jsp:param name="datavalue" value="<%=pubunitdn%>"/>
          
      </jsp:include>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>&nbsp;連&nbsp;絡&nbsp;人</td>
    <td colspan="3">
      <input name="liaisonPer" type="text" class="lInput01" value="<%=username%>" size="10"/>
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>分機號碼</td>
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
      <input name="sdate" value="<%=Datestr.date_chinese(scheduledate, "")%>" type="text" class="textarea" size="15" readonly/>
      <input name="scheduldate" type="hidden" value="<%=scheduledate%>" />
    </td>
  </tr>
  <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>預定時間</td>
    <td colspan="3">
      <select name="stime" class="select">
         <option value="0000">00:00</option>
         <option value="0030">00:30</option>
         <option value="0100">01:00</option>
         <option value="0130">01:30</option>
         <option value="0200">02:00</option>
         <option value="0230">02:30</option>
         <option value="0300">03:00</option>
         <option value="0330">03:30</option>
         <option value="0400">04:00</option>
         <option value="0430">04:30</option>
         <option value="0500">05:00</option>
         <option value="0530">05:30</option>
         <option value="0600">06:00</option>
         <option value="0630">06:30</option>
         <option value="0700">07:00</option>
         <option value="0730">07:30</option>
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
         <option value="1730">17:30</option>
         <option value="1800">18:00</option>
         <option value="1830">18:30</option>
         <option value="1900">19:00</option>
         <option value="1930">19:30</option>
         <option value="2000">20:00</option>
         <option value="2030">20:30</option>
         <option value="2100">21:00</option>
         <option value="2130">21:30</option>
         <option value="2200">22:00</option>
         <option value="2230">22:30</option>
         <option value="2300">23:00</option>
         <option value="2330">23:30</option>
         <option value="2359">23:59</option>
      </select>(起)
                  至
      <select name="etime" class="select">
         <option value="0000">00:00</option>
         <option value="0030">00:30</option>
         <option value="0100">01:00</option>
         <option value="0130">01:30</option>
         <option value="0200">02:00</option>
         <option value="0230">02:30</option>
         <option value="0300">03:00</option>
         <option value="0330">03:30</option>
         <option value="0400">04:00</option>
         <option value="0430">04:30</option>
         <option value="0500">05:00</option>
         <option value="0530">05:30</option>
         <option value="0600">06:00</option>
         <option value="0630">06:30</option>
         <option value="0700">07:00</option>
         <option value="0730">07:30</option>
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
         <option value="1730">17:30</option>
         <option value="1800">18:00</option>
         <option value="1830">18:30</option>
         <option value="1900">19:00</option>
         <option value="1930">19:30</option>
         <option value="2000">20:00</option>
         <option value="2030">20:30</option>
         <option value="2100">21:00</option>
         <option value="2130">21:30</option>
         <option value="2200">22:00</option>
         <option value="2230">22:30</option>
         <option value="2300">23:00</option>
         <option value="2330">23:30</option>
         <option value="2359">23:59</option>
      </select>(迄)
                  止
    </td>
  </tr>
  
  <tr>
    <td class="T12b" align="center">是否發佈到活動行事曆</td>
    <td colspan="3">
      <input type="radio" name="activityflag" value="Y" > 是&nbsp;&nbsp;</input>
     <input type="radio" name="activityflag" value="N" checked > 否</input>
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

