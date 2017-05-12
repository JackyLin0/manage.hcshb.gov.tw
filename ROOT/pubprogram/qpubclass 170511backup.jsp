<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：qpubclass.jsp
說明：分類程式(不分單位)
開發者：chmei
開發日期：99.05.24
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分類程式</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String tablename = ( String )request.getParameter( "tablename" );
  String classcolname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );

  String classvalue = ( String )request.getParameter( "datavalue" );
  if ( classvalue == null )
	  classvalue="";
 
  String[] ary_qclass = null;
  if ( !classvalue.equals("")  )
     ary_qclass = SvString.split(classvalue,"-");
  
  ClassData qclassname = new ClassData();
  ArrayList<Object> qlists = qclassname.findByday(tablename);  
  int rcount = qclassname.getAllrecordCount();


%>

<body>

<select name="<%=classcolname%>">
  <option value="">---請選擇---</option>
  <%
    out.println("qlists: "+qlists);
    if ( qlists != null ) {
    out.println("rcount: "+rcount);
    	for ( int i=0; i<rcount; i++ ) {
    		ClassData qlist = ( ClassData )qlists.get( i );
    		String datavalue = qlist.getSerno() + "-" + qlist.getClassname();
    		String isSelected = "";
    		if ( !classvalue.equals("") ) {
    			if ( qlist.getSerno().equals(ary_qclass[0]) )
    				isSelected = "selected";
    		}%>
    		<option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getClassname()%></option>
    	<%}
    } %>
</select>

</body>
</html>

