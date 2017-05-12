<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<title>轉excel</title>

</head>

<%@ page contentType="application/vnd.ms-excel;charset=utf-8" %>

<%@ page import="java.util.*"%>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  response.setHeader("Content-disposition","inline; filename=Emaildata.xls");

  EpaperMailData query = new  EpaperMailData();
  ArrayList<Object> qlists = query.findByday("");
  int rcount = query.getAllrecordCount();
  
  if ( qlists != null ) {%>
	  <table width="100%" border="1" cellpadding="0" cellspacing="0">
	    <tr>
	      <td>姓名</td>
	      <td>E-Mail</td>
	    </tr>
	  <%
	    for ( int i=0; i<rcount; i++ ) {
	    	EpaperMailData qlist = ( EpaperMailData )qlists.get( i ); %>
	    	<tr>
		      <td><%=qlist.getName()%></td>
		      <td><%=qlist.getEmail()%></td>
		    </tr>
	    <%}%>	  
	  </table>
  <%}%>

</body>
</html>
