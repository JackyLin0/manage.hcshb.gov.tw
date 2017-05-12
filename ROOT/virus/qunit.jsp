<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qunit.jsp
說明：發佈單位
開發者：chmei
開發日期：2017.03.15
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發佈單位</title>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>

</head>

<%
  String hcshb = PropertiesBean.getBundle("tw.com.econcord.properties.project", "hcshb", Locale.TAIWAN);

  String logindn1 = ( String )session.getAttribute("logindn");
  
  String onchange = ( String )request.getParameter( "onchange" );
  if(onchange == null){
	  onchange = "";
  }else{
	  onchange = "onchange='"+onchange+"()'";
  }
  String colname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String punitdata = "";
  if ( datavalue != null && !datavalue.equals("") ) {
	  String[] ary_punit = SvString.split(datavalue,"||");
	  punitdata = ary_punit[0];
  }	  
  
  if ( (logindn1 == null) || (logindn1.equals("null")) ) {  %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("index.jsp","_parent");
	  </script>
  <%}else{
	  String[] ary_logindn = SvString.split(logindn1,",");
	  String mlogindn = logindn1;
	  if ( ary_logindn.length > 4 ) {
		  for ( int i=0; i<ary_logindn.length-4; i++ ) {
			  mlogindn = SvString.right(mlogindn,",");
		  }
	  }
	  
	  //自session找出角色
	  String role1 = ( String )session.getAttribute("role");
	  
	  if ( role1.equals("") && !mlogindn.equals(hcshb) ) {
		  UnitData qunitname = new UnitData();
		  qunitname.setUnitdn(mlogindn);
		  boolean unitrtn = qunitname.loadUnitName();
		  String uname = "";
		  if ( unitrtn ) {
			  uname = qunitname.getUnitname();
		  }
		  String punit1 = mlogindn + "||" + uname;  %>
		  <input type="text" class="textarea" name="punit1" value=<%=uname%> size="20" readonly >
		  <input type="hidden" name="<%=colname%>" value="<%=punit1%>">
	  <%}else{
		  DepartmentTree qunit = new DepartmentTree();
		  qunit.setParentId("1");
		  ArrayList<DSItem> qunits = qunit.getDepartment();
		  if ( qunits != null && qunits.size() > 0 ) { %>
			  <select name="<%=colname%>" class="select" <%=onchange%>>
			    <option value="" selected>請選擇單位</option>
			    <%
			      for ( int i=0; i<qunits.size(); i++ ) {
			    	  DSItem qunitdata = ( DSItem )qunits.get( i );
			    	  String unitvalue = qunitdata.getUnitdn() + "||" + qunitdata.getChinesetitle(); %>
			    	  <option value="<%=unitvalue%>" <%=(qunitdata.getUnitdn().toUpperCase().equals(punitdata.toUpperCase()) ? "selected" : "")%>><%=qunitdata.getChinesetitle()%></option>
			      <%}%>
			  </select>  
		  <%}
	  }
  }%>

</html>

