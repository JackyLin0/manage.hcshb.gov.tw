<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：qpersonal_data.jsp
說明：該單位之人員
開發者：chmei
開發日期：2017.03.07
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<%
  String munit = ( String )request.getParameter( "munit" );
  
  UsersTree qperson = new UsersTree();
  ArrayList<DSItem> qpersons = qperson.getUnitUsersData(munit);
  String personal_data = "";
  if ( qpersons != null && qpersons.size() > 0 ) {
	  for ( int i=0; i<qpersons.size(); i++ ) {
		  DSItem qunitpersonal = ( DSItem )qpersons.get(i);
		  if ( personal_data.equals("") ) {
			  personal_data = qunitpersonal.getDn() + "-" + qunitpersonal.getCn();
		  }else{
			  personal_data = personal_data + "&" + qunitpersonal.getDn() + "-" + qunitpersonal.getCn();
		  }
	  }
  }
  
  if ( !personal_data.equals("") ) {
	  personal_data = "||" + personal_data + "||";
  }

  response.setContentType("text/plain; charset=UTF-8");
  response.getWriter().print(personal_data);
  response.getWriter().flush();
  response.getWriter().close();

%>
