<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<%
  String sdatevalue=(String)request.getParameter("sdatevalue");
  if ( sdatevalue == null )
	  sdatevalue = "";
  
  String edatevalue=(String)request.getParameter("edatevalue");
  if ( edatevalue == null )
	  edatevalue="";

%>

<input type="hidden" name="qptdate" value='<%=sdatevalue%>' size='10' >
<span class="T11b">(起)</span>
<input type="text" name="pview" class="lInput01" value='<%=tw.com.sysview.function.Datestr.date_chinese(sdatevalue,"4")%>' size="15" readonly  />
<img src="../../img/calendar.gif" alt="calendar" width="21" height="21" border="0" onclick="javascript:window.open('../../pubprogram/date.jsp?colname=mform.qptdate&view=mform.pview','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')" />
<span class="T11b">(迄)</span>
<input type="hidden" name="qdldate" value='<%=edatevalue%>' size='10'>
<input type="text" name="dview" class="lInput01" value='<%=tw.com.sysview.function.Datestr.date_chinese(edatevalue,"4")%>' size="15" readonly  />
<img src="../../img/calendar.gif" alt="calendar" width="21" height="21" border="0" onclick="javascript:window.open('../../pubprogram/date.jsp?colname=mform.qdldate&view=mform.dview','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')" />

