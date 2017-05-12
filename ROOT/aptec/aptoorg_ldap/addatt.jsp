<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：addatt.jsp
說明：系統權限設定(組權限attribute變數)
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.SvString" %>
<%@ page import="javax.naming.directory.*" %>

<%
  String addatt = new String();
  addatt = addatt + "objectclass=organizationalunit,aptree";

  String acitarget = ( String )request.getParameter( "dn" );
  
  String aciname = SvString.left(acitarget,",");
  String acitargetattr = "*";
  
  String aciuserdn = ( String )request.getParameter( "aciuserdnt" );
  
  int dnlen = 0;
  String[] array_aciuserdn = new String[dnlen];
  if ( aciuserdn != null && !aciuserdn.equals("null") ) {
	  array_aciuserdn = SvString.split(aciuserdn,"$");
	  dnlen = array_aciuserdn.length;
  }
  
  String aci = "";
  String aciuser = "";
  String acidn = "";
  String userallow = "";
  String acl = "";
  
  if ( aciname != null )
  {
    aci = "(target=\"ldap:///" + acitarget + "\")(targetattr=\"" + acitargetattr + "\")(version 3.0; acl \"" + aciname + "\"";    
  }  
  
  Attribute[] attrs = new Attribute[6];
  int p=1;           
  for (int cnt=0; cnt<dnlen; cnt++)
  {
     String aduser = ( String )request.getParameter( "ad" + cnt );
     if (!aduser.equals("delete"))
     {
       p = p + 1;	
       aciuser = aciuser + ";" + aduser + "(all)(userdn = \"ldap:///" + array_aciuserdn[cnt] + "\")";
       if ( !userallow.equals("") )
         userallow = userallow + ",allow";
       else
         userallow = "allow"; 
       if ( acidn.equals(""))
         acidn = array_aciuserdn[cnt];
       else    
         acidn = acidn + "$" + array_aciuserdn[cnt];         
     }      
  }    
  

  if ( p == 1 ) 
  {
     addatt = "aci,aciallowuserdn,acitargetattr,acitarget,aciuserdn";  	
  }else{	       
     acl = aci + aciuser + ";)";
     attrs[0] = new BasicAttribute( "aci" );
     attrs[0].add ( acl );
     attrs[1] = new BasicAttribute( "aciallowuserdn" );
     attrs[1].add ( userallow );  
     attrs[2] = new BasicAttribute( "aciname" );
     attrs[2].add ( aciname ); 
     attrs[3] = new BasicAttribute( "acitarget" );
     attrs[3].add ( acitarget );
     attrs[4] = new BasicAttribute( "acitargetattr" );
     attrs[4].add ( acitargetattr ); 
     attrs[5] = new BasicAttribute( "aciuserdn" );
     attrs[5].add ( acidn );
  }    
%>	