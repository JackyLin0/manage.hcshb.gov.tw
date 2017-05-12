<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：addatt.jsp
說明：應用系統管理(組應用系統attribute變數)
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="javax.naming.directory.Attribute" %>
<%@ page import="javax.naming.directory.BasicAttribute" %>

<%
  String addatt = new String();
  addatt = addatt + "objectclass=top,organizationalunit,aptree";

  String sysname =  ( String )request.getParameter( "sysname" );
  String url =  ( String )request.getParameter( "url" );
  
  String ou =  ( String )request.getParameter( "ou" );
  String punit = "";
  
  if ( request.getParameterValues( "punit" ) != null )
  {
	  String ary_punit[] = request.getParameterValues( "punit" );	  
	  for ( int i=0; i<ary_punit.length; i++ )
	  {
		  String mpunit = ary_punit[i].replace('*',',');
		  if ( punit.equals("") )
			  punit = mpunit;
		  else
			  punit = punit + "||" + mpunit;
	  }
  }	  
  String startusing = ( String )request.getParameter( "startusing" );
  if ( startusing == null )
	  startusing = "";

  String number =  ( String )request.getParameter( "num" );

  Attribute[] attrs = new Attribute[6];

  attrs[0] = new BasicAttribute( "sysname" );
  attrs[0].add ( sysname );
  attrs[1] = new BasicAttribute( "url" );
  attrs[1].add ( url );  
  attrs[2] = new BasicAttribute( "ou" );
  attrs[2].add ( ou ); 
  attrs[3] = new BasicAttribute( "punit" );
  attrs[3].add ( punit );  
  attrs[4] = new BasicAttribute( "number" );
  attrs[4].add ( number );
  attrs[5] = new BasicAttribute( "startusing" );
  attrs[5].add ( startusing );
%>
	