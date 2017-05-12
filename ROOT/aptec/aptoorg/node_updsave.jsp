<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_updsave.jsp
說明：系統權限設定
開發者：chmei
開發日期：2017.02.26
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系統權限設定</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String logincn = ( String )session.getAttribute( "logincn" );
  String loginap = ( String )session.getAttribute( "loginap" );

  String language = ( String )request.getParameter( "language" );
  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String aciuserdn = ( String )request.getParameter( "aciuserdn" );
  
  ArrayList<DSItem> result = new ArrayList<DSItem>();
  
  if ( aciuserdn != null && !aciuserdn.equals("null") && !aciuserdn.equals("") ) {
	  String[] ary_aciuserdn = SvString.split(aciuserdn,"$");
	  for ( int i=0; i<ary_aciuserdn.length; i++ ) {
		  DSItem setdata = new DSItem();
		  setdata.setAplistdn(aplistdn);
		  setdata.setAciuserdn(ary_aciuserdn[i]);
		  String mdydata = ( String )request.getParameter( "ad"+i );
		  setdata.setAciallow(mdydata);
		  setdata.setLogincn(logincn);
		  setdata.setLoginap(loginap);

		  result.add(setdata);

	  }
  }

  AptoorgTree obj = new AptoorgTree();
  obj.setMdydata(result);
  
  boolean rtn = obj.ModifyPower();

  String showAlert = null;
  if ( rtn )
	  showAlert = "權限修改成功！";
  else
	  showAlert = "權限修改失敗！" + obj.getErrorMsg();

 %>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?apdn=<%=aplistdn%>";
  </script>  


</body>
</html>

