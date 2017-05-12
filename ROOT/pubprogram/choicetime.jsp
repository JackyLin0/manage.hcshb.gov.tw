<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>

<%
  //取系統時間
  int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
  int minute = Calendar.getInstance().get(Calendar.MINUTE);

  String timevalue = ( String )request.getParameter( "timevalue" );
  
  if ( timevalue != null && !timevalue.equals("null") && !timevalue.equals("") ) {
	  hour = Integer.parseInt(timevalue.substring(0,2));
	  minute = Integer.parseInt(timevalue.substring(2,4));
  }
  String hcolname = ( String )request.getParameter( "hcolname" );
  String mcolname = ( String )request.getParameter( "mcolname" );
%>

<select name="<%=hcolname%>" class="select">
  <%
    for ( int h=0; h<24; h++ ) {
    	String isSelected = "";
        if ( h == hour )
           isSelected = "selected"; %>							
        <option value="<%=SvNumber.format( h, "00" )%>" <%=isSelected%>><%=SvNumber.format( h, "00" )%></option>        
    <%}%>
</select>時&nbsp;

<select name="<%=mcolname%>" class="select">
  <%
    for ( int m=0; m<60; m++ ) {
    	String isSelected = "";
        if ( m == minute )
           isSelected = "selected"; %>							
        <option value="<%=SvNumber.format( m, "00" )%>" <%=isSelected%>><%=SvNumber.format( m, "00" )%></option>        
    <%}%>
</select>分
