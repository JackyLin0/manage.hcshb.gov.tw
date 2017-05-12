<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qschool.jsp
說明：發佈學校
開發者：hank
開發日期：98.08.03
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發佈學校</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

</head>
<%
  String colname = ( String )request.getParameter( "colname" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String schName = request.getParameter("schName");
  
  SchoolData sd = new SchoolData();
  ArrayList list = sd.findByday("SchoolData","",datavalue);
  int rcount = sd.getAllrecordCount();
%>
<select name="<%=colname%>" class="select">
  <option value="" selected>全部學校</option>
<%
  if(!datavalue.equals("") && rcount > 0){
	  for(int i = 0 ; i < rcount ; i++){
		  SchoolData query = (SchoolData)list.get(i);
		  String qschName = query.getSchoolname();
		  
		  if(qschName.equals(schName)){
%>
  <option value="<%= qschName %>" selected><%= qschName %></option>
<%
		  }else{
%>
  <option value="<%= qschName %>"><%= qschName %></option>
<%
		  }
	  }
  }
%>
</select>
</html>