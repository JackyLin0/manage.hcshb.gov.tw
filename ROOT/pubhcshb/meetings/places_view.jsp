<%@page import="tw.com.sysview.function.Datestr"%>
<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!--
程式名稱：place201_mdy.jsp
說明：會議室預約
開發者：yclai
開發日期：103.08.26
修改者：
修改日期：
版本：ver1.0
-->


<%
  String dataserno = (String)request.getParameter( "dataserno" );
  //接收查詢條件
  String day1 = ( String )request.getParameter( "day1" );
  MeetingData meetData = new MeetingData();
  boolean rtn = meetData.load(dataserno,"Meetings");
%>  

<body>
  


<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>場地租借明細</h2>
</div>
<p></p>
&nbsp;&nbsp;&nbsp;<a class="md2" href="places_list.jsp?day1=<%=day1%>">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
<%
if ( rtn ) {  %>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">活動名稱:</td>
    <td width="85%" align="left">
      <%=meetData.getSubject()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">場地名稱:</td>
    <td width="85%" align="left">
    <%
    PlaceData query = new PlaceData();
    boolean rtn1 = query.load(meetData.getPlaceSerno(), "PlaceData");
    %>
    <%=query.getPlacename()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">申請單位:</td>
    <td width="85%" align="left">
      <%=meetData.getPubunitname()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">連絡人:</td>
    <td width="85%" align="left">
      <%=meetData.getLiaisonPer()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">分機號碼:</td>
    <td width="85%" align="left">
      <%=meetData.getLiaisonTel()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">預定人數:</td>
    <td width="85%" align="left">
      <%=meetData.getLimitNum()%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">預定日期:</td>
    <td width="85%" align="left">
      <%=Datestr.date_chinese(meetData.getSchedulDate(), "")%>
    </td>
  </tr>
  <tr>
    <td width="15%" class="T12b" align="center"><img src="img/icon05_1.gif" alt="*" width="17" height="16">預定時間:</td>
    <td width="85%" align="left">
     <%=Datestr.timeformat(meetData.getSchedulSTime(), "2")%>~
     <%=Datestr.timeformat(meetData.getSchedulETime(), "2")%>
    </td>
  </tr>
  <%}%>
  

  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>


</body>
</html>

