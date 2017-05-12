<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  String datevalue = ( String )request.getParameter( "datevalue" );
  if ( datevalue == null || datevalue.equals("null") )
	  datevalue = "";
  String colname = ( String )request.getParameter( "colname" );
  
  String colnameview = ( String )request.getParameter( "colnameview" );
  String buttonname = ( String )request.getParameter( "buttonname" );
%>

<input type="hidden" name="<%=colname%>" value='<%=datevalue%>' size='10' >
<input type="text" class="textarea" name="<%=colnameview%>" value='<%=tw.com.sysview.function.Datestr.date_chinese(datevalue,"4")%>' size='15' readonly >           

<%
  if ( datevalue.trim().equals("") || datevalue.equals("null") ) {  %>
      <img src="../../img/calendar.gif" name="<%=buttonname%>" alt="calendar" width="21" height="21" border="0" onclick="javascript:window.open('../../pubprogram/date.jsp?colname=mform.<%=colname%>&view=mform.<%=colnameview%>','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')" />
  <%}else{  %>
      <img src="../../img/calendar.gif" name="<%=buttonname%>" alt="calendar" width="21" height="21" border="0" onclick="javascript:window.open('../../pubprogram/date.jsp?colname=mform.<%=colname%>&view=mform.<%=colnameview%>&datevalue=<%=datevalue %>','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')" />
  <%}%>
  