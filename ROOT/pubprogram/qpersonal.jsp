<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qpersonal.jsp
說明：該單位之人員
開發者：chmei
開發日期：2017.03.07
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>該單位之人員</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css"/>	  
<script type="text/javascript" src="../../js/jquery-1.4.2.js"></script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
  String formname = ( String )request.getParameter( "formname" );
  String colname = ( String )request.getParameter( "colname" );
  String pcolname = ( String )request.getParameter( "pcolname" );
  
  String datavalue = ( String )request.getParameter( "datavalue" );
  if ( datavalue == null || datavalue.equals("null") ) 
	  datavalue = "";

%>

<script type="text/javascript">
  function qrypersonal(fname) {
	  var mform = "document.<%=formname%>." + fname;
	  if ( eval(mform) ) {
		  var mpunit = eval(mform).value;
	  }else{
		  var mpunit = "<%=pcolname%>";
	  }
	  
	  ary_mpunit = mpunit.split("||");
	  
	  $.ajax({
		  url: "../../pubprogram/qpersonal_data.jsp",
		  type: "POST",
		  data: "munit=" + ary_mpunit[0],
		  success: function(msg) {
		     persondata(msg);
		  }
	  });	  
  }
  
  function persondata(msg) {
	  var thisform = "document.<%=formname%>.<%=colname%>";
	  eval(thisform).options.length = 1;
	  eval(thisform).options[0].value = "";
	  eval(thisform).options[0].text = "---請選擇---";
	  var ary_msg = msg.split("||");
	  if ( ary_msg[1] != null && ary_msg[1] != '' ) {
		  ary_num = ary_msg[1].split("&");
		  eval(thisform).options.length = ary_num.length+1;
		  for ( i=0; i<ary_num.length; i++ ) {
			  var ary_value = ary_num[i].split("-");
			  eval(thisform).options[i+1].value=ary_num[i];
			  eval(thisform).options[i+1].text=ary_value[1];
			  <%
			    if ( !datavalue.equals("") ) { %>
			    	if ( ary_value[0] == "<%=datavalue%>" ) {
			    		eval(thisform).options[i+1].selected=true;
			    	}
			    <%}%>
		  }
	  }
  }
  
</script>

<select name="<%=colname%>">
   <option value="">---請選擇---</option>
</select>

<%
  if ( !datavalue.equals("") ) {%>
	  <script type="text/javascript">
	    qrypersonal();
	  </script>
  <%}%>
